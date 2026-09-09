# Google Search Console — Kurulum Adımları
### MTN İzolasyon · hazırlanma tarihi 5 Eylül 2026

Search Console, Google'ın sitenizi nasıl gördüğünü gösteren ücretsiz panel.
Hangi kelimede kaçıncı sıradasınız, kaç kişi tıkladı, hangi sayfa hata veriyor —
hepsi burada. **Site yayına alındıktan sonra yapılacak ilk iş budur.**

---

## Adım 1 — Mülk (property) ekleme

`search.google.com/search-console` adresine işletme e-postanızla girin ve
**"Mülk ekle"** deyin. İki seçenek çıkar:

| Seçenek | Ne kapsar | Öneri |
|---|---|---|
| **Alan adı (Domain)** | `mtnizolasyon.com` ve tüm alt alan adları, http + https birlikte | ✅ **Bunu seçin** |
| URL öneki | Sadece yazdığınız tam adres | Alan adı doğrulaması yapılamıyorsa |

Alan adı yöntemi tek seferde her varyasyonu kapsar — `www`'lu, `www`'suz, http, https.

---

## Adım 2 — Doğrulama

### Yöntem A — DNS TXT kaydı (alan adı mülkü için tek yol, önerilen)

1. Google size şuna benzer bir kayıt verir:
   ```
   google-site-verification=AbCdEf123456...
   ```
2. Alan adınızı aldığınız firmanın panelinde **DNS Yönetimi** bölümüne girin.
3. Yeni kayıt ekleyin:
   - **Tür:** `TXT`
   - **Ad / Host:** `@` (veya boş bırakın — firmaya göre değişir)
   - **Değer:** Google'ın verdiği satırın tamamı
   - **TTL:** varsayılan
4. Kaydedin, Search Console'da **"Doğrula"** deyin.

> DNS değişikliği bazen birkaç dakika, bazen birkaç saat sürer. İlk denemede
> "doğrulanamadı" derse panik yapmayın, 1 saat sonra tekrar deneyin.

### Yöntem B — HTML etiketi (URL öneki mülkü için)

Google size şuna benzer bir satır verir:
```html
<meta name="google-site-verification" content="XXXXXXXXXXXX" />
```

**Bu satırı bana gönderin, 12 sayfanın `<head>` bölümüne ben ekleyeyim.**
Elle eklerseniz sadece `index.html`'e eklemek yeterlidir ama tüm sayfalarda olması daha güvenli.

### Yöntem C — HTML dosyası

Google `google1a2b3c4d5e.html` gibi bir dosya indirtir. Bunu sitenin **kök dizinine**
(`public_html` içine, `index.html` ile aynı seviyeye) yükleyin. En kolay yöntem budur
ama alan adı mülkü için çalışmaz.

---

## Adım 3 — Sitemap gönderimi

Doğrulama bittikten sonra sol menüden **Site Haritaları**:

```
sitemap.xml
```

Sadece bu kadarını yazın (tam adres değil). Sitemap'te şu an **12 sayfa** kayıtlı:

- Ana sayfa
- `/hizmetler/` + 6 hizmet sayfası
- `/projeler/` + 3 proje sayfası

Gönderdikten sonra durum "Başarılı" olmalı ve "Keşfedilen URL: 12" görünmeli.

---

## Adım 4 — İlk hafta bakılacaklar

| Rapor | Ne aranmalı |
|---|---|
| **Sayfalar** (Dizine ekleme) | 12 sayfanın kaçı "Dizine eklendi"? Hariç tutulanların sebebi ne? |
| **Site haritaları** | Hata var mı, 12 URL okundu mu? |
| **Mobil Kullanılabilirlik** | Hata çıkmamalı — mobil menü ve dokunma hedefleri buna göre yapıldı |
| **Core Web Vitals** | Veri birikmesi birkaç hafta sürer, sonra bakın |

> İlk 1-2 hafta veri gelmemesi normaldir. Google yeni siteyi taramaya başlaması için
> zaman ister; sitemap göndermek bu süreci hızlandırır.

---

## Adım 5 — Bir ay sonra bakılacaklar

**Performans** raporu asıl değerli olan yer. Burada göreceksiniz:

- Hangi aramada çıkıyorsunuz (**Sorgular** sekmesi)
- Hangi sayfa trafik alıyor (**Sayfalar**)
- Ortalama sıralamanız kaç
- Gösterim var ama tıklama yoksa → başlık/açıklama metni çalışmıyor demektir

**En değerli hamle:** "Gösterim yüksek, sıralama 8-20 arası" olan kelimeleri bulun.
Bunlar ilk sayfanın eşiğindeki kelimelerdir; ilgili sayfaya biraz içerik eklemek
çoğu zaman onları ilk sayfaya taşır. Sıfırdan yeni sayfa yazmaktan çok daha verimlidir.

---

## Ayrıca kurulması önerilenler

- **Bing Webmaster Tools** — Search Console'dan tek tıkla içe aktarım yapıyor.
  Bing verisi ChatGPT ve Copilot aramalarını da besliyor, artık göz ardı edilmemeli.
- **Analitik** — Google Analytics 4 ya da daha hafif ve gizlilik dostu bir alternatif
  (Plausible, Umami). İstersen kurulum kodunu 12 sayfaya ben ekleyebilirim.

---

## Bende olması gerekenler

Şunlardan birini gönderdiğinizde ilgili işi ben yaparım:

- [ ] Search Console doğrulama meta etiketi → 12 sayfaya eklerim
- [ ] Gerçek alan adı (varsayım: `www.mtnizolasyon.com`) → farklıysa tüm canonical/OG/sitemap düzeltilir
- [ ] Gerçek çalışma saatleri → yapısal veri güncellenir
- [ ] Analitik tercihiniz → kod eklenir
