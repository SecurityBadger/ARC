##################################################################
##################################################################
##                                                              ##
##                                                              ##
##                                                              ##
##                                                              ##
##                                                              ##
##                                                              ##
##                                                              ##
##                                                              ##
##                                                              ##
##################################################################
##################################################################

function Sig_Check
{
Start-BitsTransfer https://live.sysinternals.com/sigcheck.exe

$Sig_check_Path = Read-Host -Prompt "Enter path to scan signatures"

.\sigcheck.exe -accepteula -nobanner -a -h -s -u -l -vt -vr $Sig_check_Path

pause
}



function Check_Persistance
{
$Event_Date = (Get-Date).AddDays(-7)

#Get-EventLog -LogName Security -InstanceId 4657,4697,4698 -After $Event_Date | Select-Object -Property *

Get-ScheduledTask | Get-ScheduledTaskInfo | Format-Table 

do 
    {

    $IR_action_1 = Read-Host -Prompt "Do you want to disable a scheduled task? [Y/N]"

    if ($IR_action_1 -like "Y")
        {
        $dis_task = Read-Host -Prompt "Enter the name of the scheduled task to disable"

        Disable-ScheduledTask -TaskName $dis_task

        Write-Host "`n$dis_task DISABLED`n" -ForegroundColor Green

        Pause
        }
    elseif ($IR_action_1 -like 'N')
        {
        Write-Host "`nExiting`n" -ForegroundColor Red

        Pause
        }
    else
        {
        Write-Host "`nIncorrect input detected, try again`n" -ForegroundColor DarkRed

        Pause
        }
    }
until ($IR_action_1 -like 'Y' -or 'N')
}

<#
function Check_Services
{
$Event_Date = (Get-Date).AddDays(-7)

Get-Service | Select-Object -Property * | Format-Table 

do 
    {

    $IR_action_2 = Read-Host -Prompt "Do you want to stop a service? [Y/N]"

    if ($IR_action_2 -like "Y")
        {
        $dis_serv = Read-Host -Prompt "Enter the name of the scheduled task to disable"

        Disable-ScheduledTask -TaskName $dis_task
        }
    elseif ($IR_action_2 -like 'N')
        {
        Write-Host "`nExiting`n" -ForegroundColor Red
        }
    else
        {
        Write-Host "Incorrect input detected, try again"
        }
    }
until ($IR_action_2 -like 'Y' -or 'N')
}
#>

function Run_Test
{
for ($s = 1; $s -le 100; $s++ )
    {
        Write-Progress -Activity "Testing" -Status "$s% complete:" -PercentComplete $s
        Start-Sleep -Milliseconds 50
        
    if ($s = 100) 
        {Write-Progress -Activity "Testing" -Completed}
    }
}

<#
function Get_Logs
{
$Event_Date = (Get-Date).AddDays(-7)

Get-EventLog -LogName Security -InstanceId 4624,4625 $Event_Date | where -Property Message -NotLike "Logon Type:*5" | Select-Object -Property *


Comment: this command looks for event logs that relate to potential persistance being established
Get-EventLog -LogName Security -InstanceId 4657,4697,4698 -After $evntdate | Select-Object -Property *

Comment: this command looks for event logs that relate to the "debug user" priviledge which is needed for a pash the hash attack
Get-EventLog -LogName Security -InstanceId 4704 -After $evntdate | Select-Object -Property *

}
#>


do {
Clear-Host

Write-Host -ForegroundColor White "
  -------------------------
 |    #    ######   #####  |
 |   # #   #     # #     # |
 |  #   #  #     # #       |
 | #     # ######  #       |
 | ####### #   #   #       |
 | #     # #    #  #     # |
 | #     # #     #  #####  |
  -------------------------
"
 Write-Host -ForegroundColor White "
______________________________
|                            |
| @@@@@@@@@@@@@@@@@@@@@@@@@@ |
| @                        @ |
| @           /\           @ |
| @         {    }         @ |
| @          |  |          @ |
| @          |  |          @ |
| @   ^ -----+  +----- ^   @ |
| @ <                    > @ |
| @   \/-----+  +-----\/   @ |
| @          |  |          @ |
| @          |  |          @ |
| @          |  |          @ |
| @          |  |          @ |
| @          |  |          @ |
| @         {    }         @ |
| @           \/           @ |
 \ @                      @ /
  \ @                    @ /
   \ @                  @ /
    \ @                @ /
     \ @              @ /
      \ @            @ /
       \ @@@@@@@@@@@@ /
        --------------
"
#-------------------------------------------------------------------------------------------------------#


Write-Host "What actions do you wish to take?" -ForegroundColor yellow

$strResponse = Read-Host "`n[1] Check for malicious signatures `n[2] Check for established persistance `n[3] Run Test `n`n[q] Exit `n"
If($strResponse -eq "1"){. Sig_Check}
	elseif($strResponse -eq "2"){. Check_Persistance}
	elseif($strResponse -eq "3"){. Run_Test}
    elseif($strResponse -like "q"){exit}
    else {Write-Host "`nInput not recognized, try again`n" -ForegroundColor Red -BackgroundColor Black; pause}
}
until ($strResponse -like "q")