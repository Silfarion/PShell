# $s = New-PSSession -ComputerName EPUAKHAW5085T
# Enter-PSSession $s
# $w = "C:\1.txt"
# $q = "C:\Users\Andrii_Korneichuk\"
# #New-Item -Type Directory -Path $env:HOMEPATH\remote1
# Copy-Item -ToSession $s -Path $w -Destination $q
$s = New-PSSession -ComputerName EPUAKHAW5085T
Enter-PSSession -Session $s
Invoke-Command -Session $s -ScriptBlock {
    mkdir C:\inetpub\Start
    New-Website -Name Start -PhysicalPath C:\inetpub\Start
    Get-Website | Where-Object {($_.bindings.collection.protocol -eq "http") -and ($_.bindings.collection.bindingInfo -eq "*:80:")}
    Get-Website -Name "Default Web Site" | Stop-Website
    Get-Website -Name Start | Start-Website
}
Copy-Item -ToSession $s -Path C:\Test\index.html -Destination C:\inetpub\Start\index.html
Exit-PSSession 
$a=Test-NetConnection -ComputerName EPUAKHAW5085T -Port 80 | Select-Object TcpTestSucceeded
Write-Host $a