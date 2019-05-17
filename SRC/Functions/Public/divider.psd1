function Divider {
    [CmdletBinding()]
    param (
        # Length
        [Parameter(
            Mandatory = $false,
            Position = 0)]
        [ValidateSet("Underscore", "Dot", "Dash")]
        [string]
        $Type = "Dot"
    )

    begin {
    }

    process {
        switch ($Type) {
            Underscore {
                $Script:Segments += "_"
            }
            Dot {
                $Script:Segments += "."
            }
            Dash {
                $Script:Segments += "-"
            }
            Default { }
        }
    }

    end {
    }
}
