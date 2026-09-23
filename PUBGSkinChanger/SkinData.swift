import Foundation

// MARK: - Skin Model
struct SkinItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let skinID: Int
    let category: SkinCategory
}

enum SkinCategory: String, CaseIterable {
    case weapon      = "Silahlar"
    case helmet      = "Kasklар & Sapkalar"
    case backpack    = "Sırtlık & Çanta"
    case top         = "Üst Giysi"
    case bottom      = "Alt Giysi"
    case shoes       = "Ayakkabı"
    case mask        = "Maske & Aksesuar"
    case set         = "Tam Set / X-Suit"
    case attachment  = "Eklentiler"
    
    var icon: String {
        switch self {
        case .weapon:     return "🔫"
        case .helmet:     return "⛑️"
        case .backpack:   return "🎒"
        case .top:        return "👕"
        case .bottom:     return "👖"
        case .shoes:      return "👟"
        case .mask:       return "🎭"
        case .set:        return "⚡"
        case .attachment: return "🔧"
        }
    }
}

// MARK: - Skin Database
struct SkinDatabase {
    
    static let all: [SkinItem] = weapons + helmets + backpacks + tops + bottoms + shoes + masks + sets + attachments
    
    static let weapons: [SkinItem] = [
        SkinItem(name: "Shinobi Kami M416 - Lv1 (Temel)",    skinID: 1101004211, category: .weapon),
        SkinItem(name: "Shinobi Kami M416 - Lv6 (Nihai)",    skinID: 1101004216, category: .weapon),
        SkinItem(name: "Shinobi Kami M416 - Lv8 (Prestij)",  skinID: 1101004218, category: .weapon),
        SkinItem(name: "Gocebe M416 - Lv1",                  skinID: 1101004072, category: .weapon),
        SkinItem(name: "Gocebe M416 - Lv6 (Nihai)",          skinID: 1101004077, category: .weapon),
        SkinItem(name: "Buz Diyari M416 - Lv1",              skinID: 1101004041, category: .weapon),
        SkinItem(name: "Buz Diyari M416 - Lv6 (Nihai)",      skinID: 1101004046, category: .weapon),
        SkinItem(name: "Soytari M416 - Lv1",                 skinID: 1101004057, category: .weapon),
        SkinItem(name: "Soytari M416 - Lv6 (Nihai)",         skinID: 1101004061, category: .weapon),
        SkinItem(name: "Kertenkele M416 - Lv6",              skinID: 1101004086, category: .weapon),
        SkinItem(name: "Smooth Hitman AKM",                  skinID: 1101001033, category: .weapon),
        SkinItem(name: "Rock Star AKM",                      skinID: 1101001009, category: .weapon),
        SkinItem(name: "Komutan SCAR-L",                     skinID: 1101003063, category: .weapon),
        SkinItem(name: "RE2 Licker SCAR-L",                  skinID: 1101003058, category: .weapon),
        SkinItem(name: "BAPE Pan",                           skinID: 1108004062, category: .weapon),
        SkinItem(name: "Rodan Tavasi",                       skinID: 1108004071, category: .weapon),
        SkinItem(name: "Aristokrat Tava",                    skinID: 1108004373, category: .weapon),
    ]
    
    static let helmets: [SkinItem] = [
        SkinItem(name: "Dikenli Kask (Inferno Rider)",        skinID: 1522120, category: .helmet),
        SkinItem(name: "RE2 Mutasyon Kaski",                  skinID: 1522063, category: .helmet),
        SkinItem(name: "Mekanize Kask (S7 RP)",               skinID: 1522164, category: .helmet),
        SkinItem(name: "Ay Tavsani Kaski",                    skinID: 1522141, category: .helmet),
        SkinItem(name: "Komutan Kaski Lv3",                   skinID: 502118,  category: .helmet),
        SkinItem(name: "Celik Muhafiz Kaski",                 skinID: 1402241, category: .helmet),
        SkinItem(name: "Gece Korkusu Basligi",                skinID: 1402698, category: .helmet),
        SkinItem(name: "Komutan Sapkasi",                     skinID: 1400092, category: .helmet),
        SkinItem(name: "S3 Savas Sapkasi",                    skinID: 401037,  category: .helmet),
        SkinItem(name: "Vahsi Bati Deri Sapkasi",             skinID: 401038,  category: .helmet),
        SkinItem(name: "Siyah Gul Kasketi",                   skinID: 401043,  category: .helmet),
        SkinItem(name: "Beyaz Gul Kasketi",                   skinID: 401044,  category: .helmet),
        SkinItem(name: "Iblis Avcisi Sapkasi",                skinID: 1400734, category: .helmet),
        SkinItem(name: "Ruya Kahraman Taci",                  skinID: 1402210, category: .helmet),
        SkinItem(name: "Yildirim Alevi Sacligi",              skinID: 1402260, category: .helmet),
    ]
    
