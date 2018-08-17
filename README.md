# PowerShell User Groups

This GitHub repository is intended to serve as a community-maintained, single-source list of PowerShell user groups worldwide. The content of this repository was originally stored at https://github.com/GamerLivingWill.

## Purpose

This list is a central repository of PowerShell user groups that can be updated by the community and used as a source file for other lists and websites. Information for each user group will be maintained in a json data file.

A markdown document, [PowerShellUserGroups](./PowerShellUserGroups.md) will be updated as group entries are added or revised. We encourage people to link, rather than copy, to this file in order to keep the data fresh and accurate. External sites can link to this page without seeking permission. Everyone wins.

There are long term plans to surface the group information via a REST api or other methods.

## Guidance and Governance

We're still working on the standards surrounding what information to offer and how governance will be administered.  We want to keep this conversation open.  If you want to raise a suggestion, concern, or ways to improve what we're doing, feel free to raise an issue on this repository and we can all talk about it together!

Please use the pull request process to submit new or modified entries. We prefer that you only modify your own entries. If you feel there is something we should know about a given entry, please post an issue.

_Your entry may be edited for clarity and consistency._

## Sample Layout

Each user group is defined by a json file that should look like this:

```json
{
    "Group Name":  "Omaha PowerShell User Group",
    "Owner":  [
                "Boe Prox",
                "Josh Duffney"
              ],
    "Location":  "Omaha, NE, USA",
    "WebsiteURL":  "https://twitter.com/OmahaPSUG",
    "Twitter":  "[@OmahaPSUG](https://twitter.com/OmahaPSUG)",
    "Email":  "[omahapsug@gmail.com](mailto:omahapsug@gmail.com)"
}
```

We strongly recommend that you include either an active Twitter or email account so that you can be contacted about your group.

Markdown is permitted, but it is not required. A PowerShell script, `New-UserGroupEntry.ps1` is available in this repository to make it easier to create an entry for your group. Currently, we are using a file name that includes your group name with space replaced with `_` characters. Try to avoid using special characters like `&` and slashes.

*last updated Friday, August 17, 2018 9:10:26 PM UTC*
