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
| Ana sayfa hakkımızda karuseli | 94 fotoğraf |
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

## Ana sayfa hero videosu (14 Eylül 2026)

| | |
|---|---|
| Dosya | `video/mtn-tanitim.mp4` |
| Biçim | 576×1024 dikey, H.264 High, 30 fps, ses izi yok, faststart |
| Süre / boyut | 47,5 sn / 3,5 MB (CRF 31; 27 ile 31 arasında gözle fark yok, kaynak zaten WhatsApp sıkıştırmalı) |
| Poster | `images/hero/video-poster.webp` (1,5. saniyedeki kare) |
| Arka plan | `images/hero/video-bg.webp` (90×160 bulanık kare) |

**Kaynak ve kesim.** Müşterinin yapay zekâ ile düzenlediği 57,3 saniyelik saha videosu. Müşteri 41–50 arasının çıkmasını istedi; bu aralık "Isı yalıtımı" bölümü. Geçiş kareleri ölçülerek kesim 41,1 ve 50,4 saniyeye oturtuldu, iki parça 0,5 saniyelik geçişle bağlandı. Ham dosya `_gelen/2026-09-14/` altında.

**Yerleşim.** 900 pikselin üstünde metin solda, dikey video sağda çerçeve içinde. Altında alt alta dizilir: önce başlık, sonra video. Videonun üzerine yazı bindirilmedi, çünkü videonun kendi alt yazıları ve bitiş kartı var.

**Davranış.**
- `src` ancak video ekrana girince atanır, sayfa açılışı videoyu beklemez.
- Sessiz, döngülü, satır içi oynar. Ekrandan çıkınca durur, dönünce devam eder.
- Sayfa arka plan sekmesinde açılırsa Chrome oynatmayı keser; sekmeye dönülünce `visibilitychange` ile devam eder.
- Sağ üstte oynat/duraklat düğmesi var (WCAG 2.2.2). Kullanıcı durdurduysa kaydırma onu yeniden başlatmaz.
- Hareket azaltma veya veri tasarrufu tercihinde kendiliğinden başlamaz, düğmeyle başlatılabilir.

**Önbellek kuralı.** `.htaccess` mp4 dosyalarını bir yıl `immutable` olarak önbelleğe aldırıyor. Video değişirse **dosya adı da değişmeli** (örneğin `mtn-tanitim-2.mp4`), yoksa ziyaretçiler bir yıl boyunca eskisini görür. Aynı kural görseller için de geçerli.

Eski `images/hero/hero-*.webp` dosyaları `_kaldirilan-gorseller/hero/` klasörüne taşındı, artık yüklenmiyor. FTP betiği sunucudan dosya silmediği için eski kopyalar sunucuda duruyor; zararsızlar, istenirse elle silinir.

JavaScript kapalıyken oynat düğmesi gizli kalır ve `<noscript>` içindeki denetimli video gösterilir. Yazdırmada video gizlenir, hero metin yüksekliğine iner ve beyaz yazı siyaha döner.

**Bilinen kusur:** videoya gömülü başlıklardan biri "BİTÜMLÜ MEMBRAN UYGULAMA" yazıyor, iyelik eki eksik (doğrusu "UYGULAMASI"). Yazı müşterinin videosuna gömülü, düzeltilmiş çıktı müşteriden istenmeli.

## Hizmet sayfası görselleri (14 Eylül 2026)

`images/hizmetler/<slug>.webp` ve `<slug>-480.webp`. Figür 400 piksel yüksekliğinde `object-fit:cover` bir bant olarak çizilir, her sayfada `object-position` konuya göre ayarlı. Başlıktaki preload bağlantısı `imagesrcset` ve `imagesizes` kullanır, böylece telefon büyük görseli ayrıca indirmez.

## Test ortamı notu (ek)

Tarayıcı bölmesi gizliyken Chrome videoyu güç tasarrufu gerekçesiyle durdurur (`AbortError ... paused to save power`) ve `img.decode()` hiç sonuçlanmaz. Bunlar site hatası değil. Yerel `python -m http.server` WebP dosyalarını `application/octet-stream` türüyle verir; canlı sunucu doğru türü veriyor.
