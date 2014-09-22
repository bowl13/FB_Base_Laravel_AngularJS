## Laravel API + AngularJS + Facebook API

***

###Instalación Laravel

* Clonar repositorio

```sh
git clone [git-repo-url]
cd [directorio]
```

* Ejecutar actualización dependencias Laravel `composer update`
* Configurar credenciales MySql según ambiente (local/qa/production)
* Migrar tablas y poblar datos 

```sh
php artisan migrate --env=local
php artisan db:seed --env=local
```
***

###Instalar dependencias node y bower

```sh
cd [directorio]/_gulp
npm install
bower install
```

***
###Ambiente desarrollo

* Correr Gulp desarrollo: ```gulp ```

###Ambiente Producción

* Correr Gulp desarrollo: ```gulp dist ```
