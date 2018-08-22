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

&$PSScriptRoot\get-uglist.ps1 -path $path| Sort-object -Property "Group Name" |
foreach-object {
    $md+= "`n## $($_.'Group Name')`n"
    $details = ($_ | select-object -property * -exclude group*| out-string).trim() -split "`n" 
    foreach ($detail in $details) {
        $md+= "`n$($detail.trim())  "
    }
    $md+="`n"
}

$utc = &$PSScriptRoot\get-utc.ps1
$md+="`n_Generated $($utc)_"

$md | Out-File "$PSScriptRoot\$OutputFile" -Encoding utf8