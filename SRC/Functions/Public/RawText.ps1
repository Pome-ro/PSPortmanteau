function RawText {
    [CmdletBinding()]
    param (
        # Sperator Type
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [string]
        $text
    )

    begin {
    }

    process {
        $Script:Segments += $text
        
    }

    end {
    }
}
