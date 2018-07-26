#Creating parameters for script
Param (
   $width,
   $lenght
)
#Creating object with parameters
try {
$Square=$width*$lenght
    $rect = @{
        wid=$width;
        len=$lenght;
        square=$Square
    }
#    Write-Host $rect.square
    #Write-Host $S
    #Write out parameters of object
          if (($rect.square -gt 0) -and ($rect.square.GetType() -ne [string] ))
  {
             Write-Host "Square = " $rect.square }
             else {
                Write-Host "Input parameters should be positive integer numbers" # String or non-positive parameters exception
             }
}
catch {
    Write-Host "Input parameters should be positive integer numbers"
}
