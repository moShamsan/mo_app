# ايقاف العمليات التي تقفل مجلدات البناء ثم حذفها
# شغّل من PowerShell: .\fix_build_lock.ps1
Write-Host "Stopping Java and Dart processes..."
taskkill /F /IM java.exe 2>$null
taskkill /F /IM dart.exe 2>$null
Start-Sleep -Seconds 2
$p = $PSScriptRoot
if (Test-Path "$p\.dart_tool\flutter_build") {
    Remove-Item -Recurse -Force "$p\.dart_tool\flutter_build"
    Write-Host "Deleted .dart_tool\flutter_build"
}
if (Test-Path "$p\build") {
    Remove-Item -Recurse -Force "$p\build"
    Write-Host "Deleted build"
}
Write-Host "Done. You can now run: flutter pub get ; flutter run"
