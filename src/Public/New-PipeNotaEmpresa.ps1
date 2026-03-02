function New-PipeNotaEmpresa {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param (
        [Parameter(Mandatory)]
        [string]$RazaoSocial,

        [Parameter()]
        [string]$NomeFantasia,

        [Parameter(Mandatory)]
        [string]$Cnpj,

        [Parameter()]
        [string]$Ie,

        [Parameter()]
        [ValidateSet('Matriz', 'Filial')]
        [string]$Tipo,

        [Parameter()]
        [ValidateSet('Ativa', 'Inativa')]
        [string]$Situacao,

        [Parameter()]
        [string]$DiretorioXmlAutorizados,

        [Parameter()]
        [string]$DiretorioXmlProcessados,

        [Parameter()]
        [string[]]$EmailPara,

        [Parameter()]
        [string[]]$EmailCc,

        [Parameter()]
        [string[]]$EmailCco
    )
}
