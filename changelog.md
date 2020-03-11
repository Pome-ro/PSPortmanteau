# 📃 PSPortmanteau Change Log

## v0.1.4 2020-03-10
* Added a "RawText" item in the event you need to inject external information into the username or password. 
* Fixed some temp text outputting to host in the Generate command. 
* Updated the build command to account for missing folders when cloned from GitHub due to them being unused. 
## v0.1.3 2020-02-24
* Major DSL syntax overhall, moved to more genaric term for creating new strings called "Generate"
    * Generate operates just like Username did in the past, however, it will have many flags in wihich you can call that allows you to generate and fill some fields in the PSPUser object type
        * Two flags exist currently, Username and Password
        * Username operates like the previous Username cmd did, filling in the "SamAccountName" field with the generated string on completion
        * Password allows you to populate the "PasswordAsPlainText" field within the PSPUser object. 
    * Added a "Random Character" command RandomChar allowing you to generate strings of random characters. 
        * Has three switches: -Numeric, -Alpha, and -Symbol. Use each one to add more characters to the viable random posibilites. 
    * This version is very close to being production ready. I'll have to test it by generating a spreadsheet of Usernames and Passwords using real data. 
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
