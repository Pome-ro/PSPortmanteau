# ✂ PSPortmanteau
A PowerShell Module for creating Naming Conventions using a simple DSL. Designed for a K12 EDU environment where User Name and Password conventions can change between grade levels. Allows for ease of use if username conventions need to change.

To be used as part of a configuration step for a larger automation tool, managing the synchronization of users between systems that do not inherently connect.


## Examples:
```powershell
$User = New-PSPUser -FirstName "Raphael" -LastName "Wiggum" -MiddleName "John" -DOB 11/18/1981

Generate -UserName $User {
    LastName
    FirstName 1
    MiddleName 1
    Birthday yy
}
output:
FirstName         : Ralphael
LastName          : Wiggum
MiddleName        : John
DOB               : 11/18/1981 12:00:00 AM
SamAccountName    : WiggumRJ81
PlainTextPassword : 11181985tp
UserID            : 123456789



Generate -UserName $User {
    FirstName
    Divider "Dot"
    LastName
}
output:
FirstName         : Ralphael
LastName          : Wiggum
MiddleName        : John
DOB               : 11/18/1981 12:00:00 AM
SamAccountName    : Ralphael.Wiggum
PlainTextPassword : 11181985tp
UserID            : 123456789
```
More examples in the [Examples dir](.\Examples).

# But Why...
Mostly, to try some stuff I haven't tried before, but also because I hate writing "username-formatting" functions, so now I'll never need to write one again.

My use case is for automating the creation of user accounts for a current job as a K12 IT Professional. This tool will eventually be expanded to password generation as well.

Password complexity and memorability change depending on the grade level, some grades have formulaic passwords for ease of use with small children, while at higher grades the password complexity increases.
