#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$modulePath = Join-Path $PSScriptRoot -ChildPath 'PipeNota.psm1'

if (-not (Get-Module | Where-Object { $_.Path -eq $modulePath })) {
    Import-Module -Name $modulePath -ErrorAction Stop
}
