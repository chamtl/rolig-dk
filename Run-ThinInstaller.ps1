
#Start ThinInstaller drive check via ServiceUI
Start-Process -FilePath "${Env:WinDir}\System32\WindowsPowerShell\v1.0\PowerShell.exe" -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File ${Env:ProgramData}\ThinInstaller\Invoke-ServiceUI.ps1 
