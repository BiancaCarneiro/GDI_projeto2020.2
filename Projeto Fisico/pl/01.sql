DECLARE
TYPE PESSOA IS RECORD
(
CPF VARCHAR2(5),
NOME VARCHAR2(11),
DATA_NASCIMENTO VARCHAR2(5)
);

PESSOA_1 PESSOA;
PESSOA_2 PESSOA;

BEGIN
PESSOA_1.CPF := '11999999999';
PESSOA_1.NOME := 'Matheus Oliveira';
PESSOA_1.DATA_NASCIMENTO := TO_DATE ('10-MAR-1998');

PESSOA_2.CPF := '22999999999';
PESSOA_2.NOME := 'Andre luna';
PESSOA_2.DATA_NASCIMENTO := TO_DATE ('10-FEB-2000');

dbms_output.put_line('PESSOA 1 cpf : '|| PESSOA_1.CPF);
dbms_output.put_line('PESSOA 1 nome : '|| PESSOA_1.NOME);
dbms_output.put_line('PESSOA 1 nascimento : '|| PESSOA_1.DATA_NASCIMENTO);

dbms_output.put_line('PESSOA 2 cpf : '|| PESSOA_2.CPF);
dbms_output.put_line('PESSOA 2 nome : '|| PESSOA_2.NOME);
dbms_output.put_line('PESSOA 2 nascimento : '|| PESSOA_2.DATA_NASCIMENTO);
END;