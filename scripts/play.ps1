# Sinoxy Gameon launcher: runs the game for normal play (no scripted presses, no capture).
param(
    [Parameter(Mandatory = $true)][string]$Game,
    [string]$Cache = "$env:LOCALAPPDATA\sinoxy\cache",
    [string]$Data = "$env:LOCALAPPDATA\sinoxy\data",
    [string]$Exe = "$PSScriptRoot\..\target\release\sinoxy.exe"
)
foreach ($v in "SINOXY_KEYS", "SINOXY_CAPTURE", "SINOXY_CAPTURE_FRAMES", "SINOXY_DUMP_TARGETS") {
    Remove-Item "Env:$v" -ErrorAction SilentlyContinue
}
New-Item -ItemType Directory -Force $Cache, $Data | Out-Null
$env:SINOXY_CACHE_DIR = $Cache
$env:SINOXY_DATA_DIR = $Data
& $Exe run $Game --execute 2>&1 | Out-File "$env:TEMP\sinoxy.log" -Encoding utf8
Write-Host "Exited with $LASTEXITCODE; log: $env:TEMP\sinoxy.log"
