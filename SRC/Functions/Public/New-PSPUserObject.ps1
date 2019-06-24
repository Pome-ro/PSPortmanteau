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
