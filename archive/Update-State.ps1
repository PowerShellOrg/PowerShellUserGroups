#requires -version 5.0

#replace US state names with abbreviations

[cmdletbinding(SupportsShouldprocess)]
Param(
#the path to the json data folder
[string]$Path = ".\data"
)

#build hashtable of state abbreviations
$in = Get-Content .\states.json | ConvertFrom-Json
$in | 
foreach-object -Begin {$stateHash = @{} } -process {
 $statehash.Add($_.Name,$_.'alpha-2')
} 

&$PSScriptRoot\get-uglist.ps1 | 
ForEach-Object {
 $group = $_
 $group.Location = $group.location.replace(", ",",")
 #write-host "testing $($group.location)" -fore cyan
 $test = $stateHash.GetEnumerator() | 
 where {$group.location -match "(?<=,)($($_.name))"}
 
 if ($test) {
  [regex]$rx = "(?<=,)($($test.name))"
  #write-host $rx.ToString() -ForegroundColor Green
  $group.location = $rx.Replace($group.location,$test.value)
  write-host "Updating $($group.'Group Name')" -ForegroundColor cyan
  $g=($_."Group Name").Replace(" ","_").replace("/","").replace("&","and");
 
  $json = Join-path -Path (Convert-path $path) -ChildPath "$g.json"
  $group | Convertto-json | Out-file -FilePath $json -Encoding unicode
 } 
 
}