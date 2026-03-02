function Get-PipeNotaApplicationData {
    [CmdletBinding()]
    [OutputType([string])]
    param ()

    $localAppDataPath = [System.Environment]::GetFolderPath('LocalApplicationData')

    $pipeNotaDataPath = [System.IO.Path]::Combine($localAppDataPath, 'PipeNota')

    if (-not (Test-Path -LiteralPath $pipeNotaDataPath -PathType Container)) {
        New-Item -Path $pipeNotaDataPath -ItemType Directory -Force | Out-Null
    }

    # Envia a saída para o Pipeline
    Write-Output $pipeNotaDataPath
}
