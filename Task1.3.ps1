# Creating parameters for script
Param (
    $width,
    $lenght
)
# Cheching out if reqctangle is tiny or huge and writing out result.
try {
    $square = $lenght * $width
    if ($square -le 100) {
        if ($square -gt 0) {
            Write-Host "Square = "$square
            Write-Host "Your rectangle is tiny"
        }
        else {
            throw [System.ArgumentException]
        }
    }
    else {
        Write-Host "Square = "$square
        Write-Host "Your rectangle is huge"
    }
}
# Exception for invalid format of input data
catch [System.ArgumentException] {
    Write-Error "Input parameters should be positive numbers" # Non positive parameters exception
}
catch {
    Write-Error "You assigned lenght or width in invalid format. This parameters should be positive numbers"
}
Exit