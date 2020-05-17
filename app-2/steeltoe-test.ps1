$ErrorActionPreference = "Stop"

$sharePath=$env:SMB_SHARE
$username=$env:SMB_USERNAME
$password=$env:SMB_PASSWORD

Add-Type -Path "Steeltoe.Common.Net.dll"

$creds = [System.Net.NetworkCredential]::New($username,$password)

[Steeltoe.Common.Net.WindowsNetworkFileShare]::New($sharePath,$creds)

$testFilePath=$sharePath+"\test.txt"
echo "hello" > $testFilePath
dir $sharePath
cat $testFilePath
rm $testFilePath
