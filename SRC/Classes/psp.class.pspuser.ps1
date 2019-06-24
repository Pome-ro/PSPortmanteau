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
