function Add-GitChanges {
    git add $args
}

function Get-GitStatus {
    git status $args
}

function Copy-GitRepo {
    git clone $args
}

function Copy-GitRepoCd {
    param (
        [string]$url
    )
    Copy-GitRepo $url
    if ($?) {
        Set-Location $url.Split('/')[-1].Replace('.git', '')
    }
}

function Sync-ChildRepos {
    Get-ChildItem -Directory | ForEach-Object {
        if (Test-Path (Join-Path $_.FullName ".git")) {
            Write-Host "Pulling changes in $($_)"
            & git -C $_.FullName pull
        }
    }
}

function Add-GitRepo {
    param ( $REMOTE )
    if (-not $REMOTE) {
        Write-Host "No remote provided. Exiting."
        return
    }
    git init
    git add .
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin $REMOTE
    git push -u origin main
}
