<#
.SYNOPSIS
Obtém o caminho raíz do diretório de dados do PipeNota.

.DESCRIPTION
Retorna o caminho da pasta "PipeNota" dentro do diretório
LocalApplicationData do usuário. Caso a pasta não exista,
ela será criada automaticamente.

.OUTPUTS
System.String
#>
function Get-PipeNotaDataLocation {
    [CmdletBinding()]
    [OutputType([string])]
    param ()

    $localAppDataPath = [System.Environment]::GetFolderPath('LocalApplicationData')
    $pipeNotaDataPath = [System.IO.Path]::Combine($localAppDataPath, 'PipeNota')

    if (-not (Test-Path -LiteralPath $pipeNotaDataPath -PathType Container)) {
        New-Item -Path $pipeNotaDataPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
    }

    $pipeNotaDataPath
}
