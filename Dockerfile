# Usar la imagen oficial de NGINX
FROM nginx:latest

# Copiar el archivo de video al directorio de contenido de NGINX
COPY video.mp4 /proba/video.mp4

# Exponer el puerto 80
EXPOSE 80
