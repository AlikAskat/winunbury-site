$ErrorActionPreference = "Stop"

# WinUnbury - BluetoothSwitch product page publisher

$Repo = "C:\Users\asus\Downloads\WinUnburySite"

if (-not (Test-Path $Repo)) {
    throw "Repository not found: $Repo"
}

Set-Location $Repo

Write-Host ""
Write-Host "WinUnbury - BluetoothSwitch publisher" -ForegroundColor Cyan
Write-Host ""

git diff --check
if ($LASTEXITCODE -ne 0) {
    throw "git diff --check found whitespace errors."
}

Write-Host "Repository status:" -ForegroundColor Yellow
git status --short
Write-Host ""

git add ".\bluetoothswitch\index.html" ".\sitemap.xml"
if ($LASTEXITCODE -ne 0) {
    throw "git add failed."
}

git diff --cached --quiet

if ($LASTEXITCODE -eq 0) {
    Write-Host "Nothing new to commit." -ForegroundColor Yellow
}
else {
    git commit -m "Add BluetoothSwitch product page"
    if ($LASTEXITCODE -ne 0) {
        throw "git commit failed."
    }

    git push origin main
    if ($LASTEXITCODE -ne 0) {
        throw "git push failed."
    }

    Write-Host ""
    Write-Host "Published to GitHub." -ForegroundColor Green
}

Write-Host ""
Write-Host "Cloudflare Pages:" -ForegroundColor Green
Write-Host "https://winunbury-site.pages.dev/bluetoothswitch/" -ForegroundColor Cyan
Write-Host ""
Write-Host "Cloudflare should deploy automatically after the GitHub push." -ForegroundColor Green
