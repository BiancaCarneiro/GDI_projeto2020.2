--group by/having
--Pega as desenvolvedoras que tem mais jogos que a media
SELECT a.name as 'Nome', AVG(a.qtd_jogos)
FROM DESENVOLVEDORA
GROUP BY a.name
HAVING a.qtd_jogos > AVG(a.qtd_jogos)


--Junção interna
--Pega o nome do empregado e do seu chefe
SELECT a.nome as 'funcionario', b.name as 'chefes'
FROM EMPREGADO a
INNER JOIN EMPREGADO b
ON a.cpf = b.cpf_chefe


--semi join
--Seleciona os empregados que são chefes de alguém
SELECT a.name as 'Chefe'
FROM EMPREGADO a
WHERE EXISTS (SELECT 1 
              FROM EMPREGADO b
              WHERE b.cpf_chefe = a.cpf
            )


--anti join
--Seleciona os funcionários que não são chefes
SELECT a.name as 'Nao eh chefe'
FROM EMPREGADO a
WHERE NOT EXISTS (SELECT 1 
                  FROM EMPREGADO b
                  WHERE b.cpf_chefe = a.cpf
                )


--where
--Seleciona a desenvolvedora que tem pelo menos um jogo
SELECT a.name as 'Desenvolvedoras com jogos'
FROM DESENVOLVEDORA a
WHERE a.qtd_jogos > 0