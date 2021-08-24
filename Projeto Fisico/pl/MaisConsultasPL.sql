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
    UPDATE COMPRA c SET c.valor = c.valor*desconto
    WHERE c.email = :NEW.email AND c.id = :NEW.id_dev AND c.codigo = :new.codigo;
END;


-- AINDA FALTA TESTAR:


-- Funcao com SQL embutida e parametro
-- Pega a diferenca do salario dos funcionarios
create or replace function getDif(cpf1 in varchar2(11 CHAR), cpf2 in varchar2(11 CHAR))    
return number    
is     
  dif number;  
  sal1 number;
  sal2 number;  
begin    
    SELECT salario INTO sal1
    FROM SENIOR
    WHEre cpf = cpf1;

    SELECT salario INTO sal2
    FROM SENIOR
    WHEre cpf = cpf2;

    dif := ABS(sal1-sal2)
  return dif;    
end;


-- procedimento com parametros
-- cria uma compra
CREATE OR REPLACE PROCEDURE add_compra(email in VARCHAR2, id in NUMBER, codigo in NUMBER, valor in NUMBER, meio_de_pag IN VARCHAR2)
IS 
   BEGIN 
    insert into compra values(email, id, codigo, valor, meio_de_pag);
  END;
