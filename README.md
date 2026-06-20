# MTN İzolasyon — Kurumsal Web Sitesi

Alanya merkezli, Türkiye geneli su yalıtımı ve izolasyon hizmetleri sunan **MTN İzolasyon** için tek sayfalık (landing page) kurumsal web sitesi.

🌐 **Canlı:** https://mtn-izolasyon.vercel.app

## Teknoloji

Framework yok — bağımlılıksız, statik bir site:

- Semantik **HTML**
- Bileşen tabanlı, responsive **CSS** (custom property'ler, hover/focus durumları, kırılma noktaları)
- Vanilla **JavaScript** (mobil menü, scroll-reveal animasyonları, S.S.S. akordeonu, video oynatıcı)
- Self-hosted fontlar (Archivo, Barlow, Barlow Semi Condensed)
- LocalBusiness + FAQPage **JSON-LD** yapısal verisi, Open Graph / Twitter Card meta'ları

## Proje yapısı

```
index.html            # Ana sayfa
404.html              # Markalı 404 sayfası
css/
  fonts.css           # Self-hosted @font-face tanımları (woff2)
  styles.css          # Tüm bileşen stilleri + responsive
js/
  main.js             # Etkileşimler
assets/
  images/             # Proje fotoğrafları (proje-1..4.jpg)
  videos/             # Uygulama videoları (video-1..4.mp4)
  fonts/              # woff2 font dosyaları
favicon.svg
robots.txt
sitemap.xml
vercel.json           # Cache + güvenlik başlıkları (CSP, nosniff vb.)
MTN İzolasyon.html    # Orijinal tasarım kaynağı (Claude Design export — deploy edilmez)
```

> `index.html` yayınlanan sitedir. `MTN İzolasyon.html` yalnızca tasarımın orijinal kaynağıdır ve `.vercelignore` ile deploy dışı bırakılmıştır.

## Yerel çalıştırma

Statik bir site olduğu için herhangi bir sunucuyla servis edilebilir:

```bash
npx serve .
```

Ardından tarayıcıda gösterilen adresi açın. (Dosyayı doğrudan `file://` ile açmak yerine bir sunucuyla servis edin; göreceli yollar ve videolar bu şekilde doğru çalışır.)

## Deploy

Vercel'e bağlıdır:

```bash
vercel deploy --prod
```

## Lisans

© 2025 MTN İzolasyon. Tüm hakları saklıdır.
