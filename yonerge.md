# Proje: Flutter Masaüstü Okul Zili Otomasyonu

## 1. Proje Özeti
Bu proje, bir okuldaki amfi/zil sistemini otomatize eden bir masaüstü uygulamasıdır. Eski, donma ve kilitlenme sorunları yaratan Excel (VBA Makro) tabanlı sistemin yerine yazılacaktır. 
Uygulamanın temel amacı: Sistem saatini arka planda asenkron olarak dinlemek, belirlenen saatler geldiğinde ses dosyasını (mp3/wav) çalmak ve tamamen insan müdahalesiz, stabil bir şekilde çalışmaktır.

## 2. Geliştirme ve Hedef Platform Ortamı
**ÖNEMLİ NOT:** Geliştirici bu projeyi **macOS** işletim sisteminde yazacak ve test edecektir. Ancak uygulamanın nihai çalışma (production) ortamı **Windows**'tur. 
Bu nedenle, seçilecek tüm kütüphanelerin (audio, tray, startup vb.) hem macOS hem de Windows destekli (cross-platform) olması ZORUNLUDUR.

## 3. Temel Özellikler ve Mimari Beklentiler
Lütfen projeyi oluştururken aşağıdaki gereksinimleri karşılayan bir mimari kur:

*   **Yerel Veritabanı (Offline-First):** İnternet bağlantısı gerektirmemelidir. Zil saatleri (Pazartesi-Cuma döngüsü) yerel bir `JSON` dosyasında veya `Hive` / `SharedPreferences` gibi basit bir yerel veritabanında tutulmalıdır. Veri yapısı esnek olmalı; gün, saat (HH:mm) ve çalınacak ses dosyası yolu belirtilebilmelidir.
*   **Asenkron Zamanlayıcı (Kilitlenmez Yapı):** Arayüzü dondurmayacak şekilde, arka planda çalışan bir `Timer.periodic` veya `Isolate` ile her saniye sistem saati kontrol edilmelidir.
*   **Otomatik Başlatma (Auto-Start & Auto-Run):** Bilgisayar açıldığında uygulama işletim sistemiyle beraber başlamalı ve kullanıcıdan herhangi bir "Başlat" komutu beklemeden timer döngüsünü hemen aktif etmelidir.
*   **Sistem Tepsisi (System Tray):** Uygulama açıldığında varsayılan olarak gizlenmeli ve görev çubuğunda (sağ alt köşe - system tray) bir ikon olarak çalışmalıdır. Ekranda kalabalık yapmamalıdır.
*   **Medya Oynatıcı:** Zil saatleri eşleştiğinde ses dosyasını sorunsuz çalacak bir altyapı kurulmalıdır.
*   **Minimalist Arayüz:** Kullanıcı tray ikonuna tıkladığında veya uygulamayı açtığında çok basit bir arayüz görmelidir:
    *   Mevcut sistem saati.
    *   Sıradaki zilin çalacağı saat.
    *   Manuel acil durum "Zili Çal" butonu.

## 4. Önerilen Paketler (Dependencies)
Aşağıdaki paketleri veya aynı işi yapan cross-platform alternatiflerini kullanabilirsin:
*   `window_manager`: Uygulama penceresini gizlemek/göstermek ve boyutlandırmak için.
*   `tray_manager`: Sistem tepsisi (system tray) entegrasyonu için.
*   `launch_at_startup`: İşletim sistemi açılışında otomatik başlama özelliği için.
*   `audioplayers` (veya `just_audio`): Ses dosyalarını çalmak için (macOS ve Windows masaüstü desteği olduğundan emin olun).
*   State Management: Geliştirme hızını artırmak için `Provider` veya `Riverpod` kullanabilirsin.

## 5. Agent İçin Adım Adım Görevler
Lütfen projeyi şu adımlarla inşa et ve kodları modüler olarak sun:
1.  **Kurulum:** Gerekli `pubspec.yaml` bağımlılıklarını ekle ve macOS/Windows masaüstü izinlerini/yapılandırmalarını ayarla.
2.  **Veri Katmanı:** Örnek bir zil programı (örneğin 08:30 ders zili, 09:10 teneffüs zili) barındıran yerel veri modelini ve repository sınıfını oluştur.
3.  **Servis Katmanı:** Ses çalma işlemini yönetecek `AudioService` ve zaman kontrolünü yapacak `TimerService` sınıflarını yaz.
4.  **Sistem Entegrasyonu:** `main.dart` içerisinde uygulamanın başlangıçta gizli açılmasını, tray ikonunun oluşturulmasını ve işletim sistemi başlangıcına eklenmesi (startup) fonksiyonlarını yaz.
5.  **Kullanıcı Arayüzü (UI):** Sadece gerekli bilgileri gösteren, karmaşadan uzak basit bir ana ekran (Dashboard) tasarla.

Lütfen kodları yazarken, gereksiz karmaşıklıktan kaçın, temiz mimari (Clean Architecture) prensiplerine sadık kal ve Türkçe açıklama satırları ekle.