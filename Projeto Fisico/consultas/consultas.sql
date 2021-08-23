
--Junção interna
--Pega o nome do empregado e do seu chefe
SELECT a.name as "chefe", b.name as "subordinados"
FROM EMPREGADO a
INNER JOIN EMPREGADO b
ON a.cpf = b.cpf_chefe


--semi join
--Seleciona os empregados que são chefes de alguém
SELECT a.name as "Chefe"
FROM EMPREGADO a
WHERE EXISTS (SELECT 1 
              FROM EMPREGADO b
              WHERE b.cpf_chefe = a.cpf
            )


--anti join
--Seleciona os funcionários que não são chefes
SELECT a.name as "Nao eh chefe"
FROM EMPREGADO a
WHERE NOT EXISTS (SELECT 1 
                  FROM EMPREGADO b
                  WHERE b.cpf_chefe = a.cpf
                )


--where
--Seleciona a desenvolvedora que tem pelo menos um jogo
SELECT a.name as "Desenvolvedoras com jogos"
FROM DESENVOLVEDORA a
WHERE a.qtd_jogos > 0

--left outer join de desenvolvedora com jogos de preço maior que 10, ainda mostrando as devs que não estão na relação / order by
SELECT j.preco, j.name, d.name, d.qtd_jogos
FROM Desenvolvedora D LEFT OUTER JOIN Jogo J
ON J.ID = D.ID
	AND J.preco > 10
ORDER BY J.name


-- funcionarios contratados em ordem de contratação
SELECT Empregado.CPF,	Empregado.Name as "nome",Contrato.data_contrato
FROM Empregado INNER JOIN Contrato
ON Empregado.CPF = Contrato.CPF
ORDER BY Contrato.data_contrato asc
