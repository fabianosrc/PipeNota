<#
.SYNOPSIS
    Normaliza um CNPJ removendo a máscara e validando o comprimento.

.DESCRIPTION
    Recebe um CNPJ com pontos, barras e traços e retorna apenas os números.
    Valida se o resultado contém exatamente 14 dígitos.

.PARAMETER Cnpj
    CNPJ a ser normalizado.

.EXAMPLE
    PS> Format-Cnpj -Cnpj '01.234.567/0001-89'

.OUTPUTS
    System.String
    Retorna o CNPJ contendo apenas números (14 dígitos).
#>
function ConvertTo-CnpjNormalizado {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Cnpj
    )

    if ([string]::IsNullOrWhiteSpace($Cnpj)) {
        throw [System.ArgumentException]::new('CNPJ não pode ser nulo ou vazio.', 'Cnpj')
    }

    $cnpjNormalizado = $Cnpj -replace '\D', ''

    if ($cnpjNormalizado.Length -ne 14) {
        throw 'CNPJ inválido.'
    }

    Write-Output $cnpjNormalizado
}
