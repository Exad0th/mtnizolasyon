# MTN İzolasyon — Kurumsal Web Sitesi

Alanya merkezli, Türkiye geneli su yalıtımı ve izolasyon hizmetleri sunan **MTN İzolasyon** için
13 sayfalık statik kurumsal web sitesi.

## Teknoloji

Framework yok, build adımı yok — bağımlılıksız statik HTML:

- Semantik **HTML5**, sayfa içi `<style>` ve `<script>` blokları
- Vanilla **JavaScript**: tema değiştirici, mobil menü, SSS akordeonu, IntersectionObserver'lı slider
- Görseller **WebP** (Pillow ile optimize edildi: 33,6 MB → 10,6 MB)
- **JSON-LD** yapısal veri: LocalBusiness, Service, FAQPage, BreadcrumbList, CreativeWork, CollectionPage, ItemList
- Açık/koyu tema (`localStorage` + `prefers-color-scheme`)

## Sayfa yapısı

```
index.html                                  Ana sayfa
404.html                                    Hata sayfası
hizmetler/
  index.html                                Hizmet hub'ı
  teras-cati-izolasyonu/
  havuz-izolasyonu/
  su-kacagi-enjeksiyon/
  membran-uygulamasi/
  negatif-yonlu-kristalize-yalitim/
  bentonit-uygulamasi/
projeler/
  index.html                                Proje hub'ı
  alanya-oba-stadyumu/
  lonicera-otel-havuz-izolasyonu/
  hyundai-enerji-istasyonu-kocaeli/
images/                                     WebP görseller (hero, carousel, projects)
robots.txt  sitemap.xml  site.webmanifest
vercel.json                                 Vercel: güvenlik başlıkları, önbellek, yönlendirme
.htaccess                                   Apache: aynı ayarların karşılığı
```

URL'ler dizin tabanlı (`/hizmetler/<slug>/`), böylece sunucu ayarı gerekmeden temiz URL çalışır.

## Mimari notlar

**Ortak parçalar kopyalanmıştır.** Nav, footer, mobil menü, CSS ve paylaşılan JS her sayfada
ayrı ayrı bulunur. Bunlardan birini değiştirirken **13 dosyanın hepsinde** değiştirmek gerekir.

**Koyu tema, satır içi stil dizelerini yakalar.** `html.dark [style*="background:#fff"]` gibi
attribute seçiciler kullanılır. Yeni bölüm yazarken renkler şu güvenli listeden seçilmelidir:
`background:#fff`, `background:#f4f5f6`, `background:#e3e6e8`,
`color:#15202b`, `color:#586572`, `color:#3a454f`, `color:#8c97a1`.
Başka bir hex kullanılacaksa `.sinif` tanımlanıp `html.dark .sinif{...}` karşılığı da yazılmalıdır.

**Alt sayfalarda yollar kök-mutlaktır** (`/images/...`, `/#contact`). Göreli yol kırılır.

## Erişilebilirlik

- WCAG 2.2 AA hedeflenmiştir: kontrast oranları hesaplanarak düzeltildi, dokunma hedefleri 44×44 px
- İçeriğe atla bağlantısı, `:focus-visible` halkası, mobil menüde odak tuzağı
- SSS akordeonu klavyeyle kullanılabilir (`role="button"`, `tabindex`, `aria-expanded`, Enter/Space)
- Otomatik geçişli karusel duraklatılabilir (WCAG 2.2.2), `prefers-reduced-motion` desteklenir

## Yerel geliştirme

Build gerekmez; herhangi bir statik sunucu yeterlidir:

```bash
python -m http.server 8765
```

## Yayına alma

Vercel'de kök dizin doğrudan yayınlanır (`vercel.json` başlıkları ve yönlendirmeleri uygular).
Apache tabanlı hosting için `.htaccess` aynı ayarları içerir.

## Depoya girmeyen yerel klasörler

`images-original/` (optimizasyon öncesi ham fotoğraflar), `_kurulum/` (Google İşletme Profili ve
Search Console kurulum notları) ve `_kaldirilan-gorseller/` `.gitignore` ile hariç tutulmuştur.

## Bilinen açık konular

- Alan adı, çalışma saatleri ve bazı içerik iddiaları (`350+ proje`, `15+ yıl`) teyit bekliyor
- Fontlar Google Fonts CDN'inden çekiliyor; KVKK ve performans açısından self-host değerlendirilmeli
- Responsive görseller (`srcset`) henüz eklenmedi
- Google Maps gömmeleri için çerez/KVKK bildirimi bulunmuyor
