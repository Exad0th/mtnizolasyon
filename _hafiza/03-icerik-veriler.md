# İçerik, veriler ve telif

## Teyitli proje verileri

Üçü de müşteriden birebir alındı.

### Alanya Oba Stadyumu
| | |
|---|---|
| Tarih | Ocak 2008 |
| Alan | 5.000 m² |
| Malzeme | ODE PP300 membran |
| Süre | 60 gün |
| Garanti | 5 yıl |
| Müteahhit | Mekikler İnşaat |
| İsim kullanımı | serbest |
| Fotoğraf | yok |

### Lonicera Otel, havuz izolasyonu
| | |
|---|---|
| Tarih | Şubat 2021 |
| Alan | 3.000 m² |
| Malzeme | Sika Topseal-107, çimento esaslı, tam elastik |
| Süre | 15 gün |
| Garanti | 5 yıl |
| İsim kullanımı | serbest |
| Fotoğraf | yok |

### Hyundai Enerji İstasyonu, Kocaeli (Aslan Holding)
| | |
|---|---|
| Tarih | Haziran 2013 |
| Alan | 2.500 m² |
| Malzeme | Onduline PP300, polyester taşıyıcılı bitümlü membran |
| Süre | 7 gün |
| Garanti | 5 yıl |
| İsim kullanımı | serbest |
| Fotoğraf | yok |

### Bir kez düzeltildi

Lonicera sayfası önce tekstil membran anlatıyordu ve karşılaştırma bölümünde
çimento esaslı sistemleri açıkça eliyordu; gerçek malzeme çimento esaslıydı.
Hyundai sayfası epoksi zemin kaplaması anlatıyor ve bitümlü membranları eliyordu;
gerçek malzeme bitümlü membrandı. Her iki sayfanın yöntem ve karşılaştırma
bölümleri yeniden yazıldı.

Yeni bir proje sayfası eklerken malzeme ile anlatının çeliştiğini mutlaka
kontrol edin.

## Konum bölümleri

Fotoğraf olmadığı için proje sayfalarına Google Haritalar gömülü çerçeveleri
eklendi. API anahtarı gerekmiyor.

- Street View gömme parametresi: `pb=!3m1!1str!5m1!1str!6m6!1m5!2m2!1d<ENLEM>!2d<BOYLAM>!4f-0!5f1`
- Uydu görünümü gömme parametresi: `pb=!1m4!2m1!1s<enlem>,<boylam>!5e1!6i16`

Hyundai için müşteri Türkler bölgesindeki yeri işaret etti, o konum kullanıldı.

**Geçersiz (14 Eylül):** Lonicera'nın hangi otel olduğu sorusu artık önemli değil, proje Mövenpick ile değiştirilecek.

## Görsel telifi, kırmızı çizgi

Müşteri Google Görseller'den görsel almayı reddetti. Doğru karardı.

Üç proje görselinin internetten alındığı üstveriden çıkarıldı ve müşteri
doğruladı. Kanıtlar: 2,78:1 ve 2,46:1 en boy oranları hiçbir fotoğraf
makinesinde yoktur, bir dosya adında `_web` eki vardı, birinin EXIF verisinde
sanatçı adı ve 10 Eylül 2024 tarihi vardı ama proje Şubat 2021'e aitti.

Bu üç görsel `_kaldirilan-gorseller/` klasörüne alındı: `hyundai_web`,
`lon_aqua1`, `stadium`, her biri jpg ve webp olarak. Yerlerine kendi
arşivimizden fotoğraflar kondu, yanıltıcı 8 alt metin, alt yazı ve JSON-LD
alanı düzeltildi.

Bu klasör depoya da sunucuya da asla gitmez.

## Yayına uygun olmayan fotoğraflar

100 fotoğrafın tamamı tek tek incelendi. Altısı elendi, hem karuselden hem
galeriden çıkarıldı:

| Sayı | Sebep |
|---|---|
| 2 | tanınabilir yüz |
| 1 | okunabilir plaka |
| 1 | rakip firma tabelası |
| 1 | konuyla ilgisiz, asansör rayı |
| 2 | fazla karanlık |

Bunlar ana sayfa karuselinde canlıya çıkmak üzereydi. Yeni fotoğraf eklerken
aynı gözden geçirme yapılmalı.

## Alt metinler

94 alt metnin 46'sı Türkçe karakterler olmadan yazılmıştı. Temiz olan 48
metinden bir sözlük çıkarıldı, terim sözlüğü eklendi, iki geçişte düzeltildi.
Kalan yok.

## Hâlâ teyit edilmemiş ama sitede yazan iddialar

Bunlar makine okunur veriye veya görünür metne yazıldı ve kaynağı yok:

1. **Çalışma saatleri Pazartesi-Cumartesi 08:30-18:30.** Ana sayfa JSON-LD
   `openingHoursSpecification` alanında. Yanlışsa Google, firma kapalıyken
   açık gösterir. En riskli olanı bu.
