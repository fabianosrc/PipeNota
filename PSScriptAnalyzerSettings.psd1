@{
    Severity = @('Error', 'Warning')

    IncludeRules = @(
        # Security and best practices
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
        'PSUseCmdletCorrectly',

        # Style and consistency
        'PSAlignAssignmentStatement',
        'PSAvoidMultipleStatementsPerLine',
        'PSAvoidTrailingWhitespace',
        'PSAvoidMultipleEmptyLines',
        'PSUseConsistentWhitespace',
        'PSAvoidInlineComments',
        'PSUseCorrectCasing',
        'PSUseSingularNouns',
        'PSPipelineIndentation',
        'PSHashTableFormatting'
    )

    Rules = @{
        PSUseConsistentIndentation = @{
            IndentationSize = 4
        }
        PSAlignAssignmentStatement = @{
            AlignmentStyle = 'Variable'
        }
        PSPipelineIndentation = @{
            IndentationStyle = 'IncreaseForFirstPipeline'
        }
        PSHashTableFormatting = @{
            AlignKeysAndValues = $true
            IndentationSize = 4
        }
    }

    ExcludeRules = @()
}
