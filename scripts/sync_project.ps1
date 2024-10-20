param (
    [string]$sourceDir = "C:\path\to\source\directory",
    [string]$targetDir = "C:\path\to\target\directory"
)

# Sync the /project directory with a local directory using robocopy
robocopy $sourceDir $targetDir /MIR

# Add a scheduled task to automate the sync process
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File `"$PSScriptRoot\sync_project.ps1`""
$trigger = New-ScheduledTaskTrigger -Daily -At 3am
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -Settings $settings -TaskName "SyncProjectTask" -Description "Sync the /project directory with a local directory"
