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

## CORRE EL COMANDO (SOLO UNA VEZ)

`conduit document client -d ./public`



### Corre el proyecto

`conduit serve`

### Accede a el swagger para crear tu usuario y probar tus endpoints (Opcional se puede usar postman también)

http://localhost:8888/files/client.html



### FORMATO PARA INSERTAR EN NOTAS
{
  "n_contenido": "string",
  "n_fecha_creada": "2023-04-05",
  "n_fecha_borrada": null,
  "n_tipo": "string",
  "folder":{"c_clave":1,"c_nombre":"hola","c_tipo": "bla",
      "user":{
  "password": "xxx",
  "email": "moron@gmail.com",
  "first_name": "carlos",
  "middle_name": "moron",
  "first_surname": "julio",
  "second_surname": "diaz",
  "id": 3,
  "username": "morongas"
    }
    
  }
} 
