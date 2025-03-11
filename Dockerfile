FROM nginx:latest

# Copiar la página web y la carpeta de videos
COPY index.html /usr/share/nginx/html/
COPY videos/ /usr/share/nginx/html/videos/

# Exponer el puerto 80
EXPOSE 80
