﻿
#Remove-Item -path "fichier.txt" -force

$file = "fichier.txt"



Function Search-crendentials { 

			$paths = @(
				"$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Login Data",
				"$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Login Data"
				
					)
					
			foreach ($path in $paths){
				
				if(Test-Path $path){
					
					Add-Content -path $file -Value $path
					
				}
			}
}




Search-crendentials

Get-Content -path $file -raw


		



