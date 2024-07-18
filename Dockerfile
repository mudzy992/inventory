# Koristimo službeni Node.js image kao bazu
FROM node:alpine

# Kreiramo direktorij za aplikaciju unutar image-a
WORKDIR /usr/src/app

# Kopiramo package.json i package-lock.json u radni direktorij
COPY package*.json ./

# Instaliramo ovisnosti
RUN npm install --force --verbose

# Kopiramo ostatak aplikacije
COPY . .

# Provjera sadržaja direktorija prije builda
RUN echo "Prije builda:" && ls -la /usr/src/app

# Build
RUN npm run build --verbose

# Provjera sadržaja direktorija nakon builda
RUN echo "Nakon builda:" && ls -la /usr/src/app

# Instaliramo PM2 globalno
RUN npm install -g pm2

# Otvaramo port na kojem aplikacija radi
EXPOSE 3006

# Pokrećemo aplikaciju sa PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
