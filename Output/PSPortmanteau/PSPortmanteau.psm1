class PSPUser {
    #Properties
    [String]$FirstName
    [String]$LastName
    [String]$MiddleName
    [datetime]$DOB
    [String]$SamAccountName
    [String]$PlainTextPassword
    [String]$UserID
    [String]$UserPrincipalName

    #Constructor
    PSPUser ([String]$FirstName, [String]$LastName, [String]$DOB, [String]$UserID) {
        $this.FirstName = $FirstName
        $this.LastName = $LastName
        $this.DOB = $DOB
        $this.UserID = $UserID
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
function Generate {
    [CmdletBinding()]
    param (
        # PSPUser
        [Parameter(
            Mandatory = $true,
            Position = 0)]
        [PSPUser[]]
        $PSPUser,
        # Username
        [Parameter(
            Mandatory = $false,
            Position = 1, 
            ParameterSetname = 'Username' )]
        [switch]
        $Username,
        # ScriptBlock
        [Parameter(
            Mandatory = $true,
            Position = 2)]
        [scriptblock]
        $Script,
        ###############
        # Expand - if the username isn't unique you can select a field to expand to drive uniqueness. 
        ###############
        [Parameter(
            Mandatory = $false,
            Position = 4, 
            ParameterSetname = 'Username' )]
        [string]
        [ValidateSet('FirstName','LastName','MiddleName','ID')]
        $Expand,
        ###############
        # MaxLength - Set the max username length to ensure compatability with systems.
        ###############
        [Parameter(
            Mandatory = $false,
            Position = 5, 
            ParameterSetname = 'Username' )]
        [int32]
        $MaxLength,
        ###############
        # Trim - If the MaxLength is breached, you can specify a field to trim to ensure the correct length. 
        ###############
        [Parameter(
            Mandatory = $false,
            Position = 6, 
            ParameterSetname = 'Username' )]
        [string]
        [ValidateSet('FirstName','LastName','MiddleName','UserID')]
        $Trim,          
        ###############
        # Password
        ###############
        [Parameter(
            Mandatory = $false,
            Position = 1, 
            ParameterSetname = 'Password' )]
        [switch]
        $Password
    )

    begin {
    }

    process {
        foreach ($PUser in $PSPUser) {
            $Script:User = $PUser
            $Script:Segments = @()
            . $Script
            $String = -join $Script:Segments
            ##############################
            # Start Username Logic
            ##############################
            if( $Username -eq $True){
                If ($MaxLength -ne 0) {
                    $Overide = @{
                        Function = $Trim
                        Action = "Trim"
                        Value = 0
                    }
                    while ($String.Length -gt $MaxLength) {
                        $Script:Overide = $Overide
                        $Script:Segments = @()
                        . $Script
                        $String = -Join $Script:Segments
                        $Overide.Value += 1
                    }
                }

                $PUser.SetUsername($String)
            }
            ##############################
            # Start Password Logic
            ##############################
            if ($password -eq $True) {
                $PUser.SetPlainTextPassword($String)               
            }

            # Output the PS User
            $PUser
        }
    }

    end {
        $Overide = $Null
        $Script:Overide = $Overide
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
        $UserID = $(New-Guid).GUID
    )

    begin {

    }

    process {
        $PSPObject = [PSPUser]::New($Firstname, $LastName, $DOB, $UserID)
        if ($MiddleName -ne $null) {
            $PSPObject.MiddleName = $MiddleName
        }
        Write-Output $PSPObject
    }

    end {
    }
}
function RandomChar {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Int32]
        $Length = 12,
        # Alpha
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Switch]
        $Alpha,
        # Numeric
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Switch]
        $Numeric,
        # Symbols
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Switch]
        $Symbols

    )

    begin {
    }

    process {
        if($Null -ne $Overide){
            if ($Overide.Function -eq 'RandomChar'){
            }
        }
        $ValidChar = @()
        $AlphaChar = "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
        $NumericChar = "1","2","3","4","5","6","7","8","9","0"
        $SymbolChar = "!","(",")","-",".","?","[","]","~",";",":","@","#","$","%","^","&","*","+","="

        If($Alpha){
            $ValidChar += $AlphaChar
        }
        If($Numeric){
            $ValidChar += $NumericChar
        }
        If($Symbols){
            $ValidChar += $SymbolChar
        }

        $CharacterSet = $ValidChar | Get-Random -Count $Length

        $CharString = -join $CharacterSet

        $Script:Segments += $CharString 
    }

    end {
    }
}
function RawText {
    [CmdletBinding()]
    param (
        # Sperator Type
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [string]
        $text
    )

    begin {
    }

    process {
        $Script:Segments += $text
        
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

