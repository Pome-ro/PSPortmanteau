function RandomChar {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Int32]
        $Length = 12,
        # Alpha
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Switch]
        $Alpha,
        # Numeric
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Switch]
        $Numeric,
        # Symbols
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [Switch]
        $Symbols

    )

    begin {
    }

    process {
        if($Null -ne $Overide){
            if ($Overide.Function -eq 'RandomChar'){
            }
        }
        $ValidChar = @()
        $AlphaChar = "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
        $NumericChar = "1","2","3","4","5","6","7","8","9","0"
        $SymbolChar = "!","(",")","-",".","?","[","]","~",";",":","@","#","$","%","^","&","*","+","="

        If($Alpha){
            $ValidChar += $AlphaChar
        }
        If($Numeric){
            $ValidChar += $NumericChar
        }
        If($Symbols){
            $ValidChar += $SymbolChar
        }

        $CharacterSet = $ValidChar | Get-Random -Count $Length

        $CharString = -join $CharacterSet

        $Script:Segments += $CharString 
    }

    end {
    }
}
