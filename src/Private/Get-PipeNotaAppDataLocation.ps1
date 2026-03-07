<#
.SYNOPSIS
Obtém o caminho da pasta de dados do PipeNota em LocalAppData.

.DESCRIPTION
Retorna o caminho da pasta "PipeNota" dentro do diretório
LocalApplicationData do usuário. Caso a pasta não exista,
ela será criada automaticamente.

.OUTPUTS
System.String
Caminho completo da pasta de dados do PipeNota.
#>
function Get-PipeNotaAppDataLocation {
    [CmdletBinding()]
    [OutputType([string])]
    param ()

    $localAppDataPath = [System.Environment]::GetFolderPath('LocalApplicationData')

    $pipeNotaDataPath = [System.IO.Path]::Combine($localAppDataPath, 'PipeNota')

    if (-not (Test-Path -LiteralPath $pipeNotaDataPath -PathType Container)) {
        New-Item -Path $pipeNotaDataPath -ItemType Directory -Force | Out-Null
    }

    $pipeNotaDataPath
}
