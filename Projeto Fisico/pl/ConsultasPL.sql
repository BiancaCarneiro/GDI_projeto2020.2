--Trigger para adicionar em qtd jogos quando um jogo for inserido

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
