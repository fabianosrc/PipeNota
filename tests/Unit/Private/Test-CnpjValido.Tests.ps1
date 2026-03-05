BeforeAll {
    . "$PSScriptRoot/../../TestSetup.ps1"
}

Describe 'Test-CnpjValido' {

    Context 'CNPJ válido' {
        It 'Retorna True para CNPJ com máscara' {
            Test-CnpjValido -Cnpj '78.332.372/0001-02' | Should -BeTrue
        }

        It 'Retorna True para CNPJ sem máscara' {
            Test-CnpjValido -Cnpj '78332372000102' | Should -BeTrue
        }
    }

    Context 'CNPJ inválido' {
        It 'Retorna False para CNPJ com máscara' {
            Test-CnpjValido -Cnpj '28.775.268/0001-26' | Should -BeFalse
        }

        It 'Retorna False para CNPJ com máscara' {
            Test-CnpjValido -Cnpj '28775268000126' | Should -BeFalse
        }

        It 'Retorna False para CNPJ com números repetidos com máscara' {
            Test-CnpjValido -Cnpj '11.111.111/1111-11' | Should -BeFalse
        }

        It 'Retorna False para CNPJ com números repetidos sem máscara' {
            Test-CnpjValido -Cnpj '99999999999999' | Should -BeFalse
        }
    }
}
