# 📃 PSPortmanteau Change Log
## v0.1.2 2019-06-24
* Added the UserID Segment and Class Field
    * the UuserID is required when creating a PSPUser object
    * Using the New-PSPUser CMDLET will auto generate a UserID using New-GUID if no UserID is set. 
    * The UserID Segment has options for pulling characters from the start or the end of the string using the -Direction param. Valid options are Left-Right or Right-Left
## v0.1.1 2019-05-16
* Added Following Segments
    * Birthday
        * Allows for output of user birthday.
        * Allows for formatting options
    * Divider
        * Allows for insertion of separator symbol.
        * Symbols are currently
            * Dot .
            * Dash -
            * Underscore _
* Added SetUsername to the PSPUser Class.
    * Stores a Username in a PSPUser object.

## Initial Commit 2019-05-16
* first iteration
