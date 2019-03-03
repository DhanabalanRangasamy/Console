function connectspo($object)
{
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.Sharepoint.client.dll"
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
$pwd=ConvertTo-SecureString "test" -AsPlainText -force
$ctx=New-object Microsoft.SharePoint.Client.ClientContext($object)
$ctx.Credentials=New-object Microsoft.SharePoint.Client.SharePointOnlineCredentials("rangasad@test.com",$pwd)
Write-host "Connected to SITE"
}
function getpermission
{
connectspo "https://test.sharepoint.com/sites/test"
$web=$ctx.Web
$ctx.load($web)
$ctx.ExecuteQuery()
Write-host $($web.Url)
$Role=$web.RoleAssignments
$ctx.Load($web.RoleAssignments)
$ctx.ExecuteQuery()
Write-host $($Role.count)
foreach($d in $Role)
{
$ctx.load($d.Member)
$ctx.ExecuteQuery()
Write-host $($d.member.Title)
Write-host $($d.member.Loginname)
if($d.Member.PrincipalType -eq "User")
{
if($d.Member.LoginName -eq "i:0#.f|membership|nadeem.ashraf@test.com")
{
"`t $($d.Member.LoginName)" | out-file C:\permission.csv
$ctx.load($d.RoleDefinitionBindings)
$ctx.ExecuteQuery()
foreach($e in $d.RoleDefinitionBindings)
{
$grouppermission += $e.Name +";"
Write-host $($e.'Name')
"`t `t $($grouppermission)" | out-file c:\permission.csv -Append
}
}
}
}
}