    static let backpacks: [SkinItem] = [
        SkinItem(name: "Batman Cantasi Lv1",                  skinID: 1501001025, category: .backpack),
        SkinItem(name: "Batman Cantasi Lv2",                  skinID: 1501001026, category: .backpack),
        SkinItem(name: "Batman Cantasi Lv3",                  skinID: 1501001027, category: .backpack),
        SkinItem(name: "Sakaci Sirtligi Lv1",                 skinID: 1501001052, category: .backpack),
        SkinItem(name: "Sakaci Sirtligi Lv3",                 skinID: 1501001054, category: .backpack),
        SkinItem(name: "Dus Yargici Sirtligi",                skinID: 1534176,    category: .backpack),
        SkinItem(name: "Firavun Sirtligi Lv3",                skinID: 1501001067, category: .backpack),
        SkinItem(name: "Kuzgun Sirtligi Lv3",                 skinID: 1501001087, category: .backpack),
        SkinItem(name: "Gece Korkusu Cantasi Lv3",            skinID: 1501001093, category: .backpack),
        SkinItem(name: "Beyaz Melek Sirtligi Lv3",            skinID: 1501001050, category: .backpack),
        SkinItem(name: "Seytan Cantasi Lv3",                  skinID: 1501001039, category: .backpack),
        SkinItem(name: "Asik Tavsan Canta Lv3",               skinID: 1501001060, category: .backpack),
        SkinItem(name: "Ryan Sirtligi Lv3",                   skinID: 1501001114, category: .backpack),
        SkinItem(name: "Ay Tavsani Sandigi",                  skinID: 1514741,    category: .backpack),
        SkinItem(name: "Godzilla Sirt Kabugu",                skinID: 1405160,    category: .backpack),
        SkinItem(name: "Ghidorah Sirt Kabugu",                skinID: 1405161,    category: .backpack),
    ]
    
    static let tops: [SkinItem] = [
        SkinItem(name: "Komutan Palto",                       skinID: 1400101, category: .top),
        SkinItem(name: "Freestyle Ustu",                      skinID: 1404166, category: .top),
        SkinItem(name: "Mekanik Horoz Ustu",                  skinID: 1404158, category: .top),
        SkinItem(name: "Isiltili Dansci Ustu",                skinID: 1404174, category: .top),
        SkinItem(name: "Aristokrat Ustu",                     skinID: 1404131, category: .top),
        SkinItem(name: "Korsan Ustu",                         skinID: 1400265, category: .top),
        SkinItem(name: "Kovboy Deri Yelegi",                  skinID: 403185,  category: .top),
        SkinItem(name: "BAPE Kopekbaligi Kapusonlu",          skinID: 1404049, category: .top),
        SkinItem(name: "BAPE Camo T-Shirt",                   skinID: 1404048, category: .top),
        SkinItem(name: "Walker Hoodie",                       skinID: 1404017, category: .top),
        SkinItem(name: "Tavsan Sezonu Kapusonlu",             skinID: 1404284, category: .top),
        SkinItem(name: "Godzilla Blue T-Shirt",               skinID: 1404024, category: .top),
        SkinItem(name: "Rodan Red T-Shirt",                   skinID: 1404023, category: .top),
        SkinItem(name: "Pofuduk Tavsan Tulumu",               skinID: 1400295, category: .top),
    ]
    
    static let bottoms: [SkinItem] = [
        SkinItem(name: "Komutan Pantolonu",                   skinID: 1400122, category: .bottom),
        SkinItem(name: "Freestyle Pantolonu",                 skinID: 1404167, category: .bottom),
        SkinItem(name: "Mekanik Horoz Alti",                  skinID: 1404159, category: .bottom),
        SkinItem(name: "Isiltili Dansci Pantolonu",           skinID: 1404175, category: .bottom),
        SkinItem(name: "Aristokrat Alti",                     skinID: 1404132, category: .bottom),
        SkinItem(name: "BAPE Basketbol Sortu",                skinID: 1404050, category: .bottom),
        SkinItem(name: "Walker Pants",                        skinID: 1404044, category: .bottom),
        SkinItem(name: "Tavsan Sezonu Tayti",                 skinID: 1404285, category: .bottom),
    ]
    
