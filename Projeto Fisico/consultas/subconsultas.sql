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



--Group by: Pega o valor total da compra
SELECT Compra.Email, SUM(Compra.Valor) as totalPago
FROM Compra
GROUP BY Compra.Email
HAVING SUM(Compra.Valor) > 80;



--Pega os nomes dos jogos que tem a mesma faixa etária que o jogo de id 112
--Subconsulta de linha
SELECT NAME
FROM JOGO J
WHERE(j.car_faixa_etaria) = (SELECT car_faixa_etaria 
                            FROM JOGO
                            WHERE ID = 112);

