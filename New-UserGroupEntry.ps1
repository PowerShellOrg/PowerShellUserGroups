#requires -version 5.0

<#
Create a new JSON entry for a PowerShell User Group
You can pipe this command to Out-File or Set-Content to create the
json file.
#>

[cmdletbinding()]
Param(
    [Parameter(Mandatory, HelpMessage = "Enter the name of the user group", ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [alias("Group Name")]
    [String]$Name,
    [Parameter(Mandatory, HelpMessage = "Enter the location of the user group", ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [String]$Location,
    [Parameter(Mandatory, HelpMessage = "Enter the owner(s) of the user group. Markdown is allowed.", ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [String[]]$Owner,
    [Parameter(HelpMessage = "Enter the email address(s) for the user group. Markdown is allowed", ValueFromPipelineByPropertyName)]
    [string[]]$Email,
    [Parameter(HelpMessage = "Enter the URL(s) for the user group. Markdown is allowed", ValueFromPipelineByPropertyName)]
    [alias("websiteURL")]
    [string[]]$URL,
    [Parameter(HelpMessage = "Enter the Twitter account(s) for the user group. Markdown is allowed", ValueFromPipelineByPropertyName)]
    [string[]]$Twitter
)

Process {
    [pscustomobject]@{
        'Group Name' = $Name
        Owner        = $owner
        Location     = $Location
        WebsiteURL   = $Url
        Twitter      = $Twitter
        Email        = $email
    } | Convertto-Json
}


