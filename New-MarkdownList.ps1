#generate a version of the user groups as a list in Markdown

$md = @"
# PowerShell User Groups

"@

&$PSScriptRoot\get-uglist.ps1 | Sort-object -Property "Group Name" |
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

$md | Out-File $PSScriptRoot\PowerShellUserGroupList.md -Encoding utf8