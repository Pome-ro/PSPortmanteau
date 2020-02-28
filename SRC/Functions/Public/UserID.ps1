Function UserID {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Int32]
        $Length = $Script:User.ID.Length,
        # Direction of Snip, left to Right, or Right to Left
        [Parameter(
            Mandatory = $False, 
            Position = 1)]
        [String]
        [ValidateSet('Left-Right','Right-Left')]
        $Direction = 'Left-Right',
        # toLower
        [Parameter(
            Mandatory = $false,
            Position = 2)]
        [Switch]
        $toLower
       
    )

    begin {
    }

    process {
        if($Null -ne $Overide){
            if ($Overide.Function -eq 'UserID'){
                if ($overide.Action -eq 'Trim'){
                    $Length = $Length - $Overide.Value
                }
                if($overide.Action -eq 'Expand'){
                    $Length = $Length + $Overide.Value
                }
            }
        }
        #Set Max Length of the Length field. 
        $IDLength = $Script:User.UserID.Length
        $Length = if ($Length -ge $IDLength) { $IDLength } else { $Length }

        #Take Snip of ID from either Left to Right or Right to Left
        If($Direction -eq 'Left-Right'){
            $IDSegment = $Script:User.UserID.substring(0, $Length)
        }
        if($Direction -eq 'Right-Left'){
            $NewLength = $IDLength - $Length
            $IDSegment = $Script:User.UserID.substring($NewLength,$Length )
        }
        
        $Script:Segments += $IDSegment

        if ($toLower) {
            $Script:Segments += $IDSegment.toLower()
        }  else {
            $Script:Segments += $IDSegment
        }
    }

    end {
    }
}

