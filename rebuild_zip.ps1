$ProgressPreference = 'SilentlyContinue'
if (Test-Path "apr-group-theme.zip") {
    Remove-Item "apr-group-theme.zip" -Force
}
Compress-Archive -Path "apr-group-theme" -DestinationPath "apr-group-theme.zip" -Force
Get-Item "apr-group-theme.zip" | Select-Object Name, Length
