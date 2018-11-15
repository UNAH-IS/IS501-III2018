/*

SELECT X
FROM Y
WHERE Z;
X: (Un solo campo, un solo registro).
Y: (Hay que tener cuidado al momento de realizar cruces, Puede retornar muchas filas y muchas columnas)
Z: (Un solo campo y varios registros (IN) ó Un solo campo, un solo registro(=,>.<))

*/


--Obtener el porcentaje de presupuesto relacionado a salarios por empleado.
--Formula: (salario por empleado/Total de salarios de la empresa)* 100
SELECT SUM(PORCENTAJE) TOTAL
FROM (
    SELECT EMPLOYEE_ID,FIRST_NAME, 
            100*SALARY/
            (
                SELECT SUM(SALARY) AS SALARY
                FROM EMPLOYEES
            ) AS PORCENTAJE
    FROM EMPLOYEES
);



--Obtener el empleado que gana mas dinero

SELECT SALARY
FROM EMPLOYEES;

SELECT *
FROM EMPLOYEES 
WHERE SALARY = (
            SELECT MAX(SALARY)
            FROM EMPLOYEES
        );
        
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (
    SELECT SALARY
    FROM EMPLOYEES 
    WHERE SALARY BETWEEN 10000 AND 20000
);

SELECT *
FROM EMPLOYEES
WHERE SALARY IN (
17000,
12008,
11000,
14000,
13500,
12000,
11000,
10500,
10000,
10000,
10500,
11500,
10000,
11000,
13000,
10000,
12008
);