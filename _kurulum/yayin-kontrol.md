# Yayına Alma ve Kontrol — DirectAdmin

## Barındırma özeti

| | |
|---|---|
| Sağlayıcı | internettescil.com.tr |
| Panel | **DirectAdmin** (cPanel değil) |
| Paket | Linux Hosting Mini1 — mtnizolasyon.com |
| Web sunucusu | nginx (ters vekil) + **Apache** (arkada) |
| `.htaccess` | **Çalışır** — Apache istekleri karşılıyor |
| DirectAdmin paneli | `https://mtnizolasyon.com:2222` (açık) |
| FTP | port 21 (açık) |
| SSH / SFTP | kapalı |

---

## WHMCS içindeki dosya yöneticisini kullanmayın

Sağlayıcının müşteri panelindeki (`internettescil.com.tr/v3/clientarea.php`) basit dosya
yöneticisi şu hatayı verir:

```
There is a symbolic link in that path. The path must be a full non-linked path.
```

**Sebebi:** DirectAdmin'de `/home/<kullanıcı>/public_html` gerçek bir klasör değil, **sembolik link**'tir.
Asıl yol şudur:

```
/home/<kullanıcı>/domains/mtnizolasyon.com/public_html
```

Bu basitleştirilmiş dosya yöneticisi symlink üzerinden işlem yapmayı reddediyor. Ayrıca zip
açma (Extract) özelliği de yok. İki gerçek seçeneğiniz var.

---

## Yöntem A — DirectAdmin paneli (önerilen)

### 1. Panele girin

```
https://mtnizolasyon.com:2222
```

Kullanıcı adı ve şifre, hosting satın alırken gelen e-postadadır. Bulamazsanız
müşteri panelinden *Şifre Değiştirme* ile sıfırlayabilirsiniz.

> Tarayıcı "bağlantı güvenli değil" uyarısı verebilir — panelin sertifikası
> alan adına değil sunucuya ait olduğu için normaldir, devam edin.

### 2. Doğru klasöre gidin

**Dosya Yöneticisi** (File Manager) → soldaki ağaçtan:

```
domains  →  mtnizolasyon.com  →  public_html
```

`home` altındaki `public_html` kısayolunu **kullanmayın**, symlink olan o.

### 3. Yedek alın

Mevcut `index.html` ve `images` klasörünü seçin → **Add to Archive** →
`eski-site-yedek.tar.gz` olarak kaydedin ve bilgisayarınıza indirin.

### 4. Eskiyi silin

`index.html` ve `images` klasörünü seçip silin. (Eski `images` 33,8 MB; yeni paketimizde
aynı adla farklı içerik var, üzerine yazmak yerine temiz başlamak daha güvenli.)

### 5. Yükleyin ve açın

**Upload Files** → `mtn-yayin.zip` → yükleme bitince dosyaya sağ tık →
**Extract** (veya *Dosyayı Çıkart*).

DirectAdmin'in eski sürümlerinde Extract yalnızca `.tar.gz` destekleyebilir.
Zip açılmazsa **Yöntem B**'ye geçin.

### 6. Zip'i silin

Açma bittikten sonra `mtn-yayin.zip` sunucuda kalmasın.

### 7. Gizli dosyayı doğrulayın

DirectAdmin dosya yöneticisinde nokta ile başlayan dosyalar genelde görünür, ama
görünmüyorsa ayarlardan *Show hidden files* açın. **`.htaccess` `public_html` kökünde
olmalı** — bu dosya olmadan yönlendirmeler ve güvenlik başlıkları çalışmaz.

---

## Yöntem B — FTP (en güvenilir)

Zip açma sorunu yaşarsanız bu yol hiç zip gerektirmez.

### 1. FTP bilgilerini alın

Müşteri paneli → **FTP Hesapları**. Ana hesabın bilgileri zaten vardır; yoksa yeni hesap açın.

- **Sunucu:** `ftp.mtnizolasyon.com` (veya panelde yazan sunucu adı)
- **Port:** 21
- **Kullanıcı / şifre:** panelde görünen

### 2. FileZilla kurun

`filezilla-project.org` → *FileZilla Client* (ücretsiz).

### 3. Bağlanın ve yükleyin

1. Üstteki alanlara sunucu, kullanıcı adı, şifre, port 21 → **Quickconnect**
2. Sağ paneldeki uzak dizinde `domains/mtnizolasyon.com/public_html` klasörüne gidin
3. Eski `index.html` ve `images` klasörünü silin
4. Sol panelde `C:\Users\EXADOTH\Desktop\mtnsite` klasörünü açın
5. Şunları seçip sağ panele sürükleyin:

