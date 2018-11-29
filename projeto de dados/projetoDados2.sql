
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
                idfornecedor INTEGER,
                idcliente INTEGER,
                CONSTRAINT idmov PRIMARY KEY (idmov)
);


ALTER SEQUENCE public.movimento_idmov_seq OWNED BY public.movimento.idmov;

CREATE TABLE public.itens_mov (
                idmov_mov INTEGER NOT NULL,
                idprod_mov INTEGER NOT NULL,
                qtde INTEGER NOT NULL,
                dtvenda DATE NOT NULL,
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
