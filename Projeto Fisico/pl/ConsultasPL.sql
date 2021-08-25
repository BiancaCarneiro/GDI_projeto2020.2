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


create or replace trigger  adicionaJOGOemDEV
    after insert on JOGO
    for each row
DECLARE 
    ID_DEV NUMBER;
begin
    UPDATE DESENVOLVEDORA d
    SET d.QTD_JOGOS = d.qtd_jogos +1
    WHERE :new.id = d.ID;
end;

-- Gatilho
-- Muda o valor da compra quando há promoção
-- com cursor
CREATE OR REPLACE TRIGGER checaValorCompra
    AFTER INSERT ON ELEGIVEL_PROM
    FOR EACH ROW
DECLARE 
    CURSOR cur_val is
        SELECT p.percent_desconto
        FROM PROMOCAO p
        WHERE :NEW.id = p.id;
    desconto NUMBER;
BEGIN
    dbms_output.put_line  (user || ' Tables in the database:'); 
    OPEN cur_val;
    LOOP
        FETCH cur_val into desconto;
        dbms_output.put_line(desconto); 
        EXIT WHEN cur_val%notfound;
    END LOOP;
    CLOSE cur_val;
    UPDATE COMPRA c SET c.valor = c.valor - c.valor*desconto
    WHERE c.email = :NEW.email AND c.id = :NEW.id_dev AND c.codigo = :new.codigo;
END;

-- sem cursor MAIS SIMPLES


CREATE OR REPLACE TRIGGER checaValorCompra
    AFTER INSERT ON ELEGIVEL_PROM
    FOR EACH ROW
DECLARE 
    desconto NUMBER;
BEGIN
    SELECT p.percent_desconto into desconto
    FROM PROMOCAO p
    WHERE :NEW.id = p.id;
    UPDATE COMPRA c SET c.valor = c.valor - c.valor*desconto
    WHERE c.email = :NEW.email AND c.id = :NEW.id_dev AND c.codigo = :new.codigo;
END;




-- Funcao com SQL embutida e parametro
-- Pega a diferenca do salario dos funcionarios
CREATE OR REPLACE FUNCTION getDif (cpf1 in varchar2, cpf2 in varchar2)    
RETURN NUMBER    
IS     
  dif number;  
  sal1 number;
  sal2 number;  
BEGIN    
    SELECT salario INTO sal1
    FROM SENIOR
    WHERE cpf = cpf1;

    SELECT salario INTO sal2
    FROM SENIOR
    WHERE cpf = cpf2;

    dif := ABS(sal1-sal2);
  RETURN dif;    
END;


-- consulta com a funcao: -> pega a diferenca dos salarios dos funcionarios
SELECT GETDIF(A.CPF, B.CPF), F.NAME AS FUNC1, G.NAME AS FUNC2
FROM SENIOR A, SENIOR B, EMPREGADO F, EMPREGADO G
WHERE A.CPF > B.CPF AND F.CPF = A.CPF AND G.CPF = B.CPF


-- procedimento com parametros
-- cria uma compra
CREATE OR REPLACE PROCEDURE add_compra(email in VARCHAR2, id in NUMBER, codigo in NUMBER, valor in NUMBER, meio_de_pag IN VARCHAR2)
IS 
   BEGIN 
    insert into compra values(email, id, codigo, valor, meio_de_pag);
  END;
