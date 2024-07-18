# Koristimo službeni Node.js image kao bazu
FROM node:18-alpine3.20

# Kreiramo direktorij za aplikaciju unutar image-a
WORKDIR /usr/src/app

# Kopiramo package.json i package-lock.json u radni direktorij
COPY package*.json ./

# Instaliramo ovisnosti
RUN npm install --force

# Kopiramo ostatak aplikacije
COPY . .

# Instaliramo PM2 globalno
RUN npm install -g pm2

# Build

RUN npm run build

# Otvaramo port na kojem aplikacija radi
EXPOSE 3006

# Pokrećemo aplikaciju sa PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
