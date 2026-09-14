# Yapılacaklar

Son güncelleme: 14 Eylül 2026.

## 1. Hemen

**Tam yükleme.** 14 Eylül değişiklikleri ve 9 Eylül'deki woff2 düzeltmesi sunucuda değil. `_kurulum\FTP-YUKLE.bat` çalıştırılacak. Ek doğrulama komutları [04-yayin.md](04-yayin.md) içinde.

**FTP hesabını silin.** Yükleme bitince. Bağlantı TLS'siz, şifre ağ üzerinde açık gidiyor.

## 2. Müşteriye sorulacaklar

1. **Mövenpick künyesi:** alan (m²), işveren ve otel adını kullanma izni hâlâ eksik. Tarih 2023, süre 2 ay, garanti 5 yıl ve malzeme Sika tekstil membran işlendi. Tam ürün adı gelirse yöntem bölümü yazılır; ay bilgisi gelirse künye ve JSON-LD `dateCreated` netleşir.
2. **Kristalize yalıtım için doğru fotoğraf.**
3. **Tanıtım videosunda "BİTÜMLÜ MEMBRAN UYGULAMA" başlığı** "UYGULAMASI" olmalı. Yazı videoya gömülü; düzeltilmiş çıktı gelirse aynı kesimle (41,1–50,4 sn çıkarılır) yeniden üretilir ve dosya adı değiştirilir.
4. **Çalışma saatleri.** Pazartesi-Cumartesi 08:30-18:30 diye JSON-LD'ye işlendi, teyitsiz. Yanlışsa Google firma kapalıyken açık gösterir.
5. **Teras uygulaması 2-5 gün** (ana sayfa SSS). Değişirse JSON-LD `FAQPage` cevabı da birebir değişmeli.
6. **350+ proje, 15+ yıl tecrübe, yurt dışında hizmet.** Kaynağı yok.

## 3. Müşterinin kendi yapması gerekenler

**Google İşletme Profili.** Profil zaten var: Haritalar'da "MTN izolasyon", 4,7 puan, 18 yorum, kategori "İnşaat Şirketi". Adres, telefon ve web sitesi siteyle aynı. Saatler, fotoğraflar girilmiş ve "sahibi siz misiniz" satırı yok, yani bir hesap tarafından yönetiliyor. Müşterinin 14 Eylül'de verdiği Gmail hesabı profili yönetmiyor: business.google.com/locations sayfasında 0 işletme görünüyor.

- Yönetici hesap müşteriye sorulacak: telefonundaki Google hesabı, eski web tasarımcısı veya ajans, profil e-postalarının geldiği adres.
- Bulunamazsa business.google.com/add üzerinden işletme aranıp erişim isteği gönderilecek. Bu akış mevcut sahibin e-posta adresinin bir kısmını gösterir. **Yeni profil açılmayacak**, çift kayıt sıralamaya zarar verir.
- Erişim gelince: birincil kategori "Su yalıtımı servisi", ad "MTN İzolasyon", web sitesi https://www.mtnizolasyon.com, yeni proje ve hizmet fotoğrafları. Hazır metinler `_kurulum/google-isletme-profili.md` içinde.
- Haritada açılış saati 07:30, sitenin JSON-LD'si 08:30 diyor. Haftalık saatler haritadan alınıp site profile uydurulacak.

**Google Search Console.** Adımlar `_kurulum/search-console-kurulum.md` içinde. `sitemap.xml` gönderilmeli.

**Müşteri yorumları toplamak.** Yerel aramada en çok işe yarayan ve en çok ihmal edilen adım.

## 4. Sonraki oturumlarda yapılabilecekler

- Yükleme sonrası canlı site denetimi: hero videosu gerçek telefonda, Core Web Vitals, Zengin Sonuç Testi.
- Sunucudaki eski dosyaların temizliği: eski sitenin `images` klasörü ve artık kullanılmayan `images/hero/hero-*.webp`.
- `seo-revizyonu` dalını müşteri onayından sonra `main` ile birleştirmek.

## Yapılmayacaklar

- **Kaynağı belli olmayan görsel yayınlamak.** Google Görseller'den alınmaz; müşteriden gelen görselin de kimin çektiği belli olmalı.
- **İncelenmemiş fotoğraf yayınlamak.** Yüz, plaka, rakip tabelası ve siyasi pankart kontrol edilir.
- **Ürün adı gelmeden yöntem bölümü yazmak.** Malzeme bilinmeden yazılan anlatı bir kez gerçek malzemeyle çelişti.
- **"Rulo membran" demek.** Müşterinin terimi bitümlü membran.
- **Teyitsiz bilgiyi JSON-LD'ye yazmak.**
