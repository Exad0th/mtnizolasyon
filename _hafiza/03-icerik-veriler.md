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
| Malzeme | Onduline PP300, rulo membran |
| Süre | 7 gün |
| Garanti | 5 yıl |
| İsim kullanımı | serbest |
| Fotoğraf | yok |

### Bir kez düzeltildi

Lonicera sayfası önce tekstil membran anlatıyordu ve karşılaştırma bölümünde
çimento esaslı sistemleri açıkça eliyordu; gerçek malzeme çimento esaslıydı.
Hyundai sayfası epoksi zemin kaplaması anlatıyor ve rulo membranları eliyordu;
gerçek malzeme rulo membrandı. Her iki sayfanın yöntem ve karşılaştırma
bölümleri yeniden yazıldı.

Yeni bir proje sayfası eklerken malzeme ile anlatının çeliştiğini mutlaka
kontrol edin.

## Konum bölümleri

Fotoğraf olmadığı için proje sayfalarına Google Haritalar gömülü çerçeveleri
eklendi. API anahtarı gerekmiyor.

- Street View gömme parametresi: `pb=!3m1!1str!5m1!1str!6m6!1m5!2m2!1d<ENLEM>!2d<BOYLAM>!4f-0!5f1`
- Uydu görünümü gömme parametresi: `pb=!1m4!2m1!1s<enlem>,<boylam>!5e1!6i16`

Hyundai için müşteri Türkler bölgesindeki yeri işaret etti, o konum kullanıldı.

**Açık soru:** Alanya'da dört Lonicera oteli var, hangisi olduğu netleşmedi.
Netleşirse uydu gömmesi Street View gömmesine çevrilebilir, tek satırlık iş.

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
