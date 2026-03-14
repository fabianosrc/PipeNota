#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$modulePath = @{
    Private = [System.IO.Path]::Combine($PSScriptRoot, 'src', 'Private')
    Public  = [System.IO.Path]::Combine($PSScriptRoot, 'src', 'Public')
}

# Dot-sourcing private functions (not exported)
Get-ChildItem -Path $modulePath.Private -Filter *.ps1 -File | ForEach-Object {
    . $_.FullName
}

# Dot-sourcing public functions (exported)
Get-ChildItem -Path $modulePath.Public -Filter *.ps1 -File | ForEach-Object {
    . $_.FullName
}
