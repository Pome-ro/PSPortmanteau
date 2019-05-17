class PSPUser {
    #Properties
    [String]$FirstName
    [String]$LastName
    [String]$MiddleName
    [datetime]$DOB
    [String]$SamAccountName
    [String]$PlainTextPassword

    #Constructor
    PSPUser ([String]$FirstName, [String]$LastName, [String]$DOB) {
        $this.FirstName = $FirstName
        $this.LastName = $LastName
        $this.DOB = $DOB
    }

    #Set Username
    SetUsername ([string]$username) {
        $this.SamAccountName = $username
    }
}
