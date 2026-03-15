<#
.SYNOPSIS
Normaliza uma string removendo caracteres indesejados
e aplicando outras transformações.

.DESCRIPTION
Recebe uma string (pode ser texto com máscara ou não) e retorna
uma versão normalizada. Se o parâmetro `-AsciiOnly` for informado,
remove caracteres especiais e normaliza para ASCII.

.PARAMETER String
Texto a ser normalizado.

.PARAMETER MaxLength
Tamanho máximo permitido para o texto resultante. O padrão é 150.

.PARAMETER AsciiOnly
Se ativado, remove caracteres especiais e converte caracteres Unicode
para a versão ASCII.

.EXAMPLE
PS C:\> ConvertTo-SafeString -String 'ACME IND & CO. LTD.'

.EXAMPLE
PS C:\> ConvertTo-SafeString -String 'ACME''CORP IND & CO. LTD.' -AsciiOnly

.OUTPUTS
System.String
#>
function ConvertTo-SafeString {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory)]
        [string]$String,

        [Parameter()]
        [int]$MaxLength = 150,

        [Parameter()]
        [switch]$AsciiOnly
    )

    $normalized = $String -replace '[\\/]', ','

    $normalized = $normalized -replace '[^\w\s\-\.,\+áàâãéèêíìîóòôõúùûçÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛÇ&,]', ''

    $normalized = ($normalized -replace "\s+", " ").Trim()

    if ($AsciiOnly) {
        $normalized = $normalized.Normalize([Text.NormalizationForm]::FormD)
        $normalized = -join ($normalized.ToCharArray() | Where-Object {
            [Globalization.CharUnicodeInfo]::GetUnicodeCategory($_) -ne 'NonSpacingMark'
        })

        $normalized = $normalized -replace "ç", "c"
    }

    if ($normalized.Length -gt $MaxLength) {
        $normalized = $normalized.Substring(0, $MaxLength)
    }

    $normalized
}
