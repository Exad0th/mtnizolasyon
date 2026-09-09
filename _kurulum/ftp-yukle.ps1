# =============================================================
#  MTN İzolasyon — FTP ile yayına alma
#
#  KULLANIM:  _kurulum\FTP-YUKLE.bat dosyasına ÇİFT TIKLAYIN.
#  (Bu .ps1'i doğrudan çalıştırmanız da olur ama .bat daha güvenli:
#   pencereyi açık tutar ve betik engellemesini aşar.)
#
#  Ne olursa olsun pencere kapanmaz; her hata ekrana VE
#  _kurulum\ftp-log.txt dosyasına yazılır.
# =============================================================

# --- Her şeyi kaydet: pencere kapansa bile log dosyada kalır ---
$LogYolu = Join-Path $PSScriptRoot 'ftp-log.txt'
if (-not $PSScriptRoot) { $LogYolu = Join-Path (Get-Location) 'ftp-log.txt' }
try { Start-Transcript -Path $LogYolu -Force | Out-Null } catch { }

function Duraklat {
    Write-Host ""
    Write-Host "  --- Kapatmak için Enter'a basın ---" -ForegroundColor DarkGray
    try { Read-Host | Out-Null } catch { Start-Sleep -Seconds 30 }
}

try {

    Write-Host ""
    Write-Host "  MTN İzolasyon — FTP yükleme" -ForegroundColor Cyan
    Write-Host "  PowerShell sürümü: $($PSVersionTable.PSVersion)" -ForegroundColor DarkGray
    Write-Host ""

    # --- Kaynak klasörü bul (birkaç yedekli yöntem) ---
    $Kaynak = $null
    if ($PSScriptRoot) { $Kaynak = Split-Path -Parent $PSScriptRoot }
    if (-not $Kaynak -and $MyInvocation.MyCommand.Path) {
        $Kaynak = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
    }
    if (-not $Kaynak) { $Kaynak = (Get-Location).Path }

    # index.html burada mı? Değilse bir üst/alt klasöre bak
    if (-not (Test-Path (Join-Path $Kaynak 'index.html'))) {
        $aday = Join-Path $Kaynak 'mtnsite'
        if (Test-Path (Join-Path $aday 'index.html')) { $Kaynak = $aday }
    }

    Write-Host "  Kaynak klasör : $Kaynak" -ForegroundColor Cyan

    if (-not (Test-Path (Join-Path $Kaynak 'index.html'))) {
        Write-Host ""
        Write-Host "  HATA: Bu klasörde index.html bulunamadı." -ForegroundColor Red
        Write-Host "  Betiği proje klasöründeki _kurulum içinden çalıştırın:" -ForegroundColor Yellow
        Write-Host "    C:\Users\EXADOTH\Desktop\mtnsite\_kurulum\FTP-YUKLE.bat"
        Duraklat; return
    }

    # --- Yüklenmeyecekler ---
    $HaricKlasor = @('images-original', '_kaldirilan-gorseller', '_kurulum', '_hafiza', '.git', '.claude', '__pycache__')
    $HaricUzanti = @('.bak', '.zip', '.py', '.ps1', '.bat')
    $HaricDosya  = @('README.md', 'vercel.json', '.gitignore', '.vercelignore')

    $Dosyalar = Get-ChildItem -Path $Kaynak -Recurse -File -ErrorAction SilentlyContinue | Where-Object {
        $rel = $_.FullName.Substring($Kaynak.Length + 1)
        $ilk = $rel.Split('\')[0]
        -not (($HaricKlasor -contains $ilk) -or
              ($HaricUzanti -contains $_.Extension.ToLower()) -or
              ($HaricDosya  -contains $_.Name))
    }

    if (-not $Dosyalar -or $Dosyalar.Count -eq 0) {
        Write-Host "  HATA: Yüklenecek dosya bulunamadı." -ForegroundColor Red
        Duraklat; return
    }

    $ToplamMB = [math]::Round((($Dosyalar | Measure-Object -Property Length -Sum).Sum / 1MB), 1)
    Write-Host "  Yüklenecek    : $($Dosyalar.Count) dosya, $ToplamMB MB" -ForegroundColor Cyan
    Write-Host ""

    # --- FTP bilgileri ---
    Write-Host "  FTP BİLGİLERİ  (müşteri paneli -> FTP Hesapları)" -ForegroundColor Yellow
    Write-Host ""

    $Sunucu = Read-Host "  FTP sunucusu  [Enter = ftp.mtnizolasyon.com]"
    if ([string]::IsNullOrWhiteSpace($Sunucu)) { $Sunucu = 'ftp.mtnizolasyon.com' }
    $Sunucu = ($Sunucu -replace '^ftp://', '').TrimEnd('/')

    $Kullanici = Read-Host "  Kullanıcı adı"
    if ([string]::IsNullOrWhiteSpace($Kullanici)) {
        Write-Host "  HATA: Kullanıcı adı boş olamaz." -ForegroundColor Red; Duraklat; return
    }

    $SifreGuvenli = Read-Host "  Şifre (yazarken görünmez)" -AsSecureString
    $Sifre = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
               [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SifreGuvenli))
    if ([string]::IsNullOrWhiteSpace($Sifre)) {
        Write-Host "  HATA: Şifre boş olamaz." -ForegroundColor Red; Duraklat; return
    }

    $UzakKok = Read-Host "  Hedef klasör  [Enter = /domains/mtnizolasyon.com/public_html]"
    if ([string]::IsNullOrWhiteSpace($UzakKok)) { $UzakKok = '/domains/mtnizolasyon.com/public_html' }
    $UzakKok = '/' + $UzakKok.Trim('/')

    $Kimlik = New-Object System.Net.NetworkCredential($Kullanici, $Sifre)

    function Yeni-Istek([string]$Yol, [string]$Metot, [bool]$SslKullan) {
        $r = [System.Net.FtpWebRequest]::Create("ftp://$Sunucu$Yol")
        $r.Credentials = $Kimlik
        $r.Method      = $Metot
        $r.UseBinary   = $true
        $r.UsePassive  = $true
        $r.KeepAlive   = $false
        $r.EnableSsl   = $SslKullan
        $r.Timeout     = 45000
        return $r
    }

    # --- Bağlantıyı sırayla dene: önce FTPS, olmazsa düz FTP ---
    Write-Host ""
    $Ssl = $null
    foreach ($deneme in @($true, $false)) {
        $etiket = 'FTPS (şifreli)'
        if (-not $deneme) { $etiket = 'düz FTP' }
        Write-Host "  Bağlantı deneniyor — $etiket ..." -NoNewline
        try {
            $t = Yeni-Istek $UzakKok ([System.Net.WebRequestMethods+Ftp]::ListDirectory) $deneme
            $y = $t.GetResponse(); $y.Close()
            Write-Host " BAŞARILI" -ForegroundColor Green
            $Ssl = $deneme
            break
        } catch {
            Write-Host " olmadı" -ForegroundColor DarkYellow
            $sonHata = $_.Exception.Message
        }
    }

    if ($null -eq $Ssl) {
        Write-Host ""
        Write-Host "  BAĞLANTI KURULAMADI" -ForegroundColor Red
        Write-Host "  Son hata: $sonHata" -ForegroundColor Red
        Write-Host ""
        Write-Host "  Sırayla şunları deneyin:" -ForegroundColor Yellow
        Write-Host "   1. Kullanıcı adı / şifre doğru mu? (müşteri paneli -> FTP Hesapları)"
        Write-Host "   2. Hedef klasörü değiştirin. Sırayla deneyin:"
        Write-Host "        /domains/mtnizolasyon.com/public_html"
        Write-Host "        /public_html"
        Write-Host "        /"
        Write-Host "   3. Sunucu adresi farklı olabilir: mtnizolasyon.com  veya  lin1.nictr.com"
        Write-Host ""
        Write-Host "  Bu ekranın tamamı şuraya kaydedildi:" -ForegroundColor DarkGray
        Write-Host "    $LogYolu"
        Duraklat; return
    }

    # --- Uzak klasörleri oluştur ---
    $Olusturulan = @{}
    function Klasor-Olustur([string]$UzakYol) {
        if ($Olusturulan.ContainsKey($UzakYol)) { return }
        try {
            $r = Yeni-Istek $UzakYol ([System.Net.WebRequestMethods+Ftp]::MakeDirectory) $Ssl
            $y = $r.GetResponse(); $y.Close()
        } catch { }
        $Olusturulan[$UzakYol] = $true
    }

    # --- Yükleme ---
    Write-Host ""
    Write-Host "  Yükleme başlıyor — $($Dosyalar.Count) dosya" -ForegroundColor Cyan
    Write-Host ""

    $Sayac = 0; $Basarili = 0; $Basarisiz = @()
    $Baslangic = Get-Date

    foreach ($d in $Dosyalar) {
        $Sayac++
        $rel  = $d.FullName.Substring($Kaynak.Length + 1).Replace('\', '/')
        $uzak = "$UzakKok/$rel"

        $parca = $rel.Split('/')
        if ($parca.Count -gt 1) {
            $birikim = $UzakKok
            for ($i = 0; $i -lt $parca.Count - 1; $i++) {
                $birikim = "$birikim/$($parca[$i])"
                Klasor-Olustur $birikim
            }
        }

        $yuzde = [math]::Round(($Sayac / $Dosyalar.Count) * 100)
        Write-Progress -Activity "FTP yükleme" -Status "$Sayac / $($Dosyalar.Count)  $rel" -PercentComplete $yuzde

        $denendi = 0; $tamam = $false
        while (-not $tamam -and $denendi -lt 3) {
            $denendi++
            try {
                $r = Yeni-Istek $uzak ([System.Net.WebRequestMethods+Ftp]::UploadFile) $Ssl
                $veri = [System.IO.File]::ReadAllBytes($d.FullName)
                $r.ContentLength = $veri.Length
                $ak = $r.GetRequestStream()
                $ak.Write($veri, 0, $veri.Length)
                $ak.Close()
                $y = $r.GetResponse(); $y.Close()
                $tamam = $true; $Basarili++
            } catch {
                if ($denendi -ge 3) {
                    $Basarisiz += "$rel  ->  $($_.Exception.Message)"
                } else { Start-Sleep -Milliseconds 700 }
            }
        }

        if ($Sayac % 25 -eq 0) {
            Write-Host ("    {0} / {1}   %{2}" -f $Sayac, $Dosyalar.Count, $yuzde) -ForegroundColor DarkGray
        }
    }

    Write-Progress -Activity "FTP yükleme" -Completed
    $Sure = (Get-Date) - $Baslangic

    Write-Host ""
    Write-Host "  ==========================================" -ForegroundColor Cyan
    Write-Host "   Başarılı : $Basarili dosya" -ForegroundColor Green
    if ($Basarisiz.Count -gt 0) {
        Write-Host "   HATALI   : $($Basarisiz.Count) dosya" -ForegroundColor Red
        $Basarisiz | Select-Object -First 15 | ForEach-Object { Write-Host "     $_" -ForegroundColor Red }
    } else {
        Write-Host "   Hata yok" -ForegroundColor Green
    }
    Write-Host ("   Süre     : {0} dakika {1} saniye" -f [int]$Sure.TotalMinutes, $Sure.Seconds)
    Write-Host "  ==========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Şimdi tarayıcıda kontrol edin:" -ForegroundColor Yellow
    Write-Host "    https://www.mtnizolasyon.com/"
    Write-Host "    https://www.mtnizolasyon.com/hizmetler/"
    Write-Host "    https://www.mtnizolasyon.com/galeri/"

} catch {
    Write-Host ""
    Write-Host "  BEKLENMEYEN HATA" -ForegroundColor Red
    Write-Host "  $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Ayrıntı:" -ForegroundColor DarkGray
    Write-Host "  $($_.ScriptStackTrace)" -ForegroundColor DarkGray
} finally {
    try { Stop-Transcript | Out-Null } catch { }
    Write-Host ""
    Write-Host "  Bu ekranın tamamı kaydedildi:" -ForegroundColor DarkGray
    Write-Host "    $LogYolu" -ForegroundColor DarkGray
    Duraklat
}
