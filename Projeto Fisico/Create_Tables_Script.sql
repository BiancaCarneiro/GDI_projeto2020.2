-- DROP TABLE EMPREGADO;
-- DROP TABLE ESTAGIARIO;
-- DROP TABLE SENIOR;
-- DROP TABLE DESENVOLVEDORA;
-- DROP TABLE PROMOCAO;
-- DROP TABLE CONSUMIDOR;
-- DROP TABLE JOGO;
-- DROP TABLE CAR_GENEROS;
-- DROP TABLE COMPRA;
-- DROP TABLE ELEGIVEL_PROM;
-- DROP TABLE CONTRATO;

-- TRUNCATE TABLE ESTAGIARIO
-- TRUNCATE TABLE SENIOR
-- TRUNCATE TABLE CONTRATO
-- TRUNCATE TABLE EMPREGADO
-- TRUNCATE TABLE ELEGIVEL_PROM
-- TRUNCATE TABLE PROMOCAO
-- TRUNCATE TABLE COMPRA
-- TRUNCATE TABLE CONSUMIDOR
-- TRUNCATE TABLE CAR_GENEROS
-- TRUNCATE TABLE JOGO
-- TRUNCATE TABLE DESENVOLVEDORA

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