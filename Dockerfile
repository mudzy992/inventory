# Koristimo službeni Node.js image kao bazu
FROM node:20.12.7-alpine

# Kreiramo direktorij za aplikaciju unutar image-a
WORKDIR /usr/src/app

# Kopiramo ostatak aplikacije
COPY . .

# Instaliramo ovisnosti
RUN npm install --force


RUN npm install rimraf -g --force

# Build
RUN npm run build

# Instaliramo PM2 globalno
RUN npm install -g pm2

# Otvaramo port na kojem aplikacija radi
EXPOSE 3006

# Pokrećemo aplikaciju sa PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
