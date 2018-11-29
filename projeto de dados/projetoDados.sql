﻿
CREATE SEQUENCE produto_idprod_seq;

CREATE TABLE produto (
                idprod INTEGER NOT NULL DEFAULT nextval('produto_idprod_seq'),
                nome VARCHAR(80) NOT NULL,
                qtdeest INTEGER NOT NULL,
                qtdemin INTEGER NOT NULL,
                precovenda NUMERIC(6,2) NOT NULL,
                CONSTRAINT idprod PRIMARY KEY (idprod)
);


ALTER SEQUENCE produto_idprod_seq OWNED BY produto.idprod;

CREATE SEQUENCE estado_idestado_seq_1;

CREATE TABLE estado (
                idestado INTEGER NOT NULL DEFAULT nextval('estado_idestado_seq_1'),
                nome VARCHAR(50) NOT NULL,
                sigla CHAR(2) NOT NULL,
                CONSTRAINT idestado PRIMARY KEY (idestado)
);


ALTER SEQUENCE estado_idestado_seq_1 OWNED BY estado.idestado;

CREATE SEQUENCE cidade_idcidade_seq;

CREATE TABLE cidade (
                idcidade INTEGER NOT NULL DEFAULT nextval('cidade_idcidade_seq'),
                nome VARCHAR(50) NOT NULL,
                idestado INTEGER NOT NULL,
                CONSTRAINT idcidade PRIMARY KEY (idcidade)
);


ALTER SEQUENCE cidade_idcidade_seq OWNED BY cidade.idcidade;

CREATE SEQUENCE pessoa_idpessoa_seq;

CREATE TABLE pessoa (
                idpessoa INTEGER NOT NULL DEFAULT nextval('pessoa_idpessoa_seq'),
                nome VARCHAR(100) NOT NULL,
                telefone VARCHAR(14),
                endereco VARCHAR,
                email VARCHAR(255),
                idcidade INTEGER NOT NULL,
                CONSTRAINT idpessoa PRIMARY KEY (idpessoa)
);


ALTER SEQUENCE pessoa_idpessoa_seq OWNED BY pessoa.idpessoa;

CREATE TABLE fornecedor (
                idPessoaFornecedor INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                CONSTRAINT idpessoafornecedor PRIMARY KEY (idPessoaFornecedor)
);


CREATE TABLE cliente (
                idPessoaCliente INTEGER NOT NULL,
                cpf CHAR(11) NOT NULL,
                rg VARCHAR(15) NOT NULL,
                dtNasc VARCHAR NOT NULL,
                CONSTRAINT idpessoacliente PRIMARY KEY (idPessoaCliente)
);


CREATE SEQUENCE movimento_idmov_seq;

CREATE TABLE movimento (
                idmov INTEGER NOT NULL DEFAULT nextval('movimento_idmov_seq'),
                dtvenda DATE NOT NULL,
                precototal NUMERIC(6,2),
                idfornecedor INTEGER,
                idcliente INTEGER,
                CONSTRAINT idmov PRIMARY KEY (idmov)
);


ALTER SEQUENCE movimento_idmov_seq OWNED BY movimento.idmov;

CREATE TABLE itens_mov (
                idmov_mov INTEGER NOT NULL,
                idprod_mov INTEGER NOT NULL,
                qtde INTEGER NOT NULL,
                preco NUMERIC(6,2) NOT NULL,
                CONSTRAINT iditens_mov PRIMARY KEY (idmov_mov, idprod_mov)
);


ALTER TABLE itens_mov ADD CONSTRAINT idprod_itens_venda_fk
FOREIGN KEY (idprod_mov)
REFERENCES produto (idprod)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cidade ADD CONSTRAINT estado_cidade_fk
FOREIGN KEY (idestado)
REFERENCES estado (idestado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pessoa ADD CONSTRAINT cidade_pessoa_fk
FOREIGN KEY (idcidade)
REFERENCES cidade (idcidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cliente ADD CONSTRAINT pessoa_cliente_fk
FOREIGN KEY (idPessoaCliente)
REFERENCES pessoa (idpessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fornecedor ADD CONSTRAINT pessoa_fornecedor_fk
FOREIGN KEY (idPessoaFornecedor)
REFERENCES pessoa (idpessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE movimento ADD CONSTRAINT fornecedor_idvend_fk
FOREIGN KEY (idcliente)
REFERENCES fornecedor (idPessoaFornecedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE movimento ADD CONSTRAINT cliente_idvend_fk
FOREIGN KEY (idfornecedor)
REFERENCES cliente (idPessoaCliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE itens_mov ADD CONSTRAINT idvend_itens_venda_fk
FOREIGN KEY (idmov_mov)
REFERENCES movimento (idmov)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

INSERT INTO estado(nome, sigla) VALUES
('PARANÁ','PR');

INSERT INTO cidade(nome,idestado) VALUES
('Marilena', 1);


INSERT INTO pessoa(nome,telefone, endereco, email, idcidade) VALUES
('João', 'rua Tal A','34421515', 'joão@gmail.com',1),
('maria', 'rua Tal B', '34534343','maria@gmail.com',1);

INSERT INTO cliente(idPessoaCliente, cpf, rg, dtNasc) VALUES
(1,'12312312312','12312312','2000-10-01');

INSERT INTO fornecedor(idpessoaFornecedor, cnpj) VALUES
(2,'45645645');

INSERT INTO movimento(dtvenda, precototal, idfornecedor, idcliente) VALUES /*um dos id é null, pois ou é cliente, ou fornecedor*/
('2018-08-05','4.00',1,NULL), /*PRIMEIRO MOVIMENTO FOI UMA COMPRA DO FORNECEDOR*/
('2016-05-02','6.00',NULL,2); /*SEGUNDO MOVIMENTO FOI UMA VENDA PARA CLIENTE*/

INSERT INTO produto(nome,qtdeest,qtdemin,precovenda) VALUES
('cerveja',60,20,'2.00'),
('chiclete',70,15,'0.10');

INSERT INTO itens_mov(idmov_mov,idprod_mov,qtde,preco) VALUES
(1,1,20,'40.00'),
(1,2,10,'1.00'),
(2,1,2,'4.00'),
(2,2,1,'0.10');












/*testes de select-----------------*/
SELECT * 
FROM pessoa INNER JOIN cliente
ON pessoa.idpessoa = cliente.idPessoaCliente;

SELECT * 
FROM pessoa INNER JOIN fornecedor
ON pessoa.idpessoa = fornecedor.idPessoaFornecedor;



