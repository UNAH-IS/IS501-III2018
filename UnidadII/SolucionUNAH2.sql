/*Mostrar los alumnos con excelencia académica (Cum Laude >= 80) para cada carrera, puede darse el caso
de que un estudiante tenga más de una carrera y en ambas sea excelencia académica. Para este ejercicio
NO utilizar el campo PROMEDIO_CARRERA de la tabla TBL_CARRERA_X_ALUMNOS, en su lugar hacer
el cálculo del historial académico. Información a mostrar:
a. Nombre completo con cada inicial en mayúscula.
b. Número de cuenta.
c. Carrera
d. Promedio para dicha carrera: Sumatoria de las UV * Promedio por asignatura/Sumatoria del total
de UV por carrera.
Ejemplo del cálculo del promedio:*/

CREATE VIEW VW_PROMEDIOS AS 
SELECT C.NOMBRE ||' '||C.APELLIDO AS NOMBRE_COMPLETO, 
        B.NUMERO_CUENTA,
        F.NOMBRE_CARRERA,
        E.CODIGO_CARRERA,
        SUM(E.CANTIDAD_UNIDADES_VALORATIVAS) TOTAL_UV,
        SUM(E.CANTIDAD_UNIDADES_VALORATIVAS * A.PROMEDIO) AS PESO,
        ROUND(SUM(E.CANTIDAD_UNIDADES_VALORATIVAS * A.PROMEDIO)/SUM(E.CANTIDAD_UNIDADES_VALORATIVAS),2) PROMEDIO
FROM TBL_HISTORIAL A
INNER JOIN TBL_ALUMNOS B
ON (A.CODIGO_ALUMNO = B.CODIGO_ALUMNO)
INNER JOIN TBL_PERSONAS C 
ON (B.CODIGO_ALUMNO = C.CODIGO_PERSONA)
INNER JOIN TBL_SECCION D
ON A.CODIGO_SECCION = D.CODIGO_SECCION
INNER JOIN TBL_ASIGNATURAS E
ON (D.CODIGO_ASIGNATURA = E.CODIGO_ASIGNATURA)
INNER JOIN TBL_CARRERAS F
ON (E.CODIGO_CARRERA = F.CODIGO_CARRERA)
GROUP BY C.NOMBRE ||' '||C.APELLIDO, 
        B.NUMERO_CUENTA,
        F.NOMBRE_CARRERA,
        E.CODIGO_CARRERA;


SELECT *
FROM VW_PROMEDIOS
WHERE PROMEDIO = (
    SELECT MAX(PROMEDIO)
    FROM VW_PROMEDIOS
);

SELECT *
FROM VW_PROMEDIOS
WHERE PROMEDIO = (
    SELECT MIN(PROMEDIO)
    FROM VW_PROMEDIOS
);