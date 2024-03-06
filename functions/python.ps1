function Enter-Venv {
    param (
        [string]$Path = $PWD
    )
    $venvFolders = @("venv", ".venv")

    foreach ($folder in $venvFolders) {
        $venvActivatePath = Join-Path $Path $folder | Join-Path -ChildPath "Scripts\activate.ps1"
        if (Test-Path -Path $venvActivatePath -PathType Leaf) { return . $venvActivatePath }
    }
    Write-Error "Virtual environment not found at $venvPath"
}

function New-Venv {
    uv venv $args
    Enter-Venv
}

function install-PyRequirements {
    uv pip install -Ur .\requirements.txt 
}

function Invoke-IPython { py -m IPython $args }
