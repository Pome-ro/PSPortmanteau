class PSPUser {
    #Properties
    [String]$FirstName
    [String]$LastName
    [String]$MiddleName
    [datetime]$DOB
    [String]$SamAccountName
    [String]$PlainTextPassword
    [String]$ID

    #Constructor
    PSPUser ([String]$FirstName, [String]$LastName, [String]$DOB, [String]$ID) {
        $this.FirstName = $FirstName
        $this.LastName = $LastName
        $this.DOB = $DOB
        $this.ID = $ID
    }

    #Set Username
    SetUsername ([string]$username) {
        $this.SamAccountName = $username
    }
    
    SetPlainTextPassword ([string]$PlainTextPassword) {
        $this.PlainTextPassword = $PlainTextPassword
    }
}
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
function Divider {
    [CmdletBinding()]
    param (
        # Sperator Type
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [ValidateSet("Underscore", "Dot", "Dash")]
        [string]
        $Type = "Dot"
    )

    begin {
    }

    process {
        switch ($Type) {
            Underscore {
                $Script:Segments += "_"
            }
            Dot {
                $Script:Segments += "."
            }
            Dash {
                $Script:Segments += "-"
            }
            Default { }
        }
    }

    end {
    }
}
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
function New-PSPUserObject {
    [CmdletBinding()]
    param (
        # First Name
        [Parameter(Mandatory = $true)]
        [String]
        $FirstName,
        # Last Name
        [Parameter(Mandatory = $true)]
        [String]
        $LastName,
        # Date of Birth
        [Parameter(Mandatory = $true)]
        [datetime]
        $DOB,
        # Middle Name
        [Parameter(Mandatory = $false)]
        [String]
        $MiddleName,
        # ID
        [Parameter(Mandatory = $false)]
        [String]
        $ID = $(New-Guid).GUID
    )

    begin {

    }

    process {
        $PSPObject = [PSPUser]::New($Firstname, $LastName, $DOB, $ID)
        if ($MiddleName -ne $null) {
            $PSPObject.MiddleName = $MiddleName
        }
        Write-Output $PSPObject
    }

    end {
    }
}
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

function Username {
    [CmdletBinding()]
    param (
        # PSPUser
        [Parameter(
            Mandatory = $true,
            Position = 0)]
        [PSPUser[]]
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
        foreach ($PUser in $PSPUser) {
            $Script:User = $PUser
            $Script:Segments = @()
            . $Script
            $Username = -join $Script:Segments
            $PUser.SetUsername($Username)
            $PUser
        }
    }

    end {
    }
}
Export-ModuleMember -Function *
