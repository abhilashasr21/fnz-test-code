<#
.SYNOPSIS
  Deploys the Deploy-Private-DNS-Zones policy set definition to a management group.

.NOTES
  - The source JSON uses ARM-style "[[..." escapes (so the same file can be deployed
    via ARM). This script un-escapes them to "[..." for the direct policy API call.
#>

param(
  [string] $PolicySetFile      = ".\Policymanagement\policySetDefinations\Deploy-Private-DNS-Zones.json",
  [string] $ManagementGroupId  = "mg-fnz-root"
)

# ---- 1. Load the file as text and un-escape ARM expressions ----
$rawText = Get-Content -Raw -Path $PolicySetFile

# Convert "[[xxx]" -> "[xxx]" so the policy API gets a real expression.
# We do this on the raw text BEFORE parsing so we don't have to walk every property.
$unescaped = $rawText -replace '"\[\[', '"['

# ---- 2. Parse ----
$obj = $unescaped | ConvertFrom-Json -Depth 100

if (-not $obj.properties.policyDefinitions -or $obj.properties.policyDefinitions.Count -eq 0) {
  throw "policyDefinitions array is empty or missing — check the source file."
}

Write-Host ("Found {0} policy definition references." -f $obj.properties.policyDefinitions.Count)
Write-Host ("First reference: {0}"                    -f $obj.properties.policyDefinitions[0].policyDefinitionReferenceId)

# ---- 3. Re-serialize the inner pieces as JSON strings ----
$policyDefinitionsJson = $obj.properties.policyDefinitions | ConvertTo-Json -Depth 100 -Compress
$parametersJson        = $obj.properties.parameters        | ConvertTo-Json -Depth 100 -Compress
$metadataJson          = $obj.properties.metadata          | ConvertTo-Json -Depth 100 -Compress

# ---- 4. Create / update the policy set definition ----
New-AzPolicySetDefinition `
  -Name                $obj.name `
  -DisplayName         $obj.properties.displayName `
  -Description         $obj.properties.description `
  -PolicyDefinition    $policyDefinitionsJson `
  -Parameter           $parametersJson `
  -Metadata            $metadataJson `
  -ManagementGroupName $ManagementGroupId