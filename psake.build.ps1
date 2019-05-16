properties {
    $ModuleName = "PSPortmanteau"
    $OutputPath = Join-Path -Path .\ -ChildPath Output
    $ModulePath = Join-Path -Path $OutputPath -ChildPath $ModuleName
}

task default -depends clean, build, test

task Test {
    Import-Module $ModulePath
    $IsLoaded = Get-Module $ModuleName

    if (!($IsLoaded -eq $Null)) {
        Write-Host -ForegroundColor Green "$ModuleName Loaded Successfully."
    }
    Remove-Module $ModuleName
}

task Clean {
    if (Test-Path -Path "$OutputPath") {
        Remove-Item -Path $OutputPath -Recurse
        New-Item -Path .\ -ItemType Directory -Name "Output" | Out-Null
        New-Item -Path $OutputPath -Name $ModuleName -ItemType Directory | Out-Null
    } else {
        New-Item -Path .\ -ItemType Directory -Name "Output" | Out-Null
        New-Item -Path $OutputPath -Name $ModuleName -ItemType Directory | Out-Null
    }

}

task Build -depends Clean {
    Copy-Item -Path ".\SRC\PSPortmanteau.psd1" -Destination $ModulePath
    Copy-Item -Path ".\SRC\PSPortmanteau.psm1" -Destination $ModulePath
    $PSPUserClass = Get-Content -Path ".\SRC\Classes\psp.class.pspuser.ps1"
    $PSPPublicFunctions = Get-ChildItem ".\SRC\Functions\Public"
    $PSPPrivetFunctions = Get-ChildItem ".\SRC\Functions\Privet"
    Add-Content -Path "$ModulePath\PSPortmanteau.psm1" -Value $PSPUserClass
    foreach ($PublicFuntion in $PSPPublicFunctions) {
        $Content = Get-Content -Path $PublicFuntion.FullName
        Add-Content -Value $content -Path "$ModulePath\PSPortmanteau.psm1"
    }
    Add-Content -Value "Export-ModuleMember -Function *" -Path "$ModulePath\PSPortmanteau.psm1"
}

task Publish -depends Build, Test {
    Publish-Module -Name $ModulePath -Repository "Mansfield Powershell Repo" -WhatIf
}

