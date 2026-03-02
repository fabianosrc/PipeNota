@{
    Severity = @('Error', 'Warning')

    IncludeRules = @(
        'PSAvoidUsingPlainTextForPassword',
        'PSAvoidUsingWriteHost',
        'PSShouldProcess',
        'PSUseApprovedVerbs',
        'PSUseOutputTypeCorrectly',
        'PSUseConsistentIndentation',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSAvoidDefaultValueSwitchParameter',
        'PSMisleadingBacktick',
        'PSMissingModuleManifestField',
        'PSReservedCmdletChar',
        'PSReservedParams',
        'PSAvoidUsingCmdletAliases',
        'PSAvoidUsingPositionalParameters',
        'PSUseCmdletCorrectly'
    )

    Rules = @{
        PSUseConsistentIndentation = @{
            IndentationSize = 4
        }
    }

    ExcludeRules = @()
}
