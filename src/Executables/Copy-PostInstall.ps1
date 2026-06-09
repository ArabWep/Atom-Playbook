$src = Join-Path $PSScriptRoot "PostInstall"
$dst = Join-Path $env:USERPROFILE "Desktop\PostInstall"
if (Test-Path $src) {
    Copy-Item -Path $src -Destination $dst -Recurse -Force
}
