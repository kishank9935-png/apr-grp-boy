[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = 'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=1000&q=85'
$f1 = 'c:\Users\DELL\Desktop\APR GROUP\assets\images\projects\layout-view.jpg'
$f2 = 'c:\Users\DELL\Desktop\APR GROUP\apr-group-theme\assets\images\projects\layout-view.jpg'
Invoke-WebRequest -Uri $url -OutFile $f1 -TimeoutSec 15 -UserAgent 'Mozilla/5.0'
Copy-Item $f1 $f2 -Force
Get-Item $f1 | Select-Object FullName, Length
