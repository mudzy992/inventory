# Koristimo službeni Node.js image kao bazu
FROM node:alpine

# Kreiramo direktorij za aplikaciju unutar image-a
WORKDIR /usr/src/app

# Kopiramo package.json i package-lock.json u radni direktorij
COPY package*.json ./

# prebuild

RUN npm run prebuild --verbose

# Build

RUN npm run build --verbose

# Kopiramo ostatak aplikacije
COPY . .

# Instaliramo ovisnosti
RUN npm install --force --verbose

# Instaliramo PM2 globalno
RUN npm install -g pm2

# Otvaramo port na kojem aplikacija radi
EXPOSE 3006

# Pokrećemo aplikaciju sa PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
