<#
.SYNOPSIS
  Creates one Deploy-DNS-Zone policy assignment per private-link mapping,
  pointing each to your existing private DNS zones.

.DESCRIPTION
  - Reads private-zones.json (privateLinkResourceType / subresource / DNS zone mapping).
  - For each mapping, creates a policy assignment at the specified MG with:
      * privateDnsZoneIds                = full IDs built from -DnsZoneSubscriptionId + -DnsZoneResourceGroup
      * privateEndpointPrivateLinkServiceId
      * privateEndpointGroupId
  - Attaches a System-Assigned managed identity and grants Network Contributor at MG scope.
  - Defaults to EnforcementMode = DoNotEnforce so nothing is remediated until you flip it.

.EXAMPLE
  ./Deploy-DNS-Zone-Assignments.ps1 `
      -ManagementGroupId        mgt100000 `
      -DnsZoneSubscriptionId    f4a270f4-c469-4215-bef6-b4abaea6815e `
      -DnsZoneResourceGroup     rg-ctl-vwan-pridns-nprd-laz-01 `
      -ManagedIdentityLocation  ukwest
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $ManagementGroupId,

    [Parameter(Mandatory = $true)]
    [string] $DnsZoneSubscriptionId,

    [Parameter(Mandatory = $true)]
    [string] $DnsZoneResourceGroup,

    [string] $ManagedIdentityLocation = "westeurope",

    [string] $PrivateZonesFile        = "$PSScriptRoot\archieve\private-zones.json",

    [string] $PolicyDefinitionName    = "Deploy-DNS-Zone",

    [ValidateSet("Default", "DoNotEnforce")]
    [string] $EnforcementMode         = "DoNotEnforce",

    [ValidateSet("DeployIfNotExists", "Disabled")]
    [string] $Effect                  = "DeployIfNotExists"
)

$ErrorActionPreference = 'Stop'

# ---- 0. Pre-flight ----
if (-not (Test-Path $PrivateZonesFile)) {
    throw "Mapping file not found: $PrivateZonesFile"
}

$mgScope = "/providers/Microsoft.Management/managementGroups/$ManagementGroupId"

Write-Host "`n=== Deploy-DNS-Zone Assignment Run ===" -ForegroundColor Cyan
Write-Host "  MG scope          : $mgScope"
Write-Host "  DNS zone sub      : $DnsZoneSubscriptionId"
Write-Host "  DNS zone RG       : $DnsZoneResourceGroup"
Write-Host "  Identity location : $ManagedIdentityLocation"
Write-Host "  Enforcement mode  : $EnforcementMode"
Write-Host "  Effect            : $Effect`n"

# ---- 1. Get the policy definition ----
$policyDef = Get-AzPolicyDefinition `
    -Name                $PolicyDefinitionName `
    -ManagementGroupName $ManagementGroupId

# Different Az.Resources versions return different ID property names
$policyDefId = $policyDef.ResourceId
if (-not $policyDefId) { $policyDefId = $policyDef.Id }
if (-not $policyDefId) { $policyDefId = $policyDef.PolicyDefinitionId }

if (-not $policyDefId) {
    throw "Could not resolve policy definition Id from Get-AzPolicyDefinition output."
}

Write-Host "✓ Found policy definition: $policyDefId`n" -ForegroundColor Green

# ---- 2. Load the private zones mapping ----
$mapping = (Get-Content -Raw -Path $PrivateZonesFile | ConvertFrom-Json).'private-zones-mapping'
Write-Host "Loaded $($mapping.Count) mappings from $PrivateZonesFile`n"

