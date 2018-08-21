#requires -version 5.0

#run this command after new user groups have been added
#to generate updated markdown and PDF documents.
#this script requires the nodejs and the markdown-pdf package

#for best results, run this in PowerShell Core on Windows
# pwsh -file <path>\build.ps1

.\New-MarkdownList.ps1
.\New-UserGroupMarkdown.ps1
markdown-pdf -s .\markdown-pdf.css -f Letter .\PowerShellUserGroupList.md
markdown-pdf -s .\markdown-pdf.css -f Letter .\PowerShellUserGroups.md
get-childitem *.md,*.pdf -Exclude README.md
get-childitem *.pdf | foreach-object {start $_.fullname}

write-host "`nIf PDFs look ok, commit these changes and push to GitHub." -ForegroundColor cyan
