function Copy-GitRepo {
    git clone $args
}

function Copy-GitRepoCd {
    Copy-GitRepo $args
    Set-Location $URL.Split('/')[-1].Replace('.git', '')
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
