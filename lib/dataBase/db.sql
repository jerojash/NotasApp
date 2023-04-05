CREATE TABLE usuario(
    u_clave serial,
    u_user varchar(100) not null,
    u_nombre varchar(100) not null,
    u_apellido varchar(100) not null,
    u_contrasena varchar(500) not null,
    u_correo varchar(500) not null,
    u_segundoNombre varchar(100),
    u_segundoApellido varchar(100),
    
    constraint pk_usuario primary key(u_clave)
);

CREATE TABLE carpeta(
    c_clave serial,
    c_nombre varchar(100) not null,
    c_tipo varchar(100) not null,
    fk_usuario integer,
    constraint pk_carpeta primary key(c_clave),
    constraint fk_user foreign key(fk_usuario) references usuario(u_clave)   
);

CREATE TABLE nota(
    n_clave serial,
    n_contenido varchar(2500) not null,
    n_fechaCreada date not null,
    n_fechaBorrada date,
    n_tipo varchar(100),
    fk_carpeta integer,
    fk_usuario integer,
    constraint pk_nota primary key(n_clave),
    constraint fk_user foreign key (fk_usuario) references usuario(u_clave),
    constraint fk_carpeta foreign key (fk_carpeta) references carpeta(c_clave)
);