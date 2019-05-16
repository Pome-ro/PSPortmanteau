function FirstName {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Int32]
        $Length = $Script:User.FirstName.Length
    )

    begin {
    }

    process {
        $FNLength = $Script:User.FirstName.Length
        $Length = if ($Length -ge $FNLength) { $FNLength } else { $Length }
        $FirstNameSegment = $Script:User.FirstName.substring(0, $Length)
        $Script:Segments += $FirstNameSegment
    }

    end {
    }
}
