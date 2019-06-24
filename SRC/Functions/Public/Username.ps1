function Username {
    [CmdletBinding()]
    param (
        # PSPUser
        [Parameter(
            Mandatory = $true,
            Position = 0)]
        [PSPUser[]]
        $PSPUser,
        # ScriptBlock
        [Parameter(
            Mandatory = $true,
            Position = 1)]
        [scriptblock]
        $Script
    )

    begin {
    }

    process {
        foreach ($PUser in $PSPUser) {
            $Script:User = $PUser
            $Script:Segments = @()
            . $Script
            $Username = -join $Script:Segments
            $PUser.SetUsername($Username)
            $PUser
        }
    }

    end {
    }
}
