FROM node:16-slim

# instalar dependências de build e o youtube-dl (ou yt-dlp)
RUN apt-get update \
 && apt-get install -y git python3 ffmpeg \
 && pip3 install yt-dlp \
 && ln -s /usr/local/bin/yt-dlp /usr/local/bin/youtube-dl \
 && rm -rf /var/lib/apt/lists/*

# clonar o repositório e instalar dependências Node
RUN git clone https://github.com/StefanLobbenmeier/youtube-dl-gui.git /opt/app \
 && cd /opt/app \
 && npm install --production

WORKDIR /opt/app

# expõe porta para o web-ui
EXPOSE 5800

# comando padrão: inicia o Electron headless + web UI
ENTRYPOINT ["npm","start"]
