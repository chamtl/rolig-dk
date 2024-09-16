# Bail out if we aren't in OOBE
$TypeDef = @" 
using System;
using System.Text;
using System.Collections.Generic;
using System.Runtime.InteropServices;
  
namespace Api
{
 public class Kernel32
 {
   [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
   public static extern int OOBEComplete(ref int bIsOOBEComplete);
 }
}
"@ 
Add-Type -TypeDefinition $TypeDef -Language CSharp
  
$IsOOBEComplete = $false
$hr = [Api.Kernel32]::OOBEComplete([ref] $IsOOBEComplete)
if ($IsOOBEComplete) {
  Write-Host "Not in OOBE, nothing to do."
  exit 0
}
 
# Get device information
$systemEnclosure = Get-CimInstance -ClassName Win32_SystemEnclosure
$details = Get-ComputerInfo

if (($null -eq $systemEnclosure.SerialNumber) -or ($systemEnclosure.SerialNumber -eq "")) {
    
    $serial = New-Guid

    $serialstring = "$serial"

    #Write-Output $serialstring

    $newserial1 = $serialstring.Replace("-", "")


if ($newserial1.Length -gt 8) {
    $newserial1 = $newserial1.Substring(0, 8)
}

    $newName = "PC-" + $newserial1 + "-NS"

    #Write-Output $newname

    #Exit

    }
    
    else {

    $serial = $systemEnclosure.SerialNumber

    $newName = "PC-" + $serial

    if ($newname.Length -gt 13) {
        $newname = $newname.Substring(0, 13)
    }   

    Write-Output $newname

    }


# Is the computer name already set?  If so, bail out
if ($newName -ieq $details.CsName) {
    Write-Host "No need to rename computer, name is already set to $newName"
    Exit 0
}
 
# Set the computer name
Write-Host "Renaming computer to $($newName)"
Rename-Computer -NewName $newName -Force

