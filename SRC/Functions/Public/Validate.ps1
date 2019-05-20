function Validate {
    [CmdletBinding()]
    param (
        # obj
        [Parameter(mandatory = $true)]
        [string[]]
        $Validators
    )

    begin {
        $ScriptArray = $()
        foreach ($Validator in $Validators) {
            try {
                $ValidateScript = Get-ChildItem -Path .\Validators\psv.$Validator.ps1
                $ScriptArray += $ValidateScript.FullName
            } catch {
                return
            }
        }
    }

    process {
        ForEach ($VScript in $ScriptArray) {
            . $VScript $Script:Segments
        }
    }

    end {
    }
}
