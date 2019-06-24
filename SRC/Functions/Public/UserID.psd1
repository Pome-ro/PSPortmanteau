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
        $Direction = 'Left-Right'
       
    )

    begin {
    }

    process {
        #Set Max Length of the Length field. 
        $IDLength = $Script:User.ID.Length
        $Length = if ($Length -ge $IDLength) { $IDLength } else { $Length }

        #Take Snip of ID from either Left to Right or Right to Left
        If($Direction -eq 'Left-Right'){
            $IDSegment = $Script:User.ID.substring(0, $Length)
        }
        if($Direction -eq 'Right-Left'){
            $NewLength = $IDLength - $Length
            $IDSegment = $Script:User.ID.substring($NewLength,$Length )
        }
        
        $Script:Segments += $IDSegment
    }

    end {
    }
}

