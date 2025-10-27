
#Start HPIA drive check via ServiceUI
Start-Process -FilePath "${Env:WinDir}\System32\WindowsPowerShell\v1.0\PowerShell.exe" -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File ${Env:ProgramData}\HPIA\Invoke-ServiceUI.ps1  -AllowRebootPassThru"
