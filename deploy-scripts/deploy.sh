#!/bin/bash

# Ovdje postavite svoj tajni ključ za webhook
SECRET_KEY="tajniključzawebhook"

# Provjerite da li je tajni ključ ispravan
if [[ "$1" != "$SECRET_KEY" ]]; then
  echo "Nevažeći tajni ključ. Pristup odbijen."
  exit 1
fi

# Postavite putanju do vašeg repozitorija
REPO_PATH="Documents/GitHub/inventory/"

# Navigirajte do repozitorija
cd $REPO_PATH

# Provjerite status PM2 instance za vašu aplikaciju
if pm2 info inventory-backend >/dev/null 2>&1; then
  # Ako PM2 instanca već postoji, izvršite restart
  pm2 restart inventory-backend --watch
else
  # Ako PM2 instanca ne postoji, pokrenite novu
  # Instalirajte sve ovisnosti
  npm install

  # Pokrenite aplikaciju pomoću PM2
  pm2 start dist/src/main.js --name inventory-backend --watch
fi

# Skripta je uspješno završena
echo "Ažuriranje i ponovno pokretanje uspješno završeno za backend."
