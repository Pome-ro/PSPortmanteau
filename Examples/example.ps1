Import-Module PSPortmanteau

# Pull Users from Randomuser.me
$users = (Invoke-WebRequest -Uri "https://randomuser.me/api/?nat=us&results=100&inc=name,gender,dob&noinfo&format=csv").Content | ConvertFrom-CSV

# Convert each user into a PSPUser Object
$PSPUser = Foreach ($User in $Users) {
    New-PSPUserObject -FirstName $($User."name.first") -LastName $($User."name.last") -DOB $($User."dob.date")
}

# Itterate over each object, returning that object with the Username stored in its SamAccountName Property.
$PSPUserUsername = Generate $PSPUser -Username -MaxLength 24 -Trim LastName {
    FirstName
    Divider -type "dot"
    LastName
}

$PSPUserPassword = Generate $PSPUserUsername -Password {
    FirstName -Length 1 -toLower
    LastName -Length 1 -toLower
    Birthday -Format "Mdyy"
}
