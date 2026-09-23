# PUBG Skin Changer - iOS

## Nasıl Kurulur?

### 1. Bu repoyu fork/clone et
GitHub'da bu projeyi fork et.

### 2. GitHub Actions IPA'yı otomatik build eder
- Actions sekmesine git
- "Build iOS IPA" workflow'unu çalıştır  
- Bittikten sonra Artifacts'tan `PUBGSkinChanger-IPA.zip` indir

### 3. IPA'yı telefona yükle

**AltStore ile (Ücretsiz, 7 günde bir yenileme gerekir):**
1. PC'ye AltServer kur: https://altstore.io
2. AltStore'u iPhone'a kur
3. İndirdiğin IPA'yı AltStore'a sürükle

**Sideloadly ile (Ücretsiz Apple ID yeterli):**
1. https://sideloadly.io adresinden Sideloadly indir
2. iPhone'u USB ile bağla
3. IPA'yı sürükle, Apple ID gir, Install

---

## Uyarı
Bu uygulama network tüneli açarak PUBG trafiğini yakalamaya çalışır.
Sonuç garanti değildir — SSL pinning engeli olabilir.

## İçerik
- Tüm PUBG Mobile skin ID'leri (137+ skin)
- Kategorilere göre ayrım: Silah, Kask, Sırtlık, Üst, Alt, Ayakkabı, Maske, Set, Eklenti
- Apply / Remove butonları
- Network Extension ile trafik yakalama denemesi
