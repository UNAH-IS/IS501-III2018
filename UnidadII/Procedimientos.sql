--Procedimientos almacenados: 
--PL/SQL

--Tipos de procedimientos:
--*Anonimos:
    --No tienen nombre
    --Las instrucciones se ejecutan en el momento
    --No se guardan en la base de datos
    --Son conocidos como bloques anonimos y sus instrucciones deben ir entre BEGIN y END;
    

    
    BEGIN
        dbms_output.put_line('Hola mundo');
    END;
    
    
    DECLARE
        --DECLARACION DE VARIABLES
        NOMBRE VARCHAR2(200):='JUAN';
        APELLIDO VARCHAR2(200);
        CORREO VARCHAR2(200);
    BEGIN
        APELLIDO := 'PEREZ';
        SELECT 'JPEREZ@GMAIL.COM' INTO CORREO
        FROM DUAL;
        dbms_output.put_line('Hola '||NOMBRE||' '||APELLIDO||'('||CORREO||')');
    END;
    
    
    DECLARE
        I INTEGER:=0;
    BEGIN
        WHILE I<10 LOOP
            dbms_output.put_line('iteracion ' || i);
            I:=I+1;
        END LOOP;
    END;
    
    
    DECLARE
        I INTEGER:=0;
    BEGIN
        WHILE I<1000000 LOOP
            INSERT INTO TMP(CAMPO) VALUES (I);
            I:=I+1;
        END LOOP;
    END;
    
    
    SELECT COUNT(*) FROM TMP;
    
    ROLLBACK;
    --Habilitar la consola de oracle
    SET SERVEROUTPUT ON;
    
    SELECT 'JPEREZ@GMAIL.COM' 
        FROM DUAL;
    
        
--*Procedimientos con nombre
    --Si tienen nombre
    --Las instrucciones NO se ejecutan en el momento, se tienen que ejecutar luego al llamar al procedimiento almacenado
    --Si se guardan en la base de datos
    
    CREATE OR REPLACE PROCEDURE NOMBRE_PROCEDIMIENTO AS
    --DECLARACION DE VARIABLES
    BEGIN
        NULL;--CUERPO DEL PROCEDIMIENTO
    END;
    
    CREATE OR REPLACE PROCEDURE P_HOLA_MUNDO AS
    --DECLARACION DE VARIABLES
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Hola Mundo');
    END;
    
    
    --EJECUCION DE UN PROCEDIMIENTO ALMACENADO
    
    --UTILIZANDO EXECUTE
    EXECUTE P_HOLA_MUNDO;
    
    --UTILIZANDO CALL
    CALL P_HOLA_MUNDO();
    
    --DENTRO DE UN BLOQUE ANONIMO
    BEGIN
        P_HOLA_MUNDO;
    END;

    CREATE OR REPLACE PROCEDURE P_MOSTRAR_MENSAJE(NOMBRE VARCHAR2) AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Hola '||NOMBRE);
    END;
    
    
    EXECUTE P_MOSTRAR_MENSAJE('PEDRO');


CREATE OR REPLACE PROCEDURE P_AGREGAR_EMPLEADO (
            p_first_name in varchar2,
            p_last_name in varchar2,
            p_email in varchar2,
            p_phone_number in varchar2,
            p_hire_date in date,
            p_job_id in varchar2,
            p_salary in number,
            p_commission_pct in number,
            p_manager_id in integer,
            p_department_id in integer,
            p_mensaje_validacion out varchar,
            p_codigo_resultado out integer, --1 es correcto y 0 es incorrecto
            p_codigo_empleado_agregado out integer
)AS
BEGIN
    IF P_FIRST_NAME IS NULL OR P_LAST_NAME IS NULL THEN
        p_mensaje_validacion:='NOMBRE Y APELLIDO OBLIGATORIO';
        p_codigo_resultado := 0;
        RETURN;
    END IF;
    p_codigo_empleado_agregado:=EMPLOYEES_SEQ.NEXTVAL;
    INSERT INTO employees (
        employee_id,
        first_name,
        last_name,
        email,
        phone_number,
        hire_date,
        job_id,
        salary,
        commission_pct,
        manager_id,
        department_id
    ) VALUES (
        p_codigo_empleado_agregado,
        p_first_name,
        p_last_name,
        p_email,
        p_phone_number,
        p_hire_date,
        p_job_id,
        p_salary,
        p_commission_pct,
        p_manager_id,
        p_department_id
    );
    commit;
    p_mensaje_validacion:='REGISTRO ALMACENADO CON EXITO';
    p_codigo_resultado:=1;
