#!/bin/bash

# Tajni ključ za webhook
SECRET_KEY="tajniključzawebhook"

# Odabrani branch
SELECTED_BRANCH="nova-verzija"

# Dobijanje trenutnog branch-a
#CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Provjera da li je tajni ključ ispravan
if [[ "$1" != "$SECRET_KEY" ]]; then
  echo "Neispravan tajni ključ. Pristup odbijen."
  exit 1
fi

# Putanja repozitorija
REPO_PATH="/home/administrator/Documents/GitHub/inventory/"

# Navigirajte do repozitorija
cd "$REPO_PATH" || exit

# Premjestite se na odabrani branch
echo "Premještanje na branch: $SELECTED_BRANCH"
git checkout "$SELECTED_BRANCH"

# Povucite izmjene sa odabrane grane
echo "Povlačenje izmjena sa branch-a: $SELECTED_BRANCH"
git pull origin "$SELECTED_BRANCH"

# Provjerite postoji li datoteka package-lock.json
if [ -f "package-lock.json" ]; then
  # Ako postoji, provjerite ima li promjena u paketima
  if npm ci --dry-run; then
    echo "Nema promjena u paketima. Preskakanje npm install."
  else
    echo "Detektirane promjene u paketima. Izvršavanje npm install."
    # Instalirajte sve ovisnosti pomoću npm
    npm install
  fi
else
  # Ako ne postoji, instalirajte sve ovisnosti pomoću npm
  echo "package-lock.json ne postoji. Izvršavanje npm install."
  npm install
fi

# Izvršite build projekta
echo "Izvršavanje npm run build."
npm run build

# Provjerite status PM2 instance za vašu aplikaciju
if pm2 info inventory-backend >/dev/null 2>&1; then
  # Ako PM2 instanca već postoji, izvršite restart
  echo "PM2 instanca postoji. Izvršavanje pm2 restart."
  pm2 restart inventory-backend --watch
else
  # Ako PM2 instanca ne postoji, pokrenite novu
  echo "PM2 instanca ne postoji. Pokretanje nove instance."
  # Pokrenite aplikaciju pomoću PM2
  pm2 start dist/src/main.js --name inventory-backend --watch
fi

# Skripta je uspješno završena
echo "Ažuriranje i ponovno pokretanje uspješno završeno za BackEnd."
