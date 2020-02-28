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
