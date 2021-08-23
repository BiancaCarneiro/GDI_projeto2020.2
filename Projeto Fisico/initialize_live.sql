
create table EMPREGADO (  
  cpf           varchar2(11 CHAR),  
  name          varchar2(50) not null,  
  cpf_chefe     varchar2(11 CHAR) default null,
  constraint pk_empregado primary key (cpf),
  constraint fk_empregado_empregado foreign key (cpf_chefe)
                references EMPREGADO (cpf)
);
    
create table ESTAGIARIO (
  cpf           varchar2(11 CHAR),
  bolsa         number,
  faculdade     varchar2(60),
  constraint pk_estagiario primary key (cpf),
  constraint fk_estagiario_empregado foreign key (cpf)
                references EMPREGADO (cpf)
);
    
create table SENIOR (
  cpf           varchar2(11 CHAR),
  area          varchar2(50) not null,
  salario       number not null,
  constraint pk_senior primary key (cpf),
  constraint fk_senior_empregado foreign key (cpf)
                references EMPREGADO (cpf)
);
    
create table DESENVOLVEDORA (
  id           	  number,
  name            varchar2(50) not null,
  qtd_jogos       number check (qtd_jogos >= 0),
  constraint pk_desenvolvedora primary key (id)
);
    
create table PROMOCAO (
  id                  	 number,
  percent_desconto       number check (percent_desconto > 0 and percent_desconto < 1) not null,
  constraint pk_promocao primary key (id)
);

create table CONSUMIDOR (
  email          varchar2(50),
  name           varchar2(50),
  username        varchar2(50) not null,
  constraint pk_consumidor primary key (email)
);

create table JOGO (
  id                number,
  codigo            number,
  name              varchar2(50) not null,
  preco             number,
  car_faixa_etaria  number,
  constraint pk_jogo primary key (id, codigo),
  constraint fk_jogo_desenvolvedora foreign key (id)
                references DESENVOLVEDORA (id)
);

create table CAR_GENEROS (
  id             	number,
  codigo            number,
  generos           varchar2(50),
  constraint pk_car_generos primary key (id, codigo, generos),
  constraint fk_car_generos_jogo foreign key (id, codigo)
                references JOGO (id, codigo)
);

create table COMPRA (
  email         varchar2(50),
  id        	number,
  codigo        number,    
  valor         number,    
  meio_de_pag   varchar(50) not null,
  constraint pk_compra primary key (email, id, codigo),
  constraint fk_compra_consumidor foreign key (email)
                references CONSUMIDOR (email),
  constraint fk_compra_jogo foreign key (id, codigo)
                references JOGO (id, codigo)
);


create table ELEGIVEL_PROM (
 id          	number,
 email          varchar2(50),
 id_dev         number,
 codigo         number,
 constraint pk_elegivel_prom primary key (id, email, id_dev, codigo),
 constraint fk_elegivel_prom_promocao foreign key (id)
                references PROMOCAO (id),
 constraint fk_elegivel_prom_compra foreign key (email, id_dev, codigo)
                references COMPRA (email, id, codigo) 
);

create table CONTRATO (
  cpf                varchar2(11 CHAR),
  id            	 number,
  data_contrato      date,
  constraint pk_contrato primary key (cpf, id, data_contrato),
  constraint fk_contrato_empregado foreign key (cpf)
                references EMPREGADO (cpf),
  constraint fk_contrato_desenvolvedora foreign key (id)
                references DESENVOLVEDORA (id)
);

insert into EMPREGADO (cpf, name) values ('00000000000', 'Andre');
insert into EMPREGADO (cpf, name, cpf_chefe) values ('22222222222', 'Bianca', '00000000000');
insert into EMPREGADO (cpf, name) values ('33333333333', 'Caio');
insert into EMPREGADO (cpf, name) values ('44444444444', 'Rod');
insert into EMPREGADO (cpf, name) values ('99999999999', 'Carla');
insert into EMPREGADO (cpf, name, cpf_chefe) values ('55555555555', 'Rodrigo','99999999999');
insert into EMPREGADO (cpf, name) values ('66666666666', 'Pedro');
insert into EMPREGADO (cpf, name) values ('77777777777', 'Aline');
insert into EMPREGADO (cpf, name) values ('88888888888', 'Felicia');

insert into ESTAGIARIO (cpf, bolsa, faculdade) values ('33333333333', 2000, 'UFPE');
insert into ESTAGIARIO (cpf, bolsa, faculdade) values ('77777777777', 1500, 'Unicap');
insert into ESTAGIARIO (cpf, bolsa, faculdade) values ('55555555555', 1800, 'Fafire');

insert into SENIOR (cpf, area, salario) values ('44444444444', 'TI', 5000);
insert into SENIOR (cpf, area, salario) values ('66666666666', 'Gerencia', 8000);
insert into SENIOR (cpf, area, salario) values ('99999999999', 'TI', 5000);
insert into SENIOR (cpf, area, salario) values ('88888888888', 'Limpeza', 1500);

insert into DESENVOLVEDORA (id, name, qtd_jogos) values (123, 'Globus', 101);
insert into DESENVOLVEDORA (id, name, qtd_jogos) values (112, 'Lobo Solitario', 23);
insert into DESENVOLVEDORA (id, name, qtd_jogos) values (892, 'Azul Marinho', 30);
insert into DESENVOLVEDORA (id, name, qtd_jogos) values (222, 'TecMaster', 32);
insert into DESENVOLVEDORA (id, name, qtd_jogos) values (877, 'RastaGames', 101);
insert into DESENVOLVEDORA (id, name, qtd_jogos) values (189, 'Devinstron', 32);
insert into DESENVOLVEDORA (id, name, qtd_jogos) values (111, 'Seila', 2);

