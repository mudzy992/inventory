#!/bin/bash

# Ovdje postavite svoj tajni ključ za webhook
SECRET_KEY="tajniključzawebhook"

# Provjerite da li je tajni ključ ispravan
if [[ "$1" != "$SECRET_KEY" ]]; then
  echo "Nevažeći tajni ključ. Pristup odbijen."
  exit 1
fi

# Postavite putanju do vašeg repozitorija
REPO_PATH="/home/administrator/Documents/GitHub/frontend-inventory/"

# Navigirajte do repozitorija
cd $REPO_PATH

# Resetirajte repozitorij na najnoviju verziju na produkcioni grani
#PRODUCTION_BRANCH="AI-optimizacija"

# Dobijte informacije o trenutnom branch-u iz webhook događaja
BRANCH=$(echo $2 | cut -d/ -f3)

git checkout $BRANCH
#git checkout $PRODUCTION_BRANCH
git pull

# Instalirajte sve ovisnosti pomoću npm
npm install

# Pokrenite ili restartajte aplikaciju koristeći PM2
# Ovdje zamijenite 'your_app_name' s odgovarajućim imenom za vašu aplikaciju
pm2 startOrRestart ecosystem.config.js --env production --update-env

# Skripta je uspješno završena
echo "Ažuriranje i ponovno pokretanje uspješno završeno za FrontEnd."
