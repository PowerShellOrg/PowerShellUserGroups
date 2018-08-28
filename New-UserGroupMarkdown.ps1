#requires -version 5.0

<#
This script will create a markdown version of PowerShell user groups
based on the json entries in the Data folder.
#>

[cmdletbinding(SupportsShouldProcess)]
Param(
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("\.md$")]    
    [string]$OutputFile = "PowerShellUserGroups.md",
    #the path to the folder with json data files
    [string]$Path = ".\data",
    [switch]$Passthru
)

$md = @"
# PowerShell User Groups

|Name|Owner|Location|WebsiteURL|Twitter|Email|
|----|-----|--------|----------|-------|-----|

"@

&$PSScriptRoot\get-uglist.ps1 -Path $path | 
    Sort-Object -property Name |
    foreach-object {
    $md += "|{0}|{1}|{2}|{3}|{4}|{5}|`n" -f $_.Name, $($_.Owner -join ","), $_.location, ($_.WebSiteURL -join ","), $($_.Twitter -join ","), $($_.Email -join ",")
}

$md += 
"`nList generated _$((Get-Date).toUniversaltime().DateTime) UTC_"

$md | Out-file -FilePath "$psscriptroot\$OutputFile" -Encoding utf8 -Width 80

if ($Passthru) {
    Get-Item -Path "$psscriptroot\$OutputFile"
}