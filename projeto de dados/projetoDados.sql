﻿
CREATE SEQUENCE public.produto_idprod_seq;

CREATE TABLE public.produto (
                idprod INTEGER NOT NULL DEFAULT nextval('public.produto_idprod_seq'),
                nome VARCHAR(80) NOT NULL,
                qtdeest INTEGER NOT NULL,
                qtdemin INTEGER NOT NULL,
                precovenda NUMERIC(6,2) NOT NULL,
                CONSTRAINT idprod PRIMARY KEY (idprod)
);


ALTER SEQUENCE public.produto_idprod_seq OWNED BY public.produto.idprod;

CREATE SEQUENCE public.estado_idestado_seq_1;

CREATE TABLE public.estado (
                idestado INTEGER NOT NULL DEFAULT nextval('public.estado_idestado_seq_1'),
                nome VARCHAR(50) NOT NULL,
                sigla CHAR(2) NOT NULL,
                CONSTRAINT idestado PRIMARY KEY (idestado)
);


ALTER SEQUENCE public.estado_idestado_seq_1 OWNED BY public.estado.idestado;

CREATE SEQUENCE public.cidade_idcidade_seq;

CREATE TABLE public.cidade (
                idcidade INTEGER NOT NULL DEFAULT nextval('public.cidade_idcidade_seq'),
                nome VARCHAR(50) NOT NULL,
                idestado INTEGER NOT NULL,
                CONSTRAINT idcidade PRIMARY KEY (idcidade)
);


ALTER SEQUENCE public.cidade_idcidade_seq OWNED BY public.cidade.idcidade;

CREATE SEQUENCE public.pessoa_idpessoa_seq;

CREATE TABLE public.pessoa (
                idpessoa INTEGER NOT NULL DEFAULT nextval('public.pessoa_idpessoa_seq'),
                nome VARCHAR(100) NOT NULL,
                telefone VARCHAR(14),
                endereco VARCHAR,
                email VARCHAR(255),
                idcidade INTEGER NOT NULL,
                CONSTRAINT idpessoa PRIMARY KEY (idpessoa)
);


ALTER SEQUENCE public.pessoa_idpessoa_seq OWNED BY public.pessoa.idpessoa;

CREATE TABLE public.fornecedor (
                idPessoaFornecedor INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                CONSTRAINT idpessoafornecedor PRIMARY KEY (idPessoaFornecedor)
);


CREATE TABLE public.cliente (
                idPessoaCliente INTEGER NOT NULL,
                cpf CHAR(11) NOT NULL,
                rg VARCHAR(15) NOT NULL,
                dtNasc VARCHAR NOT NULL,
                CONSTRAINT idpessoacliente PRIMARY KEY (idPessoaCliente)
);


CREATE SEQUENCE public.movimento_idmov_seq;

CREATE TABLE public.movimento (
                idmov INTEGER NOT NULL DEFAULT nextval('public.movimento_idmov_seq'),
                dtvenda DATE NOT NULL,
                idfornecedor INTEGER,
                idcliente INTEGER,
                CONSTRAINT idmov PRIMARY KEY (idmov)
);


ALTER SEQUENCE public.movimento_idmov_seq OWNED BY public.movimento.idmov;

CREATE TABLE public.itens_mov (
                idmov_mov INTEGER NOT NULL,
                idprod_mov INTEGER NOT NULL,
                qtde INTEGER NOT NULL,
                preco NUMERIC(6,2) NOT NULL,
                CONSTRAINT iditens_mov PRIMARY KEY (idmov_mov, idprod_mov)
);