# ---- 3. Build globally-unique 24-char-safe assignment names ----
function Get-AssignmentName {
    param([string]$ResourceType, [string]$Subresource)

    # Short hash for global uniqueness (handles e.g. EventHub/namespaces vs ServiceBus/namespaces)
    $hashInput = "$ResourceType/$Subresource"
    $sha       = [System.Security.Cryptography.SHA1]::Create()
    $bytes     = $sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($hashInput))
    $hash6     = (-join ($bytes[0..2] | ForEach-Object { $_.ToString('x2') }))   # 6 hex chars

    # Human-readable token (last segment of resource type)
    $svc = ($ResourceType -split '/')[-1]
    $tag = "$svc-$Subresource" -replace '[^a-zA-Z0-9]', ''

    # Reserve: "DDZ-" (4) + "-" (1) + 6-char hash = 11 chars; max 24 -> tag <= 13 chars
    $maxTag = 24 - 4 - 1 - 6
    if ($tag.Length -gt $maxTag) { $tag = $tag.Substring(0, $maxTag) }

    return "DDZ-$tag-$hash6"
}

# ---- 4. Loop and create assignments ----
$createdAssignments = @()
$index             = 0
$failed            = 0

foreach ($m in $mapping) {
    $index++

    # Build full DNS zone resource IDs from your existing zones
    $zoneIds = @($m.privateDnsZoneName | ForEach-Object {
        "/subscriptions/$DnsZoneSubscriptionId/resourceGroups/$DnsZoneResourceGroup/providers/Microsoft.Network/privateDnsZones/$_"
    })

    # Plain values - NO { value = ... } wrappers
    # New-AzPolicyAssignment -PolicyParameterObject expects raw values keyed by parameter name.
    $parameters = @{
        privateDnsZoneIds                   = $zoneIds
        privateEndpointPrivateLinkServiceId = $m.privateLinkResourceType
        privateEndpointGroupId              = $m.subresource
        effect                              = $Effect
    }

    $assignmentName = Get-AssignmentName -ResourceType $m.privateLinkResourceType -Subresource $m.subresource
    $displayName    = "Deploy DNS Zone - $($m.resource) ($($m.subresource))"
    $description    = "Auto-generated: $($m.privateLinkResourceType) / $($m.subresource)"

    Write-Host ("[{0,2}/{1}] {2} -> {3}" -f $index, $mapping.Count, $assignmentName, $m.resource) -ForegroundColor Yellow

    try {
        $assignment = New-AzPolicyAssignment `
            -Name                  $assignmentName `
            -DisplayName           $displayName `
            -Description           $description `
            -Scope                 $mgScope `
            -PolicyDefinition      $policyDef `
            -PolicyParameterObject $parameters `
            -EnforcementMode       $EnforcementMode `
            -IdentityType          SystemAssigned `
            -Location              $ManagedIdentityLocation

        $createdAssignments += $assignment

        # ---- 5. Grant Network Contributor (4d97b98b-...) so DINE can remediate ----
        if ($Effect -eq "DeployIfNotExists") {
            $principalId = $null
            if ($assignment.Identity)              { $principalId = $assignment.Identity.PrincipalId }
            if (-not $principalId -and $assignment.IdentityPrincipalId) { $principalId = $assignment.IdentityPrincipalId }

            if ($principalId) {
                Start-Sleep -Seconds 5  # let identity propagate
                try {
                    New-AzRoleAssignment `
                        -ObjectId          $principalId `
                        -RoleDefinitionId  "4d97b98b-1d4f-4787-a291-c67834d212e7" `
                        -Scope             $mgScope `
                        -ErrorAction       Stop | Out-Null
                    Write-Host "         ↳ Granted Network Contributor to $principalId" -ForegroundColor DarkGray
                }
                catch {
                    if ($_.Exception.Message -match "already exists|RoleAssignmentExists") {
                        Write-Host "         ↳ Role assignment already exists" -ForegroundColor DarkGray
                    }
                    else {
                        Write-Warning "         ↳ Failed to assign role: $($_.Exception.Message)"
                    }
                }
            }
            else {
                Write-Warning "         ↳ Could not read managed identity principalId; skip role assignment."
            }
        }
    }
    catch {
        $failed++
        Write-Error "Failed to create assignment '$assignmentName': $($_.Exception.Message)" -ErrorAction Continue
    }
}

Write-Host "`n=== Done. Created/updated $($createdAssignments.Count) of $($mapping.Count) assignments. Failures: $failed ===" -ForegroundColor Cyan
return $createdAssignments