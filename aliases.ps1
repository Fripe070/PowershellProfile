Set-Alias -Name music-dl -Value Get-AudioYTDLP
Set-Alias -Name audio-dl -Value Get-AudioYTDLP
Set-Alias -Name dl -Value Get-File

# System
Set-Alias -Name ls -Value Get-FancyChildItem -Option AllScope
Set-Alias -Name which -Value Get-Command
Set-Alias -Name here -Description "Opens the current directory in explorer" -Value Open-CurrentDir
Set-Alias -Name refresh -Description "Reloads the environment and profile" -Value Update-All
Set-Alias -Name symlink -Value New-Symlink
Set-Alias -Name functions -Description "Returns custom powershell functions" -Value Get-Functions
Set-Alias -Name funcs -Description "Returns custom powershell functions" -Value Get-Functions

# Git
Set-Alias -Name gitc -Description "Alias for 'git clone'" -Value Copy-GitRepo
Set-Alias -Name gitcd -Description "Clones a git repo and cds into it" -Value Copy-GitRepoCd
Set-Alias -Name newgit -Description "initiates a new git repo and pushes it to the remote" -Value Add-GitRepo
Set-Alias -Name syncall -Description "Runs git pull in all imediate child git repos" -Value Sync-ChildRepos

# Python
Set-Alias -Name ipython -Description "Runs IPython" -Value Invoke-IPython
Set-Alias -Name ipy -Description "Runs IPython" -Value Invoke-IPython
Set-Alias -Name activate -Description "Activate a python virtual environment" -Value Enter-Venv
Set-Alias -Name venv -Description "Creates and enters a python virtual environment" -Value New-Venv
Set-Alias -Name reqs -Description "Installs python requirements" -Value install-PyRequirements
