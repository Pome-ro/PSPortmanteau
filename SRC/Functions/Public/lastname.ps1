function LastName {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Int32]
        $Length = $Script:User.LastName.Length,
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
            if ($Overide.Function -eq 'LastName'){
                if ($overide.Action -eq 'Trim'){
                    $Length = $Length - $Overide.Value
                }
                if($overide.Action -eq 'Expand'){
                    $Length = $Length + $Overide.Value
                }
            }
        }

        $FNLength = $Script:User.LastName.Length
        $Length = if ($Length -ge $FNLength) { $FNLength } else { $Length }
        $LastNameSegment = $Script:User.LastName.substring(0, $Length)
        

        if ($toLower) {
            $Script:Segments += $LastNameSegment.toLower()
        }  else {
            $Script:Segments += $LastNameSegment
        }
    }

    end {
    }
}
