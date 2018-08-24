#requires -version 5.0
# generate a version of the user groups as a list in Markdown
# grouped by country and state

<#
This script will create a markdown version of PowerShell user groups
based on the json entries in the Data folder.
#>

[cmdletbinding(SupportsShouldProcess)]
Param(
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("\.md$")]    
    [string]$OutputFile = "PowerShellGroupsbyLocation.md",
    #the path to the folder with json data files
    [string]$Path = ".\data",
    [switch]$Passthru
)

$grouped = &$PSScriptRoot\get-uglist.ps1 -Path $path | 
    Sort-Object -property Country, State, Name | 
    Group-object -Property Country

$md = @"
# PowerShell Groups by Location

"@

foreach ($item in $Grouped) {
    #strip off {} for country values with multiple entries like Australia,New Zealand
    $name = $item.name -replace "{|}", ""
    Write-Verbose "Processing $name" 
    $md += "`n## $name`n"
    
    #group each user group by state
    $states = $item.group | Group-Object -Property State
    
    foreach ($state in $states) {

        if ($state.name -match "\w+") {
            write-Verbose "Adding $($state.name)" 
            $md += "`n### $($state.name)`n"
        }
        foreach ($group in $state.group) {
            write-Verbose $group.name 

            $group.psobject.properties.name | 
                foreach-object { 
                if ($group.$_ -is [array]) {
                    $group.$_ = $group.$_ -join ","
                }
            }
            $details = ($group | Select-Object -property Name, Owner, Location, WebSiteURL, Twitter, Email | Out-String).trim() -split "`n" 
            foreach ($detail in $details) {
  
                $md += "`n$($detail.trim())  "
            }
            $md += "`n"
        } #foreach state group
    } #foreach group
}

$utc = &$PSScriptRoot\get-utc.ps1
$md += "`n_Generated $($utc)_"

$md | Out-File "$PSScriptRoot\$OutputFile" -Encoding utf8 -Width 80

if ($Passthru) {
    Get-Item -Path "$psscriptroot\$OutputFile"
}