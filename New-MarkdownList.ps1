#requires -version 5.0
#generate a version of the user groups as a list in Markdown

<#
This script will create a markdown version of PowerShell user groups
based on the json entries in the Data folder.
#>

[cmdletbinding(SupportsShouldProcess)]
Param(
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("\.md$")]    
    [string]$OutputFile = "PowerShellUserGroupList.md",
    #the path to the folder with json data files
    [string]$Path = ".\data",
    [switch]$Passthru
)

$md = @"
# PowerShell User Groups

"@

&$PSScriptRoot\get-uglist.ps1 -path $path| Sort-object -Property Name |
    foreach-object {
    $md += "`n## $($_.Name.trim())`n"
    #define a variable for the processed group to make it easier to track
    $group = $_
    #test each property to see if the value is an array
    #and if so update the object with a comma separated string
    $group.psobject.properties.name | foreach-object { if ($group.$_ -is [array]) {$group.$_ = $group.$_ -join ","}}
    $details = ($group | select-object -property * -exclude Name | out-string).trim() -split "`n" 
    foreach ($detail in $details) {
  
        $md += "`n$($detail.trim())  "
    }
    $md += "`n"
}

$utc = &$PSScriptRoot\get-utc.ps1
$md += "`n_Generated $($utc)_"

$md | Out-File "$PSScriptRoot\$OutputFile" -Encoding utf8 -Width 80

if ($Passthru) {
    Get-Item -Path "$psscriptroot\$OutputFile"
}