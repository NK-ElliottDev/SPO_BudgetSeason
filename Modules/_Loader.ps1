$Global:Base       = "C:\Users\nkohler\OneDrive - NAI Elliott\Support\SPO_BudgetSeason"
$Global:Modules    = "$Base\Modules"
$Global:Scripts    = "$Base\Scripts"
$Global:Logs       = "$Base\Logs"
$Global:CSVInput   = "$Base\Scripts_CSV_Inputs"

$ModList = gci $Global:Modules -filter "*.psm1"

FOREACH ($Module in $ModList){
 & Import-Module $Module -Global -Force
}

Import-Module pnp.powershell -Global
Connect-PNPBudgetSeason