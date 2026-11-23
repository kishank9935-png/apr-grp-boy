$testUrl = "http://localhost:8080/index.html"
try {
    $wc = New-Object System.Net.WebClient
    $html = $wc.DownloadString($testUrl)
    Write-Output "HTTP Fetch: SUCCESS ($($html.Length) chars)"

    $hasWriteReview = $html -match 'href="https://g\.page/r/CUNndIdTFafPEBM/review"\s+target="_blank"\s+rel="noopener noreferrer"'
    Write-Output "Write Review Link Correct: $hasWriteReview"

    $hasReadAllReviews = $html -match 'href="https://maps\.app\.goo\.gl/oc3artJE4YjWZAFA8"\s+target="_blank"\s+rel="noopener noreferrer"'
    Write-Output "Read All Reviews Link Correct: $hasReadAllReviews"

    $hasFakeRajesh = $html -match "Rajesh Kumar"
    $hasFakeAnil = $html -match "Anil Maurya"
    $hasFakeSanjay = $html -match "Sanjay Tiwari"
    Write-Output "Zero Fake Reviews: $(!$hasFakeRajesh -and !$hasFakeAnil -and !$hasFakeSanjay)"

    $hasGoogleAttribution = $html -match "Google is a trademark of Google LLC"
    Write-Output "Google Attribution: $hasGoogleAttribution"
} catch {
    Write-Output "Fetch Error: $($_.Exception.Message)"
}
