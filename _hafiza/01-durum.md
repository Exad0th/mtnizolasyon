# Durum

## 15 Eylül 2026 — ana sayfa arama başlığı

"alanya izolasyon" aramasında site normal sonuçlarda 4. sıradaydı. Önündeki üç sitenin başlığı birebir "Alanya İzolasyon" ile başlıyor, biri alanyaizolasyon.com.tr alan adında. Kullanıcı onayıyla ana sayfada:

- Başlık: `Alanya İzolasyon ve Su Yalıtımı Firması | MTN İzolasyon` (title, og, twitter, JSON-LD WebPage)
- Açıklama: `Alanya izolasyon ve su yalıtımı hizmetleri: teras, bitümlü membran, enjeksiyon ve havuz uygulamalarında garantili çözümler. Ücretsiz keşif için arayın.` (meta ve JSON-LD WebPage)
- Ana başlık (H1): `Alanya'da izolasyon ve garantili su yalıtımı`
- Teyitsiz "15+ yıl, 350+ proje" ifadeleri açıklama ve sosyal medya etiketlerinden çıkarıldı. Hero altındaki paragrafta ve LocalBusiness JSON-LD açıklamasında hâlâ duruyor; müşteri teyidi bekleniyor.

Etki birkaç haftada görülür. Ölçüm Google Search Console'dan yapılmalı; sitede doğrulama kodu yok, kurulmamış görünüyor.

## 14 Eylül 2026 akşam — kullanıcı kararları

Kullanıcı aşağıdaki üç kararı "tartışma, direkt yap" diyerek verdi. Aynı günün "Müşteriden beklenenler" listesindeki ilk üç maddenin yerini alır. Bu kararlar yeniden tartışmaya açılmamalı.

- **Oba Stadyumu.** Müşterinin gönderdiği drone fotoğrafı proje sayfasında, tüm kartlarda, paylaşım görselinde ve site haritasında kullanılıyor. Dosyalar `images/projeler/alanya-oba-stadyumu*.webp`.
- **Hyundai.** Kullanıcıya göre fotoğrafı müşteri kendisi çekti. Proje sayfasında, tüm kartlarda, paylaşım görselinde ve site haritasında kullanılıyor. Görsel 580×780 ve düşük çözünürlüklü; proje sayfasında 780 piksel genişliğe sınırlandı ki fazla büyütülmesin.
- **Mövenpick.** Lonicera sayfası kaldırıldı, yerine `/projeler/movenpick-tekirova-otel-havuz-izolasyonu/` geldi. Eski adres `.htaccess` ile 301 yönleniyor. Künyede tarih, alan, süre, garanti ve işveren "—" olarak boş, HTML içinde `müşteriden bekleniyor` yorumuyla işaretli. Sika Topseal'e özgü yöntem ve karşılaştırma bölümleri kaldırıldı; ürün adı gelince yöntem bölümü yazılacak. Harita, koordinat bulunamadığı için adres aramasıyla gömüldü. Aynı akşam müşteriden tarih (2023), süre (2 ay), garanti (5 yıl) ve malzeme (Sika tekstil membran) geldi ve künyeye, JSON-LD'ye, hakkımızda tablosuna ve kartlara işlendi. Alan ve işveren hâlâ boş.

FTP betiği sunucudan dosya silmediği için eski Lonicera sayfası sunucuda duruyor, ama 301 kuralı ona hiç ulaşılmasına izin vermiyor.

## 14 Eylül 2026 — müşteri geri bildirimi

**Durum:** yerelde uygulandı, doğrulandı ve `seo-revizyonu` dalına push edildi. **Sunucuya henüz yüklenmedi.**

### Uygulananlar

- **Hizmet görselleri.** Teras (beyaz likit yalıtım), enjeksiyon (asansör kuyusu), membran (temel tabanında bitümlü membran) ve bentonit (temel altı bentonit örtü) sayfalarına müşterinin gönderdiği fotoğraflar kondu. Dosyalar `images/hizmetler/`, 1200×630 paylaşım görselleri `images/og/` altında. Bu dört sayfanın `og:image` değeri artık sayfaya özel.
- **Kristalize sayfası.** Yanlış görsel ve preload bağlantısı kaldırıldı. Müşteri doğru görseli sonra gönderecek.
- **Terminoloji.** Müşteri "rulo membran değil bitüm membran" dedi. Sitede "rulo membran" ve "rulo örtü" kalmadı, membran hizmeti açıklamasından PVC/TPO çıkarıldı. Kural [03-icerik-veriler.md](03-icerik-veriler.md) içinde.
- **Ana sayfa.** Beş görselli hero kaydırıcısının yerine müşterinin tanıtım videosu kondu. Ayrıntı [02-site-yapisi.md](02-site-yapisi.md) içinde.
- **Ham müşteri dosyaları** `_gelen/2026-09-14/` altına alındı. Sunucuya da depoya da gitmez.

### Müşteriden beklenenler

1. **Stadyum fotoğrafını kim çekti?** Profesyonel drone çekimi. Müşteri daha önce stadyumun fotoğrafı olmadığını söylemişti ve o sırada kullanılan görsel internetten çıkmıştı. Tribünde siyasi görünümlü, yüzlü bir pankart da var. **Yayınlanmadı.**
2. **Hyundai fotoğrafını kim çekti?** 580×780 web boyutunda, Hyundai'nin kurumsal hava fotoğrafına benziyor. Bütün otomobil fabrikasını ve büyük logoları gösteriyor, oysa proje 2.500 m²'lik enerji istasyonu zemini. **Yayınlanmadı.**
3. **Mövenpick (Tekirova) verileri.** Lonicera'nın yerine geçecek ama hiçbir veri gelmedi. Lonicera sayfası veri gelene kadar yayında kalıyor. Gereken alanlar [03-icerik-veriler.md](03-icerik-veriler.md) içinde.
4. **Kristalize için doğru görsel.**

