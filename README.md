# Localizacion de Farmacias

# Indice
<a href="#indice"></a>

1. [Requisitos](#requisitos)
2. [Deployment Local](#deploymentlocal)
3. [Deployment con Docker](#deploymentdocker)

# Requisitos
<a href="#requisitos"></a>

1) Requisitos
    * PHP 8.1 o +[Web oficial](https://www.php.net/downloads)
    * Composer [Web oficial](https://getcomposer.org/download/)
    * MySQL [Web oficial](https://www.mysql.com/downloads/)
    * Node 18 o superior [Web oficial](https://nodejs.org/es)
    * (opcional) Docker [Web oficial](https://www.docker.com/)

# Deployment Local
<a href="#deploymentlocal"></a>

### Inicialmente este repositorio cuenta con una instalacion con docker automatizada por script, pero tambien cuenta con una instalacion independiente a Docker

1) Ejecute el siguiente comando en la raiz de su proyecto

    ```bash
        cd api/ ;
        cp .env.example .env ;
        cd .. ;
    ```

2) Verifique que las credenciales de tu base de datos local (MySQL) coincidan con las variables de entorno en .env

    ```bash
        DB_HOST=
        DB_PORT=
        DB_DATABASE=
        DB_USERNAME=
        DB_PASSWORD=
    ```

3) Copie y pegue el siguiente comando ejecutable en la raiz del proyecto.

    ```bash
        cd api/ ;
        composer i ;
        php artisan key:generate && php artisan migrate --seed ;
        cd ../vue-app/ ;
        npm i ; 
        cd .. ;
    ```


4) Para levantar cada microservicio de manera local ejecute en 2 terminales distintas en la raíz del proyecto

    ```bash
        cd api && php artisan serve
    ```

    ```bash
        cd vue-app && npm run dev
    ```

5) Ya puedes ver la aplicación de VueJS corriendo en tu sistema


# Deployment con Docker
<a href="#deploymentdocker"></a>

### La instalacion con Docker está automatizada, por lo que es muy sencillo por si eres principiante en Docker

### Veras en la raiz el proyecto un archivo script.sh

1) Para ejecutar este script primero debes otorgarle permisos de ejecución:

    ```bash
        chmod +x script.sh
    ```

2) Ejecuta el script

    ```bash
        ./script.sh
    ```

## Disfruta de la aplicación

# Author

[![linkedin-shield-alansanchez]][linkedin-alansanchez-url] [![portfolio]][portfolio-alansanchez] <br>

<p align="left"><a href="#indice">Volver al Indice</a></p>

[portfolio]: https://img.shields.io/badge/-Portfolio-orange?style=for-the-badge&logo=appveyor

[linkedin-shield-alansanchez]: https://img.shields.io/badge/-Alan_Sanchez-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[linkedin-alansanchez-url]: https://linkedin.com/in/alansanchez96
[portfolio-alansanchez]: https://dev-alansan.netlify.app/