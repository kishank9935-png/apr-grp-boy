$imgs = @('hero-banner.jpg', 'about-office.jpg', 'rajpura-1.jpg', 'ugapur-1.jpg', 'kanshraipur-1.jpg', 'chauri-1.jpg', 'gosai-1.jpg', 'parjapatpur-1.jpg')
foreach ($img in $imgs) {
    $url = "http://localhost:8080/assets/images/projects/$img"
    $r = Invoke-WebRequest -Uri $url -Method Head -UseBasicParsing
    [PSCustomObject]@{ Image = $img; Status = $r.StatusCode; Length = $r.Headers['Content-Length'] }
}
