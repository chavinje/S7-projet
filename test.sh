# Exécutez la commande pour obtenir l'adresse IP et le port
output=$(ip a )

# Utilisez des outils comme awk, grep ou sed pour extraire l'adresse IP
adresse_ip=$(echo "$output" | awk '{print $1}')

# Définissez la variable d'environnement
export ADRESSE_IP_PORT="$adresse_ip:8080"

# Affichez la variable d'environnement pour vérification
echo "Adresse IP et port: $ADRESSE_IP_PORT"
