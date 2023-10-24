#!/bin/bash

# Tajni ključ za webhook
SECRET_KEY="tajniključzawebhook"

# Provjera da li je tajni ključ ispravan
if [[ "$1" != "$SECRET_KEY" ]]; then
  echo "Neispravan tajni ključ. Pristup odbijen."
  exit 1
fi

# Putanja repozitorija
REPO_PATH="Documents/GitHub/inventory/"

# Navigirajte do repozitorija
cd $REPO_PATH

# Premjestite se na master granu
git checkout master

# Povucite izmjene sa master grane
git pull origin master

npm run build

# Provjerite status PM2 instance za vašu aplikaciju
if pm2 info inventory-backend >/dev/null 2>&1; then
  # Ako PM2 instanca već postoji, izvršite restart
  pm2 restart inventory-backend --watch
else
  # Ako PM2 instanca ne postoji, pokrenite novu
  # Instalacija svih dep
  npm install

  # Pokrenite aplikaciju pomoću PM2
  pm2 start dist/src/main.js --name inventory-backend --watch
fi

# Skripta je uspješno završena
echo "Ažuriranje i ponovno pokretanje uspješno završeno za BackEnd"
