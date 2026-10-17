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

**Anahtar kelime çalışmasından doğan sorular (15 Eylül):**
- **Ses yalıtımı:** kendi ekibinizle duvar, tavan veya döşemede ses yalıtımı uyguluyor musunuz, yoksa yalnızca ürün mü satıyorsunuz? mtnyapi.com sizin firmanız mı? Evetse Alanya'da yapılmış bir işin fotoğrafı ve malzeme adı gerekiyor. Cevap gelene kadar "alanya ses yalıtımı" için içerik yazılmayacak.
- **Isı yalıtımı:** su yalıtımından ayrı bir hizmet olarak yapılıyor mu? Videodan bu bölüm çıkarıldığı için sorulmalı.
- **İstatistik kutuları:** ana sayfadaki 350+ proje, 15+ yıl ve "yurt dışı hizmet" kutuları ile SSS'deki "yurt dışında da hizmet" cümlesinin dayanağı var mı?

## 3. Müşterinin kendi yapması gerekenler

**Google İşletme Profili.** Profil zaten var: Haritalar'da "MTN izolasyon", 4,7 puan, 18 yorum, kategori "İnşaat Şirketi". Adres, telefon ve web sitesi siteyle aynı. Saatler, fotoğraflar girilmiş ve "sahibi siz misiniz" satırı yok, yani bir hesap tarafından yönetiliyor. 14 Eylül'de müşterinin verdiği ilk Gmail hesabı profili yönetmiyordu; **15 Eylül'de profili yöneten hesap bulundu.** Profilde yapılacak değişikliklerin sırası ve kopyalanacak metinler `_kurulum/google-isletme-profili.md` içinde.

- Profilde: birincil kategori "İzolasyon İşleri Yüklenicisi", ikincil "Su yalıtımı servisi", ad "MTN İzolasyon", web sitesi https://www.mtnizolasyon.com, yeni proje ve hizmet fotoğrafları. Hazır metinler `_kurulum/google-isletme-profili.md` içinde.
- Haritada açılış saati 07:30, sitenin JSON-LD'si 08:30 diyor. Haftalık saatler haritadan alınıp site profile uydurulacak.

**Google Search Console.** Adımlar `_kurulum/search-console-kurulum.md` içinde. `sitemap.xml` gönderilmeli.

**Müşteri yorumları toplamak.** Yerel aramada en çok işe yarayan ve en çok ihmal edilen adım.

**Otellere tanıtım e-postası (7 Ekim 2026).** Antalya ilindeki otellerin kendi sitelerinde yayımladıkları kurumsal adreslerden bir liste ve e-posta şablonu hazırlandı. Dosyalar `_pazarlama/` klasöründe; bu klasör `.gitignore`, FTP betiğinin hariç listesi ve `.htaccess` ile depodan ve sunucudan uzak tutuluyor. **Listeyi asla depoya veya `_hafiza/`'ya kopyalama: depo herkese açık.**
- Gönderimden önce: MTN İzolasyon İYS'ye (iys.org.tr) kaydolmalı, otel adresleri "tacir" olarak girilmeli (Ticari İletişim Yönetmeliği m.6/6). Her e-postada ticaret unvanı + MERSİS, iletişim bilgisi, konuda "Tanıtım", "ÇIKAR" yanıtıyla listeden çıkma. Çıkma talebi 3 iş gününde uygulanır; kayıtlar 10 yıl saklanır.
- Kişi adına kayıtlı adresler (ad.soyad@) KVKK nedeniyle listeye alınmadı (Kurul Kararı 2022/861).
- Gönderim şirketin kendi alan adındaki bir posta kutusundan, günde 20–50, her otele ayrı e-posta. Sunucu ayarı: IMAP `lin1.nictr.com:993`, SMTP `lin1.nictr.com:465`, ikisi de SSL.
- internettescil müşteri panelinde "Module license has expired" arızası var; e-posta işlemleri hizmet sayfasındaki "Giriş Yap → Hosting Paneli" (DirectAdmin) üzerinden yapılıyor.
- Gönderim aracı `_pazarlama/gonderim/` içinde (`GONDER.bat`, kullanım `README.md`). Eksikler: şablondaki ticaret unvanı/MERSİS/imza, barındırma firmasından sunucu IP'sinin ters DNS (PTR) kaydı.

## 4. Sonraki oturumlarda yapılabilecekler

- Yükleme sonrası canlı site denetimi: hero videosu gerçek telefonda, Core Web Vitals, Zengin Sonuç Testi.
- Sunucudaki eski dosyaların temizliği: eski sitenin `images` klasörü ve artık kullanılmayan `images/hero/hero-*.webp`.
- `seo-revizyonu` dalını müşteri onayından sonra `main` ile birleştirmek.
- Otel e-posta listesi: web araması kotası dolduğu için e-postası bulunamayan ~450 büyük otel (A/B önceliği) kaldı. Betikler ve çalışma sırası `_pazarlama/betikler/README.md` içinde; yeni bir oturumda ajanlarla devam edilebilir.

## Yapılmayacaklar

- **Kaynağı belli olmayan görsel yayınlamak.** Google Görseller'den alınmaz; müşteriden gelen görselin de kimin çektiği belli olmalı.
- **İncelenmemiş fotoğraf yayınlamak.** Yüz, plaka, rakip tabelası ve siyasi pankart kontrol edilir.
- **Ürün adı gelmeden yöntem bölümü yazmak.** Malzeme bilinmeden yazılan anlatı bir kez gerçek malzemeyle çelişti.
- **"Rulo membran" demek.** Müşterinin terimi bitümlü membran.
- **Teyitsiz bilgiyi JSON-LD'ye yazmak.**
