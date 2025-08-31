##$lastruntime = get-ItemPropertyValue -Path 'HKCU:\SOFTWARE\OK\HPIA\\' -Name RunTime
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




if ( Test-RegistryValue -Path 'HKLM:\\SOFTWARE\\OK\\HPIA' -Value 'RunTime'){
    
    $lastruntime = get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\OK\HPIA\\' -Name RunTime
    $timenow = Get-Date -Format "yyyy/MM/dd"
    Write-Host "HPIA: Previous runtime detected. Script will continue..."

}
else{
    
    Write-Host "HPIA: No previous runtime detected. Start HP driver check...."
    Exit 1
}



if ($timenow -gt $lastruntime) {
    
    Write-Host "HPIA: Need to check for driver updates...."
    Exit 1
}
else{
    
    Write-Host "HPIA: All is good."
    Exit 1
}

