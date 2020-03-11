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
