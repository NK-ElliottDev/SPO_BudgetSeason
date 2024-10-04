#Sidebar: List Template Gallery- https://naielliott.sharepoint.com/sites/PRP_Config/_catalogs/lt/Forms/AllItems.aspx

$Script:PropertyTaskListTemplate    = "TEMPLATE_BudgetTaskList"
$Script:PropertyAnalyticsTemplate   = "TEMPLATE_PropertyAnalytics"
$Script:PropertyLinkListTemplate    = "TEMPLATE_LinkList"

$Script:PropertyListSet = @(
     $Script:PropertyTaskListTemplate
    ,$Script:PropertyAnalyticsTemplate
)


FUNCTION Add-ListFromTemplate(
 $ListTemplateName,
 $NewListName
)
{
 write-host "Checking for existence of $NewListName before create..."
 Get-PNPList $NewListName -ErrorAction SilentlyContinue |out-null
 IF ($? -eq $False){
  write-host "Building $($NewListName) from $($ListTemplateName)..." -ForegroundColor white 
 }ELSE{
  Remove-List -ListName
  write-host "Cannot create. $NewListName still exists" -ForegroundColor Red
  break;
 }



  $Web = Get-pnpweb
  $Ctx = get-pnpcontext
  $RootWeb = $Ctx.site.RootWeb
  $ctx.load($Rootweb)
  invoke-pnpquery
  $ListTemplates = $Ctx.site.GetCustomListTemplates($RootWeb)
  $Ctx.load($ListTemplates)
  invoke-pnpquery
   
  $ListCreation = New-Object Microsoft.SharePoint.Client.ListCreationInformation
  $listCreation.Title = $NewListName
  $ListCreation.ListTemplate = ($ListTemplates | ?{$_.Name -eq $ListTemplateName})
  $web.lists.add($ListCreation)
  invoke-pnpquery
  if ($?){
   write-host "$NewListName created successfully" -ForegroundColor cyan 
  }ELSE{
   write-host "Failure: $NewListName failed to create" -ForegroundColor red 
  }
}

Function Remove-List(
 [string]$ListName
)
{
 Write-Host "Checking $NewListName before delete... "
 Get-PnPList $NewListName -ErrorAction SilentlyContinue |out-null
 IF ($?){
  write-host "Deleting $($NewListName) ..." -ForegroundColor Red 
  Remove-PnPList -Identity $NewListName -Force
 }Else{
  write-host "$NewListName does not exist" -ForegroundColor yellow 
 }
}


Function Add-PropertyLists(
 [string]$PRPID    
){
 ForEach($PRPList in $Script:PropertyListSet){
  Add-ListFromTemplate $PRPList 
 }   
}

Function Remove-PropertyLists(
 [string]$PRPID
){
 ForEach($PRPList in $Script:PropertyListSet){
  remove-list $PRPList 
 }
}