EXCEPTION WHEN OTHERS THEN
    P_MENSAJE_VALIDACION:=SQLERRM;
    p_codigo_resultado:=0;
    rollback;
END;


/*p_first_name varchar2,
            p_last_name varchar2,
            p_email varchar2,
            p_phone_number varchar2,
            p_hire_date date,
            p_job_id varchar2,
            p_salary number,
            p_commission_pct varchar2,
            p_manager_id integer,
            p_department_id integer*/
execute p_agregar_empleado(null, null,'jramirez@gmail.com','111110',to_date('12-12-2012','dd-mm-yyyy'),'AC_MGR',22222,0.5,100,20);

select * from employees;



select *
from employees
where employee_id = 211;


--PARA PROBAR EL RESULTADO DE UN PARAMETRO DE SALIDA SE DEBE EJECUTAR EN UN BLOQUE ANONIMO
DECLARE
    V_MENSAJE_RESULTADO VARCHAR2(200);
    V_CODIGO_RESULTADO INTEGER;
    V_CODIGO_EMPLEADO INTEGER;
BEGIN
    p_agregar_empleado('MATUSALEN', 'PEREZ','matusalen@gmail.com','111110',to_date('12-12-2012','dd-mm-yyyy'),'AC_MGR',22222,0.5,100,20, V_MENSAJE_RESULTADO, V_CODIGO_RESULTADO, V_CODIGO_EMPLEADO);
    DBMS_OUTPUT.PUT_LINE('RESULTADO: ' || V_MENSAJE_RESULTADO||', CODIGO DEL RESULTADO: '||V_CODIGO_RESULTADO||', EMPLEADO AGREGADO: '||V_CODIGO_EMPLEADO);
END;



SET SERVEROUTPUT ON;

DECLARE 
    V_RESULTADO VARCHAR2(200);
BEGIN
    SELECT FIRST_NAME INTO V_RESULTADO
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    DBMS_OUTPUT.PUT_LINE('NOMBRE: ' ||V_RESULTADO);
END;


DECLARE 
    V_CANTIDAD_EMPLEADOS VARCHAR2(200);
    V_SALARIO_MAX NUMBER;
    V_SALARIO_MIN NUMBER;
BEGIN
    SELECT COUNT(*),MAX(SALARY),MIN(SALARY) 
    INTO V_CANTIDAD_EMPLEADOS,V_SALARIO_MAX,V_SALARIO_MIN 
    FROM EMPLOYEES;
    DBMS_OUTPUT.PUT_LINE('EMPLEADOS: ' ||V_CANTIDAD_EMPLEADOS);
    DBMS_OUTPUT.PUT_LINE('MAXIMO: ' ||V_SALARIO_MAX);
    DBMS_OUTPUT.PUT_LINE('MINIMO: ' ||V_SALARIO_MIN);
END;

--LAS INSTRUCCIONES DDL NO SE PUEDEN EJECUTAR DIRECTAMENTE, ES NECESARIO
--UTILIZAR EXECUTE IMMEDIATE
DECLARE
    I INTEGER:=0;
BEGIN
    WHILE I<10 LOOP
        EXECUTE IMMEDIATE 'CREATE TABLE TMP'||I||'(CAMPO1 VARCHAR2(100))';
        I:=I+1;
    END LOOP;
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR AL CREAR LAS TABLAS');
END;



--FUNCIONES: SON COMO PROCEDIMIENTOS ALMACENADOS, PERO OBLIGATORIAMENTE DEBEN RETORNAR UN VALOR.

CREATE OR REPLACE FUNCTION F_SUMAR(A INTEGER, B INTEGER) RETURN INTEGER AS
    RESULTADO INTEGER;
BEGIN
    RESULTADO:=A+B;
    RETURN RESULTADO;
END;



BEGIN
    DBMS_OUTPUT.PUT_LINE('SUMA: '||F_SUMAR(5,4));
END;




SELECT ROUND(12.45645654,2)
FROM DUAL;

SELECT F_SUMAR(10,20) AS RESULTADO
FROM DUAL;






--TRIGGERS (DISPARADOR): SON PROCEDIMIENTOS QUE SE EJECUTAN DEPENDIENDO DE EVENTOS OCURRIDOS EN LA BD.



