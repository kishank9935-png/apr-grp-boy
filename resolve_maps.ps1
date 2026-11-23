try {
    $req = [System.Net.HttpWebRequest]::Create("https://maps.app.goo.gl/oc3artJE4YjWZAFA8")
    $req.AllowAutoRedirect = $false
    $resp = $req.GetResponse()
    $loc = $resp.GetResponseHeader("Location")
    Write-Output "Redirected Location: $loc"
} catch {
    Write-Output "Error: $($_.Exception.Message)"
}