    static let shoes: [SkinItem] = [
        SkinItem(name: "BAPE Basketbol Ayakkabisi",           skinID: 1404051, category: .shoes),
        SkinItem(name: "BAPE Sta Mid Ayakkabi",               skinID: 1404003, category: .shoes),
        SkinItem(name: "Walker Shoes",                        skinID: 1404045, category: .shoes),
        SkinItem(name: "Tavsan Sezonu Ayakkabi",              skinID: 1404286, category: .shoes),
    ]
    
    static let masks: [SkinItem] = [
        SkinItem(name: "Pofuduk Tavsan Maskesi",              skinID: 1400294, category: .mask),
        SkinItem(name: "Crew Zafer Maskesi",                  skinID: 1402244, category: .mask),
        SkinItem(name: "Mutlu Infazci Siyah Sapka",           skinID: 1402154, category: .mask),
        SkinItem(name: "Mutlu Infazci Altin Sapka",           skinID: 1402155, category: .mask),
        SkinItem(name: "Kanun Kacagi Sapkasi",                skinID: 1400426, category: .mask),
        SkinItem(name: "Pofuduk Tavsan Sapkasi",              skinID: 1400293, category: .mask),
    ]
    
    static let sets: [SkinItem] = [
        SkinItem(name: "Altin Firavun X-Suit (7 Yildiz)",    skinID: 1405629, category: .set),
        SkinItem(name: "Altin Firavun X-Suit (6 Yildiz)",    skinID: 1405628, category: .set),
        SkinItem(name: "Kuzgun X-Suit (7 Yildiz)",           skinID: 1405872, category: .set),
        SkinItem(name: "Kuzgun X-Suit (6 Yildiz)",           skinID: 1405870, category: .set),
        SkinItem(name: "Dravion X-Suit",                     skinID: 1407667, category: .set),
        SkinItem(name: "Soytari Kostumu",                    skinID: 1405092, category: .set),
        SkinItem(name: "Mavi Hayalet Giysisi",               skinID: 1405164, category: .set),
        SkinItem(name: "Gul Desenli Tuvalet (Pink Rose)",    skinID: 1405130, category: .set),
        SkinItem(name: "Mutlu Infazci (Siyah)",              skinID: 1405332, category: .set),
        SkinItem(name: "Mutlu Infazci (Altin)",              skinID: 1405333, category: .set),
        SkinItem(name: "Crew Sampiyon Seti (Kirmizi)",       skinID: 1405282, category: .set),
        SkinItem(name: "Crew Katilimci Seti (Yesil)",        skinID: 1405283, category: .set),
        SkinItem(name: "Kelebek Dovuscusu",                  skinID: 1406586, category: .set),
        SkinItem(name: "Sirk Danscisi Giysisi",              skinID: 1400259, category: .set),
        SkinItem(name: "Kanun Kacagi Giysisi",               skinID: 1400425, category: .set),
        SkinItem(name: "RE2 Claire Redfield",                skinID: 1405063, category: .set),
        SkinItem(name: "RE2 Leon Kennedy",                   skinID: 1405065, category: .set),
        SkinItem(name: "RE2 Ada Wong",                       skinID: 1405069, category: .set),
    ]
    
    static let attachments: [SkinItem] = [
        SkinItem(name: "Kompansator (AR)",                   skinID: 201009, category: .attachment),
        SkinItem(name: "Susturucu (AR)",                     skinID: 201011, category: .attachment),
        SkinItem(name: "Alev Gizleyen",                      skinID: 201010, category: .attachment),
        SkinItem(name: "Sarjor (Uzatilmis)",                 skinID: 204013, category: .attachment),
        SkinItem(name: "Dipcik M416",                        skinID: 205002, category: .attachment),
        SkinItem(name: "Kirmizi Nokta",                      skinID: 203001, category: .attachment),
        SkinItem(name: "4x ACOG Durbun",                     skinID: 203005, category: .attachment),
        SkinItem(name: "6x Durbun",                          skinID: 203006, category: .attachment),
        SkinItem(name: "Dikey Tutamak",                      skinID: 202001, category: .attachment),
        SkinItem(name: "Lazer Nisangah",                     skinID: 202007, category: .attachment),
    ]
    
    static func items(for category: SkinCategory) -> [SkinItem] {
        all.filter { $0.category == category }
    }
    
    static func search(_ query: String) -> [SkinItem] {
        guard !query.isEmpty else { return all }
        return all.filter {
            $0.name.localizedCaseInsensitiveContains(query) ||
            "\($0.skinID)".contains(query)
        }
    }
}
