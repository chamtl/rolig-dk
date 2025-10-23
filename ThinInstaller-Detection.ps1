##$lastruntime = get-ItemPropertyValue -Path 'HKCU:\SOFTWARE\OK\ThinInstaller\\' -Name RunTime
##$timenow = Get-Date -Format "yyyy/MM/dd"

#Write-Host "The variable type now is" $lastruntime.GetType()

#$lastruntime=[Datetime]::ParseExact($lastruntime, 'yyyy/MM/dd', $null)

#Write-Host "After conversion the type is" $lastruntime.GetType() "and the value is" $lastruntime

function Test-RegistryValue {

  param (
  
  [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]$Path,
  
  [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]$Value
)
  
  try {
  
    Get-ItemProperty -Path $Path -ErrorAction Stop | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
    return $true
  }
  
  catch {
  
    return $false
  
  }

}




if ( Test-RegistryValue -Path 'HKLM:\\SOFTWARE\\OK\\ThinInstaller' -Value 'RunTime'){
    
    $lastruntime = get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\OK\ThinInstaller\\' -Name RunTime
    $timenow = Get-Date -Format "yyyy/MM/dd"
    Write-Host "ThinInstaller: Previous runtime detected. Script will continue..."

}
else{
    
    Write-Host "ThinInstaller: No previous runtime detected. Start Lenovo driver check...."
    Exit 1
}



if ($timenow -gt $lastruntime) {
    
    Write-Host "ThinInstaller: Need to check for driver updates...."
    Exit 1
}
else{
    
    Write-Host "ThinInstaller: All is good."
    Exit 1
}

