$srcPath = Join-Path -Path $PSScriptRoot -ChildPath '..\src'

Get-ChildItem -Path $srcPath -Filter *.ps1 -Recurse -File |
    Sort-Object FullName |
    ForEach-Object { . $_.FullName }
