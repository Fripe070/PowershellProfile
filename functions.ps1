foreach ($file in Join-Path -Path $PSScriptRoot -ChildPath functions\ | Get-ChildItem -Filter *.ps1) {
    . $file.FullName
}


function Get-AudioYTDLP {
    param ( $URL )
    yt-dlp -f bestaudio/best --embed-thumbnail --embed-metadata -x --audio-format mp3 --audio-quality 0 --output "%(fulltitle)s [%(id)s].%(ext)s" $URL
}

function Get-File {
    curl -O -J $args
}
