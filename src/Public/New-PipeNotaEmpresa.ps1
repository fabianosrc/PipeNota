function New-PipeNotaEmpresa {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$RazaoSocial,

        [Parameter()]
        [string]$NomeFantasia,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Cnpj,

        [Parameter()]
        [string]$Ie,

        [Parameter()]
        [ValidateSet('Ativa', 'Inativa')]
        [string]$Situacao = 'Ativa',

        [Parameter()]
        [string[]]$EmailPara,

        [Parameter()]
        [string[]]$EmailCc,

        [Parameter()]
        [string[]]$EmailCco,

        [Parameter()]
        [string]$DirXmlAutorizados,

        [Parameter()]
        [string]$DirXmlProcessados
    )

    if ($PSCmdlet.ShouldProcess('Empresa', 'Cadastrar')) {
        $empresa = [PSCustomObject]@{
            RazaoSocial       = $RazaoSocial
            NomeFantasia      = $NomeFantasia
            Cnpj              = $Cnpj
            Ie                = $Ie
            Situacao          = $Situacao
            EmailPara         = $EmailPara
            EmailCc           = $EmailCc
            EmailCco          = $EmailCco
            DirXmlAutorizados = $DirXmlAutorizados
            DirXmlProcessados = $DirXmlProcessados
        }

        return $empresa
    }
}
