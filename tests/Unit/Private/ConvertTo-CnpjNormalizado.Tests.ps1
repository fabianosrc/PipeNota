BeforeAll {
    . "$PSScriptRoot/../../../src/Private/ConvertTo-CnpjNormalizado.ps1"
}

Describe 'ConvertTo-CnpjNormalizado' {

    Context 'Quando recebe um CNPJ válido com máscara' {

        It 'Deve remover pontos, barras e traço' {
            ConvertTo-CnpjNormalizado -Cnpj '01.234.567/0001-89' |
                Should -Be '01234567000189'
        }

        It 'Deve retornar exatamente 14 dígitos' {
            (ConvertTo-CnpjNormalizado -Cnpj '01.234.567/0001-89').Length |
                Should -Be 14
        }

        It 'Deve retornar o mesmo valor se já estiver normalizado' {
            ConvertTo-CnpjNormalizado -Cnpj '01234567000189' |
                Should -Be '01234567000189'
        }

        It 'Remove qualquer caractere não numérico' {
            ConvertTo-CnpjNormalizado -Cnpj '01A.234B.567R/0001-89' |
                Should -Be '01234567000189'
        }
    }

    Context 'Quanto o CNPJ possui quantidade inválida de dígitos' {

        It 'Deve lançar uma exceção quando tiver menos de 14 dígitos' {
            { ConvertTo-CnpjNormalizado -Cnpj '01.235.456/OOO9' } |
                Should -Throw 'CNPJ inválido.'
        }

        It 'Deve lançar uma exceção quando tiver mais de 14 dígitos' {
            { ConvertTo-CnpjNormalizado -Cnpj '01.234.567/OOO08-91' } |
                Should -Throw 'CNPJ inválido.'
        }
    }

    Context 'Quando -Cnpj recebe um valor nulo ou vazio' {

        It 'Deve lançar uma exceção se for apenas espaços em branco' {
            { ConvertTo-CnpjNormalizado -Cnpj '    ' } |
                Should -Throw 'CNPJ não pode ser nulo ou vazio. (Parameter ''Cnpj'')'
        }

        It 'Deve lançar uma exceção se a string for vazia' {
            { ConvertTo-CnpjNormalizado -Cnpj '' } |
                Should -Throw
        }

        It 'Deve lançar uma exceção se for $null' {
            { ConvertTo-CnpjNormalizado -Cnpj $null } |
                Should -Throw
        }
    }
}