ALTER TABLE public.itens_mov ADD CONSTRAINT idprod_itens_venda_fk
FOREIGN KEY (idprod_mov)
REFERENCES public.produto (idprod)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cidade ADD CONSTRAINT estado_cidade_fk
FOREIGN KEY (idestado)
REFERENCES public.estado (idestado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pessoa ADD CONSTRAINT cidade_pessoa_fk
FOREIGN KEY (idcidade)
REFERENCES public.cidade (idcidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cliente ADD CONSTRAINT pessoa_cliente_fk
FOREIGN KEY (idPessoaCliente)
REFERENCES public.pessoa (idpessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fornecedor ADD CONSTRAINT pessoa_fornecedor_fk
FOREIGN KEY (idPessoaFornecedor)
REFERENCES public.pessoa (idpessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT fornecedor_idvend_fk
FOREIGN KEY (idcliente)
REFERENCES public.fornecedor (idPessoaFornecedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT cliente_idvend_fk
FOREIGN KEY (idfornecedor)
REFERENCES public.cliente (idPessoaCliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.itens_mov ADD CONSTRAINT idvend_itens_venda_fk
FOREIGN KEY (idmov_mov)
REFERENCES public.movimento (idmov)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

INSERT INTO estado(nome, sigla) VALUES
('PARANÁ','PR'),
('SÃO PAULO','SP'),
('RIO DE JANEIRO','RJ');

INSERT INTO cidade(nome,idestado) VALUES
('Maringá', 1),
('Paranavaí', 1),
('Marilena', 1),
('Campinas', 2),
('Petrópolis', 3);


INSERT INTO pessoa(nome,telefone, endereco, email, idcidade) VALUES
('FORNECEDORA 1', 'rua Tal A','34421515', 'joão@gmail.com',5), /*colocar pessoas, isso é só para teste */
('FORNECEDORA 2', 'rua Tal B', '34534343','maria@gmail.com',4),
('FORNECEDORA 3', 'rua Tal A','34421515', 'joão@gmail.com',1), /*colocar pessoas, isso é só para teste */
('maria2', 'rua Tal B', '34534343','maria@gmail.com',1),
('João3', 'rua Tal A','34421515', 'joão@gmail.com',2), /*colocar pessoas, isso é só para teste */
('maria3', 'rua Tal B', '34534343','maria@gmail.com',3);

INSERT INTO cliente(idPessoaCliente, cpf, rg, dtNasc) VALUES /*colocar clientes, isso é só para teste */
(4,'12312312312','12312312','2000-10-01'),
(5,'45612312312','45612312','2002-10-01'), /*colocar clientes, isso é só para teste */
(6,'78912312312','78912312','1999-10-01');

INSERT INTO fornecedor(idpessoaFornecedor, cnpj) VALUES
(1,'0889305000103'),
(2,'6945944000140'),
(3,'88910790001605');

INSERT INTO movimento(dtvenda, idfornecedor, idcliente) VALUES /*um dos id é null, pois ou é cliente, ou fornecedor*/ 

('2018-11-20',NULL,1), /*ULTIMO CAMPO FOI UMA COMPRA DO FORNECEDOR*/
('2018-11-21',NULL,1),
('2018-11-25',NULL,2),
('2018-11-20',NULL,2),
('2018-11-21',NULL,3),
('2018-11-25',NULL,3),
('2016-05-02',4,NULL), /*PENULTIMA FOI UMA VENDA PARA CLIENTE*/
('2018-11-04',4,NULL),
('2018-11-05',5,NULL),
('2018-11-04',5,NULL),
('2018-11-05',6,NULL),
('2018-11-04',6,NULL);
 

INSERT INTO produto (nome, qtdeest, qtdemin, precovenda)
VALUES ('Skol 300 Ml', 4, 1, 3.00),
       ('Skol 350 Ml', 4, 1, 3.50),
       ('Skol 600 Ml', 6, 2, 6.50),
       ('Skol 650 Ml', 6, 2, 7.50),
       ('Skol 1 L', 4, 1, 7.00),
       ('Brahma 300 Ml', 4, 1, 3.00),
       ('Brahma 350 Ml', 4, 1, 3.00),
       ('Brahma 600 ML', 6, 2, 6.50),
       ('Brahma 650 Ml', 6, 2, 7.50),
       ('Brahma 1 L', 4, 1, 10.00),
       ('Subzero 350 Ml', 3, 1, 3.00),
       ('Subzero 600 Ml', 5, 1, 5.00),
       ('Subzero 650 Ml', 5, 1, 6.00),
       ('Subzero 1 L', 3, 1, 6.50),
       ('Brahma Extra 600 Ml', 2, 1, 6.50),
       ('Brahma Extra 650 Ml', 2, 1, 7.50),
       ('Antartica Original 600 Ml', 2, 1, 8.00),
       ('Antartica Original 650 Ml', 2, 1, 9.00),
       ('Budweiser 600 Ml', 2, 1, 6.50),
       ('Budweiser 650 Ml', 2, 1, 7.50),
       ('Guaraná Antartica 2 L', 2, 1, 7.00),
       ('Guaraná Antartica 350 Ml', 2, 1, 3.00),
       ('Guaraná Antartica 290 Ml', 2, 1, 3.00),
       ('Coca Cola 290 Ml', 3, 1, 3.00),
       ('Coca Cola 350 Ml', 2, 1, 3.50),
       ('Coca Cola 600 Ml', 2, 1, 4.50),
       ('Coca Cola 1 L', 2, 1, 5.00),
       ('Coca Cola 2 L', 2, 1, 8.00),
       ('Tubaina Funada 2 L', 2, 1, 6.00),
       ('Tubaina Funada 600 Ml', 2, 1, 3.00),
       ('Sodinha', 3, 1, 2.00),
       ('Guaraná Funada 2 L', 2, 1, 6.00),
       ('Fanta 290 Ml', 3, 1, 3.00),
       ('Fanta 350 Ml', 2, 1, 3.50),
       ('Fanta 2 L', 2, 1, 7.00),
       ('Agua Tonica 290 Ml', 2, 1, 3.00),
       ('Brahma Sem Álcool 350 Ml', 1, 1, 4.00),
       ('Brahma Sem Álcool 350 Ml', 1, 1, 5.00),
       ('H2OH Limoneto 500 Ml', 2, 1, 4.50),
       ('H2OH Limoneto 500 Ml', 2, 1, 5.50),
       ('Dose de Pinga', 10, 2, 1.50),
       ('Paçoca', 1, 1, 0.50),
       ('Canudinho Doce de Leite', 1, 1, 0.50),
       ('Amendoim Salgado Pacote', 1, 1, 2.00);

INSERT INTO itens_mov(idmov_mov,idprod_mov,qtde,preco) VALUES
(1,1,5,'3.00'), /*Atenção repita o preço do produto, pois ficará no histórico, a tabela produto pode ter seus preços alterados*/
(1,2,4,'3.50'),
(2,3,4,'6.50'),
(2,4,7,'7.50'),
(3,5,8,'7.00'),
(3,6,9,'3.00'),
(4,7,2,'3.00'),
(4,8,2,'6.50'),
(5,9,2,'7.50'),
(5,10,2,'10.00'),
(6,11,2,'3.00'),
(6,12,2,'5.00');

/*Relação de todos os clientes*/
SELECT pessoa.nome, movimento.dtvenda, itens_mov.preco, itens_mov.qtde, produto.nome
FROM pessoa INNER JOIN cliente
ON pessoa.idpessoa = idPessoaCliente
INNER JOIN movimento
ON idPessoaCliente = idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod;

/*Relação de todos os Fornecedores*/
SELECT pessoa.nome, movimento.dtvenda, itens_mov.preco, itens_mov.qtde, produto.nome
FROM pessoa INNER JOIN fornecedor
ON pessoa.idpessoa = idPessoaFornecedor
INNER JOIN movimento
ON idPessoaFornecedor = idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod;






select * from produto



/*testes de select-----------------*/
SELECT * 
FROM pessoa INNER JOIN cliente
ON pessoa.idpessoa = cliente.idPessoaCliente;

SELECT * 
FROM pessoa INNER JOIN fornecedor
ON pessoa.idpessoa = fornecedor.idPessoaFornecedor;

SELECT produto.nome, produto.quantidade 
