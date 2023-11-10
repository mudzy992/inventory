# #!/bin/bash

# # Ovdje postavite svoj tajni ključ za webhook
# SECRET_KEY="tajniključzawebhook"

# # Provjerite da li je tajni ključ ispravan
# if [[ "$1" != "$SECRET_KEY" ]]; then
#   echo "Nevažeći tajni ključ. Pristup odbijen."
#   exit 1
# fi

# # Postavite putanju do vašeg repozitorija (i React projekta ako je ista putanja)
# REPO_PATH="/home/administrator/Documents/GitHub/frontend-inventory/"

# # Navigirajte do repozitorija
# cd $REPO_PATH

# # Resetirajte repozitorij na najnoviju verziju na produkcioni grani
# # Dobijte informacije o trenutnom branch-u iz webhook događaja
# BRANCH=$(echo $2 | cut -d/ -f3)

# git checkout $BRANCH
# git pull

# # Navigirajte do direktorijuma sa React aplikacijom (ako je razdvojeno)
# # REACT_APP_PATH="/putanja/do/React/aplikacije"
# # cd $REACT_APP_PATH

# # Instalirajte sve ovisnosti pomoću npm
# npm install
# npm run build

# # Pokrenite ili restartajte aplikaciju koristeći PM2
# # Ovdje zamijenite 'your_app_name' s odgovarajućim imenom za vašu aplikaciju
# # pm2 startOrRestart /home/administrator/Documents/GitHub/frontend-inventory/deploy-scripts/ecosystem.config.js --env production
# serve /home/administrator/Documents/GitHub/frontend-inventory/build -s -p 4001

# # Skripta je uspješno završena
# echo "Ažuriranje i ponovno pokretanje uspješno završeno za FrontEnd."

#!/bin/bash

# Tajni ključ za webhook
SECRET_KEY="tajniključzawebhook"

# Postavite putanju do vašeg repozitorija (i React projekta ako je ista putanja)
REPO_PATH="/home/administrator/Documents/GitHub/frontend-inventory/"

# Navigirajte do repozitorija
cd "$REPO_PATH" || exit

# Resetirajte repozitorij na najnoviju verziju na produkcioni grani
# Dobijte informacije o trenutnom branch-u iz webhook događaja
BRANCH=$(echo "$2" | cut -d/ -f3)

# Ispis trenutnog radnog direktorija
echo "Trenutni radni direktorij: $(pwd)"

# Povucite izmjene sa odabrane grane
echo "Povlačenje izmjena sa branch-a: $BRANCH"
git checkout "$BRANCH"
git pull

# Provjerite ima li promjena koje zahtijevaju npm install
if [ "$(git diff-index --quiet HEAD --; echo $?)" -ne 0 ]; then
  echo "Detektirane promjene u kodu ili dependency-jima. Izvršavanje npm install."

  # Instalirajte sve ovisnosti pomoću npm
  npm install

  # Izvršite build React aplikacije
  npm run build

  # Pokrenite ili restartujte aplikaciju pomoću serve
  # Pratite izlaz na stderr kako biste provjerili eventualne greške
  serve /home/administrator/Documents/GitHub/frontend-inventory/build -s -p 4001 2> /dev/null &
else
  echo "Nema promjena koje zahtijevaju npm install. Samo izvršavanje npm run build i pokretanje serve."

  # Izvršite build React aplikacije
  npm run build

  # Pokrenite ili restartujte aplikaciju pomoću serve
  # Pratite izlaz na stderr kako biste provjerili eventualne greške
  serve /home/administrator/Documents/GitHub/frontend-inventory/build -s -p 4001 2> /dev/null &
fi

# Skripta je uspješno završena
echo "Ažuriranje i ponovno pokretanje uspješno završeno za FrontEnd."

