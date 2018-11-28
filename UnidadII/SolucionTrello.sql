/*Desarrollar las siguientes consultas:
1. Mostrar todos los usuarios que no han creado ningún tablero, para dichos usuarios mostrar el
nombre completo y correo, utilizar producto cartesiano con el operador (+).
*/

SELECT  A.NOMBRE||' '||A.APELLIDO AS NOMBRE_COMPLETO,
        A.CORREO
FROM    TBL_USUARIOS A,
        TBL_TABLERO B
WHERE   A.CODIGO_USUARIO = B.CODIGO_USUARIO_CREA(+)
AND     B.CODIGO_TABLERO IS NULL;


/*
2. Mostrar la cantidad de usuarios que se han registrado por cada red social, mostrar inclusive la
cantidad de usuarios que no están registrados con redes sociales.
*/

SELECT NVL(B.NOMBRE_RED_SOCIAL,'SIN RED SOCIAL') AS NOMBRE_RED_SOCIAL, COUNT(*) AS CANTIDAD_USUARIOS
FROM    TBL_USUARIOS A
LEFT JOIN TBL_REDES_SOCIALES B
ON (A.CODIGO_RED_SOCIAL = B.CODIGO_RED_SOCIAL)
GROUP BY NVL(B.NOMBRE_RED_SOCIAL,'SIN RED SOCIAL');
/*
3. Consultar el usuario que ha hecho más comentarios sobre una tarjeta (El más prepotente), para
este usuario mostrar el nombre completo, correo, cantidad de comentarios y cantidad de
tarjetas a las que ha comentado (pista: una posible solución para este último campo es utilizar
count(distinct campo))*/
SELECT MAX(CANTIDAD_COMENTARIOS)
FROM (
    SELECT CODIGO_USUARIO, COUNT(*) CANTIDAD_COMENTARIOS
    FROM TBL_COMENTARIOS
    GROUP BY CODIGO_USUARIO
);

SELECT *
FROM TBL_USUARIOS;

SELECT *
FROM TBL_COMENTARIOS
WHERE CODIGO_USUARIO = 241;


SELECT  A.CODIGO_USUARIO, 
        B.NOMBRE||' '||B.APELLIDO AS NOMBRE_COMPLETO, 
        B.CORREO,
        COUNT(*) CANTIDAD_COMENTARIOS,
        COUNT(DISTINCT CODIGO_TARJETA) CANTIDAD_TARJETAS
FROM TBL_COMENTARIOS A
INNER JOIN TBL_USUARIOS  B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
GROUP BY A.CODIGO_USUARIO, 
        B.NOMBRE||' '||B.APELLIDO, 
        B.CORREO
HAVING COUNT(*)=(
    SELECT MAX(CANTIDAD_COMENTARIOS)
    FROM (
    SELECT CODIGO_USUARIO, COUNT(*) CANTIDAD_COMENTARIOS
    FROM TBL_COMENTARIOS
    GROUP BY CODIGO_USUARIO
    )
);

/*
4. Mostrar TODOS los usuarios con plan FREE, de dichos usuarios mostrar la siguiente información:
• Nombre completo
• Correo
• Red social (En caso de estar registrado con una)
• Cantidad de organizaciones que ha creado, mostrar 0 si no ha creado ninguna.*/

SELECT  A.CODIGO_USUARIO, 
        A.NOMBRE||' '||A.APELLIDO,
        A.CORREO,
        B.NOMBRE_RED_SOCIAL,
        NVL(C.CANTIDAD_ORGANIZACIONES,0) AS CANTIDAD_ORGANIZACIONES
FROM TBL_USUARIOS A
LEFT JOIN TBL_REDES_SOCIALES B
ON (A.CODIGO_RED_SOCIAL = B.CODIGO_RED_SOCIAL)
LEFT JOIN (
    SELECT CODIGO_ADMINISTRADOR, COUNT(*) CANTIDAD_ORGANIZACIONES
    FROM TBL_ORGANIZACIONES
    GROUP BY CODIGO_ADMINISTRADOR
) C
ON (A.CODIGO_USUARIO = C.CODIGO_ADMINISTRADOR);
/*
5. Mostrar los usuarios que han creado más de 5 tarjetas, para estos usuarios mostrar:
Nombre completo, correo, cantidad de tarjetas creadas*/
SELECT A.CODIGO_USUARIO, COUNT(*) CANTIDAD_TARJETAS
FROM TBL_TARJETAS A
RIGHT JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
GROUP BY A.CODIGO_USUARIO;

--EN UN DADO CASO SEA NECESARIO VISUALIZAR TODOS LOS USUARIOS QUE HAN O NO HAN CREADO TARJETAS
SELECT B.CODIGO_USUARIO, COUNT(A.CODIGO_USUARIO)
FROM TBL_TARJETAS A
RIGHT JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
GROUP BY B.CODIGO_USUARIO;

--
SELECT  A.CODIGO_USUARIO,
        B.NOMBRE||' '||B.APELLIDO AS NOMBRE_COMPLETO, 
        B.CORREO, COUNT(*) CANTIDAD_TARJETAS
FROM TBL_TARJETAS A
INNER JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
GROUP BY A.CODIGO_USUARIO,B.NOMBRE||' '||B.APELLIDO, B.CORREO
HAVING COUNT(*)>5;

