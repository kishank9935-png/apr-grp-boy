try {
    $testUrl = "https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&q=80"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $testUrl -OutFile "scratch/test_download.jpg" -TimeoutSec 10 -UserAgent "Mozilla/5.0"
    Get-Item "scratch/test_download.jpg" | Select-Object Length
} catch {
    Write-Output "Error: $($_.Exception.Message)"
}
