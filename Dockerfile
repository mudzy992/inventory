# Stage 1: dependencies
FROM node:20-alpine AS dependencies
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --force --silent

# Stage 2: build
FROM dependencies AS build
COPY . .
RUN npm run build --verbose

# Stage 3: production
FROM node:20-alpine AS production
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/package*.json ./
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/dist ./dist

# Storage mount
VOLUME ["/usr/src/app/storage"]

EXPOSE 3006
CMD ["node", "dist/src/main.js"]
