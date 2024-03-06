function Open-CurrentDir { explorer.exe . }

function Get-FancyChildItem {
    Import-Module -Name Terminal-Icons
    Get-ChildItem $args
}

function Update-Env {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    Write-Host "Path reloaded"
}

function Update-Profile {
    $passed = $false
    try {
        . $PROFILE
        $passed = $true
    } catch {}
    try {
        . "$HOME\Documents\PowerShell\Profile.ps1"
        $passed = $true
    } catch {}

    if ($passed) { Write-Host "Profile reloaded" }
    else { Write-Error "Profile failed to reload" }
}

function Update-All {
    Update-Env
    Update-Profile
}

function New-Synmlink ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

function Get-CodeFromName {
    param ( 
        [string] $name,
        [int] $maxDepth = 5 
    )
    $commandName = $name
    for ($i = 0; $i -lt $maxDepth; $i++) {
        $cmd = Get-Command $commandName
        $commandName = $cmd.ResolvedCommand
        if ($null -eq $commandName) {
            return $cmd.ScriptBlock
        }
    }
}

function Get-Functions {
    Compare-Object (
        powershell.exe -NoProfile -Command "Get-ChildItem function: | Select-Object -ExpandProperty Name"
    ) (
        Get-ChildItem function: | Select-Object -ExpandProperty Name
    ) -PassThru
}



