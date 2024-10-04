$Script:TenantID = "a18a42b5-07d7-4cfc-891e-49f2fa7b2974"
$Script:CertThumbprint = "512BC45C3C4BE4D1D80B967794405DCEFE814ED5"
$Script:EntraApp = "504bc4d1-2478-4939-b687-10949e2d73ea"
$Script:DefaultSite = "https://naielliott.sharepoint.com/sites/PRP_Config"

FUNCTION Connect-PNPBudgetSeason{
 PARAM(
    $SiteURL=$Script:DefaultSite
 )
 
 Connect-pnponline -Url $SiteURL -ApplicationId $Script:EntraApp -Thumbprint $Script:CertThumbprint -Tenant $Script:TenantID

}

