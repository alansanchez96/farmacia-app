#!/bin/bash
# Author: Alan Sanchez

# Configuración inicial de Laravel
cd api && cp .env.example .env

# Verificar el sistema operativo y ejecutar docker-compose o docker compose
if command -v docker-compose &> /dev/null; then
    echo "Ejecutando 'docker-compose up -d'..."
    docker-compose up -d
else
    echo "El comando docker-compose no está disponible. Ejecutando 'docker compose'..."
    docker compose up -d
fi

# Esperar a que el contenedor de API esté en funcionamiento
echo "Esperando a que el contenedor de API esté en funcionamiento..."
sleep 5

# Instalar dependencias y configurar laravel y migraciones
docker exec api.pharmacy composer i
docker exec api.pharmacy php artisan key:generate
sleep 5
docker exec api.pharmacy php artisan migrate --seed

# Instalar dependencias de NPM en el contenedor de Vue
docker exec vue.pharmacy npm i

# Compilar la aplicación de Vue
docker exec vue.pharmacy npm run build

# Establecer permisos en el contenedor de API
docker exec api.pharmacy chmod -R 777 storage bootstrap/cache

# Abrir la URL localhost:8080 en el navegador predeterminado según el sistema operativo
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open http://localhost:8080
elif [[ "$OSTYPE" == "darwin"* ]]; then
    open http://localhost:8080
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    start http://localhost:8080
else
    echo "No se pudo determinar el sistema operativo para abrir la URL."
fi