/*
6. Un usuario puede estar suscrito a tableros, listas y tarjetas, de tal forma que si hay algún cambio
se le notifica por teléfono, sabiendo esto, se necesita mostrar los nombres de
todos los usuarios con la cantidad de suscripciones de cada tipo, en la consulta se debe mostrar:
• Nombre completo del usuario
• Cantidad de tableros a los cuales está suscrito
• Cantidad de listas a las cuales está suscrito
• Cantidad de tarjetas a las cuales está suscrito*/

SELECT B.CODIGO_USUARIO,
        B.NOMBRE||' '||B.APELLIDO AS NOMBRE_COMPLETO,
        COUNT(CODIGO_LISTA) CANTIDAD_LISTAS, 
        COUNT(CODIGO_TABLERO) CANTIDAD_TABLEROS,
        COUNT(CODIGO_TARJETA) CANTIDAD_TARJETAS
FROM TBL_SUSCRIPCIONES A
RIGHT JOIN TBL_USUARIOS B
ON (A.CODIGO_USUARIO = B.CODIGO_USUARIO)
GROUP BY B.CODIGO_USUARIO, B.NOMBRE||' '||B.APELLIDO;

--15 -> 0,1,2



/*
7. Consultar todas las organizaciones con los siguientes datos:
• Nombre de la organización
• Cantidad de usuarios registrados en cada organización
• Cantidad de Tableros por cada organización
• Cantidad de Listas asociadas a cada organización
• Cantidad de Tarjetas asociadas a cada organización 
*/
SELECT  A.CODIGO_ORGANIZACION, 
        A.NOMBRE_ORGANIZACION,
        NVL(B.CANTIDAD_USUARIOS,0) AS CANTIDAD_USUARIOS,
        NVL(C.CANTIDAD_TABLEROS,0) AS CANTIDAD_TABLEROS,
        NVL(D.CANTIDAD_LISTAS,0) AS CANTIDAD_LISTAS,
        NVL(E.CANTIDAD_TARJETAS,0) AS CANTIDAD_TARJETAS
FROM TBL_ORGANIZACIONES A
LEFT JOIN (
    --• Cantidad de usuarios registrados en cada organización
    SELECT CODIGO_ORGANIZACION, COUNT(*) CANTIDAD_USUARIOS
    FROM TBL_USUARIOS_X_ORGANIZACION
    GROUP BY CODIGO_ORGANIZACION
) B
ON (A.CODIGO_ORGANIZACION = B.CODIGO_ORGANIZACION)
LEFT JOIN (
    ---• Cantidad de Tableros por cada organización
    SELECT CODIGO_ORGANIZACION, COUNT(*) CANTIDAD_TABLEROS
    FROM TBL_TABLERO
    GROUP BY CODIGO_ORGANIZACION
) C
ON (A.CODIGO_ORGANIZACION = C.CODIGO_ORGANIZACION)
LEFT JOIN (
    --• Cantidad de Listas asociadas a cada organización
    SELECT B.CODIGO_ORGANIZACION, COUNT(*) CANTIDAD_LISTAS
    FROM TBL_LISTAS A
    INNER JOIN TBL_TABLERO B
    ON (A.CODIGO_TABLERO = B.CODIGO_TABLERO)
    GROUP BY B.CODIGO_ORGANIZACION
) D
ON (A.CODIGO_ORGANIZACION = D.CODIGO_ORGANIZACION)
LEFT JOIN (
    --• Cantidad de Tarjetas asociadas a cada organización 
    SELECT C.CODIGO_ORGANIZACION, COUNT(*) CANTIDAD_TARJETAS
    FROM TBL_TARJETAS A
    INNER JOIN TBL_LISTAS B
    ON (A.CODIGO_LISTA = B.CODIGO_LISTA)
    INNER JOIN TBL_TABLERO C
    ON (B.CODIGO_TABLERO = C.CODIGO_TABLERO)
    GROUP BY C.CODIGO_ORGANIZACION
) E
ON (A.CODIGO_ORGANIZACION = E.CODIGO_ORGANIZACION);




/*
8. Crear una vista materializada con la información de facturación, los campos a incluir son los
siguientes:
• Código factura
• Nombre del plan a facturar
• Nombre completo del usuario
• Fecha de pago (Utilizar fecha inicio, mostrarla en formato Día-Mes-Año)
• Año y Mes de pago (basado en la fecha inicio)
• Monto de la factura
• Descuento
• Total neto
*/
CREATE MATERIALIZED VIEW MVW_FACTURAS AS
SELECT  A.CODIGO_FACTURA, B.NOMBRE_PLAN,
        C.NOMBRE||' '||C.APELLIDO AS NOMBRE_COMPLETO,
        TO_CHAR(A.FECHA_INICIO, 'DD-MM-YYYY') FECHA,
        TO_CHAR(A.FECHA_INICIO, 'MM-YYYY') MES_ANIO,
        ROUND(MONTO,2) AS MONTO,
        ROUND(DESCUENTO,2) AS DESCUENTO,
        ROUND(MONTO-DESCUENTO,2) AS TOTAL_NETO
FROM TBL_FACTURACION_PAGOS A 
INNER JOIN TBL_PLANES B
ON (A.CODIGO_PLAN = B.CODIGO_PLAN)
INNER JOIN TBL_USUARIOS C
ON (A.CODIGO_USUARIO = C.CODIGO_USUARIO);

SELECT *
FROM MVW_FACTURAS;