<#
.SYNOPSIS
Retorna o timestamp atual no formato ISO 8601 com offset do timezone.

.DESCRIPTION
Gera um timestamp no formato ISO 8601 (yyyy-MM-ddTHH:mm:sszzz) com o
offset de timezone.

.PARAMETER Format
Formato de saída para formatos customizáveis.

.EXAMPLE
PS C:\> Get-CurrentTimestamp

.OUTPUTS
System.String
#>
function Get-CurrentTimestamp {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter()]
        [string]$Format
    )

    if (-not ($Format)) {
        $Format = 'yyyy-MM-ddTHH:mm:sszzz'
    }

    (Get-Date).ToString($Format)
}
