$html = (Invoke-WebRequest -Uri "http://localhost:8080/index.html" -UseBasicParsing).Content

# 1. Hero checks
$heroStart = $html.IndexOf('<section class="hero-home">')
$heroEnd = $html.IndexOf('</section>', $heroStart)
$heroHtml = $html.Substring($heroStart, $heroEnd - $heroStart)

$hasCalcBtn = $heroHtml.Contains("Calculate Plot Price")
$hasWaBtn = $heroHtml.Contains("WhatsApp Us")
$hasHeroStats = $heroHtml.Contains("hero-stats")
$hasFloatingCard = $heroHtml.Contains("hero-floating-card")
$hasExploreBtn = $heroHtml.Contains("Explore Our Projects")

# 2. Carousel checks
$hasCarousel = $heroHtml.Contains("id=""heroProjectCarousel""")
$hasRajpura = $heroHtml.Contains("Rajpura Phase 1")
$hasUgapur = $heroHtml.Contains("Ugapur, Bhadohi")
$hasKanshraipur = $heroHtml.Contains("Kanshraipur")
$hasChauri = $heroHtml.Contains("Chauri Bazar")
$hasGosai = $heroHtml.Contains("Gosai Bazar, Gyanpur")
$hasParjapatpur = $heroHtml.Contains("Parjapatpur, Bhadohi")
$hasArrows = $heroHtml.Contains("hero-carousel-arrow prev") -and $heroHtml.Contains("hero-carousel-arrow next")
$hasDots = $heroHtml.Contains("hero-carousel-dots")

# 3. Customer Reviews and Form checks
$hasReviewsSection = $html.Contains("id=""reviews-section""")
$hasReviewForm = $html.Contains("id=""aprReviewForm""")
$hasCustName = $html.Contains("id=""revCustomerName""")
$hasMobile = $html.Contains("id=""revMobileNumber""")
$hasStars = $html.Contains("star-btn")
$hasReviewText = $html.Contains("id=""revReviewText""")
$hasAdminNotice = $html.Contains("Authenticity & Approval Policy")

# 4. Floating Action Buttons checks
$hasFabWhatsApp = $html.Contains("class=""fab-btn fab-whatsapp""") -and $html.Contains("<span>WhatsApp</span>")
$hasFabCall = $html.Contains("class=""fab-btn fab-call""") -and $html.Contains("<span>Call Now</span>")

[PSCustomObject]@{
    "1. Calc Btn Removed from Hero"      = (-not $hasCalcBtn)
    "2. WA Btn Removed from Hero"        = (-not $hasWaBtn)
    "3. Hero Stats Row Removed"          = (-not $hasHeroStats)
    "4. Floating Office Card Removed"    = (-not $hasFloatingCard)
    "Hero Explore Btn Kept"              = $hasExploreBtn
    "5. Hero 6-Project Carousel Present" = $hasCarousel
    "   - All 6 Projects in Carousel"    = ($hasRajpura -and $hasUgapur -and $hasKanshraipur -and $hasChauri -and $hasGosai -and $hasParjapatpur)
    "   - Carousel Arrows & Dots"        = ($hasArrows -and $hasDots)
    "6. Customer Reviews Section"        = $hasReviewsSection
    "7. Share Experience Form"           = ($hasReviewForm -and $hasCustName -and $hasMobile -and $hasStars -and $hasReviewText)
    "   - Pending Admin Notice Present"  = $hasAdminNotice
    "8. Floating WA Rounded Rect + Text" = $hasFabWhatsApp
    "   - Floating Call Rounded + Text"  = $hasFabCall
} | Format-List
