This repo is meant for private use, and is not recoanended to be used by anyone else.

## Instalation
Clone this repository into the parent folder of your powershell profile.
Once the repo is cloned, you should add this to your powershell profile (`notepad.exe $PROFILE`)
```ps1
foreach ($file in Join-Path -Path $PSScriptRoot -ChildPath PowershellProfile\ | Get-ChildItem -Filter *.ps1) {
    . $file.FullName
}
```
### I am lazy
```ps1
git clone https://github.com/Fripe070/PowershellProfile "$(Split-Path -parent $profile | Join-Path -ChildPath FripePowershellProfile\)" && Add-Content -Path $PROFILE -Value "`nforeach (`$file in Join-Path -Path `$PSScriptRoot -ChildPath FripePowershellProfile\ | Get-ChildItem -Filter *.ps1) {`n    . `$file.FullName`n}"
```


 
