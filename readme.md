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

###Configurar url de ambientes

La aplicación reconoce el ambiente (Environment) según la url que se trabaje, es por este que se debe considerar lo siguiente:

* `local` environment: la url debe contener la palabra `local`, ej: `miapp.local.com`, `dev.local.com`
* `qa` environment: la url debe contener la palabra `qa`, ej: `miapp.qa.com`, `dev.qa.com`
* `production` environment: por defecto tomará éste ambiente sino tiene coincidencia con los anteriores, ej: `miapp.com`

***
###Ambiente desarrollo

* Correr Gulp desarrollo: ```gulp ```

###Ambiente Producción

* Correr Gulp desarrollo: ```gulp dist ```
