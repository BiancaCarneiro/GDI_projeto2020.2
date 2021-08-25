-- Inner-join
-- Pega o nome do empregado e do seu chefe
SELECT a.name as "chefe", b.name as "subordinados"
FROM EMPREGADO a
INNER JOIN EMPREGADO b
ON a.cpf = b.cpf_chefe


-- Semi-join
-- Seleciona os empregados que são chefes de alguém
SELECT a.name as "Chefe"
FROM EMPREGADO a
WHERE EXISTS (SELECT 1 
              FROM EMPREGADO b
              WHERE b.cpf_chefe = a.cpf
            )


-- Anti-join
-- Seleciona os funcionários que não são chefes
SELECT a.name as "Nao eh chefe"
FROM EMPREGADO a
WHERE NOT EXISTS (SELECT 1 
                  FROM EMPREGADO b
                  WHERE b.cpf_chefe = a.cpf
                )


-- Left outer join de desenvolvedora com jogos de preço maior que 10,
-- ainda mostrando as devs que não estão na relação / order by
SELECT j.preco, j.name, d.name, d.qtd_jogos
FROM Desenvolvedora D LEFT OUTER JOIN Jogo J
ON J.ID = D.ID
	AND J.preco > 10
ORDER BY J.name


-- Operação conjunto.
-- Sempre vai devolver nada, porque são disjuntos
SELECT cpf from estagiario
INTERSECT
SELECT cpf from senior


-- Retorna desenvolvedora com jogo de maior preço
-- Subconsulta Escalar com Tabela
SELECT Desenvolvedora.Name
FROM Desenvolvedora
WHERE Desenvolvedora.ID in (
    SELECT a.ID
    FROM Jogo a
    WHERE a.preco = (SELECT MAX(b.preco) as max_preco
                      FROM Jogo b
                     )
    );


-- Pega todos os jogos que tenham o mesmo preço
-- e mesma faixa etária que um determinado jogo.
-- Subconsulta de linha
SELECT J.name
FROM jogo J
WHERE (J.PRECO, J.CAR_FAIXA_ETARIA) = (SELECT JR.PRECO, JR.CAR_FAIXA_ETARIA
                                       FROM jogo JR
                                       WHERE JR.codigo = 27 AND JR.id = 111)


-- Group by:
-- Pega a soma dos valores de cada compra por email
-- e só exibe aqueles maiores de 80
SELECT Compra.Email, SUM(Compra.Valor) as totalPago
FROM Compra
GROUP BY Compra.Email
HAVING SUM(Compra.Valor) > 80;