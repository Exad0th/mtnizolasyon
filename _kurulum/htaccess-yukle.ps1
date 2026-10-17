# MTN Izolasyon - tek dosya yukleme (.htaccess duzeltmesi)
$ErrorActionPreference = 'Continue'

$LogYolu = Join-Path $PSScriptRoot 'htaccess-log.txt'
try { Start-Transcript -Path $LogYolu -Force | Out-Null } catch { }

function Duraklat {
    Write-Host ""
    Write-Host "  --- Kapatmak icin Enter'a basin ---" -ForegroundColor DarkGray
    try { Read-Host | Out-Null } catch { Start-Sleep -Seconds 30 }
}

try {
    $Kaynak = Split-Path -Parent $PSScriptRoot
    $Dosya  = Join-Path $Kaynak '.htaccess'

    Write-Host ""
    Write-Host "  ==============================================" -ForegroundColor Cyan
    Write-Host "   MTN Izolasyon - .htaccess duzeltmesi" -ForegroundColor Cyan
    Write-Host "  ==============================================" -ForegroundColor Cyan
    Write-Host ""

    if (-not (Test-Path $Dosya)) {
        Write-Host "  HATA: .htaccess bulunamadi: $Dosya" -ForegroundColor Red
        Duraklat; return
    }
    Write-Host "  Gonderilecek: $Dosya"
    Write-Host "  Boyut       : $((Get-Item $Dosya).Length) bayt"
    Write-Host ""
    Write-Host "  Biraz once kullandiginiz FTP bilgilerini girin." -ForegroundColor Yellow
    Write-Host ""

    $Sunucu = Read-Host "  FTP sunucusu  [Enter = ftp.mtnizolasyon.com]"
    if ([string]::IsNullOrWhiteSpace($Sunucu)) { $Sunucu = 'ftp.mtnizolasyon.com' }
    $Sunucu = ($Sunucu -replace '^ftp://', '').TrimEnd('/')

    $Kullanici = Read-Host "  Kullanici adi"
    if ([string]::IsNullOrWhiteSpace($Kullanici)) {
        Write-Host "  Kullanici adi bos olamaz." -ForegroundColor Red
        Duraklat; return
    }

    $SifreGuvenli = Read-Host "  Sifre (yazarken gorunmez)" -AsSecureString
    $bstr  = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SifreGuvenli)
    $Sifre = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)

    $UzakKok = Read-Host "  Hedef klasor  [Enter = /public_html]"
    if ([string]::IsNullOrWhiteSpace($UzakKok)) { $UzakKok = '/public_html' }
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

    Write-Host ""
    $Ssl = $null
    $sonHata = ''
    foreach ($deneme in @($true, $false)) {
        $etiket = 'FTPS (sifreli)'
        if (-not $deneme) { $etiket = 'duz FTP' }
        Write-Host "  Baglanti deneniyor - $etiket ..." -NoNewline
        try {
            $t = Yeni-Istek $UzakKok ([System.Net.WebRequestMethods+Ftp]::ListDirectory) $deneme
            $y = $t.GetResponse(); $y.Close()
            Write-Host " BASARILI" -ForegroundColor Green
            $Ssl = $deneme
            break
        } catch {
            Write-Host " olmadi" -ForegroundColor DarkYellow
            $sonHata = $_.Exception.Message
        }
    }

    if ($null -eq $Ssl) {
        Write-Host ""
        Write-Host "  BAGLANTI KURULAMADI" -ForegroundColor Red
        Write-Host "  Son hata: $sonHata" -ForegroundColor Red
        Duraklat; return
    }

    Write-Host ""
    Write-Host "  .htaccess gonderiliyor ..."
    $veri  = [System.IO.File]::ReadAllBytes($Dosya)
    $tamam = $false
    for ($i = 1; $i -le 3; $i++) {
        try {
            $r = Yeni-Istek "$UzakKok/.htaccess" ([System.Net.WebRequestMethods+Ftp]::UploadFile) $Ssl
            $r.ContentLength = $veri.Length
            $ak = $r.GetRequestStream()
            $ak.Write($veri, 0, $veri.Length)
            $ak.Close()
            $c = $r.GetResponse(); $c.Close()
            $tamam = $true
            break
        } catch {
            $sonHata = $_.Exception.Message
            Start-Sleep -Milliseconds 700
        }
    }

    Write-Host ""
    if ($tamam) {
        Write-Host "  ==============================================" -ForegroundColor Green
        Write-Host "   BASARILI - .htaccess guncellendi" -ForegroundColor Green
        Write-Host "  ==============================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "  Tarayicida GIZLI PENCERE acip deneyin:" -ForegroundColor Yellow
        Write-Host "    https://www.mtnizolasyon.com/"
        Write-Host ""
        Write-Host "  Normal pencerede onbellek yuzunden hala donebilir." -ForegroundColor DarkGray
    } else {
        Write-Host "  YUKLENEMEDI" -ForegroundColor Red
        Write-Host "  Hata: $sonHata" -ForegroundColor Red
    }

    Duraklat
}
catch {
    Write-Host ""
    Write-Host "  BEKLENMEYEN HATA" -ForegroundColor Red
    Write-Host "  $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "  Satir: $($_.InvocationInfo.ScriptLineNumber)" -ForegroundColor Red
    Duraklat
}
finally {
    try { Stop-Transcript | Out-Null } catch { }
}
