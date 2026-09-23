import NetworkExtension
import Foundation

class PacketTunnelProvider: NEPacketTunnelProvider {

    private var activeSkins: [String: Int] = [:]

    // MARK: - Tunnel Start
    override func startTunnel(options: [String: NSObject]?,
                              completionHandler: @escaping (Error?) -> Void) {
        let settings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: "127.0.0.1")

        let ipv4 = NEIPv4Settings(addresses: ["192.168.99.1"],
                                  subnetMasks: ["255.255.255.0"])
        ipv4.includedRoutes = [NEIPv4Route.default()]
        settings.ipv4Settings = ipv4
        settings.dnsSettings  = NEDNSSettings(servers: ["8.8.8.8"])
        settings.mtu          = 1500

        setTunnelNetworkSettings(settings) { [weak self] error in
            completionHandler(error)
            if error == nil { self?.readLoop() }
        }
    }

    override func stopTunnel(with reason: NEProviderStopReason,
                             completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    // MARK: - App -> Extension mesajı
    override func handleAppMessage(_ messageData: Data,
                                   completionHandler: ((Data?) -> Void)?) {
        if let msg = try? JSONDecoder().decode(SkinMessage.self, from: messageData) {
            if msg.action == "apply", let id = Int(msg.skinID) {
                activeSkins[msg.category] = id
            } else if msg.action == "remove" {
                activeSkins.removeValue(forKey: msg.category)
            }
        }
        completionHandler?(nil)
    }

    // MARK: - Paket okuma döngüsü
    private func readLoop() {
        packetFlow.readPacketObjects { [weak self] packets in
            guard let self = self else { return }

            let modified = packets.map { pkt -> NEPacket in
                var data = pkt.data
                self.tryPatch(&data)
                return NEPacket(data: data, protocolFamily: pkt.protocolFamily)
            }

            self.packetFlow.writePacketObjects(modified)
            self.readLoop()
        }
    }

    // MARK: - Payload içinde skin ID bul & değiştir
    private func tryPatch(_ data: inout Data) {
        guard data.count > 28 else { return }

        // IP header kontrolu
        guard (data[0] >> 4) == 4 else { return }
        let ipHeaderLen = Int((data[0] & 0xF) * 4)
        let proto       = data[9]

        // TCP(6) veya UDP(17)
        guard proto == 6 || proto == 17 else { return }

        let transportHeaderLen = proto == 6 ? 20 : 8
        let payloadStart       = ipHeaderLen + transportHeaderLen

        guard payloadStart < data.count - 4 else { return }

        // Her aktif skin için tarama
        for (_, newID) in activeSkins {
            var i = payloadStart
            while i <= data.count - 4 {
                let val = UInt32(data[i])
                    | UInt32(data[i + 1]) << 8
                    | UInt32(data[i + 2]) << 16
                    | UInt32(data[i + 3]) << 24

                // Bilinen skin ID aralıkları
                let isSkin = (val >= 1_101_001_000 && val <= 1_101_009_999)
                          || (val >= 1_400_000     && val <= 1_540_000)
                          || (val >= 502_000       && val <= 502_200)
                          || (val >= 1_522_000     && val <= 1_523_000)

                if isSkin {
                    let b = withUnsafeBytes(of: UInt32(newID).littleEndian) { Array($0) }
                    data[i]     = b[0]
                    data[i + 1] = b[1]
                    data[i + 2] = b[2]
                    data[i + 3] = b[3]
                }
                i += 1
            }
        }
    }
}

// MARK: - Shared model (Extension tarafı)
struct SkinMessage: Codable {
    let action:   String
    let skinID:   String
    let category: String
}
