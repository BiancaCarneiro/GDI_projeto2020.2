/*
Retorna desenvolvedora com jogo de maior preço
 
 Subconsulta Escalar com Tabela
*/
BEGIN

SELECT Desenvolvedora.Name
FROM Desenvolvedora
WHERE Desenvolvedora.ID in (
    SELECT a.ID
    FROM Jogo a
    WHERE a.preco = (SELECT MAX(b.preco) as media_preco
                      FROM Jogo b
                     )
    );
END


--Pega os nomes dos jogos que tem a mesma faixa etária que o jogo de id 112
SELECT NAME
FROM JOGO J
WHERE(j.car_faixa_etaria) = (SELECT car_faixa_etaria 
                            FROM JOGO
                            WHERE ID = 112);