```
index.html   404.html   robots.txt   sitemap.xml
site.webmanifest   favicon.ico   apple-touch-icon.png
.htaccess
fonts/   images/   hizmetler/   projeler/
galeri/   hakkimizda/   iletisim/   izolasyon-fiyatlari/
```

**Yüklemeyin:** `images-original/`, `_kaldirilan-gorseller/`, `_kurulum/`,
`mtn-yayin.zip`, `.git/`, `*.bak`, `README.md`, `vercel.json`, `.gitignore`

> FileZilla varsayılan olarak gizli dosyaları gösterir. `.htaccess` görünmüyorsa
> *Sunucu → Gizli dosyaları göstermeye zorla* seçeneğini işaretleyin.

259 dosya var; bağlantı hızınıza göre 5–20 dakika sürer. FileZilla kopan aktarımı
kaldığı yerden sürdürür.

---

## Yükleme sonrası kontrol

### 1. Sayfalar açılıyor mu

| Adres | Beklenen |
|---|---|
| `https://www.mtnizolasyon.com/` | Yeni ana sayfa |
| `https://www.mtnizolasyon.com/hizmetler/` | Hizmet hub'ı |
| `https://www.mtnizolasyon.com/galeri/` | 94 fotoğraflı galeri |
| `https://www.mtnizolasyon.com/robots.txt` | Metin (404 değil) |
| `https://www.mtnizolasyon.com/sitemap.xml` | XML (404 değil) |

### 2. `.htaccess` çalışıyor mu

```bash
curl -I https://www.mtnizolasyon.com/
```

Şu başlıkları arayın:

```
x-content-type-options: nosniff
referrer-policy: strict-origin-when-cross-origin
content-security-policy: default-src 'self'; ...
```

Gelmiyorsa sağlayıcıya sorun: *"AllowOverride All açık mı, .htaccess okunuyor mu?"*

### 3. Yönlendirmeler

```bash
curl -sI https://mtnizolasyon.com/ | grep -i location
curl -sI https://www.mtnizolasyon.com/index.html | grep -i location
curl -sI https://www.mtnizolasyon.com/hizmetler | grep -i location
```

Sırasıyla `www`'lu adrese, `/` köküne ve `/hizmetler/` (eğik çizgili) adrese 301 dönmeli.

### 4. 404 sayfası

`https://www.mtnizolasyon.com/olmayan-bir-sayfa` → **markalı 404 sayfamız** çıkmalı,
Apache'nin çıplak hata sayfası değil.

### 5. Statik dosya önbelleği

```bash
curl -sI https://www.mtnizolasyon.com/images/og-cover.jpg | grep -i cache-control
```

`public, max-age=31536000, immutable` geliyorsa tamam. Gelmiyorsa hata değil, sadece
kaçırılmış performans: nginx görselleri Apache'ye uğratmadan servis ediyor olabilir.
O durumda `_kurulum/nginx-ayarlari.conf` dosyasının **5. ve 7. bölümünü** sağlayıcıya iletin.

### 6. Fontlar

```bash
curl -sI https://www.mtnizolasyon.com/fonts/manrope-400-latin.woff2
```

`200` dönmeli. 404 verirse yazı tipleri sistem fontuna düşer.

---

## Yayından sonra

1. **Google Search Console** — `_kurulum/search-console-kurulum.md`
2. **Google İşletme Profili** — `_kurulum/google-isletme-profili.md`
3. Bana haber verin, canlı siteyi baştan sona denetleyeyim.

---

## Sorun çıkarsa

**"There is a symbolic link in that path"** → WHMCS'teki basit dosya yöneticisini kullanıyorsunuz.
DirectAdmin paneline (`:2222`) veya FTP'ye geçin.

**Alt sayfalar 404 veriyor, ana sayfa açılıyor** → Klasörler oluşmamış olabilir.
`public_html/hizmetler/index.html` gerçekten var mı bakın.

**Görseller görünmüyor** → Sunucu Linux, dosya adları büyük/küçük harf duyarlı.
FTP aktarımı **binary** modda olmalı (FileZilla varsayılanı otomatik, sorun çıkarsa
*Aktarım → Aktarım tipi → İkili* seçin).

**Site eski hâlinde** → Tarayıcı önbelleği. `Ctrl+Shift+R` veya gizli pencere.

**Şifre yok / panele giremiyorum** → Müşteri paneli → *Şifre Değiştirme* ile sıfırlayın,
ya da sağlayıcının destek hattı: +90 232 446 4 232.
