# Yapılacaklar

Son güncelleme: 14 Eylül 2026.

## 1. Hemen

**Tam yükleme.** 14 Eylül değişiklikleri ve 9 Eylül'deki woff2 düzeltmesi sunucuda değil. `_kurulum\FTP-YUKLE.bat` çalıştırılacak. Ek doğrulama komutları [04-yayin.md](04-yayin.md) içinde.

**FTP hesabını silin.** Yükleme bitince. Bağlantı TLS'siz, şifre ağ üzerinde açık gidiyor.

## 2. Müşteriye sorulacaklar

1. **Oba Stadyumu drone fotoğrafını kim çekti?** Firmanın kendi çekimiyse sayfaya konur, değilse konmaz.
2. **Hyundai fabrika fotoğrafını kim çekti?** Kendi çekimi olsa bile tüm fabrikayı gösterdiği için "Hyundai fabrikasının yalıtımını yaptık" izlenimi verir. Proje sahasının kendi fotoğrafı tercih edilmeli.
3. **Mövenpick Tekirova verileri:** tarih, m², malzeme ve ürün adı, süre, garanti, otel adını kullanma izni, havuz olup olmadığı. Veri gelince Lonicera sayfası Mövenpick ile değiştirilecek, eski adresten 301 verilecek.
4. **Kristalize yalıtım için doğru fotoğraf.**
5. **Tanıtım videosunda "BİTÜMLÜ MEMBRAN UYGULAMA" başlığı** "UYGULAMASI" olmalı. Yazı videoya gömülü; düzeltilmiş çıktı gelirse aynı kesimle (41,1–50,4 sn çıkarılır) yeniden üretilir ve dosya adı değiştirilir.
6. **Çalışma saatleri.** Pazartesi-Cumartesi 08:30-18:30 diye JSON-LD'ye işlendi, teyitsiz. Yanlışsa Google firma kapalıyken açık gösterir.
7. **Teras uygulaması 2-5 gün** (ana sayfa SSS). Değişirse JSON-LD `FAQPage` cevabı da birebir değişmeli.
8. **350+ proje, 15+ yıl tecrübe, yurt dışında hizmet.** Kaynağı yok.

## 3. Müşterinin kendi yapması gerekenler

**Google İşletme Profili.** Hazır metinler `_kurulum/google-isletme-profili.md` içinde. Lonicera geçiyorsa Mövenpick verisi gelince güncellenmeli.

**Google Search Console.** Adımlar `_kurulum/search-console-kurulum.md` içinde. `sitemap.xml` gönderilmeli.

**Müşteri yorumları toplamak.** Yerel aramada en çok işe yarayan ve en çok ihmal edilen adım.

## 4. Sonraki oturumlarda yapılabilecekler

- Yükleme sonrası canlı site denetimi: hero videosu gerçek telefonda, Core Web Vitals, Zengin Sonuç Testi.
- Sunucudaki eski dosyaların temizliği: eski sitenin `images` klasörü ve artık kullanılmayan `images/hero/hero-*.webp`.
- `seo-revizyonu` dalını müşteri onayından sonra `main` ile birleştirmek.

## Yapılmayacaklar

- **Kaynağı belli olmayan görsel yayınlamak.** Google Görseller'den alınmaz; müşteriden gelen görselin de kimin çektiği belli olmalı.
- **İncelenmemiş fotoğraf yayınlamak.** Yüz, plaka, rakip tabelası ve siyasi pankart kontrol edilir.
- **Veri gelmeden proje sayfası yazmak.** Malzeme bilinmeden yazılan anlatı bir kez gerçek malzemeyle çelişti.
- **"Rulo membran" demek.** Müşterinin terimi bitümlü membran.
- **Teyitsiz bilgiyi JSON-LD'ye yazmak.**
