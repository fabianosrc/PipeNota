Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

<#
.SYNOPSIS
Adiciona um tipo personalizado a um objeto PowerShell.

.DESCRIPTION
Recebe um objeto e adiciona um nome de tipo personalizado ao
PSObject.TypeNames. Isso permite que o objeto seja tratado como um
tipo específico dentro do módulo PipeNota.

Opcionalmente, define quais propriedades devem ser exibidas por padrão
quando o objeto é mostrado no console, utilizando um
DefaultDisplayPropertySet.

.PARAMETER InputObject
Objeto que será adaptado para o tipo personalizado.

Aceita entrada pelo pipeline.

.PARAMETER TypeName
Nome do tipo que será atribuído ao objeto.

.PARAMETER Namespace
Namespace usado para compor o nome completo do tipo.

O valor padrão é "PipeNota".

.PARAMETER DefaultDisplayProperties
Lista de propriedades que serão exibidas por padrão quando o objeto
for mostrado no console.

.INPUTS
System.Object
Objeto que será adaptado para o tipo personalizado.

.OUTPUTS
System.Management.Automation.PSObject
Objeto adaptado com o tipo personalizado.

.EXAMPLE
PS C:\> $empresa = [PSCustomObject]@{
    RazaoSocial  = 'Empresa XPTO'
    NomeFantasia = 'XPTO'
    Cnpj         = '01.234.567/0001-89'
}

PS C:\> $empresa | New-PipeNotaTypedObject -TypeName Empresa

Adiciona o tipo "PipeNota.Empresa" ao objeto.

.EXAMPLE
PS C:\> $empresa | New-PipeNotaTypedObject -TypeName Empresa -DefaultDisplayProperties RazaoSocial, Cnpj

Adiciona o tipo personalizado ao objeto e define as propriedades
exibidas por padrão no console.

.NOTES
Utiliza o Extended Type System (ETS) do PowerShell para adicionar
nomes de tipo personalizados a objetos em tempo de execução.
#>
function New-PipeNotaTypedObject {
    [CmdletBinding()]
    [OutputType([psobject])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [object]$InputObject,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$TypeName,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Namespace = 'PipeNota',

        [Parameter()]
        [string[]]$DefaultDisplayProperties
    )

    process {
        if ($null -eq $InputObject) {
            return
        }

        $psObject = [psobject]::AsPSObject($InputObject)
        $customType = '{0}.{1}' -f $Namespace, $TypeName

        if (-not ($psObject.PSObject.TypeNames.Contains($customType))) {
            $psObject.PSObject.TypeNames.Insert(0, $customType)
        }

        if ($DefaultDisplayProperties) {
            foreach ($property in $DefaultDisplayProperties.Where({ $_ -and $_.Trim() })) {
                if (-not ($psObject.PSObject.Properties.Match($property))) {
                    $psObject.PSObject.Properties.Add(
                        [System.Management.Automation.PSNoteProperty]::new($property, $null)
                    )
                }
            }

            $displayPropertySet = [System.Management.Automation.PSPropertySet]::new(
                'DefaultDisplayPropertySet', $DefaultDisplayProperties
            )

            $standardMembers = [System.Management.Automation.PSMemberSet]::new(
                'PSStandardMembers', [System.Management.Automation.PSMemberInfo[]]@($displayPropertySet)
            )

            if ($psObject.PSObject.Members['PSStandardMembers']) {
                $psObject.PSObject.Members.Remove('PSStandardMembers')
            }

            $psObject.PSObject.Members.Add($standardMembers)
        }

        $psObject
    }
}
