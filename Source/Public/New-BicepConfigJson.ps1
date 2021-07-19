function New-BicepConfigJson {
    [CmdletBinding()]
    param (
        [Bicep.Core.Diagnostics.DiagnosticLevel]$Level = 'Warning'
    )
    
    begin {
        [PSCustomObject]$ResultObj = @{}
    }
    
    process {
        # Get all rules from the currently loaded version of Bicep.Core
        $CurrentlyLoadedRules = [AppDomain]::CurrentDomain.GetAssemblies().GetTypes() | Where-Object {
            $_.NameSpace -eq 'Bicep.Core.Analyzers.Linter.Rules' -and
            $_.BaseType.Name -eq 'LinterRuleBase'
        } | Select-Object -ExpandProperty Name

        $CurrentlyLoadedRules | ForEach-Object { 
            $CurrentRule = New-Object -TypeName Bicep.Core.Analyzers.Linter.Rules.${_}
            $NewRule = @{
                $CurrentRule.Code = @{
                    'level' = $Level.ToString()
                }
            }
            $NewRule
            # $SearchOrder = $CurrentRule.RuleConfigSection.split(':')

        }
    }
    
    end {
        
    }
}