--Crear base de datos llamada blog.
CREATE DATABASE blog;

\c blog;

--Crear las tablas indicadas de acuerdo al modelo de datos.
CREATE TABLE usuarios (id SERIAL, email VARCHAR(50), PRIMARY KEY (id));

CREATE TABLE post (id SERIAL, usuario_id INT, título VARCHAR(50), fecha DATE, PRIMARY KEY (id), FOREIGN KEY (usuario_id) REFERENCES usuarios (id));

CREATE TABLE comentarios(id SERIAL PRIMARY KEY, usuario_id INT NOT NULL REFERENCES usuarios(id), post_id INT NOT NULL REFERENCES post(id), texto VARCHAR(50) NOT NULL, fecha DATE);

--Insertar los siguientes registros
\copy usuarios FROM '/Users/ale/Documents/bootcamp/programacion/parte-3/3_desafio/usuarios.csv' csv header;

 \copy post FROM '/Users/ale/Documents/bootcamp/programacion/parte-3/3_desafio/post.csv' csv header;

 \copy comentarios FROM '/Users/ale/Documents/bootcamp/programacion/parte-3/3_desafio/comentarios.csv' csv header;

--Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT usuarios.email, usuarios.id, post.título
FROM usuarios
JOIN post ON usuarios.id = post.usuario_id
WHERE usuarios.id = '5';

--Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
SELECT  usuarios.id, usuarios.email, comentarios.texto
FROM usuarios 
JOIN comentarios ON usuarios.id = comentarios.usuario_id
WHERE usuarios.id<>'6';

--Listar los usuarios que no han publicado ningún post.
SELECT usuarios.*
FROM usuarios
LEFT JOIN post ON usuarios.id = post.usuario_id
WHERE post.título IS NULL;

--Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
SELECT post.título, comentarios.texto
FROM post
FULL OUTER JOIN comentarios 
ON post.id = comentarios.post_id;

--Listar todos los usuarios que hayan publicado un post en Junio.
SELECT usuarios.id, usuarios.email, post.fecha
FROM usuarios
JOIN post
ON usuarios.id = post.usuario_id
WHERE post.fecha 
BETWEEN '2020-06-01' and '2020-06-30' ORDER BY fecha ASC;