2. **Ortalama bir teras uygulaması 2-5 gün sürer.** Ana sayfa SSS bölümünde.
3. **350+ proje**, **15+ yıl tecrübe**, **yurt dışında hizmet.** Sitede duruyor.

95+ referans ifadesi çelişki yarattığı için kaldırıldı.

Müşteriye sorulup ya doğrulanmalı ya çıkarılmalı.

## İçerik hacmi

Denetimde ölçülen: 541 kelimeden 17.192 görünür kelimeye çıkıldı, 1 sayfadan
17 sayfaya geçildi.

## Terminoloji kuralı: bitümlü membran (14 Eylül 2026)

Müşterinin sözü: *"Membran uygulaması ve temel su yalıtımı rulo membran değil bitüm membran."*

- Sitede **"bitümlü membran"** ve **"bitümlü örtü"** kullanılır. Müşterinin kendi videosunda da "Bitümlü membran uygulama" yazıyor.
- **"Rulo membran" ve "rulo örtü" kullanılmaz.** 14 Eylül itibarıyla sitede sıfır geçiş var.
- Membran hizmetinin açıklaması **PVC veya TPO içermez.** Güncel metin: *"polyester taşıyıcılı bitümlü membranla oluşturulan esnek su yalıtım katmanları"*.
- PVC yalnızca havuz karşılaştırmalarında *"PVC havuz örtüsü (liner)"* seçeneği olarak geçer. Bu doğru, dokunulmadı.
- Oba Stadyumu (ODE PP300) ve Hyundai (Onduline PP300) zaten bitümlü membran projeleri, metinleri bununla uyumlu.

## Proje değişikliği: Lonicera yerine Mövenpick (bekliyor)

Müşteri Lonicera (3.000 m²) yerine **Mövenpick, Tekirova** otelini referans göstermek istiyor: daha büyük bir otel ve daha büyük bir iş. Referans fotoğrafı `_gelen/2026-09-14/WhatsApp Image 2026-09-14 at 15.47.06.jpeg`: havuz kabuğunda sarı panel membran, çevrede inşaat hâlindeki binalar. Fotoğrafta uzakta küçük bir kişi var, yüzü seçilmiyor.

**Veri gelmeden sayfa yazılmayacak.** Lonicera sayfasının malzemeyle çelişen anlatısı bir kez düzeltilmişti; aynı hata tekrarlanmasın. Gerekenler:

| Alan | Neden |
|---|---|
| Tarih (ay, yıl) | künye ve JSON-LD |
| Alan (m²) | başlık ve künye |
| Malzeme ve ürün adı | yöntem ve karşılaştırma bölümleri buna göre yazılır; müşteri "tekstil membran" dedi, ürün belli değil |
| Uygulama süresi | künye |
| Garanti | künye |
| Otel adını kullanma izni | Mövenpick bir zincir markası; diğer üç projede izin açıkça alınmıştı |
| Havuz mu, başka bir yüzey mi | fotoğraf havuza benziyor, teyit gerekli |

Sayfa yazılınca yapılacaklar: yeni adres, eski Lonicera adresinden 301 yönlendirme, sitemap, proje merkez sayfası, ana sayfa kartı, havuz hizmet sayfası, Oba ve Hyundai sayfalarındaki "diğer projeler" kartları, hakkımızda tablosu, Google İşletme Profili notu.

## 14 Eylül'de gelen görseller

| Dosya (saat) | İçerik | Karar |
|---|---|---|
| 15.43.55 | Oba Stadyumu drone çekimi, 1920×1080 | **Bekletildi.** Kimin çektiği belli değil |
| 15.46.44 | Hyundai fabrikası hava fotoğrafı, 580×780 | **Bekletildi.** Web boyutunda kurumsal görsel, proje ölçeğini de abartıyor |
| 15.47.06 | Mövenpick havuzu, sarı membran | Mövenpick sayfası için saklandı |
| 15.50.48 | Beyaz likit yalıtımlı teras | Teras sayfasında |
| 15.51.35 | Asansör kuyusunda enjeksiyon | Enjeksiyon sayfasında; ustanın yüzü görünmüyor |
| 15.52.46 | Temel tabanında bitümlü membran | Membran sayfasında; uzaktaki iki işçi ve kamyonet seçilmiyor |
| 15.54.05 | Temel altı bentonit örtü, 837×438 | Bentonit sayfasında; çözünürlüğü düşük, masaüstünde hafif yumuşak görünür |

WhatsApp dosyalarında EXIF verisi yok, kaynak üstveriden okunamıyor. Karar görüntü içeriğine ve boyut oranlarına göre verildi. 4:5 ve 1,91:1 oranları Instagram kırpımına işaret ediyor, muhtemelen firmanın kendi hesabından alınmışlar.

**Kristalize sayfası:** mevcut görsel yanlıştı, kaldırıldı. Yenisi gelmedi.
