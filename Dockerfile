FROM node:18-alpine

# Installer les dépendances système nécessaires
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    ffmpeg

# Variables d'environnement pour Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

WORKDIR /evolution

# Copier les fichiers de configuration
COPY package*.json ./
COPY yarn.lock ./

# Installer les dépendances
RUN yarn install --production

# Copier le code source
COPY . .

# Créer les dossiers nécessaires
RUN mkdir -p /evolution/instances
RUN mkdir -p /evolution/store

# Exposer le port
EXPOSE 8080

# Variables d'environnement par défaut
ENV SERVER_TYPE=http
ENV SERVER_PORT=8080
ENV SERVER_URL=https://localhost:8080
ENV CORS_ORIGIN=*
ENV CORS_METHODS=POST,GET,PUT,DELETE
ENV CORS_CREDENTIALS=true

# Commande de démarrage
CMD ["node", "./dist/src/main.js"]
