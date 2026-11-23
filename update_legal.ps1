$legalFiles = @("privacy-policy.html", "terms-and-conditions.html", "disclaimer.html")

$target = '<p style="color:var\(--text-footer\);font-size:0\.9rem;\">Phone: \+91 63921 99296</p>'

$replacement = @'
          <p style="color:var(--text-footer);font-size:0.9rem;">Phone: +91 63921 99296</p>
          <div class="footer-action-buttons">
            <a href="https://wa.me/916392199296" target="_blank" rel="noopener" class="footer-btn footer-btn-whatsapp" aria-label="WhatsApp APR Group">
              <svg viewBox="0 0 24 24"><path d="M12.04 2c-5.46 0-9.91 4.45-9.91 9.91 0 1.75.46 3.45 1.32 4.95L2.05 22l5.25-1.38c1.45.79 3.08 1.21 4.74 1.21 5.46 0 9.91-4.45 9.91-9.91 0-2.65-1.03-5.14-2.9-7.01A9.816 9.816 0 0 0 12.04 2zm.01 16.67c-1.5 0-2.97-.4-4.26-1.16l-.31-.18-3.16.83.84-3.08-.2-.32a8.212 8.212 0 0 1-1.26-4.37c0-4.54 3.7-8.24 8.25-8.24 2.2 0 4.27.86 5.82 2.42a8.181 8.181 0 0 1 2.41 5.83c.02 4.54-3.68 8.24-8.23 8.24z"/></svg>
              <span>WhatsApp</span>
            </a>
            <a href="tel:+916392199296" class="footer-btn footer-btn-call" aria-label="Call APR Group">
              <svg viewBox="0 0 24 24"><path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z"/></svg>
              <span>Call Now</span>
            </a>
          </div>
'@

foreach ($name in $legalFiles) {
    if (Test-Path $name) {
        $c = [System.IO.File]::ReadAllText((Resolve-Path $name).Path, [System.Text.Encoding]::UTF8)
        if ($c -notmatch "footer-action-buttons") {
            $c = [System.Text.RegularExpressions.Regex]::Replace($c, $target, $replacement)
            [System.IO.File]::WriteAllText((Resolve-Path $name).Path, $c, [System.Text.Encoding]::UTF8)
            Write-Output "Updated legal file: $name"
        }
    }
}
