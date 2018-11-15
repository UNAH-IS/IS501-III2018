/*
Se le solicita realizar los siguientes incisos:
1. Consultar la cantidad de likes por publicación.*/

SELECT *
FROM TBL_PUBLICACIONES;

SELECT A.CODIGO_PUBLICACION, B.CONTENIDO_PUBLICACION, COUNT(*) CANTIDAD_LIKES
FROM TBL_LIKE_PUBLICACIONES A
INNER JOIN TBL_PUBLICACIONES B
ON (A.CODIGO_PUBLICACION = B.CODIGO_PUBLICACION)
GROUP BY A.CODIGO_PUBLICACION, B.CONTENIDO_PUBLICACION
ORDER BY CODIGO_PUBLICACION;

/*
2. Consultar la cantidad de likes por fotografía.*/
SELECT CODIGO_FOTO, COUNT(*) AS CANTIDAD_LIKES
FROM TBL_LIKE_FOTOGRAFIAS
GROUP BY CODIGO_FOTO;

SELECT *
FROM TBL_FOTOS;


/*
3. Consultar los grupos en los cuales la cantidad de usuarios sea mayor que 5, mostrar el nombre
del grupo y la cantidad de usuarios.*/

SELECT *
FROM TBL_GRUPOS;

--Utilizando inner join
SELECT A.CODIGO_GRUPO,B.NOMBRE_GRUPO, COUNT(*) AS CANTIDAD_USUARIOS
FROM TBL_GRUPOS_X_USUARIO A
INNER JOIN TBL_GRUPOS B
ON (A.CODIGO_GRUPO = B.CODIGO_GRUPO)
GROUP BY A.CODIGO_GRUPO, B.NOMBRE_GRUPO
HAVING COUNT(*)>5;

--Utilizando productos cartesianos
SELECT A.CODIGO_GRUPO,B.NOMBRE_GRUPO, COUNT(*) AS CANTIDAD_USUARIOS
FROM    TBL_GRUPOS_X_USUARIO A,
        TBL_GRUPOS B
WHERE A.CODIGO_GRUPO = B.CODIGO_GRUPO
GROUP BY A.CODIGO_GRUPO, B.NOMBRE_GRUPO
HAVING COUNT(*)>5;

/*
4. Mostrar la cantidad de amistades pendientes y rechazadas.
*/

SELECT  A.CODIGO_USUARIO,
        B.NOMBRE_ESTATUS,
        COUNT(*) CANTIDAD_SOLICITUDES
FROM TBL_AMIGOS A
INNER JOIN TBL_ESTATUS_SOLICITUDES B
ON (A.CODIGO_ESTATUS = B.CODIGO_ESTATUS)
WHERE A.CODIGO_ESTATUS IN (3,2)
GROUP BY A.CODIGO_USUARIO,
        B.NOMBRE_ESTATUS
ORDER BY CODIGO_USUARIO, NOMBRE_ESTATUS;


/*
SELECT
FROM
JOINS
WHERE
GROUP BY
HAVING
ORDER BY
*/
SELECT *
FROM TBL_ESTATUS_SOLICITUDES;

/*
5. Mostrar el usuario con mayor cantidad de amigos confirmados (El más cool).
6. Mostrar el usuario con más solicitudes rechazadas (Forever alone).
7. Mostrar la cantidad de usuarios registrados mensualmente.
8. Mostrar la edad promedio de los usuarios por género.
9. Con respecto al historial de accesos se necesita saber el crecimiento de los accesos del día 19 de
agosto del 2015 con respecto al día anterior, la fórmula para calcular dicho crecimiento se
muestra a continuación:
((b-a)/a) * 100
Donde:
a = Cantidad de accesos del día anterior (18 de Agosto del 2015)
b = Cantidad de accesos del día actual (19 de Agosto del 2015)
Mostrar el resultado como un porcentaje (Concatenar %)
10. Crear una consulta que muestre lo siguiente:
• Nombre del usuario.
• País donde pertenece.
• Cantidad de publicaciones que tiene.
• Cantidad de amigos confirmados.
*/
