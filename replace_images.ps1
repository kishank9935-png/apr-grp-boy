Add-Type -AssemblyName System.Drawing

$images = @{
    "hero-banner.jpg"    = "https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=1200&q=85"
    "about-office.jpg"   = "https://images.unsplash.com/photo-1497366216548-37526070297c?w=1000&q=85"
    "plotting-road.jpg"  = "https://images.unsplash.com/photo-1513694203232-719a280e022f?w=1000&q=85"
    "green-plots.jpg"    = "https://images.unsplash.com/photo-1500076656116-558758c991c1?w=1000&q=85"
    "layout-view.jpg"    = "https://images.unsplash.com/photo-1524813686514-a57563d77d61?w=1000&q=85"
    "site-visit.jpg"     = "https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=1000&q=85"
    "rajpura-1.jpg"      = "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1000&q=85"
    "rajpura-2.jpg"      = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1000&q=85"
    "ugapur-1.jpg"       = "https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=1000&q=85"
    "ugapur-2.jpg"       = "https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=1000&q=85"
    "kanshraipur-1.jpg"  = "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1000&q=85"
    "kanshraipur-2.jpg"  = "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=1000&q=85"
    "chauri-1.jpg"       = "https://images.unsplash.com/photo-1448375240586-882707db888b?w=1000&q=85"
    "chauri-2.jpg"       = "https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?w=1000&q=85"
    "gosai-1.jpg"        = "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=1000&q=85"
    "gosai-2.jpg"        = "https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=1000&q=85"
    "parjapatpur-1.jpg"   = "https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=1000&q=85"
    "parjapatpur-2.jpg"   = "https://images.unsplash.com/photo-1426604966848-d7adac402bff?w=1000&q=85"
}

$dest1 = "c:\Users\DELL\Desktop\APR GROUP\assets\images\projects"
$dest2 = "c:\Users\DELL\Desktop\APR GROUP\apr-group-theme\assets\images\projects"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

foreach ($name in $images.Keys) {
    $file1 = Join-Path $dest1 $name
    $file2 = Join-Path $dest2 $name

    # Remove old file from user's computer
    if (Test-Path $file1) { Remove-Item $file1 -Force }
    if (Test-Path $file2) { Remove-Item $file2 -Force }

    $url = $images[$name]
    $downloadSuccess = $false

    try {
        Write-Output "Downloading ${name} from royalty-free source..."
        Invoke-WebRequest -Uri $url -OutFile $file1 -TimeoutSec 15 -UserAgent "Mozilla/5.0"
        if ((Get-Item $file1).Length -gt 5000) {
            $downloadSuccess = $true
        }
    } catch {
        Write-Output "Download failed for ${name}"
    }

    if (-not $downloadSuccess) {
        Write-Output "Generating fallback high-res placeholder for ${name}..."
        $bmp = New-Object System.Drawing.Bitmap 1200, 800
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $navyBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(23, 59, 101))
        $greenBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(21, 149, 104))
        $whiteBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
        $fontTitle = New-Object System.Drawing.Font "Arial", 36, [System.Drawing.FontStyle]::Bold
        $fontSub = New-Object System.Drawing.Font "Arial", 22, [System.Drawing.FontStyle]::Regular

        $g.FillRectangle($navyBrush, 0, 0, 1200, 800)
        $g.FillRectangle($greenBrush, 0, 760, 1200, 40)
        $g.DrawString("APR GROUP OF COMPANY", $fontTitle, $whiteBrush, 100, 320)
        $g.DrawString("Residential Plotting - Replace via Elementor", $fontSub, $whiteBrush, 100, 390)

        $g.Dispose()
        $bmp.Save($file1, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        $bmp.Dispose()
    }

    # Copy to theme
    Copy-Item $file1 $file2 -Force
    $size = (Get-Item $file1).Length
    Write-Output "Saved ${name} ($size bytes) in both locations."
}

Write-Output "All 18 images successfully replaced with royalty-free/placeholder images."
