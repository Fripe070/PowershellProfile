$env:VIRTUAL_ENV_DISABLE_PROMPT = 1
function Prompt {
    $LastWasSuccessCopy = $?
    $LastExitCodeCopy = $LastExitCode

    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

    if (Test-Path variable:/PSDebugContext) { # Check if debug prompt
        Write-Host ('[🛠️]') -NoNewLine -ForegroundColor Grey
    }
    if ($principal.IsInRole($adminRole)) { # Check if admin prompt
        Write-Host ('[⚡]') -NoNewLine -ForegroundColor Yellow
    }

    # Write-Host (
    #     [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.Split("\")[1]
    #     # '@' + 
    #     # $([System.Net.Dns]::GetHostName())
    # ) -NoNewLine -ForegroundColor Cyan

    # Write-Host (':') -NoNewLine
    Write-Host ($(Get-Location)) -NoNewLine -ForegroundColor Blue
    
    $branchName = $(git rev-parse --abbrev-ref HEAD)
    if ($branchName) {
        Write-Host (" ($branchName)") -NoNewLine -ForegroundColor Red
    }
    if ($null -ne $env:VIRTUAL_ENV) { 
        Write-Host (" (venv)") -NoNewLine -ForegroundColor Blue
    }
    Write-Host (" $('$' * ($nestedPromptLevel + 1))") -ForegroundColor (&{If($LastWasSuccessCopy) {"White"} Else {"Red"}}) -NoNewLine

    return " "
}
