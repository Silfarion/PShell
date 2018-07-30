#Creating parameters for script
Param (
    $width,
    $lenght
)
#Creating object with parameters
try {
    $Square = $width * $lenght
    $rect = @{
        wid    = $width;
        len    = $lenght;
        square = $Square
    }
    #Write out parameters of object
    if (($rect.square -gt 0) -and ($rect.square.GetType() -ne [string] )) {
        Write-Host "Square = "$rect.square
    }
    else {
        throw [System.ArgumentException]::new("Invalid input data")
    }
    # Write-Host "Square = " $rect.square }
    # else {
    #    Write-Error "Input parameters should be positive integer numbers" # String or non-positive parameters exception
    # }
}
catch [System.ArgumentException] {
    Write-Error $_.exception.Tostring()
}
catch {
    Write-Error "Input parameters should be positive integer numbers"
}
exit