import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vpnManager: VPNManager
    @State private var selectedCategory: SkinCategory = .weapon
    @State private var searchText = ""
    @State private var appliedSkins: [SkinCategory: SkinItem] = [:]
    @State private var showApplyConfirm = false
    @State private var pendingSkin: SkinItem?
    @State private var statusMessage = ""
    @State private var showStatus = false
    
    private var displayedItems: [SkinItem] {
        if !searchText.isEmpty {
            return SkinDatabase.search(searchText)
        }
        return SkinDatabase.items(for: selectedCategory)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "0d1117").ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    headerView
                    
                    // VPN Durum
                    vpnStatusBar
                    
                    // Kategori sekmeleri
                    categoryTabs
                    
                    // Arama
                    searchBar
                    
                    // Skin listesi
                    skinList
                    
                    // Uygulanan skinler ozeti
                    if !appliedSkins.isEmpty {
                        appliedSummary
                    }
                }
                
                // Durum bildirimi
                if showStatus {
                    statusToast
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
    
    // MARK: - Header
    var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("PUBG SKIN CHANGER")
                    .font(.system(size: 16, weight: .black, design: .monospaced))
                    .foregroundColor(Color(hex: "f79b00"))
                Text("iOS Client-Side  |  v1.0")
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundColor(Color(hex: "8b949e"))
            }
            Spacer()
            // VPN Toggle
            Button(action: { vpnManager.toggle() }) {
                HStack(spacing: 6) {
                    Circle()
                        .fill(vpnManager.isConnected ? Color(hex: "3fb950") : Color(hex: "f85149"))
                        .frame(width: 8, height: 8)
                    Text(vpnManager.isConnected ? "AKTİF" : "KAPALı")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(vpnManager.isConnected ? Color(hex: "3fb950") : Color(hex: "f85149"))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(Color(hex: "161b22"))
                .cornerRadius(8)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(hex: "161b22"))
    }
    
    // MARK: - VPN Status
    var vpnStatusBar: some View {
        HStack(spacing: 8) {
            Image(systemName: vpnManager.isConnected ? "shield.fill" : "shield.slash.fill")
                .foregroundColor(vpnManager.isConnected ? Color(hex: "3fb950") : Color(hex: "8b949e"))
                .font(.system(size: 12))
            Text(vpnManager.statusText)
                .font(.system(size: 11, design: .monospaced))
                .foregroundColor(Color(hex: "8b949e"))
            Spacer()
            Text("\(appliedSkins.count) skin aktif")
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundColor(Color(hex: "f79b00"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(hex: "0d1117"))
    }
    
    // MARK: - Category Tabs
    var categoryTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(SkinCategory.allCases, id: \.self) { category in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedCategory = category
                            searchText = ""
                        }
                    }) {
                        VStack(spacing: 3) {
                            Text(category.icon)
                                .font(.system(size: 18))
                            Text(category.rawValue)
                                .font(.system(size: 9, weight: .semibold, design: .monospaced))
                                .lineLimit(1)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(
                            selectedCategory == category
                            ? Color(hex: "f79b00")
                            : Color(hex: "161b22")
                        )
                        .foregroundColor(
                            selectedCategory == category
                            ? Color.black
                            : Color(hex: "8b949e")
                        )
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
        }
        .background(Color(hex: "0d1117"))
    }
    
    // MARK: - Search Bar
    var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(hex: "8b949e"))
                .font(.system(size: 14))
            TextField("Skin ara...", text: $searchText)
                .font(.system(size: 13, design: .monospaced))
                .foregroundColor(.white)
                .accentColor(Color(hex: "f79b00"))
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(hex: "8b949e"))
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 9)
        .background(Color(hex: "161b22"))
        .cornerRadius(10)
        .padding(.horizontal, 12)
        .padding(.bottom, 6)
    }
    
    // MARK: - Skin List
    var skinList: some View {
        ScrollView {
            LazyVStack(spacing: 6) {
                ForEach(displayedItems) { skin in
                    SkinRow(
                        skin: skin,
                        isApplied: appliedSkins[skin.category]?.skinID == skin.skinID,
                        onApply: { applySkin(skin) },
                        onRemove: { removeSkin(skin) }
                    )
                }
                
                if displayedItems.isEmpty {
                    VStack(spacing: 12) {
                        Text("🔍")
                            .font(.system(size: 40))
                        Text("Sonuç bulunamadı")
                            .font(.system(size: 14, design: .monospaced))
                            .foregroundColor(Color(hex: "8b949e"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 60)
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
    }
    
    // MARK: - Applied Summary
    var appliedSummary: some View {
        VStack(spacing: 0) {
            Divider().background(Color(hex: "30363d"))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(appliedSkins.values), id: \.skinID) { skin in
                        HStack(spacing: 4) {
                            Text(skin.category.icon)
                                .font(.system(size: 12))
                            Text(skin.name)
                                .font(.system(size: 10, design: .monospaced))
                                .foregroundColor(Color(hex: "f79b00"))
                                .lineLimit(1)
                            Button(action: { removeSkin(skin) }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundColor(Color(hex: "f85149"))
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(Color(hex: "161b22"))
                        .cornerRadius(6)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
        }
        .background(Color(hex: "0d1117"))
    }
    
    // MARK: - Status Toast
    var statusToast: some View {
        VStack {
            Spacer()
            Text(statusMessage)
                .font(.system(size: 13, weight: .semibold, design: .monospaced))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color(hex: "3fb950").opacity(0.9))
                .cornerRadius(20)
                .padding(.bottom, 100)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.spring(), value: showStatus)
    }
    
    // MARK: - Actions
    func applySkin(_ skin: SkinItem) {
        appliedSkins[skin.category] = skin
        vpnManager.applyClientSideSkin(skinID: skin.skinID, category: skin.category.rawValue)
        showStatusMessage("✓ \(skin.name) uygulandı")
    }
    
    func removeSkin(_ skin: SkinItem) {
        if appliedSkins[skin.category]?.skinID == skin.skinID {
            appliedSkins.removeValue(forKey: skin.category)
            vpnManager.removeSkin(category: skin.category.rawValue)
            showStatusMessage("✕ \(skin.category.rawValue) kaldırıldı")
        }
    }
    
    func showStatusMessage(_ msg: String) {
        statusMessage = msg
        withAnimation { showStatus = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation { showStatus = false }
        }
    }
}

// MARK: - Skin Row
struct SkinRow: View {
    let skin: SkinItem
    let isApplied: Bool
    let onApply: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Kategori ikonu
            Text(skin.category.icon)
                .font(.system(size: 22))
                .frame(width: 36)
            
            // Skin bilgisi
            VStack(alignment: .leading, spacing: 3) {
                Text(skin.name)
                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
                    .foregroundColor(isApplied ? Color(hex: "f79b00") : .white)
                    .lineLimit(1)
                HStack(spacing: 6) {
                    Text("ID: \(skin.skinID)")
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundColor(Color(hex: "8b949e"))
                    if isApplied {
                        Text("AKTİF")
                            .font(.system(size: 9, weight: .black, design: .monospaced))
                            .foregroundColor(Color(hex: "3fb950"))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(Color(hex: "3fb950").opacity(0.15))
                            .cornerRadius(4)
                    }
                }
            }
            
            Spacer()
            
            // Butonlar
            if isApplied {
                Button(action: onRemove) {
                    Text("KALDIR")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(hex: "f85149"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(Color(hex: "f85149").opacity(0.15))
                        .cornerRadius(7)
                }
            } else {
                Button(action: onApply) {
                    Text("UYGULA")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(hex: "f79b00"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(Color(hex: "f79b00").opacity(0.15))
                        .cornerRadius(7)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            isApplied
            ? Color(hex: "f79b00").opacity(0.07)
            : Color(hex: "161b22")
        )
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    isApplied ? Color(hex: "f79b00").opacity(0.4) : Color(hex: "30363d"),
                    lineWidth: 1
                )
        )
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}
