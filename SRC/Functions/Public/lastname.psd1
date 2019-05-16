function LastName {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Int32]
        $Length = $Script:User.LastName.Length
    )

    begin {
    }

    process {
        $FNLength = $Script:User.LastName.Length
        $Length = if ($Length -ge $FNLength) { $FNLength } else { $Length }
        $LastNameSegment = $Script:User.LastName.substring(0, $Length)
        $Script:Segments += $LastNameSegment
    }

    end {
    }
}
