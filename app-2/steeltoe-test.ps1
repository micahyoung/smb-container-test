$ErrorActionPreference = "Stop"

$env:PATH+=";$PWD"

echo running ps

try
{
  Add-Type -Path "Steeltoe.Common.dll"
  Add-Type -Path "Steeltoe.Common.Net.dll"
}
catch [System.Reflection.ReflectionTypeLoadException]
{
   Write-Host "Message: $($_.Exception.Message)"
   Write-Host "StackTrace: $($_.Exception.StackTrace)"
   Write-Host "LoaderExceptions: $($_.Exception.LoaderExceptions)"
}

$sharePath=$env:SMB_SHARE
$username=$env:SMB_USERNAME
$password=$env:SMB_PASSWORD

$creds = [System.Net.NetworkCredential]::New($username,$password)

try {
    [Steeltoe.Common.Net.WindowsNetworkFileShare]::New($sharePath,$creds)
}
catch
{
   Write-Host "Message: $($_.Exception.Message)"
   Write-Host "StackTrace: $($_.Exception.StackTrace)"
   Write-Host "LoaderExceptions: $($_.Exception.LoaderExceptions)"
}
$testFilePath=$sharePath+"\test.txt"
echo "hello" > $testFilePath
dir $sharePath
cat $testFilePath
rm $testFilePath
