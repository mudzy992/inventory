#!/bin/bash

# Ovdje postavite svoj tajni ključ za webhook
SECRET_KEY="tajniključzawebhook"

# Provjerite da li je tajni ključ ispravan
if [[ "$1" != "$SECRET_KEY" ]]; then
  echo "Nevažeći tajni ključ. Pristup odbijen."
  exit 1
fi

# Postavite putanju do vašeg repozitorija
REPO_PATH="Documents/GitHub/frontend-inventory/"

# Navigirajte do repozitorija
cd $REPO_PATH

# Resetirajte repozitorij na najnoviju verziju na glavnoj grani
git reset --hard HEAD
git pull

# Instalirajte sve ovisnosti
npm install

# Ponovno pokrenite aplikaciju pomoću PM2 ili nekog drugog proces managera
# Ako PM2 nije instaliran, možete zamijeniti s `node dist/src/main.js`
npm start dist/src/main.js

# Skripta je uspješno završena
echo "Ažuriranje i ponovno pokretanje uspješno završeno."
