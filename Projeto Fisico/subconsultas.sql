/*
Desenvolvedoras
 que fizeram 
 jogos com preco acima da media
*/
BEGIN

SELECT Nome
FROM Desenvolvedora
WHERE Desenvolvedora.ID in (
    SELECT ID,codigo, MAX(preco) as maior_preco
    FROM Jogo
    GROUP BY ID,codigo)
    HAVING Jogo.preco = maior_preco

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