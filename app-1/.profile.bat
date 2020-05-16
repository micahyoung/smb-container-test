net use t: %SMB_SHARE% %SMB_PASSWORD% /user:%SMB_USERNAME%

echo hello > t:\test.txt
dir t:\
type t:\test.txt
del t:\test.txt