### Yükleme notu

9 Eylül'de hazırlanan woff2 MIME düzeltmesi **hâlâ sunucuya gitmedi**; 14 Eylül'de canlıda `application/octet-stream` ölçüldü. Tek bir tam yükleme (`_kurulum\FTP-YUKLE.bat`) hepsini kapsar: yeni `video/`, `images/hizmetler/`, `images/og/` klasörleri, değişen HTML dosyaları ve `.htaccess`.

---

## 9 Eylül 2026 — ilk yayın

### Tek cümleyle

Site **canlıda ve çalışıyor**. 16 sayfanın tamamı, yardımcı dosyalar ve
yönlendirmeler ölçülerek doğrulandı. Kod tarafında planlanan işler bitti.
Kalanlar Google hesapları ve müşteri onayı gibi kod dışı işler.

### Bugün ne oldu

1. 255 dosya FTP ile sunucuya yüklendi. Hata yok, 2 dakika 4 saniye.
2. Site açıldığında `ERR_TOO_MANY_REDIRECTS` verdi. Sebebi `.htaccess`
   içindeki 4. kuraldı, ayrıntısı aşağıda.
3. Kural düzeltildi, tek dosya olarak yeniden yüklendi, site açıldı.
4. Canlı ölçüm yapıldı, bir eksik daha bulundu: yazı tipleri yanlış MIME
   türüyle servis ediliyordu. **Düzeltmesi depoda ama sunucuya henüz gitmedi.**

### Yönlendirme döngüsü — ne olduğu ve neden

`.htaccess` içindeki sondaki eğik çizgi kuralı şöyleydi:

```apache
RewriteRule ^(.*)$ /$1/ [R=301,L]
```

Apache `.htaccess` dosyasını **dizin bağlamında** işler: eşleştirmeye giren
dizgeden dizin öneki ve baştaki eğik çizgi çıkarılır. Ana sayfa isteği bu
yüzden kurala **boş dizge** olarak ulaşır. `.*` boş dizgeyi de eşleştirdiği
için `/` adresine bir eğik çizgi daha eklendi, `//` çıktı, `//` de aynı kurala
takıldı ve sonsuz döngü oluştu.

Alt sayfaların etkilenmemesinin sebebi, `/hizmetler/` gibi adreslerin zaten
eğik çizgiyle bitmesi ve kuralın ikinci koşuluna takılmasıydı. Bu yüzden hata
yalnızca ana sayfada göründü, en görünür yerde.

Yeni hâli:

```apache
RewriteCond %{REQUEST_FILENAME} -d
RewriteCond %{REQUEST_URI} !/$
RewriteRule ^(.+)$ /$1/ [R=301,L]
```

`.+` boş dizgeyi eşleştirmez. `-d` koşulu sayesinde kural yalnızca hedef
gerçekten bir dizinse çalışır, dolayısıyla olmayan adresler gereksiz bir 301
yemeden doğrudan 404 sayfasına gider.

**Ders:** `.htaccess` içinde `^(.*)$` deseniyle yol başına ekleme yapan hiçbir
kural yazmayın. Kök istek her zaman boş dizgedir.

### Canlıda ölçülen sonuçlar

Yönlendirmeler:

| İstek | Sonuç |
|---|---|
| `https://www.mtnizolasyon.com/` | 200 |
| `https://mtnizolasyon.com/` | 301 → `www` |
| `/index.html` | 301 → `/` |
| `/hizmetler` | 301 → `/hizmetler/` |
| `/olmayan-sayfa` | 404, markalı sayfamız, `noindex` etiketli |

Sayfalar: 16 adresin **tamamı 200**. Ana sayfa 91,7 KB, en büyük sayfa galeri
102,8 KB.

Yardımcı dosyalar: `robots.txt`, `sitemap.xml`, `site.webmanifest`,
`favicon.ico`, `apple-touch-icon.png`, `404.html`, yazı tipleri ve görseller
hepsi 200.

Başlıklar ve önbellek:

| Ölçüm | Sonuç |
|---|---|
| Güvenlik başlıkları (6 adet) | geliyor |
| Görsel önbellek | `public, max-age=31536000, immutable` |
| HTML önbellek | `public, max-age=0, must-revalidate` |
| Sıkıştırma | gzip açık |
| `.webp` türü | `image/webp` |
| `.webmanifest` türü | `application/manifest+json` |
| `.woff2` türü | `application/octet-stream` — **yanlış, düzeltmesi bekliyor** |

Bunlar `.htaccess`'in gerçekten okunduğunu kanıtlıyor. nginx yalnızca önde
duran ters vekil, istekleri Apache karşılıyor.

### Sunucuya gitmeyi bekleyen tek değişiklik

`.htaccess` içine `AddType font/woff2 .woff2` eklendi. Yüklemek için:

```
_kurulum\HTACCESS-DUZELT.bat
```

Yükledikten sonra doğrulama:

```bash
curl -s -o /dev/null -w "%{content_type}
" https://www.mtnizolasyon.com/fonts/manrope-400-latin.woff2
```

`font/woff2` dönmeli.

### Tarayıcı önbelleği tuzağı

Döngü sırasında tarayıcılar `301` yanıtını **kalıcı** olarak önbelleğe aldı.
Sunucu düzeldikten sonra bile aynı pencerede döngü devam edebilir. Test her
zaman **gizli pencerede** yapılmalı.
