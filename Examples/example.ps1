Import-Module PSPortmanteau

# Pull Users from Randomuser.me
$users = (Invoke-WebRequest -Uri "https://randomuser.me/api/?nat=us&results=100&inc=name,gender,dob&noinfo&format=csv").Content | ConvertFrom-CSV

# Convert each user into a PSPUser Object
$UserObjects = Foreach ($User in $Users) {
    New-PSPUserObject -FirstName $User."name.first" -LastName $User."name.last" -DOB $User."dob.date"
}

# Itterate over each object, returning that object with the Username stored in its SamAccountName Property.
Username $UserObjects {
    LastName # Uses the full last name as the first segment
    FirstName 5 # Uses the first 5 characters of the First Name as the second segment.
    Birthday yy # Uses the last two diggets of the users birthday as the last segment.
}
