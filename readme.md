# PSPortmanteau
A PowerShell Module for creating Naming Conventions using a simple DSL.

```
$User = New-PSPUser -FirstName "Raphael" -LastName "Wiggum" -MiddleName "John" -DOB 11/18/1981
Username $User {
    LastName
    FirstName 1
    MiddleName 1
}
output: WiggumRJ
```
