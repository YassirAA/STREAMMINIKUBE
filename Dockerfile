# Usar la imagen base de Nginx
FROM nginx:latest

# Instalar dependencias: FFmpeg, codecs y Redis CLI
RUN apt-get update && \
    apt-get install -y ffmpeg libx264-dev libx265-dev redis-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copiar configuración de NGINX para HLS
COPY nginx-hls.conf /etc/nginx/conf.d/default.conf

# Copiar página web y videos
COPY index.html /usr/share/nginx/html/
COPY videos/ /usr/share/nginx/html/videos/

# Copiar script de procesamiento
COPY process-videos.sh /usr/share/nginx/html/
RUN chmod +x /usr/share/nginx/html/process-videos.sh

# Comando al iniciar
CMD ["sh", "-c", "/usr/share/nginx/html/process-videos.sh && nginx -g 'daemon off;'"]
