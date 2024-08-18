$env:VIRTUAL_ENV_DISABLE_PROMPT = 1
function Prompt {
    $LastWasSuccessCopy = $?
    
    $added = $false
    if (Test-Path variable:/PSDebugContext) { # Check if debug prompt
        Write-Host ('🛠️') -NoNewLine -ForegroundColor Grey
        $added = $true
    }
    $isAdmin = ([Security.Principal.WindowsPrincipal] `
                [Security.Principal.WindowsIdentity]::GetCurrent() `
               ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if ($isAdmin) {
        Write-Host ('⚡') -NoNewLine -ForegroundColor Yellow
        $added = $true
    }
    $isReadOnly = ((Get-Item (Get-Location)).Attributes -band [System.IO.FileAttributes]::ReadOnly) -eq $true
    if ($isReadOnly) {
        Write-Host ('🔒') -NoNewLine -ForegroundColor DarkGray
        $added = $true
    }
    if ($added) {
        Write-Host " " -NoNewLine
    }

    Write-Host (Get-Location) -NoNewLine -ForegroundColor Blue
    
    $branchName = $(git rev-parse --abbrev-ref HEAD)
    if ($branchName) {
        Write-Host (" ($branchName)") -NoNewLine -ForegroundColor Red
    }
    if ($null -ne $env:VIRTUAL_ENV) { 
        Write-Host (" (venv)") -NoNewLine -ForegroundColor Blue
    }

    Write-Host " " -NoNewLine
    Write-Host ("$" * ($nestedPromptLevel)) -ForegroundColor White -NoNewLine
    Write-Host "$" -ForegroundColor (&{If($LastWasSuccessCopy) {"White"} Else {"Red"}}) -NoNewLine

    return " "
}
