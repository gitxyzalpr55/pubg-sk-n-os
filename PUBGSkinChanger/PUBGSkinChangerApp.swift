import SwiftUI

@main
struct PUBGSkinChangerApp: App {
    @StateObject private var vpnManager = VPNManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vpnManager)
                .preferredColorScheme(.dark)
        }
    }
}
