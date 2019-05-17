# Import-Module PSPortmanteau

$users = (Invoke-WebRequest -Uri "https://randomuser.me/api/?nat=us&results=100&inc=name,gender,dob&noinfo&format=csv").Content | ConvertFrom-CSV

$UserObjects = Foreach ($User in $Users) {
    New-PSPUserObject -FirstName $User."name.first" -LastName $User."name.last" -DOB $User."dob.date"
}

Username $UserObjects {
    LastName
    FirstName 5
    Birthday yy
}
