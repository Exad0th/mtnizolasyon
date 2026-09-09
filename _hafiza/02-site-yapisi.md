# Site yapısı ve kod alışkanlıkları

## Mimari

Yapı taşı yok, derleme adımı yok, çerçeve yok. Düz HTML dosyaları. Her sayfa
kendi CSS'ini `<style>` içinde, kendi JavaScript'ini `<script>` içinde taşır.

```
index.html                     404.html
hizmetler/index.html           + 6 hizmet sayfası
  teras-cati-izolasyonu/  havuz-izolasyonu/  su-kacagi-enjeksiyon/
  membran-uygulamasi/  negatif-yonlu-kristalize-yalitim/  bentonit-uygulamasi/
projeler/index.html            + 3 proje sayfası
  alanya-oba-stadyumu/  lonicera-otel-havuz-izolasyonu/
  hyundai-enerji-istasyonu-kocaeli/
galeri/  hakkimizda/  iletisim/  izolasyon-fiyatlari/
fonts/ (15 dosya)   images/ (217 dosya, ~15 MB)
robots.txt  sitemap.xml (16 URL)  site.webmanifest  favicon.ico
apple-touch-icon.png  .htaccess  vercel.json  README.md
```

Ölçülen: 17 HTML dosyası, 16'sı sitemap'te, 16'sında JSON-LD var.

Depoya ve sunucuya **girmeyen** klasörler:

| Klasör | Neden |
|---|---|
| `images-original/` (34 MB) | optimizasyon öncesi ham fotoğraflar |
| `_kaldirilan-gorseller/` (6 dosya) | telifi bize ait olmayan görseller, karantina |
| `_hafiza/` | bu klasör, iç notlar |
| `_kurulum/` günlükleri | FTP oturum kayıtları |

`_kurulum/` klasörünün betikleri ve notları **depoya girer** ama sunucuya
yüklenmez: FTP betiğinin dışlama listesinde ve `.htaccess` içinde engelli.

## Temiz adresler

Dizin tabanlı: `/hizmetler/teras-cati-izolasyonu/` şeklinde. Alt sayfalarda
tüm yollar **kökten mutlak** yazılır. Göreli yol kullanmayın, dizin derinliği
değişince kırılır.

## Tuzaklar

### 1. Stil satır içinde, karanlık tema nitelik seçicisiyle çalışıyor

Karanlık tema şöyle kuruldu:

```css
html.dark [style*="background:#fff"] { ... }
```

Seçici, satır içi `style` metninin kendisini eşleştiriyor. Bir rengi
değiştirirken boşluk koyarsanız veya kısaltmayı açarsanız (`#fff` yerine
`#ffffff`) kural sessizce eşleşmez ve karanlık temada o öge bozulur.
Renk yazımını olduğu gibi koruyun.

### 2. Baş kısım, menü ve alt bilgi her sayfada kopyalanmış

Ortak parça yok. Menüye bir bağlantı eklerseniz 17 dosyada birden
değiştirmeniz gerekir. Tek dosyada yapılan değişiklik sessiz tutarsızlık
üretir. Bu iş için toplu betik yazın, elle düzenlemeyin.

### 3. JSON-LD ile görünen metin birebir aynı olmak zorunda

Google, yapılandırılmış veride geçen her metinsel iddianın sayfada da görünür
olmasını şart koşuyor. Özellikle SSS bölümünde: `FAQPage` içindeki cevabı
değiştirirken sayfadaki görünür cevabı da değiştirin, tersi de geçerli.

JSON-LD `@graph` yapısında ve düğümler birbirine `@id` ile bağlı:
LocalBusiness, HomeAndConstructionBusiness, Service, FAQPage, BreadcrumbList,
CreativeWork, CollectionPage, ItemList, ImageObject, ImageGallery, WebSite,
WebPage. Bir `@id` değiştirirseniz ona işaret eden düğümleri de güncelleyin.

### 4. Yatay taşma ölçümü scrollWidth ile yapılamaz

Sayfalarda `overflow-x:hidden` taşıyan bir sarmalayıcı var. Bu, taşmayı
`document.scrollWidth` değerinden gizler. Bir oturumda bu yüzden "mobilde
taşma yok" diye yanlış rapor verildi. Gerçekte başlık çubuğunun en dar
genişliği 485 pikseldi ve hamburger düğmesi her telefonda kırpılıyordu.

Doğru ölçüm: her ögenin `getBoundingClientRect().right` değerini
`window.innerWidth` ile karşılaştırın.

### 5. Yazı tipleri kendi sunucumuzda

Google Fonts CDN kaldırıldı, woff2 dosyaları `fonts/` altında. Latin ve
latin-ext birlikte, Türkçe karakterler için ikincisi şart. Dış kaynağa giden
istek sayısı sıfır. CSP `font-src 'self'` olarak daraltıldı; tekrar CDN'e
dönerseniz CSP'yi de açmanız gerekir.

## Görseller

| | |
|---|---|
| Biçim | WebP, Pillow ile dönüştürüldü |
| Duyarlı | `srcset` ve `sizes`, 480 piksellik küçük sürümler mevcut |
| Ana sayfa karuseli | 94 fotoğraf |
| Galeri | 94 fotoğraf |
| Ham arşiv | `images-original/`, 34 MB, depoya girmez |

## Erişilebilirlik

WCAG 2.2 AA hedeflendi: kontrast oranları hesaplandı, dokunma hedefleri
44×44 piksele çıkarıldı, atlama bağlantısı eklendi, odak tuzağı kuruldu,
`prefers-reduced-motion` desteklendi, karusel için WCAG 2.2.2 duraklatma
denetimi eklendi.

## Test ortamı kısıtları

Claude Code tarayıcı bölmesinde şunlar çalışmaz, bunları hata sanmayın:
kare birleştirme yok (ekran görüntüleri boş çıkar), zamanlayıcılar kısılır,
`document.hasFocus()` false döner ve bu yüzden `:focus` hiç eşleşmez, CSS
geçişleri ilerlemez, çapraz kaynaklı çerçeveler görüntülenmez.
Odak stillerini sınıf ekleyerek test edin.
