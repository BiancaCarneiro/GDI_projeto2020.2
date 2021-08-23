-- CONSULTAS PL ANÔNIMAS

-- Declarando variável do tipo linha, atribuindo-lhe valores
-- e imprimindo um deles, concatenando com texto
SET SERVEROUTPUT ON
DECLARE
    -- declaracao de variavel
    reg_estagiario estagiario%ROWTYPE;
BEGIN
    reg_estagiario.cpf := '09302028488';
    reg_estagiario.bolsa := 2000;
    reg_estagiario.faculdade := 'UFPE';
    DBMS_OUTPUT.PUT_LINE('CPF: '|| reg_estagiario.cpf);
END;

-- Imprime quantidade de empregados usando select-into para
-- inserir valor em variável a partir de consulta
SET SERVEROUTPUT ON
DECLARE
    qtd_emp number;
BEGIN
    select count(CPF) into qtd_emp from empregado;
    DBMS_OUTPUT.PUT_LINE('Qtd de empregados: '|| qtd_emp);
END;

-- &caractere pega input do usuário. Esta consulta
-- imprime o caractere inserido em minúscula
SET SERVEROUTPUT ON
DECLARE
    x CHAR(2) := LOWER('&caractere');
BEGIN
    DBMS_OUTPUT.PUT_LINE('virando maiuscula: '|| x);
END;

-- PROCEDURES

-- Procedure parametrizado, sem retorno, com uso de cursor
-- (lista todos os jogos de uma determinada desenvolvedora)
create or replace PROCEDURE list_jogos_des (desnum number) IS
    -- insere o codigo da desenvolvedora
    id_des desenvolvedora.id%type := (desnum);
    des_name desenvolvedora.name%type;
    jogo_des jogo.name%type;
    i number := 1;
    CURSOR cur IS
        select name from jogo where id = id_des;
BEGIN
    select MAX(name) into des_name from desenvolvedora where id = id_des;
    OPEN cur;
    LOOP
        FETCH cur into jogo_des;
        EXIT WHEN cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Jogo ' || i || ' da desenvolvedora '|| des_name || ': ' || jogo_des);
        i := i + 1;
    END LOOP;
    CLOSE cur;
END;

-- Chamando procedure
SET SERVEROUTPUT ON
BEGIN
    list_jogos_des(123);
END;


-- FUNÇÕES

-- Função com retorno de número e uso de exceção
-- (devolve todos os consumidores cadastrados no steam)
create or replace FUNCTION qtd_consumidores RETURN NUMBER IS
    qtdC number;
BEGIN
    select COUNT(email) into qtdC from consumidor;
    return qtdC;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            return null;
END;

-- Chamando função

SET SERVEROUTPUT ON
BEGIN
    DBMS_OUTPUT.PUT_LINE(qtd_consumidores);
END;