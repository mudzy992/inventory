# Koristimo službeni Node.js image kao bazu
FROM node:22.4.1-alpine3.20

# Kreiramo direktorij za aplikaciju unutar image-a
WORKDIR /usr/src/app

# Kopiramo package.json i package-lock.json u radni direktorij
COPY package*.json ./

# Kopiramo ostatak aplikacije
COPY . .

# Instaliramo ovisnosti
RUN npm install --force --verbose

# Instaliramo PM2 globalno
RUN npm install -g pm2

# Build

RUN npm run build --verbose

# Otvaramo port na kojem aplikacija radi
EXPOSE 3006

# Pokrećemo aplikaciju sa PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
