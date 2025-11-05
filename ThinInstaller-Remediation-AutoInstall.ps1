
#Start ThinInstaller drive check via ServiceUI
Start-Process -FilePath "${Env:WinDir}\System32\WindowsPowerShell\v1.0\PowerShell.exe" -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File ${Env:ProgramData}\ThinInstaller\Invoke-ServiceUI.ps1  -DeploymentType Install"


# Set variables to indicate value and key to set
$RegistryPath = 'HKLM:\SOFTWARE\OK\ThinInstaller'
$Name         = 'runtime'
$runtime      = Get-Date -Format "yyyy/MM/dd"
#$runtime      = "2015/05/13"
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath)) {
  New-Item -Path $RegistryPath -Force | Out-Null
}  
# Now set the value
New-ItemProperty -Path $RegistryPath -Name $Name -Value $runtime -PropertyType "String" -Force 

Write-Host "Lenovo Driver check completed."

Exit 0
