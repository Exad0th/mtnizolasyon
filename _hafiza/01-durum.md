# Durum — 9 Eylül 2026

## Tek cümleyle

Site **canlıda ve çalışıyor**. 16 sayfanın tamamı, yardımcı dosyalar ve
yönlendirmeler ölçülerek doğrulandı. Kod tarafında planlanan işler bitti.
Kalanlar Google hesapları ve müşteri onayı gibi kod dışı işler.

## Bugün ne oldu

1. 255 dosya FTP ile sunucuya yüklendi. Hata yok, 2 dakika 4 saniye.
2. Site açıldığında `ERR_TOO_MANY_REDIRECTS` verdi. Sebebi `.htaccess`
   içindeki 4. kuraldı, ayrıntısı aşağıda.
3. Kural düzeltildi, tek dosya olarak yeniden yüklendi, site açıldı.
4. Canlı ölçüm yapıldı, bir eksik daha bulundu: yazı tipleri yanlış MIME
   türüyle servis ediliyordu. **Düzeltmesi depoda ama sunucuya henüz gitmedi.**

## Yönlendirme döngüsü — ne olduğu ve neden

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

## Canlıda ölçülen sonuçlar

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

## Sunucuya gitmeyi bekleyen tek değişiklik

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

## Tarayıcı önbelleği tuzağı

Döngü sırasında tarayıcılar `301` yanıtını **kalıcı** olarak önbelleğe aldı.
Sunucu düzeldikten sonra bile aynı pencerede döngü devam edebilir. Test her
zaman **gizli pencerede** yapılmalı.
