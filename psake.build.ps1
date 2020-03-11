properties {
    $ModuleName = "PSPortmanteau"
    $OutputPath = Join-Path -Path .\ -ChildPath Output
    $ModulePath = Join-Path -Path $OutputPath -ChildPath $ModuleName
}

task default -depends structure, clean, build, test

task Structure {
    $SRC = Get-ChildItem .\SRC
    $hasClasses = $SRC | Where-Object {$_.Name -eq "Classes"}
    $hasFunctions = $SRC | Where-Object {$_.Name -eq "Functions"}

    If($hasClasses -eq $Null){
        New-Item -Path .\SRC -ItemType Directory -Name "Classes" | Out-Null
    }
    If($hasFunctions -eq $Null){
        New-Item -Path .\SRC -ItemType Directory -Name "Functions" | Out-Null
    }
    $dirFunctions = Get-ChildItem .\SRC\Functions
    $hasPublic = $dirFunctions | Where-Object {$_.Name -eq "Public"}
    $hasPrivate = $dirFunctions | Where-Object {$_.Name -eq "Private"}
   
    If($hasPublic -eq $Null){
        New-Item -Path .\SRC\Functions -ItemType Directory -Name "Public" | Out-Null
    }
    If($hasPrivate -eq $Null){
        New-Item -Path .\SRC\Functions -ItemType Directory -Name "Private" | Out-Null
    }

}

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

task Build -depends Structure, Clean {
    
    $PrivateFunctions = Get-ChildItem ".\SRC\Functions\Private"
    $PublicFunctions = Get-ChildItem ".\SRC\Functions\Public"
    $Classes = Get-ChildItem ".\SRC\Classes\"
    $FunctionsToExport = $PublicFunctions.BaseName

    Update-ModuleManifest -Path ".\SRC\$ModuleName.psd1" -FunctionsToExport $FunctionsToExport

    Copy-Item -Path ".\SRC\$ModuleName.psd1" -Destination $ModulePath
    Copy-Item -Path ".\SRC\$ModuleName.psm1" -Destination $ModulePath
    
    # Export Classes
    foreach ($Class in $Classes) {
        $Content = Get-Content -Path $Class.FullName
        Add-Content -Value $content -Path "$ModulePath\$ModuleName.psm1"
    }
    
    # Export Private Functions
    foreach ($PrivateFunction in $PrivateFunctions) {
        $Content = Get-Content -Path $PrivateFunction.FullName
        Add-Content -Value $content -Path "$ModulePath\$ModuleName.psm1"
    }

    # Export Public Functions
    foreach ($PublicFuntion in $PublicFunctions) {
        $Content = Get-Content -Path $PublicFuntion.FullName
        Add-Content -Value $content -Path "$ModulePath\$ModuleName.psm1"
    }
}

task Publish -depends Build, Test {
    Publish-Module -Name $ModulePath -Repository "MPSPSRepo"
}

