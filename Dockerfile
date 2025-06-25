FROM node:18-alpine

# Variables d'environnement Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

WORKDIR /app

# Copier les fichiers package
COPY package*.json ./

# Installer les dépendances
RUN npm install --production --silent

# Copier le code source
COPY . .

# Créer le dossier instances
RUN mkdir -p instances

# Exposer le port
EXPOSE 8080

# Variables par défaut
ENV PORT=8080
ENV NODE_ENV=production

# Commande de démarrage
CMD ["npm", "start"]
