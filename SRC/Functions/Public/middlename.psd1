function MiddleName {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Int32]
        $Length = $Script:User.MiddleName.Length
    )

    begin {
    }

    process {
        $FNLength = $Script:User.MiddleName.Length
        $Length = if ($Length -ge $FNLength) { $FNLength } else { $Length }
        $MiddleNameSegment = $Script:User.MiddleName.substring(0, $Length)
        $Script:Segments += $MiddleNameSegment
    }

    end {
    }
}
