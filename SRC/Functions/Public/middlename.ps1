function MiddleName {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Int32]
        $Length = $Script:User.MiddleName.Length,
        # toLower
        [Parameter(
            Mandatory = $false,
            Position = 1)]
        [Switch]
        $toLower
    )

    begin {
    }

    process {
        if($Null -ne $Overide){
            if ($Overide.Function -eq 'MiddleName'){
                if ($overide.Action -eq 'Trim'){
                    $Length = $Length - $Overide.Value
                }
                if($overide.Action -eq 'Expand'){
                    $Length = $Length + $Overide.Value
                }
            }
        }

        $FNLength = $Script:User.MiddleName.Length
        $Length = if ($Length -ge $FNLength) { $FNLength } else { $Length }
        $MiddleNameSegment = $Script:User.MiddleName.substring(0, $Length)

        if ($toLower) {
            $Script:Segments += $MiddleNameSegment.toLower()
        }  else {
            $Script:Segments += $MiddleNameSegment
        }
    }

    end {
    }
}
