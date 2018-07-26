#Ask if user want to perform a test
Write-Host "Type yes if you want to perform a test"
if ($(Read-Host ) -ne "yes") {
    WhoamI
}
else {
#Test which checks all possible hours combination.
$i=0
    for ($s1 = "00:00"; $s1 -lt "23:59"; $s1 = $s1.AddHours(1)) {
        for ([datetime]$a1 = "00:00"; $a1 -lt "23:59"; $a1 = $a1.AddHours(1)) {
            $a1 = [datetime]$a1
            WhoamI -sleep $s1 -awake $a1
            $i++
        }
   }
   if ($i -eq 576) {
       Write-Host "Test completed successfuly"
   }
   else {
       Write-Host "Test failed"
   }
}
function WhoamI {
<#
.SYNOPSIS
Defines whether user is an owl or a lark.
.DESCRIPTION
According to entered sleep and awake hours script defines if user has enough sleel and whether user is a lurk or and owl.
.PARAMETER sleep
Set time of sleeping.
.PARAMETER awake
Set time of awakening.
.INPUTS
Inputs are sleep and awake in format HH:MM
.OUTPUTS
System.Datetime. Scrips returns amount of sleep time.
System.String. Script returns string with defined type.
System.String. Script returns string with info whether enough sleep or not
.EXAMPLE
Enter sleep time: 20:00
Enter awake time: 16:00
Your sleep time is 20 Hours 0 Minutes
You're an owl
You have enough sleep
#>
#Parameters Declaration
Param (
    $sleep = $(Read-Host "Enter sleep time"),
    $awake = $(Read-Host "Enter awake time")
)
$logfile= "D:\Logging.txt"
$datetime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
#Function to perform logging
function Logging {
    param (
        [string]$log
        )
    Add-Content $logfile -Value $log
}
try {
    #Function to count sleep duration
    function dreaming {
    [datetime]$sleep = $sleep
    [datetime]$awake = $awake
    if ($sleep -gt $awake) {
        $Global:dream = $awake.AddDays(1)-$sleep
#        $dream = $awake.AddDays(1)-$sleep
        Write-Host "Your Your sleep time is"$dream.Hours"Hours"$dream.Minutes"Minutes"
    }
    else {
        $Global:dream = $awake.AddDays(0)-$sleep
        Write-Host "Your sleep time is"$dream.Hours"Hours"$dream.Minutes"Minutes"
    }
    }
if (($sleep -match "\d\:\d") -and ($awake -match "\d\:\d" )) {
#    Write-Host $sleep.Hour
#    Write-Host $awake
    dreaming
    Logging "$datetime $env:USERNAME [Info] Entered data is valid"
    Logging "$datetime $env:USERNAME [Verbose] Your sleep duration time is $dream"
}
#Providing additional data input if user's previous data was invalid
else {
    DO { Write-Host "Invalid input data. It should be time in format HH:MM"
    Logging "$datetime $env:USERNAME [Error] Invalid input data"
            $sleep= $(Read-Host "Enter sleep time in format HH:MM")
    }while (!($sleep -match "\d\:\d"))
    DO {
            $awake= $(Read-Host "Enter awake time in format HH:MM")
            if (!($awake -match "\d\:\d")) {
                Logging "$datetime $env:USERNAME [Error] Invalid input data"
                Write-Host "Invalid input data. It should be time in format HH:MM"}
    }while (!($awake -match "\d\:\d"))
    dreaming
    Logging "$datetime $env:USERNAME [Info] Entered data is valid"
    Logging "$datetime $env:USERNAME [Verbose] Your sleep duration time is $dream"
}
#Checking whether user a lark or an owl
if ($awake -le "08:00") {
    Write-Host "You're a lark"
    Logging "$datetime $env:USERNAME [Verbose] You are a lark"
}
else {
    Write-Host "You're an owl"
    Logging "$datetime $env:USERNAME [Verbose] You are an owl"
}
#Checking whether user sleeps enough or not
if ($dream -ge '08:00') {
    Write-Host "You have enough sleep"
    Logging "$datetime $env:USERNAME [Verbose] You have enough sleep"
}
else {
    Write-Host "You dont have enough sleep. Take care of your health and adjust your sleep"
    Logging "$datetime $env:USERNAME [Verbose] You dont have enough sleep. Take care of your health and adjust your sleep"
}
}
catch {
    Write-Host "Invalid input data. It should be time in format HH:MM"
    Logging "$datetime $env:USERNAME [Error] Invalid input data"
}
}