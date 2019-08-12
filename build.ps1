#requires -version 5.0

#run this command after new user groups have been added
#to generate updated markdown and PDF documents.
#this script requires the nodejs and the markdown-pdf package

#for best results, run this in PowerShell Core on Windows
# pwsh -file <path>\build.ps1


$css = "$PSScriptRoot\style\markdown-custom.css"
$run = "$PSScriptRoot\style\runnings.js"

Write-Host "Creating markdown files" -ForegroundColor green
&$PSScriptRoot\New-MarkdownList.ps1 -path $PSScriptRoot\data
&$PSScriptRoot\New-UserGroupMarkdown.ps1 -path $PSScriptRoot\data
&$PSScriptRoot\New-LocationMarkdown.ps1 -path $PSScriptRoot\data

Write-Host "Converting markdown to PDF" -ForegroundColor green
markdown-pdf -c $PSScriptRoot -s $css -h $run -f Letter -o $PSScriptRoot\pdf\PowerShellUserGroupList.pdf $psscriptroot\PowerShellUserGroupList.md
markdown-pdf -c $psscriptroot -s $css -h $run -f Letter -o $PSScriptRoot\pdf\PowerShellUserGroups.pdf $psscriptroot\PowerShellUserGroups.md
markdown-pdf -c $psscriptroot -s $css -h $run -f Letter -o $PSScriptRoot\pdf\PowerShellGroupsbyLocation.pdf $psscriptroot\PowerShellGroupsbyLocation.md

Get-ChildItem $PSScriptRoot\*.md -Exclude README.md
Get-Childitem $PSScriptRoot\pdf

#open each pdf in the default application to review
get-childitem $psscriptroot\pdf\*.pdf | foreach-object {start-process $_.fullname}

write-host "`nIf PDFs look ok, commit these changes and push to GitHub." -ForegroundColor cyan
