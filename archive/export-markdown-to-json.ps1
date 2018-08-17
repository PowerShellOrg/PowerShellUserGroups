#requires -version 5.0

<#
This script was designed to do the initial conversion of the original 
markdown document into json entries. It should no longer be needed but
is maintained for historical purposes.
#>

[cmdletbinding(SupportsShouldProcess)]
Param(
[Validatescript({Test-Path $_})]
[string]$Path = "data.md",
[ValidateNotNullorEmpty()]
[string]$Delimiter = "|",
[string]$OutputPath = ".\data"
)

Get-Content -Path $path | 
Where-Object {$_ -notmatch "---"} |
foreach-object {
 #trim leading and trailing | characters
 $_.Substring(1,$_.length-1) 
} | ConvertFrom-CSV -Delimiter $Delimiter |
foreach-object {
 #clean up group names
 $g=($_."Group Name").Replace(" ","_").replace("/","").replace("&","and");
 
 #convert multiple entries into arrays
 
 if ($_.Owner -notmatch "http" -AND $_.owner -match "/") {
    $_.owner = $_.owner -split "/" | foreach {$_.trim()}
 }
 $_.owner = $_.owner -split "&" | foreach {$_.trim()}
 $_.owner = $_.owner -split "," | foreach {$_.trim()}
 $_.twitter = $_.twitter -split "," | foreach {$_.trim()}
 $_.twitter = $_.twitter -split "&" | foreach {$_.trim()}
 $_.email = $_.email -split "," | foreach {$_.trim()}
 $_.email = $_.email -split "&" | foreach {$_.trim()}

 $json = Join-Path -Path $OutputPath -ChildPath "$g.json"
 $_ | convertto-json | out-file -FilePath $json -Encoding unicode
 
 }

 Write-Host "You will need to manually review and edit the json entries." -ForegroundColor Yellow