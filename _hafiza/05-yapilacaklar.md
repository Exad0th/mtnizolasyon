# Yapılacaklar

## 1. Hemen, kod tarafı

**Yazı tipi MIME türü.** `.htaccess` içine `AddType font/woff2 .woff2` eklendi
ama sunucuya gitmedi. `_kurulum\HTACCESS-DUZELT.bat` çalıştırılacak, sonra:

```bash
curl -s -o /dev/null -w "%{content_type}\n" https://www.mtnizolasyon.com/fonts/manrope-400-latin.woff2
```

`font/woff2` dönmeli.

**FTP hesabını silin.** Yükleme bitti, hesap açık kalmasın. Bağlantı TLS'siz
olduğu için şifre ağ üzerinde açık gitti.

## 2. Müşteriye sorulacaklar

Bunlar sitede yazıyor ama teyitsiz. En riskliden başlayarak:

1. **Çalışma saatleri.** Pazartesi-Cumartesi 08:30-18:30 diye yazıldı ve
   JSON-LD'ye işlendi. Yanlışsa Google firma kapalıyken açık gösterir.
2. **Teras uygulaması 2-5 gün.** Ana sayfa SSS'inde. Değiştirilirse JSON-LD
   `FAQPage` içindeki cevap da birebir güncellenmeli.
3. **350+ proje, 15+ yıl tecrübe, yurt dışında hizmet.** Kaynağı yok.
4. **Hangi Lonicera oteli.** Alanya'da dört tane var. Netleşirse proje
   sayfasındaki uydu gömmesi Street View gömmesine çevrilir.

## 3. Müşterinin kendi yapması gerekenler

**Google İşletme Profili.** Hazır metinler `_kurulum/google-isletme-profili.md`
içinde: 690 karakterlik firma açıklaması, kategori önerileri, hizmet listesi,
yüklenecek fotoğraf seçkisi.

**Google Search Console.** Adımlar `_kurulum/search-console-kurulum.md` içinde.
Site artık canlı olduğu için doğrulama yapılabilir. `sitemap.xml` gönderilmeli.

**Müşteri yorumları toplamak.** Yerel aramada en çok işe yarayan ve en çok
ihmal edilen adım.

## 4. Sonraki oturumda yapılabilecekler

**Canlı site denetimi.** Bugün yönlendirmeler, sayfa erişimi, başlıklar,
önbellek ve MIME türleri ölçüldü. Henüz yapılmayanlar: gerçek tarayıcıda
görsel kontrol, Core Web Vitals ölçümü, Zengin Sonuç Testi ile JSON-LD
doğrulaması, mobil görünüm.

**Sunucudaki eski dosyaların temizliği.** Eski sitenin `images` klasörü
duruyor. Hangi dosyaların artık kullanılmadığı listelenip silinebilir.

**Dalı `main` ile birleştirmek.** Şu an `seo-revizyonu` dalında çalışıyoruz.
`main` hâlâ eski tek sayfalık siteyi taşıyor. Müşteri onayından sonra
birleştirilebilir.

## Yapılmayacaklar

- **Google Görseller'den görsel almak.** Konuşuldu, reddedildi.
- **İncelenmemiş fotoğraf yayınlamak.** Altı fotoğraf gizlilik ve kalite
  gerekçesiyle elendi, aynı titizlik sürmeli.
- **Teyitsiz bilgiyi JSON-LD'ye yazmak.** Zaten yazılmış olanlar yukarıda.
