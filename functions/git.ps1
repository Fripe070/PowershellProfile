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
    Copy-GitRepo $args 2>&1 | Tee-Object -Variable cloneOutput
    if ($LASTEXITCODE -eq 0) {
        $repoName = ($cloneOutput | Select-String -Pattern "Cloning into '(.+)'\.\.\." | ForEach-Object { $_.Matches[0].Groups[1].Value })
        if ($repoName) {
            Set-Location $repoName
            Write-Host "Moved into cloned repository $repoName" -ForegroundColor Green
        } else {
            Write-Host "Could not determine repository directory from clone output:`n$cloneOutput" -ForegroundColor Yellow
        }
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
    git add -A
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin $REMOTE
    git push -u origin main
}
