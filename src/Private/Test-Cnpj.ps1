<#
.SYNOPSIS
Valida um número de CNPJ.

.DESCRIPTION
Verifica se um CNPJ é válido utilizando o algoritmo oficial
de cálculo dos dígitos verificadores da SERPRO. Suporte a
CNPJ numérico e alfanumérico.

.PARAMETER Cnpj
Número do CNPJ (com ou sem máscara).

.EXAMPLE
PS C:\> Test-Cnpj -Cnpj 01234567000189

.OUTPUTS
System.Boolean
#>
function Test-Cnpj {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Cnpj
    )

    #region Helpers
    function Get-DigitoVerificador {
        [CmdletBinding()]
        [OutputType([int])]
        param (
            [Parameter(Mandatory)]
            [string[]]$Chars,

            [Parameter(Mandatory)]
            [int[]]$Pesos
        )

        [array]$valores = @()
        foreach ($char in $Chars) {
            if ($char -match '[0-9]') {
                $valores += [int]$char
            } else {
                # Cálculo alfanumérico: ASCII - 48
                $valores += ([int][char]$char - 48)
            }
        }

        $soma = 0
        for ($i = 0; $i -lt $valores.Count; $i++) {
            $soma += $valores[$i] * $Pesos[$i]
        }

        $resto = $soma % 11

        if ($resto -lt 2) {
            return 0
        } else {
            return 11 - $resto
        }
    }
    #endregion

    $Cnpj = $Cnpj.ToUpperInvariant() -replace '[^0-9A-Z]', ''

    if ($Cnpj.Length -ne 14 -or $Cnpj -match '^(\d)\1{13}$') {
        return $false
    }

    [array]$peso1 = @(5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2)
    [array]$peso2 = @(6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2)

    [char[]]$chars = $Cnpj.ToCharArray()
    $digito1 = Get-DigitoVerificador -Chars $chars[0..11] -Pesos $peso1

    [char[]]$chars2 = $chars[0..11] + $digito1.ToString().ToCharArray()
    $digito2 = Get-DigitoVerificador -Chars $chars2 -Pesos $peso2

    $digitoVerificador = '{0}{1}' -f $digito1, $digito2

    return $Cnpj.Substring(12, 2) -eq $digitoVerificador
}
