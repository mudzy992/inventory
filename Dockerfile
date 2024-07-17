# Koristimo službeni Node.js image kao bazu
FROM node:14

# Kreiramo direktorij za aplikaciju unutar image-a
WORKDIR /usr/src/app

# Kopiramo package.json i package-lock.json u radni direktorij
COPY package*.json ./

# Instaliramo ovisnosti
RUN npm install

# Kopiramo ostatak aplikacije
COPY . .

# Otvaramo port na kojem aplikacija radi
EXPOSE 3005

# Pokrećemo aplikaciju
CMD ["npm", "start"]