insert into PROMOCAO (id, percent_desconto) values (3333, 0.1);
insert into PROMOCAO (id, percent_desconto) values (9876, 0.2);
insert into PROMOCAO (id, percent_desconto) values (9283, 0.3);
insert into PROMOCAO (id, percent_desconto) values (4384, 0.4);
insert into PROMOCAO (id, percent_desconto) values (5454, 0.5);

insert into CONSUMIDOR (email, name, username) values ('aaav@cin.ufpe.br', 'Andre Valenca', 'aaav');
insert into CONSUMIDOR (email, name, username) values ('boy@yahoo.com', 'Jackson Pollock', 'boy');
insert into CONSUMIDOR (email, name, username) values ('girl@bol.com', 'Simone de Beauvoir', 'girl');
insert into CONSUMIDOR (email, name, username) values ('vampirodoidao89@hotmail.com', 'Raul Seixas', 'vampirodoidao89');
insert into CONSUMIDOR (email, name, username) values ('vamorebolar@gmail.com', 'Carla Perez', 'vamorebolar');

insert into JOGO (id, codigo, name, preco, car_faixa_etaria) values (123, 10, 'Death in The Nile', 20, 0);
insert into JOGO (id, codigo, name, preco, car_faixa_etaria) values (123, 20, 'Vampire Days', 100, 12);
insert into JOGO (id, codigo, name, preco, car_faixa_etaria) values (123, 30, 'The Hole of Destiny', 1.99, 12);
insert into JOGO (id, codigo, name, preco, car_faixa_etaria) values (123, 40, 'Cringe Worthy', 150, 18);
insert into JOGO (id, codigo, name, preco, car_faixa_etaria) values (112, 44, 'King of Maranguape', 88.72, 0);
insert into JOGO (id, codigo, name, preco, car_faixa_etaria) values (892, 56, 'Beasts Unleashed', 11, 16);
insert into JOGO (id, codigo, name, preco, car_faixa_etaria) values (892, 33, 'Sad Ghost, Cry Baby', 77, 12);
insert into JOGO (id, codigo, name, preco, car_faixa_etaria) values (877, 98, 'Jamming Tunes', 89, 0);
insert into JOGO (id, codigo, name, preco, car_faixa_etaria) values (111, 27, 'Frozen in a Pool With My Hands on My Pockets', 9.99, 14);

insert into CAR_GENEROS (id, codigo, generos) values (123, 10, 'Fantasia');
insert into CAR_GENEROS (id, codigo, generos) values (112, 44, 'Horror');
insert into CAR_GENEROS (id, codigo, generos) values (892, 33, 'Luta');
insert into CAR_GENEROS (id, codigo, generos) values (877, 98, 'Fantasia');
insert into CAR_GENEROS (id, codigo, generos) values (111, 27, 'Luta');

insert into COMPRA (email, id, codigo, valor, meio_de_pag) values ('aaav@cin.ufpe.br', 123, 10, 20, 'Cartao de Credito');
insert into COMPRA (email, id, codigo, valor, meio_de_pag) values ('boy@yahoo.com', 112, 44, 88.72, 'Debito Online');
insert into COMPRA (email, id, codigo, valor, meio_de_pag) values ('girl@bol.com', 877, 98, 89,  'PayPal');
insert into COMPRA (email, id, codigo, valor, meio_de_pag) values ('girl@bol.com', 892, 56, 11,  'PayPal');
insert into COMPRA (email, id, codigo, valor, meio_de_pag) values ('girl@bol.com', 112, 44, 88.72, 'Debito Online');
insert into COMPRA (email, id, codigo, valor, meio_de_pag) values ('vampirodoidao89@hotmail.com', 892, 33, 77, 'PayPal');
insert into COMPRA (email, id, codigo, valor, meio_de_pag) values ('vampirodoidao89@hotmail.com', 123, 10, 20, 'PayPal');
insert into COMPRA (email, id, codigo, valor, meio_de_pag) values ('vamorebolar@gmail.com', 111, 27, 9.99, 'Pagou com boas energias');

insert into ELEGIVEL_PROM (id, email, id_dev, codigo) values (3333, 'aaav@cin.ufpe.br', 123, 10);
insert into ELEGIVEL_PROM (id, email, id_dev, codigo) values (9876, 'boy@yahoo.com', 112, 44);
insert into ELEGIVEL_PROM (id, email, id_dev, codigo) values (9283, 'vampirodoidao89@hotmail.com', 892, 33);
insert into ELEGIVEL_PROM (id, email, id_dev, codigo) values (4384, 'vamorebolar@gmail.com', 111, 27);

insert into CONTRATO (cpf, id, data_contrato) values ('00000000000', 123,TO_DATE('2020-10-20','YYYY-MM-DD'));
insert into CONTRATO (cpf, id, data_contrato) values ('55555555555', 112,TO_DATE('2019-09-11','YYYY-MM-DD'));
insert into CONTRATO (cpf, id, data_contrato) values ('22222222222', 112,TO_DATE('2018-04-12','YYYY-MM-DD'));
insert into CONTRATO (cpf, id, data_contrato) values ('99999999999', 892,TO_DATE('2021-11-11','YYYY-MM-DD'));
insert into CONTRATO (cpf, id, data_contrato) values ('33333333333', 222,TO_DATE('2011-01-22','YYYY-MM-DD'));
