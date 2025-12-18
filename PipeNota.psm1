#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

#region Open XML SDK
$openXmlSdk = @{
    PSEdition = @{
        Core = @(
            'Lib\netstandard2.0\DocumentFormat.OpenXml.dll'
            'Lib\netstandard2.0\DocumentFormat.OpenXml.Framework.dll'
        )
        Desktop = @(
            'Lib\net40\DocumentFormat.OpenXml.dll'
            'Lib\net40\DocumentFormat.OpenXml.Framework.dll'
        )
    }
}

$loadLibs = $openXmlSdk['PSEdition'][$PSVersionTable.PSEdition]

$required = @($loadLibs | ForEach-Object { [System.IO.Path]::GetFileNameWithoutExtension($_) })

$loaded = [System.AppDomain]::CurrentDomain.GetAssemblies().GetName().Name

$missing = @($required | Where-Object { $_ -notin $loaded })

if ($missing.Count -gt 0) {
    foreach ($lib in $loadLibs) {
        $libPath = Join-Path -Path $PSScriptRoot -ChildPath $lib

        try {
            [System.Reflection.Assembly]::LoadFrom($libPath) | Out-Null
        } catch [System.IO.FileNotFoundException] {
            Write-Error -Message "Arquivo não encontrado.`n$($_)"
        } catch {
            Write-Error -Exception $_
        }
    }
}
#endregion

#region Private Functions
$privatePath = Join-Path -Path $PSScriptRoot -ChildPath 'Private'

Get-ChildItem -Path $privatePath -Filter *.ps1 -Recurse | ForEach-Object { . $_.FullName }
#endregion

#region Public Functions
$publicPath = Join-Path -Path $PSScriptRoot -ChildPath 'Public'

Get-ChildItem -Path $publicPath -Filter *.ps1 -Recurse | ForEach-Object { . $_.FullName }
#endregion
