$pages = @(
    'index.html', 'about.html', 'projects.html',
    'rajpura-phase-1.html', 'ugapur.html', 'kanshraipur.html',
    'chauri-bazar.html', 'gosai-bazar.html', 'parjapatpur.html',
    'gallery.html', 'blog.html',
    'blog-how-to-check-plot.html', 'blog-why-bhadohi.html',
    'blog-plot-size-vs-budget.html', 'blog-documents-checklist.html',
    'blog-how-to-calculate-prices.html',
    'contact.html', 'privacy-policy.html',
    'terms-and-conditions.html', 'disclaimer.html'
)

$results = @()
foreach ($page in $pages) {
    $url = "http://localhost:8080/$page"
    try {
        $resp = Invoke-WebRequest -Uri $url -Method Get -UseBasicParsing -TimeoutSec 5
        $results += [PSCustomObject]@{
            Page = $page
            Status = $resp.StatusCode
            Length = $resp.Content.Length
            HasPhone = $resp.Content.Contains('+91 63921 99296')
            HasLogo = $resp.Content.Contains('apr-group-logo.png')
            HasFooter = $resp.Content.Contains('APR GROUP OF COMPANY')
        }
    } catch {
        $results += [PSCustomObject]@{
            Page = $page
            Status = $_.Exception.Message
            Length = 0
            HasPhone = $false
            HasLogo = $false
            HasFooter = $false
        }
    }
}
$results | Format-Table -AutoSize
