
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

CREATE TABLE estado (
                idestado INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                sigla CHAR(2) NOT NULL,
                CONSTRAINT idestado PRIMARY KEY (idestado)
);


CREATE TABLE cidade (
                idcidade INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                idestado INTEGER NOT NULL,
                CONSTRAINT idcidade PRIMARY KEY (idcidade)
);


CREATE TABLE pessoa (
                idpessoa INTEGER NOT NULL,
                nome VARCHAR(100) NOT NULL,
                telefone VARCHAR(14),
                endereco VARCHAR,
                email VARCHAR(255),
                idcidade INTEGER NOT NULL,
                CONSTRAINT idpessoa PRIMARY KEY (idpessoa)
);


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

