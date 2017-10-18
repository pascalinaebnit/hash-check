cls

Write-Host "Hash-Check v0.3 by pascalinaebnit - 20171018"
Write-Host "------------------------------------------------"

function Print-Hashes{
    Write-Host "Used Hash-Function:" $hashfunction
    Write-Host "User Hash:" $userhash
    Write-Host "Calculated Hash:" $calculatedhash.Hash.ToLower()
}


do{
    Write-Host "Please specify desired hash function..."
    Write-Host "Available hash functions: SHA1, SHA256, SHA512, MD5"
    $hashfunction = Read-Host 
}
while(!$hashfunction)

do {
    $userhash = Read-Host "Please specify Hash which should be checked"
}
while(!$userhash)

$directory = Read-Host "Please specify directory in which you like to check a file (Default: E:\OVAs\)"
if(!$directory){
    $directory = "E:\OVAs\"
    Write-Host "Used default value" $directory
}

do{
    $filename = Read-Host "Please specify filename of the file which should be checked"
}
while(!$filename)

if(Test-Path $directory$filename){
    Write-Host "Calculating hash of" $directory$filename "please wait..."
}
else{
    Write-Host "File not found, exiting script..." -ForegroundColor Red
    exit
}

$calculatedhash = Get-FileHash $directory$filename -Algorithm $hashfunction

if ($userhash.ToLower() -eq $calculatedhash.Hash.ToLower()){  
    Write-Host "Hashes match, File is OK" -ForegroundColor Green
    Print-Hashes
}
else{
    Write-Host "Hashes do not match, please do not use this file!!!" -ForegroundColor Red
    Print-Hashes
}
