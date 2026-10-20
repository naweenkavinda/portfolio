# Rebuilds the project cards in index.html and the project table in README.md
# from the folders under projects/. Run by .github/workflows/update-portfolio.yml
# on every push; safe to run locally too (Windows PowerShell 5.1 or PowerShell 7).
#
# Each projects/<slug>/ folder becomes one card and one table row.
#   README.md  - title (first "# " heading), summary (first paragraph), tech ("## Tech" bullets)
#   index.html - if present, the project gets a demo button
#   meta.json  - optional overrides: title, summary, blurb, tech[], emoji, icon, kind
#                (live | demo | snapshot), demoLabel, tableLabel, order, links[{label,url,emoji}],
#                span (plot width in 12ths: 4 5 6 7 8 12; default 6), variant (paper | dashed |
#                accent | dark), category (the small label after "Plot NN"),
#                demoUrl (demo link when the live page isn't the folder's own index.html:
#                a full https URL, or a path relative to the site root such as "./")
param([string]$Root = (Get-Location).Path)
$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding $false

function Read-Text([string]$p) { [IO.File]::ReadAllText($p, $utf8) }
function Write-Text([string]$p, [string]$t) { [IO.File]::WriteAllText($p, $t, $utf8) }
function Esc([string]$s) { if ($null -eq $s) { return '' }; $s.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;').Replace('"', '&quot;') }
function First { foreach ($a in $args) { if ($null -ne $a -and "$a" -ne '') { return $a } }; return $null }
function Plain([string]$s) {
  if (-not $s) { return '' }
  $s = [regex]::Replace($s, '\[([^\]]+)\]\([^)]*\)', '$1')
  $s = $s -replace '\*\*|__|`', ''
  return $s.Trim()
}
function Splice([string]$text, [string]$start, [string]$end, [string]$inner, [switch]$Inline) {
  $a = $text.IndexOf($start); $b = $text.IndexOf($end)
  if ($a -lt 0 -or $b -lt $a) { throw "Markers $start / $end not found" }
  $nl = if ($Inline) { '' } else { "`n" }
  return $text.Substring(0, $a + $start.Length) + $nl + $inner + $nl + $text.Substring($b)
}

$repo = if ($env:GITHUB_REPOSITORY) { $env:GITHUB_REPOSITORY } else { 'naweenkavinda/portfolio' }
$owner, $repoName = $repo.Split('/')
$site = "https://$($owner.ToLower()).github.io/$repoName/"
$tree = "https://github.com/$repo/tree/main/projects/"

$ICONS = @{
  house    = '<path d="M14 58 60 22l46 36"/><path d="M24 50v52h72V50"/><path d="M50 102V74h20v28"/><rect x="32" y="62" width="12" height="12"/><rect x="76" y="62" width="12" height="12"/><path d="M8 108h104" stroke-dasharray="4 4"/><path d="M78 30v-8h10v16"/>'
  chart    = '<rect x="12" y="16" width="96" height="88"/><path d="M12 34h96"/><path d="M22 86l16-18 14 10 18-26 14 12 14-18"/><circle cx="84" cy="64" r="3"/><path d="M22 26h22M54 26h10"/><path d="M22 96h76" stroke-dasharray="3 5"/>'
  kanban   = '<rect x="10" y="20" width="30" height="80"/><rect x="45" y="20" width="30" height="80"/><rect x="80" y="20" width="30" height="80"/><rect x="15" y="30" width="20" height="14"/><rect x="15" y="50" width="20" height="14"/><rect x="50" y="30" width="20" height="14"/><rect x="85" y="30" width="20" height="14"/><rect x="85" y="50" width="20" height="14"/><rect x="85" y="70" width="20" height="14"/>'
  idcard   = '<rect x="14" y="28" width="92" height="62" rx="4"/><circle cx="40" cy="54" r="10"/><path d="M26 78c3-8 9-12 14-12s11 4 14 12"/><path d="M62 48h32M62 60h26M62 72h32"/><path d="M14 98h92" stroke-dasharray="3 5"/>'
  door     = '<path d="M30 104V18h60v86"/><path d="M22 104h76"/><circle cx="78" cy="62" r="3"/><rect x="42" y="30" width="36" height="24"/><path d="M48 40h24M48 46h16"/>'
  book     = '<path d="M60 26v72"/><path d="M60 26c-14-8-30-8-44-2v72c14-6 30-6 44 2"/><path d="M60 26c14-8 30-8 44-2v72c-14-6-30-6-44 2"/><path d="M26 42c8-3 16-3 24 0M26 54c8-3 16-3 24 0M70 42c8-3 16-3 24 0"/>'
  elephant = '<circle cx="60" cy="56" r="26"/><ellipse cx="28" cy="52" rx="14" ry="18"/><ellipse cx="92" cy="52" rx="14" ry="18"/><path d="M54 64c-2 12-2 22 4 28 4 4 10 2 10-4"/><circle cx="50" cy="50" r="2.5"/><circle cx="70" cy="50" r="2.5"/><path d="M46 34c8-10 20-10 28 0"/>'
  sheet    = '<rect x="20" y="14" width="80" height="92"/><path d="M20 30h80"/><path d="M32 46h56M32 58h56M32 70h40"/><path d="M64 86h36v20H64z"/><path d="M64 96h36"/>'
  site     = '<rect x="8" y="16" width="104" height="88" rx="4"/><path d="M8 32h104"/><circle cx="18" cy="24" r="2"/><circle cx="26" cy="24" r="2"/><rect x="18" y="42" width="48" height="26"/><rect x="72" y="42" width="30" height="26"/><rect x="18" y="74" width="30" height="20"/><rect x="54" y="74" width="48" height="20"/>'
}
$KIND = @{ live = 'Live'; demo = 'Demo'; snapshot = 'Snapshot' }
$ARROW = '<svg viewBox="0 0 16 16"><path d="M6 3h7v7M13 3 4 12"/></svg>'

function From-Readme([string]$dir) {
  $r = @{ title = $null; summary = $null; tech = @() }
  $p = Join-Path $dir 'README.md'
  if (-not (Test-Path $p)) { return $r }
  $lines = (Read-Text $p) -split "`r?`n"
  $seenTitle = $false; $inTech = $false
  foreach ($l in $lines) {
    $t = $l.Trim()
    if (-not $seenTitle) {
      if ($t -match '^#\s+(.+)$') { $r.title = ($Matches[1] -replace '\s+[—–-]\s+.*$', '').Trim(); $seenTitle = $true }
      continue
    }
    if (-not $r.summary -and $t -and $t -notmatch '^(#|>|-|\*|\||!|\[|<|```)' -and $t[0] -ne [char]0x25B6) { $r.summary = Plain $t }
    if ($t -match '^##\s+') { $inTech = ($t -match '^##\s+Tech'); continue }
    if ($inTech -and $t -match '^[-*]\s+(.+)$') {
      $item = $Matches[1]
      if ($item -match '^\*\*([^*]+)\*\*') { $r.tech += ($Matches[1] -split '\s*/\s*') }
      else { $r.tech += ((Plain ($item -replace '\s+[—–:-]\s+.*$', '')) -split '\s*/\s*') }
    }
  }
  $r.tech = @($r.tech | ForEach-Object { $_.Trim() } | Where-Object { $_ -and $_.Length -le 24 } | Select-Object -First 5)
  return $r
}

$projects = foreach ($d in Get-ChildItem (Join-Path $Root 'projects') -Directory) {
  $m = @{}
  $mp = Join-Path $d.FullName 'meta.json'
  if (Test-Path $mp) { (Read-Text $mp | ConvertFrom-Json).PSObject.Properties | ForEach-Object { $m[$_.Name] = $_.Value } }
  $rd = From-Readme $d.FullName
  $demoUrl = $null
  if ($m.demoUrl) { $demoUrl = [string]$m.demoUrl }
  elseif (Test-Path (Join-Path $d.FullName 'index.html')) { $demoUrl = "projects/$($d.Name)/" }
  $hasDemo = [bool]$demoUrl
  $summary = First $m.summary $rd.summary ''
  $order = 1000; if ($null -ne $m.order) { $order = [int]$m.order }
  [pscustomobject]@{
    slug       = $d.Name
    title      = First $m.title $rd.title $d.Name
    summary    = $summary
    blurb      = First $m.blurb $summary
    tech       = @(@(First $m.tech $rd.tech) | Where-Object { $_ })
    emoji      = First $m.emoji ([string][char]0x25AB)
    icon       = First $m.icon 'sheet'
    kind       = First $m.kind $(if ($hasDemo) { 'demo' } else { $null })
    demoLabel  = First $m.demoLabel 'Open demo'
    tableLabel = First $m.tableLabel 'Demo'
    links      = @(@($m.links) | Where-Object { $_ -and $_.url })
    order      = $order
    hasDemo    = $hasDemo
    demoUrl    = $demoUrl
    span       = $(if ($m.span -and @(4, 5, 6, 7, 8, 12) -contains [int]$m.span) { [int]$m.span } else { 6 })
    variant    = $(if (@('paper', 'dashed', 'accent', 'dark') -contains $m.variant) { $m.variant } elseif ($m.kind -eq 'snapshot') { 'dashed' } else { 'paper' })
    category   = First $m.category 'Project'
  }
}
$projects = @($projects | Sort-Object order, title)

# ---------- homepage cards ----------
$cards = New-Object System.Text.StringBuilder
$i = 0
foreach ($p in $projects) {
  $i++
  $icon = if ($ICONS.ContainsKey($p.icon)) { $ICONS[$p.icon] } else { $ICONS.sheet }
  $badge = ''
  if ($p.kind -and $KIND.ContainsKey($p.kind)) { $badge = "<span class=""badge $($p.kind)"">$($KIND[$p.kind])</span>" }
  $stack = ($p.tech | Select-Object -First 3 | ForEach-Object { Esc $_ }) -join ' &middot; '
  $arr = '<span class="arr">&#8599;</span>'
  $acts = @()
  if ($p.hasDemo) { $acts += "<a class=""btn solid"" href=""$(Esc $p.demoUrl)"" target=""_blank"" rel=""noopener"">$(Esc $p.demoLabel) $arr</a>" }
  foreach ($l in $p.links) { $acts += "<a class=""btn line"" href=""$(Esc $l.url)"" target=""_blank"" rel=""noopener"">$(Esc $l.label) $arr</a>" }
  $acts += "<a class=""more"" href=""$tree$($p.slug)"" target=""_blank"" rel=""noopener"">Details</a>"
  [void]$cards.Append(@"
      <article class="plot $($p.variant) s$($p.span)" data-slug="$($p.slug)">
        <span class="speed" aria-hidden="true"></span>
        <div class="plot-top mono"><span>Plot $('{0:D2}' -f $i) &middot; $(Esc $p.category)</span>$badge</div>
        <svg class="ico" viewBox="0 0 120 120" aria-hidden="true">$icon</svg>
        <h3>$(Esc $p.title)</h3>
        <p>$(Esc $p.blurb)</p>
        <div class="plot-foot"><span class="stack">$stack</span><span class="btns">$($acts -join '')</span></div>
      </article>

"@)
}

# ---------- README table ----------
$rows = New-Object System.Collections.Generic.List[string]
$rows.Add('| | Project | What it is | Tech | Live demo |')
$rows.Add('|:---:|:---|:---|:---|:---:|')
foreach ($p in $projects) {
  $tech = ($p.tech | ForEach-Object { '`' + $_ + '`' }) -join ' '
  $demoHref = if ($p.demoUrl -match '^https?://') { $p.demoUrl } else { $site + ($p.demoUrl -replace '^\./', '') }
  $demo = if ($p.hasDemo) { "**[$([char]0x25B6) $($p.tableLabel)]($demoHref)**" } else { '' }
  foreach ($l in $p.links) { $label = ((First $l.emoji '') + ' ' + $l.label).Trim(); $demo += "<br><sub>[$label]($($l.url))</sub>" }
  $what = ($p.summary -replace '\|', '\|')
  $rows.Add("| $($p.emoji) | **[$($p.title)](projects/$($p.slug))** | $what | $tech | $demo |")
}

# ---------- write ----------
$changed = $false
$ip = Join-Path $Root 'index.html'
$html = Read-Text $ip
$new = Splice $html '<!-- CARDS:START -->' '<!-- CARDS:END -->' ($cards.ToString().TrimEnd() + "`n     ")
$count = "$($projects.Count)"
$new = Splice $new '<!-- COUNT -->' '<!-- /COUNT -->' $count -Inline
if ($new -ne $html) { Write-Text $ip $new; $changed = $true; Write-Host 'Updated index.html' }

$rp = Join-Path $Root 'README.md'
$md = Read-Text $rp
$newMd = Splice $md '<!-- PROJECTS:START -->' '<!-- PROJECTS:END -->' ($rows -join "`n")
if ($newMd -ne $md) { Write-Text $rp $newMd; $changed = $true; Write-Host 'Updated README.md' }

Write-Host "$($projects.Count) projects: $(($projects | ForEach-Object { $_.slug }) -join ', ')"
if (-not $changed) { Write-Host 'No changes needed' }
