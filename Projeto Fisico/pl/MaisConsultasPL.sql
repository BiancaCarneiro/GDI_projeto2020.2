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
create or replace trigger checaValorCompra
    after insert on ELEGIVEL_PROM
    for each row
declare 
    desconto NUMBER;
    cursor cur_val is (
        SELECT p.percent_desconto
        FROM PROMOCAO p
        WHERE new.id = p.id 
    );
begin
    open cur_val;
    loop
        fetch cur_val into desconto;
        EXIT WHEN cur_val%notfound;
    UPDATE COMPRA c;
    SET c.valor = c.valor*desconto;
    WHERE :new.(email, id, codigo) = c.(email, id, codigo);
end;

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