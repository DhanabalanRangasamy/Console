$SPClient =  [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
$SPRuntime = [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")
$webUrl = "https://my.sharepoint.com/teams/contractsandorders"
$username = Read-Host -Prompt "Email address for logging into that site" 
$password = Read-Host -Prompt "Password for $username" -AsSecureString
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($webUrl) 
$ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)

$web = $ctx.Web
$ctx.Load($web)
$ctx.ExecuteQuery()
$lists = $WEB.Lists
$CTX.Load($LISTS)
$CTX.ExecuteQuery()

$list=$lists | where-object {$_.Title -eq "Media Requests"}
$ctx.Load($list)
$ctx.Load($list.Fields)
$ctx.ExecuteQuery(()
$title = $list.Title
Write-Host "$title `n ---------------------------------" -ForegroundColor Green
$list.Fields | select title,staticname | ft -AutoSize