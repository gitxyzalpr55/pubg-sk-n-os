import Foundation
import NetworkExtension

// MARK: - Mesaj modeli
struct SkinMessage: Codable {
    let action: String
    let skinID: String
    let category: String
}

// MARK: - VPN Manager
class VPNManager: ObservableObject {
    @Published var isConnected = false
    @Published var statusText = "Trafik yakalama kapalı"

    private var vpnManager = NEVPNManager.shared()
    private var activeSkins: [String: Int] = [:]

    init() {
        loadPreferences()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(vpnStatusChanged),
            name: .NEVPNStatusDidChange,
            object: nil
        )
    }

    func toggle() {
        isConnected ? disconnect() : connect()
    }

    func connect() {
        vpnManager.loadFromPreferences { [weak self] _ in
            guard let self = self else { return }

            let proto = NETunnelProviderProtocol()
            proto.providerBundleIdentifier = "com.pubgskin.app.tunnel"
            proto.serverAddress = "PUBG-INTERCEPTOR"
            proto.providerConfiguration = ["intercept": true]

            self.vpnManager.protocolConfiguration = proto
            self.vpnManager.localizedDescription  = "PUBG Skin Interceptor"
            self.vpnManager.isEnabled             = true
            self.vpnManager.isOnDemandEnabled     = false

            self.vpnManager.saveToPreferences { error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.statusText = "Kayıt hatası: \(error!.localizedDescription)"
                    }
                    return
                }
                self.vpnManager.loadFromPreferences { _ in
                    do {
                        try self.vpnManager.connection.startVPNTunnel()
                        DispatchQueue.main.async {
                            self.isConnected = true
                            self.statusText  = "Trafik yakalama aktif"
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.statusText = "Bağlanamadı: \(error.localizedDescription)"
                        }
                    }
                }
            }
        }
    }

    func disconnect() {
        vpnManager.connection.stopVPNTunnel()
        isConnected = false
        statusText  = "Trafik yakalama kapalı"
    }

    func applyClientSideSkin(skinID: Int, category: String) {
        activeSkins[category] = skinID
        sendMessage(SkinMessage(action: "apply", skinID: "\(skinID)", category: category))
    }

    func removeSkin(category: String) {
        activeSkins.removeValue(forKey: category)
        sendMessage(SkinMessage(action: "remove", skinID: "0", category: category))
    }

    // MARK: - Private
    private func sendMessage(_ msg: SkinMessage) {
        guard isConnected,
              let session = vpnManager.connection as? NETunnelProviderSession,
              let data = try? JSONEncoder().encode(msg) else { return }
        try? session.sendProviderMessage(data) { _ in }
    }

    @objc private func vpnStatusChanged() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch self.vpnManager.connection.status {
            case .connected:    self.isConnected = true;  self.statusText = "Trafik yakalama aktif"
            case .disconnected: self.isConnected = false; self.statusText = "Trafik yakalama kapalı"
            case .connecting:   self.statusText = "Bağlanıyor..."
            case .disconnecting:self.statusText = "Kesiliyor..."
            default: break
            }
        }
    }

    private func loadPreferences() {
        vpnManager.loadFromPreferences { [weak self] _ in
            DispatchQueue.main.async {
                self?.isConnected = self?.vpnManager.connection.status == .connected
            }
        }
    }
}
