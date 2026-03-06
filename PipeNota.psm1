#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$srcPath = Join-Path -Path $PSScriptRoot -ChildPath 'src'

Get-ChildItem -Path "$srcPath/Private" -File | ForEach-Object { . $_.FullName }

Get-ChildItem -Path "$srcPath/Public" -File | ForEach-Object { . $_.FullName }

Export-ModuleMember -Function New-PipeNotaEmpresa, Get-PipeNotaEmpresa, Set-PipeNotaEmpresa, Remove-PipeNotaEmpresa
