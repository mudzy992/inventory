# Stage 1: Install dependencies
FROM node:20-alpine AS dependencies

WORKDIR /usr/src/backend/app

# Kopiramo package.json i package-lock.json u radni direktorij
COPY package*.json ./

# Instaliramo ovisnosti
RUN npm install --force --verbose

# Stage 2: Build
FROM dependencies AS build

# Kopiramo ostatak aplikacije
COPY . .

# Build
RUN npm run build --verbose

# Stage 3: Production image
FROM node:20-alpine AS production

WORKDIR /usr/src/backend/app

# Kopiramo node_modules i dist iz builder faze
COPY --from=build /usr/src/backend/app/package*.json ./
COPY --from=build /usr/src/backend/app/node_modules ./node_modules
COPY --from=build /usr/src/backend/app/dist ./dist

# Instaliramo PM2 globalno
RUN npm install -g pm2

# Otvaramo port na kojem aplikacija radi
EXPOSE 3006

# Pokrećemo aplikaciju sa PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
