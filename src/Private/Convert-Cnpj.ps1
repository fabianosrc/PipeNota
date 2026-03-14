<#
.SYNOPSIS
Normaliza um CNPJ removendo a máscara e espaços em branco.

.DESCRIPTION
Recebe um CNPJ com pontos, barras e traços e retorna apenas os números.

.PARAMETER Cnpj
CNPJ a ser normalizado.

.EXAMPLE
PS C:\> Convert-Cnpj -Cnpj '01.234.567/0001-89'

.OUTPUTS
System.String
#>
function Convert-Cnpj {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Cnpj
    )

    # Suporte a CNPJ alfanumérico
    $cleanCnpj = $Cnpj.ToUpperInvariant() -replace '[^0-9A-Z]', ''

    if ([string]::IsNullOrWhiteSpace($cleanCnpj)) {
        throw 'CNPJ não pode ser nulo ou vazio.'
    }

    $cleanCnpj
}
