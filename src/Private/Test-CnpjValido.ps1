<#
.SYNOPSIS
    Valida um número de CNPJ.

.DESCRIPTION
    Verifica se um CNPJ é válido utilizando o algoritmo oficial
    de cálculo dos dígitos verificadores da Receita Federal.

.PARAMETER Cnpj
    Número do CNPJ (com ou sem máscara).

.EXAMPLE
    Test-CnpjValido -Cnpj '01.234.567/0001-89'

.EXAMPLE
    '01234567000189' | Test-CnpjValido

.OUTPUTS
    System.Boolean
#>
function Test-CnpjValido {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$Cnpj
    )

    process {
        $numeroCnpj = ConvertTo-CnpjNormalizado -Cnpj $Cnpj

        if ($numeroCnpj -match '^(\d)\1{13}$') {
            return $false
        }

        #region Helper Privado
        function _GetDigitoVerificador ([int[]]$Numbers) {
            $peso = @(5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2)

            if ($Numbers.Count -eq 13) {
                $peso = @(6) + $peso
            }

            $soma = 0

            for ($i = 0; $i -lt $Numbers.Count; $i++) {
                $soma += $Numbers[$i] * $peso[$i]
            }

            $resto = $soma % 11

            if ($resto -lt 2) {
                0
            } else {
                11 - $resto
            }
        }
        #endregion

        $numeros = $numeroCnpj.ToCharArray() | ForEach-Object { [int]$_.ToString() }

        $digito1 = _GetDigitoVerificador -Numbers $numeros[0..11]
        $digito2 = _GetDigitoVerificador -Numbers ($numeros[0..11] + $digito1)

        $digitoVerificador = '{0}{1}' -f $digito1, $digito2

        if ($numeroCnpj.Substring(12, 2) -eq $digitoVerificador) {
            return $true
        }

        return $false
    }
}
