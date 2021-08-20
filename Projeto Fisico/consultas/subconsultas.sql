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


--CONSUMIDORES QUE COMPRARAM ACIMA DA MEDIA

BEGIN

SELECT Email
FROM Consumidor
WHERE tabelaGastos.totalPago > (
    SELECT AVG(totalPago) as media
    FROM (
        SELECT Compra.Email, SUM(Compra.Valor) as totalPago
        FROM Compra
        GROUP BY Compra.Email
    ) as tabelaGastos
)
END


--primeiro funcionario
SELECT *
FROM Empregado
WHERE Empregado.CPF in (
    SELECT Contrato.CPF,Min(data_contrato) primeira
    FROM Contrato
    GROUP BY Contrato.CPF
    HAVING data_contrato = primeira
)
