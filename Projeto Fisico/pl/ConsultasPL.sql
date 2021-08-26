-- PROCEDURE

-- Procedure parametrizado, sem retorno, com uso de cursor
-- (lista todos os jogos de uma determinada desenvolvedora)
CREATE OR REPLACE PROCEDURE list_jogos_des (desnum number) IS
    -- insere o codigo da desenvolvedora
    des_name desenvolvedora.name%type;
    jogo_des jogo.name%type;
    i number := 1;
    CURSOR cur IS
        select name from jogo where id = desnum;
BEGIN
    select name into des_name from desenvolvedora where id = desnum;
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

-- Função parametrizado com retorno de número
-- Devolve o numero de jogos que um email comprou
CREATE OR REPLACE FUNCTION checa_compras (emailAtual varchar2) RETURN NUMBER IS
    qtdC number;
BEGIN
    select count(*) into qtdC from jogo j
    where (j.id, j.codigo) in
                        (select c.id, c.codigo from compra c
                        where c.email = emailAtual);
    return qtdC;
END;

-- Chamando função
SET SERVEROUTPUT ON
BEGIN
    DBMS_OUTPUT.PUT_LINE(checa_compras('aaav@cin.ufpe.br'));
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


-- TRIGGERS

-- Quando um jogo novo eh inserido,
-- a quantidade de jogos eh aumentada
CREATE OR REPLACE trigger adicionaJOGOemDEV
    AFTER INSERT on JOGO
    for each row
DECLARE 
    ID_DEV NUMBER;
    qtd NUMBER;
BEGIN
    select qtd_jogos into qtd from desenvolvedora de where :new.id = de.ID;
    IF qtd IS NULL THEN
        UPDATE DESENVOLVEDORA d
        SET d.qtd_jogos = 1
        WHERE :new.id = d.ID;
    ELSE
        UPDATE DESENVOLVEDORA d
        SET d.qtd_jogos = d.qtd_jogos + 1
        WHERE :new.id = d.ID;
    END IF;
END;


-- Aplica a promoção no valor da compra
-- (atualiza o valor de acordo com o desconto)
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
