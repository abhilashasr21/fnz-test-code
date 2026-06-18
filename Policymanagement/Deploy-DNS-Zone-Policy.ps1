<#
.SYNOPSIS
  Deploys the Deploy-DNS-Zone policy definition to a management group.

.DESCRIPTION
  Reads deploy-policy.jsonc, strips JSONC comments (without breaking URLs in strings),
  and creates/updates the policy definition at the specified management group.

.EXAMPLE
  ./Deploy-DNS-Zone-Policy.ps1 -ManagementGroupId mgt100000
#>

[CmdletBinding()]
param(
    [string] $PolicyFile         = "$PSScriptRoot\deploy-policy.jsonc",
    [Parameter(Mandatory = $true)]
    [string] $ManagementGroupId
)

$ErrorActionPreference = 'Stop'

# ---- 1. Read the .jsonc file ----
if (-not (Test-Path $PolicyFile)) {
    throw "Policy file not found: $PolicyFile"
}
$rawText = Get-Content -Raw -Path $PolicyFile

# ---- 2. Strip JSONC comments WITHOUT touching content inside strings ----
# A small state machine that walks the text char-by-char:
#   - inside a "..."  string : copy verbatim (handles \" escapes)
#   - // ... \n              : skip to end of line
#   - /* ... */              : skip to end of block
function Remove-JsonComments {
    param([string]$Text)

    $sb        = [System.Text.StringBuilder]::new($Text.Length)
    $i         = 0
    $len       = $Text.Length
    $inString  = $false

    while ($i -lt $len) {
        $c    = $Text[$i]
        $next = if ($i + 1 -lt $len) { $Text[$i + 1] } else { [char]0 }

        if ($inString) {
            [void]$sb.Append($c)
            if ($c -eq '\' -and $i + 1 -lt $len) {
                # copy escaped char as-is
                [void]$sb.Append($next)
                $i += 2
                continue
            }
            if ($c -eq '"') { $inString = $false }
            $i++
            continue
        }

        # Not in a string
        if ($c -eq '"') {
            $inString = $true
            [void]$sb.Append($c)
            $i++
            continue
        }

        if ($c -eq '/' -and $next -eq '/') {
            # line comment - skip until newline
            while ($i -lt $len -and $Text[$i] -ne "`n") { $i++ }
            continue
        }

        if ($c -eq '/' -and $next -eq '*') {
            # block comment - skip until */
            $i += 2
            while ($i + 1 -lt $len -and -not ($Text[$i] -eq '*' -and $Text[$i + 1] -eq '/')) { $i++ }
            $i += 2  # skip the closing */
            continue
        }

        [void]$sb.Append($c)
        $i++
    }

    return $sb.ToString()
}

$jsonText = Remove-JsonComments -Text $rawText

# ---- 3. Parse ----
try {
    $obj = $jsonText | ConvertFrom-Json -Depth 100
}
catch {
    Write-Error "Failed to parse $PolicyFile after stripping comments: $($_.Exception.Message)"
    throw
}

if ([string]::IsNullOrWhiteSpace($obj.name)) {
    throw "Policy file is missing a top-level 'name' property. Add `"name`": `"Deploy-DNS-Zone`" to $PolicyFile."
}

# ---- 4. Re-serialize inner pieces as JSON strings ----
$policyRuleJson = $obj.properties.policyRule | ConvertTo-Json -Depth 100 -Compress
$parametersJson = $obj.properties.parameters | ConvertTo-Json -Depth 100 -Compress
$metadataJson   = $obj.properties.metadata   | ConvertTo-Json -Depth 100 -Compress

Write-Host "Creating policy definition '$($obj.name)' at MG '$ManagementGroupId' ..." -ForegroundColor Cyan

# ---- 5. Create / update the policy definition ----
$def = New-AzPolicyDefinition `
    -Name                $obj.name `
    -DisplayName         $obj.properties.displayName `
    -Description         $obj.properties.description `
    -Policy              $policyRuleJson `
    -Parameter           $parametersJson `
    -Metadata            $metadataJson `
    -Mode                $obj.properties.mode `
    -ManagementGroupName $ManagementGroupId

Write-Host "✓ Policy definition created/updated." -ForegroundColor Green
Write-Host "  Id: $($def.ResourceId)"

return $def