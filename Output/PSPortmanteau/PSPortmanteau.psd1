
@{
    RootModule        = '.\PSPortmanteau.psm1'
    ModuleVersion     = '0.1.1'
    # Supported PSEditions
    # CompatiblePSEditions = @()
    GUID              = '20b42ae5-175c-4bb5-a2fd-a1d7909e9570'
    Author            = 'Tom Pomeroy'
    CompanyName       = 'Mansfield Public Schools'
    Copyright         = '(c) 2019 Tom Pomeroy. All rights reserved.'
    Description       = 'A tool for building Usernames and Passwords'
    # PowerShellVersion = ''
    # PowerShellHostName = ''
    # PowerShellHostVersion = ''
    # DotNetFrameworkVersion = ''
    # CLRVersion = ''
    # ProcessorArchitecture = ''
    # RequiredModules = @()
    # RequiredAssemblies = @()
    # ScriptsToProcess = @()
    # TypesToProcess = @()
    # FormatsToProcess = @()
    # NestedModules = @()
    FunctionsToExport = "New-PSPUserObject", "FirstName", "LastName", "Devider", "Birthday", "MiddleName", "Username"
    CmdletsToExport   = '*'
    VariablesToExport = '*'
    AliasesToExport   = '*'
    # DscResourcesToExport = @()
    # ModuleList = @()
    # FileList = @()
    PrivateData       = @{
        PSData = @{
            # Tags = @()
            # LicenseUri = ''
            # ProjectUri = ''
            # IconUri = ''
            # ReleaseNotes = ''
        } # End of PSData hashtable
    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}

