/*
Mostrar los alumnos con excelencia acad�mica (Cum Laude >= 80) para cada carrera, puede darse el caso
de que un estudiante tenga m�s de una carrera y en ambas sea excelencia acad�mica. Para este ejercicio
NO utilizar el campo PROMEDIO_CARRERA de la tabla TBL_CARRERA_X_ALUMNOS, en su lugar hacer
el c�lculo del historial acad�mico. Informaci�n a mostrar:
a. Nombre completo con cada inicial en may�scula.
b. N�mero de cuenta.
c. Carrera
d. Promedio para dicha carrera: Sumatoria de las UV * Promedio por asignatura/Sumatoria del total
de UV por carrera.
Ejemplo del c�lculo del promedio:

*/

SELECT  B.NUMERO_CUENTA,
        INITCAP(A.NOMBRE||' '||A.APELLIDO) AS NOMBRE,
        C.CODIGO_CARRERA,
        D.NOMBRE_CARRERA
FROM TBL_PERSONAS A
INNER JOIN TBL_ALUMNOS B
ON (A.CODIGO_PERSONA = B.CODIGO_ALUMNO)
INNER JOIN TBL_CARRERAS_X_ALUMNOS C
ON (B.CODIGO_ALUMNO = C.CODIGO_ALUMNO)
INNER JOIN TBL_CARRERAS D
ON (C.CODIGO_CARRERA = D.CODIGO_CARRERA)
ORDER BY 1;


SELECT *
FROM TBL_HISTORIAL;


SELECT * 
FROM TBL_SECCION;
