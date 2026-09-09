# Yayın: sunucu, yükleme, doğrulama

## Barındırma

| | |
|---|---|
| Alan adı | `https://www.mtnizolasyon.com` (kanonik, www'lu) |
| Sağlayıcı | internettescil.com.tr |
| Paket | Linux Hosting Mini1 |
| IP | 213.238.169.65 |
| Panel | **DirectAdmin**, cPanel değil |
| Panel adresi | `https://mtnizolasyon.com:2222` |
| Web sunucusu | nginx ters vekil, arkada **Apache** |
| `.htaccess` | **çalışıyor**, canlıda başlıklarla doğrulandı |
| FTP | port 21 açık, **TLS yok**, düz FTP |
| SSH / SFTP | kapalı |

### nginx mi Apache mi

`Server: nginx` başlığına bakıp "Apache yok" demeyin, bu hata bir kez yapıldı.
Belirleyici kanıt 404 gövdesidir. Apache'nin klasik hata sayfası şu cümleyi
içerir:

```
Additionally, a 404 Not Found error was encountered while trying to use an ErrorDocument
```

nginx'in kendi 404'ü tamamen farklı görünür, `<center>nginx</center>` içerir.

`_kurulum/nginx-ayarlari.conf` dosyası **şu an gerekmiyor.** Yalnızca saf
nginx'e geçilirse, ya da statik dosyalar Apache'ye uğramadan servis edilmeye
başlarsa gerekir; o durumda sadece 5. ve 7. bölümü sağlayıcıya iletin.

### DirectAdmin symlink tuzağı

`/home/<kullanıcı>/public_html` bir sembolik linktir. Gerçek yol:

```
/home/<kullanıcı>/domains/mtnizolasyon.com/public_html
```

Sağlayıcının WHMCS içine gömdüğü basit dosya yöneticisi symlink üzerinde
çalışmayı reddeder ve şu hatayı verir:

```
There is a symbolic link in that path. The path must be a full non-linked path.
```

Zip açma özelliği de yoktur. **Kullanmayın.** DirectAdmin paneline veya FTP'ye
geçin.

## FTP ile yükleme

FTP kullanıcısı müşteri panelinden oluşturuldu. Kullanıcı adını panelde
**FTP Hesapları** bölümünde görürsünüz; güvenlik gereği buraya yazılmadı.

Hesap oluştururken:

- Kullanıcı adı alanına domain kısmını **yazmayın**, panel kendisi ekliyor
- Şifre için **Otomatik Şifre** düğmesini kullanın
- Dizin seçeneği: **Domain**

Bu ayarla FTP kökü `domains/mtnizolasyon.com` olur, hedef klasör `/public_html`
olarak girilir.

### Betikler

| Betik | İş |
|---|---|
| `_kurulum\FTP-YUKLE.bat` | tüm siteyi yükler, 255 dosya, ~2 dakika |
| `_kurulum\HTACCESS-DUZELT.bat` | yalnızca `.htaccess` yükler, saniyeler |

İkisi de aynı soruları sorar. Cevaplar:

| Soru | Cevap |
|---|---|
| FTP sunucusu | Enter, boş bırakın |
| Kullanıcı adı | paneldeki tam ad, domain kısmı dahil |
| Şifre | panelin ürettiği şifre |
| Hedef klasör | `/public_html` |

Betikler şifreyi `-AsSecureString` ile alır ve hiçbir yere kaydetmez.
Ekran dökümü `_kurulum/*log.txt` dosyalarına yazılır; şifre orada da görünmez
ama bu dosyalar **depoya girmez**.

Sunucuya yüklenmeyenler: `images-original/`, `_kaldirilan-gorseller/`,
`_kurulum/`, `_hafiza/`, `.git/`, `*.bak`, `*.zip`, `*.py`, `*.ps1`,
`README.md`, `vercel.json`, `.gitignore`.

### PowerShell 5.1 tuzakları

- Betik dosyası **UTF-8 BOM ile** kaydedilmeli. BOM yoksa PowerShell dosyayı
  ANSI okur, Türkçe karakterler dizge sonlandırıcılarını bozar ve
  "unterminated string literal" hatası alırsınız.
- `.bat` dosyası ise **BOM'suz** olmalı, yoksa `cmd.exe` ilk satırı okuyamaz.
- `??`, `?:` ve üçlü operatör yoktur.
- `-NoExit` yalnızca PowerShell başarıyla başlarsa pencereyi açık tutar.
  Pencere yine de kapanıyorsa duraklatma `cmd` seviyesinde, `pause` ile olmalı.

## Doğrulama komutları

Yüklemeden sonra bunları çalıştırın.

Yönlendirmeler:

```bash
curl -s -o /dev/null -w "%{http_code} -> %{redirect_url}\n" https://www.mtnizolasyon.com/
curl -s -o /dev/null -w "%{http_code} -> %{redirect_url}\n" https://mtnizolasyon.com/
curl -s -o /dev/null -w "%{http_code} -> %{redirect_url}\n" https://www.mtnizolasyon.com/index.html
curl -s -o /dev/null -w "%{http_code} -> %{redirect_url}\n" https://www.mtnizolasyon.com/hizmetler
```

Sırasıyla beklenen: 200, 301 www'ya, 301 köke, 301 eğik çizgiliye.

Başlıklar:

```bash
curl -sI https://www.mtnizolasyon.com/ | grep -iE "content-security-policy|x-content-type|referrer-policy"
```

MIME türleri:

```bash
curl -s -o /dev/null -w "%{content_type}\n" https://www.mtnizolasyon.com/fonts/manrope-400-latin.woff2
curl -s -o /dev/null -w "%{content_type}\n" https://www.mtnizolasyon.com/images/carousel/slide-001-480.webp
```

`font/woff2` ve `image/webp` dönmeli.

## Kaçınılması gereken hatalar

1. **`.htaccess` içinde `^(.*)$` ile yol başına ekleme yapmayın.** Kök istek
   dizin bağlamında boş dizgedir; `.*` onu da yakalar ve sonsuz döngü olur.
   Ayrıntısı [01-durum.md](01-durum.md) içinde.
2. **Testi gizli pencerede yapın.** Tarayıcı 301 yanıtlarını kalıcı olarak
   önbelleğe alır, sunucu düzelse bile eski davranışı görmeye devam edersiniz.
3. **Görsel dosya adlarında büyük-küçük harf.** Sunucu Linux, duyarlıdır.
4. **FTP düz metin.** Yükleme bittikten sonra o FTP hesabını panelden silin.
   Yeni yükleme gerektiğinde yenisini iki dakikada açarsınız.

## Eski dosyalar

Eski tek sayfalık sitenin `images` klasörü sunucuda duruyor, silinmedi. Yeni
dosyalar üzerine yazıldı ama artık hiçbir sayfanın kullanmadığı eski görseller
orada kalmaya devam ediyor. Zarar vermiyor, yalnızca yer kaplıyor. Temizlik
istenirse hangi dosyaların fazlalık olduğu listelenebilir.
