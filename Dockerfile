# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /usr/src/app

# Kopiramo package.json i package-lock.json u radni direktorij
COPY package*.json ./

# Instaliramo ovisnosti
RUN npm install --force --verbose

# Kopiramo ostatak aplikacije
COPY --chown=node:node . .

# Build
RUN npm run build --verbose

# Stage 2: Production image
FROM node:20-alpine

WORKDIR /usr/src/app

# Kopiramo node_modules i dist iz builder faze
COPY --from=builder --chown=node:node /usr/src/app/package*.json ./
COPY --from=builder --chown=node:node /usr/src/app/node_modules ./node_modules
COPY --from=builder --chown=node:node /usr/src/app/dist ./dist

# Instaliramo PM2 globalno
RUN npm install -g pm2

# Otvaramo port na kojem aplikacija radi
EXPOSE 3006

# Pokrećemo aplikaciju sa PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
