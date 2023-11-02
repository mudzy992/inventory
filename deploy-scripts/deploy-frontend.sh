#!/bin/bash

# Ovdje postavite svoj tajni ključ za webhook
SECRET_KEY="tajniključzawebhook"

# Provjerite da li je tajni ključ ispravan
if [[ "$1" != "$SECRET_KEY" ]]; then
  echo "Nevažeći tajni ključ. Pristup odbijen."
  exit 1
fi

# Postavite putanju do vašeg repozitorija (i React projekta ako je ista putanja)
REPO_PATH="/home/administrator/Documents/GitHub/frontend-inventory/"

# Navigirajte do repozitorija
cd $REPO_PATH

# Resetirajte repozitorij na najnoviju verziju na produkcioni grani
# Dobijte informacije o trenutnom branch-u iz webhook događaja
BRANCH=$(echo $2 | cut -d/ -f3)

git checkout $BRANCH
git pull

# Navigirajte do direktorijuma sa React aplikacijom (ako je razdvojeno)
# REACT_APP_PATH="/putanja/do/React/aplikacije"
# cd $REACT_APP_PATH

# Instalirajte sve ovisnosti pomoću npm
npm install
npm run build

# Pokrenite ili restartajte aplikaciju koristeći PM2
# Ovdje zamijenite 'your_app_name' s odgovarajućim imenom za vašu aplikaciju
# pm2 startOrRestart /home/administrator/Documents/GitHub/frontend-inventory/deploy-scripts/ecosystem.config.js --env production
serve /home/administrator/Documents/GitHub/frontend-inventory/build -s -p 4001

# Skripta je uspješno završena
echo "Ažuriranje i ponovno pokretanje uspješno završeno za FrontEnd."
