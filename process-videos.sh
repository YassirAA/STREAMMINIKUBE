#!/bin/bash

# Definir las variables de entrada (videos MP4) y salida (HLS)
INPUT_DIR="/usr/share/nginx/html/videos"
OUTPUT_DIR="/usr/share/nginx/html/stream"

# Crear el directorio de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Verificar si hay archivos MP4 en el directorio de entrada
if [ -n "$(ls -A $INPUT_DIR/*.mp4 2>/dev/null)" ]; then
    for video in "$INPUT_DIR"/*.mp4; do
        # Extraer el nombre del archivo sin la extensión
        filename=$(basename "$video" .mp4)

        # Verificar si el video ya está en la caché de Redis
        if redis-cli -h redis get "$filename" > /dev/null; then
            echo "El video $filename ya está en la caché."
        else
            # Procesar el video con FFmpeg
            echo "Procesando: $filename.mp4"
            ffmpeg -i "$video" \
                -c:v libx264 -crf 23 -preset fast \
                -c:a aac -b:a 128k \
                -hls_time 4 -hls_playlist_type vod \
                -hls_segment_filename "$OUTPUT_DIR/${filename}_%03d.ts" \
                "$OUTPUT_DIR/${filename}.m3u8"

            # Almacenar la lista de reproducción en Redis
            redis-cli -h redis set "$filename" "$OUTPUT_DIR/${filename}.m3u8"
            echo "Lista de reproducción de $filename almacenada en Redis."
        fi
    done
else
    echo "Error: No hay videos en $INPUT_DIR" >&2
    exit 1
fi

# Iniciar NGINX
echo "Iniciando NGINX..."
exec nginx -g "daemon off;"
