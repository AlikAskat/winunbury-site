$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "WinUnbury - BluetoothSwitch publish helper" -ForegroundColor Green
Write-Host ""

# Verify that the BluetoothSwitch product page exists.
if (-not (Test-Path ".\bluetoothswitch\index.html")) {
    throw "File .\bluetoothswitch\index.html not found."
}

# Verify that sitemap exists.
if (-not (Test-Path ".\sitemap.xml")) {
    throw "File .\sitemap.xml not found."
}

# Check repository state.
git diff --check
if ($LASTEXITCODE -ne 0) {
    throw "git diff --check found formatting errors."
}

git status

Write-Host ""
Write-Host "Adding BluetoothSwitch product page and sitemap..." -ForegroundColor Yellow

git add ".\bluetoothswitch\index.html" ".\sitemap.xml"

if ($LASTEXITCODE -ne 0) {
    throw "git add failed."
}

# Commit only if there are staged changes.
git diff --cached --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host "No new changes to commit." -ForegroundColor Yellow
}
else {
    git commit -m "Add BluetoothSwitch product page"
    if ($LASTEXITCODE -ne 0) {
        throw "git commit failed."
    }
}

Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow

git push origin main
if ($LASTEXITCODE -ne 0) {
    throw "git push failed."
}

Write-Host ""
Write-Host "GitHub: https://github.com/AlikAskat/winunbury-site" -ForegroundColor Green
Write-Host "Cloudflare Pages: https://winunbury-site.pages.dev/" -ForegroundColor Green
Write-Host "BluetoothSwitch page: https://winunbury-site.pages.dev/bluetoothswitch/" -ForegroundColor Cyan
Write-Host ""
Write-Host "DONE" -ForegroundColor Green
