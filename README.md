<p align="center">
  <img src="assets/icon.png" alt="Okul Zili Logo" width="150"/>
</p>

<h1 align="center">Okul Zili (School Bell App) 🔔</h1>

<p align="center">
  Modern, kullanıcı dostu ve gelişmiş bir Okul Zili otomasyon sistemi. Flutter kullanılarak geliştirilmiş olup, okullar ve eğitim kurumları için otomatik ders zili, manuel acil durum/teneffüs zili yönetimi ve sistem tepsisi (tray) desteği sunar.
</p>

---

## ✨ Özellikler

- **⏰ Otomatik Zil Yönetimi:** Günlere ve saatlere göre detaylı zil planlaması yapabilirsiniz.
- **🛠 Manuel Zil Kontrolü:** Teneffüs, İstiklal Marşı ve Öğrenci Giriş zillerini tek tıkla çalabilirsiniz.
- **📊 Excel Entegrasyonu:** Zil programlarını Excel dosyasından kolayca içe aktarın.
- **🔊 Ses Kontrolü:** Uygulama içinden direkt olarak zil ses seviyesini ayarlayın.
- **💻 Arka Planda Çalışma (System Tray):** Uygulamayı kapatsanız bile sistem tepsisinde (tray) sessizce çalışmaya devam eder.
- **🚀 Açılışta Otomatik Başlatma (Auto-start):** Bilgisayar açıldığında sistemle birlikte otomatik olarak başlar.
- **🎨 Modern ve Responsive Arayüz:** Her ekran boyutuna uyumlu, şık ve gece/gündüz göz yormayan modern tasarım.

## 🛠 Kurulum ve Geliştirme

Projeyi yerel ortamınızda çalıştırmak ve derlemek için aşağıdaki adımları izleyin.

### 📋 Gereksinimler
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (sürüm 3.13.x veya üzeri önerilir)
- [Dart SDK](https://dart.dev/get-dart)
- macOS için Xcode (macOS build almak için)
- Windows için Visual Studio (Windows build almak için)

### 🚀 Geliştirme Ortamını Kurma

1. Depoyu bilgisayarınıza indirin:
   ```bash
   git clone https://github.com/bugraykann/okul_zil.git
   cd okul_zil
   ```

2. Paketleri ve bağımlılıkları indirin:
   ```bash
   flutter clean
   flutter pub get
   ```

3. Geliştirme modunda başlatın:
   ```bash
   flutter run -d macos   # macOS için
   flutter run -d windows # Windows için
   ```

---

## 📦 Build Alma (Derleme ve Kurulum Dosyası Oluşturma)

### 🍎 macOS için Derleme

macOS cihazlar için `.app` uzantılı native çıktı almak oldukça kolaydır:
```bash
flutter build macos --release
```
Derleme bittikten sonra çıktı şu dizinde yer alır:
`build/macos/Build/Products/Release/okul_zil.app`
Bu dosyayı doğrudan **Applications (Uygulamalar)** klasörüne sürükleyebilirsiniz.

### 🪟 Windows için Derleme ve Kurulum Dosyası (MSIX) Üretme

Projeyi Windows için derlemek ve bir kurulum paketi hazırlamak için:

1. Önce standart Flutter Windows build komutunu çalıştırın:
   ```bash
   flutter build windows --release
   ```
2. Kullanıcılara kurulum (Setup) dosyası vermek için projede kurulu olan `msix` paketini kullanın:
   ```bash
   dart run msix:create
   ```
   Bu komut tamamlandığında `build/windows/x64/runner/Release/` dizininde **OkulZilim.msix** adlı Windows uygulama kurulum dosyanız (installer) oluşacaktır.

---

## ☕ Destek Olun

Eğer bu projeyi faydalı bulduysanız veya okullarınızda kullanıyorsanız, geliştiriciye bir kahve ısmarlayarak destek olabilirsiniz! Sol alttaki kahve butonuna tıklayabilir veya doğrudan aşağıdaki bağlantıyı kullanabilirsiniz:

[<img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="180">](https://buymeacoffee.com/bgraykn)

## 📄 Lisans

Bu proje, açık kaynaklı bir proje olup kişisel ve eğitim amaçlı kullanıma uygundur. Ayrıntılar için geliştirici (Bugra Aykan) ile iletişime geçebilirsiniz.
