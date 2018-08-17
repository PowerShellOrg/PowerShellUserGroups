#requires -version 5.0

<#
This script will parse the underlying json data files
#>
[cmdletbinding()]
Param(
[string]$Path = ".\data"
)

Get-Childitem -Path $Path\*.json |
foreach-object {
  Get-Content $_.FullName | ConvertFrom-Json
}