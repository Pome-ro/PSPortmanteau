function Username {
    [CmdletBinding()]
    param (
        # PSPUser
        [Parameter(
            Mandatory = $true,
            Position = 0)]
        [PSPUser]
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
        $Script:User = $PSPUser
        $Script:Segments = @()
        . $Script
        Join-String $Script:Segments
    }

    end {
    }
}
