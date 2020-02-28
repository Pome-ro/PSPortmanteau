function FirstName {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Int32]
        $Length = $Script:User.FirstName.Length,
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
            if ($Overide.Function -eq 'FirstName'){
                if ($overide.Action -eq 'Trim'){
                    $Length = $Length - $Overide.Value
                }
                if($overide.Action -eq 'Expand'){
                    $Length = $Length + $Overide.Value
                }
            }
        }

        $FNLength = $Script:User.FirstName.Length
        $Length = if ($Length -ge $FNLength) { $FNLength } else { $Length }
        $FirstNameSegment = $Script:User.FirstName.substring(0, $Length)
        
        if ($toLower) {
            $Script:Segments += $FirstNameSegment.toLower()
        }  else {
            $Script:Segments += $FirstNameSegment
        }
        
    }

    end {
    }
}
