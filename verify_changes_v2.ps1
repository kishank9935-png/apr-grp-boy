$testUrl = "http://localhost:8080/index.html"
try {
    $wc = New-Object System.Net.WebClient
    $html = $wc.DownloadString($testUrl)
    Write-Output "HTTP Fetch Status: SUCCESS (Length: $($html.Length) chars)"

    # Check Requirements
    $hasGoogleReviews = $html -match "maps\.app\.goo\.gl/oc3artJE4YjWZAFA8"
    Write-Output "1. Google Profile Link Present: $hasGoogleReviews"

    $hasGoogleAttribution = $html -match "Google is a trademark of Google LLC"
    Write-Output "1. Google Attribution Present: $hasGoogleAttribution"

    $hasHorizontalReview = $html -match "share-review-horizontal" -and $html -match "share-review-layout"
    Write-Output "2. Horizontal Feedback Layout Present: $hasHorizontalReview"

    $hasFooterButtons = $html -match "footer-action-buttons" -and $html -match "footer-btn-whatsapp" -and $html -match "footer-btn-call"
    Write-Output "3. Footer Equal Buttons Present: $hasFooterButtons"

    $hasEqualFab = $html -match "fab-container" -and $html -match "fab-whatsapp" -and $html -match "fab-call"
    Write-Output "4. Floating Action Buttons Present: $hasEqualFab"

} catch {
    Write-Output "HTTP Fetch Error: $($_.Exception.Message)"
}
