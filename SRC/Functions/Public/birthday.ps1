function Birthday {
    [CmdletBinding()]
    param (
        # Date Format
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [string]
        $Format = "YYYY"
    )

    begin {
    }

    process {
        $Date = $Script:User.DOB | Get-Date -Format $Format
        $Script:Segments += $Date
    }

    end {
    }
}
