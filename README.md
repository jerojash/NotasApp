# notes_app

## COMANDOS PARA CORRER EL PROYECTO

### Descarga las dependencias necesarias

`dart pub get`

### Copia y edita los 2 archivos de configuración del proyecto:

- database.src.yaml -> database.yaml
- config.src.yaml -> config.yaml

Y coloca los datos correspondientes para tu conexión de base de datos

### Realiza las migraciones a tu base de datos local

`conduit db upgrade`

### Agrega el cliente al sistema

`conduit auth add-client --id ClientId --secret ClientSecret`

### Corre el proyecto

`conduit serve`

### Accede a el swagger para crear tu usuario y probar tus endpoints (Opcional se puede usar postman también)

http://localhost:8888/files/client.html
