
CREATE TABLE produto (
idprod SERIAL NOT NULL PRIMARY KEY,
nome VARCHAR(80) NOT NULL, 
qtde_estoque INTEGER NOT NULL,
preco NUMERIC(6,2) NOT NULL );


INSERT INTO produto (nome, qtde_estoque, preco)
VALUES 
 ('Sabão em Pó', 100, 5),
 ('Paçoca', 50, 0.50), 
 ('Arroz', 20, 12.20),
 ('Grade de Cerveja', 100, 20),
 ('Escova', 50, 2), 
 ('Nutela', 20, 20.40),
 ('vinagre', 100, 2.45),
 ('bala', 50, 0.50), 
 ('feijão', 20, 12.20)
;

SELECT * FROM produto;

CREATE TABLE cliente (
idcli SERIAL NOT NULL PRIMARY KEY,
nome VARCHAR(80) NOT NULL 
);

INSERT INTO cliente (nome) VALUES 
('Maria'),
('José'),
('Pedro'),
('Manuel'),
('Joaquim'),
('Mariana'),
('Juliana'),
('Isabela'),
('Manuela'),
('joão');
SELECT * FROM cliente;

CREATE TABLE pfisica (
idcli INT NOT NULL PRIMARY KEY, 
cpf CHAR(11) NOT NULL,
rg VARCHAR(20) NOT NULL,
conjuge INT, 
CONSTRAINT fk_pfisica_cliente FOREIGN KEY (idcli) REFERENCES cliente (idcli),
CONSTRAINT fk_conjuge FOREIGN KEY (conjuge) REFERENCES pfisica (idcli),
CONSTRAINT uk_conjuge UNIQUE (conjuge)
);

INSERT INTO pfisica VALUES 
(1,'12312312312','321321321321',null),
(2,'23454354323','1234322342342',null),
(3,'54354354354','234543645',null);

CREATE TABLE pjuridica (
idcli INT NOT NULL PRIMARY KEY,
cnpj CHAR(14) NOT NULL, 
inscest VARCHAR(12) NOT NULL,
CONSTRAINT fk_pjuridica_cliente FOREIGN KEY (idcli) REFERENCES cliente (idcli)
);

INSERT INTO pjuridica VALUES
(4,'1234509839489','234234234234'),
(5,'2342342323423','123131231231'),
(6,'34234234342F3','234234234242');

CREATE TABLE venda (
idven SERIAL NOT NULL PRIMARY KEY,
dataven DATE NOT NULL,
idcli INT NOT NULL REFERENCES cliente (idcli)
);

INSERT INTO venda (dataven, idcli) VALUES 
('2017-07-09', 1), ('2017-07-09', 2), ('2017-07-08', 5);

SELECT * FROM produto;

CREATE TABLE itens_venda (
idven INT NOT NULL REFERENCES venda (idven),
idprod INT NOT NULL REFERENCES produto (idprod),
qtde INT NOT NULL,
preco NUMERIC(6,2) NOT NULL,
CONSTRAINT pk_itens_venda PRIMARY KEY (idven,idprod)
);

INSERT INTO itens_venda VALUES
(1,1,1,5), (1, 3,1, 12.20), (1,2,1,0.50), (2,1,1,5),(2,3,1,12.20),(3,2,3,1.50);


SELECT cliente.nome , venda.dataven 
FROM cliente INNER JOIN venda
ON cliente.idcli = venda.idcli            /*cliente que já fizeram a compra ----- Sempre é PK com FK*/
order by 2;

SELECT cliente.nome , venda.dataven 
FROM cliente LEFT JOIN venda		/* prioridade para a esquerda..., exibe todos*/
ON cliente.idcli = venda.idcli            /*Lista todos os cliente, independente se ja compraram ou não*/
order by 2;

SELECT nome, preco, qtde_estoque
FROM produto

Where preco BETWEEN 5 AND 10;
/* OU */
WHERE preco >=5 AND preco <=10;

SELECT nome FROM cliente WHERE nome LIKE 'Ma%' /*Os que começam com Ma*/

SELECT nome FROM cliente WHERE nome LIKE '%ri%' /*que tem Ri no meio*/

SELECT nome FROM cliente WHERE nome LIKE '%na' /*Os que terminam com Na*/

-- soma - SUM()
-- maior - max()
-- menor - min()
-- média - agv()
-- contar - count()

--Contar o número de linhas em cliente
SELECT COUNT (*) FROM cliente;

SELECT 2 + 2

--Qantos Produtos há em estoque
SELECT SUM(qtde_estoque) FROM produto;

--O mais caro:
SELECT MAX(preco) FROM produto;

--O mais Barato:
SELECT MIN(preco) FROM produto;

--A média de preços:
SELECT AVG(preco) ::Money FROM produto; --'::'indica novo tipo de dados, no caso money

--A qtde total vendida por cada produto
SELECT produto.nome, SUM(itens_venda.qtde)
FROM produto INNER JOIN itens_venda
ON produto.idprod = itens_venda.idprod
GROUP BY 1; --AGRUPAR LINHAS IGUAIS PARA QUE SE POSSA FAZER A SOMA


/*----------------------------aula15----------------------------------*/





﻿/* Exiba a lista de clientes, mostrando o seu nome e 
a data da venda que o mesmo já participou. Ordene 
o resultado pela data da venda (menor para maior). */ 

SELECT cliente.nome, venda.dataven
FROM cliente INNER JOIN venda
     ON cliente.idcli = venda.idcli
ORDER BY venda.dataven;

/* Exiba a relação de todos os clientes cadastrados, 
e quando o mesmo já tenha participado de vendas, mostre
seu nome e a data da venda. Ordene 
o resultado pela data da venda (menor para maior). */ 

SELECT cliente.nome, venda.dataven
FROM cliente LEFT JOIN venda
     ON cliente.idcli = venda.idcli
ORDER BY venda.dataven;

SELECT cliente.nome, venda.dataven
FROM venda RIGHT JOIN cliente 
     ON cliente.idcli = venda.idcli
ORDER BY venda.dataven;

/* Mostre o nome do produto, seu preço e sua quantidade
em estoque de todos os produtos que custem entre 
R$ 5,00 e R$10,00*/
SELECT nome, preco, qtde_estoque
FROM produto
WHERE preco >= 5 AND preco <= 10;

-- BETWEEN
SELECT nome, preco, qtde_estoque
FROM produto
WHERE preco BETWEEN  5 AND 10;

/* Mostre a relação de clientes que tenham em seu nome
a sequencia de:*/

-- ana - em qualquer parte
SELECT nome FROM cliente WHERE nome LIKE '%ana%';

-- Comece com Ma
SELECT nome FROM cliente WHERE nome LIKE 'Ma%';

-- Que tenha ri no meio
SELECT nome FROM cliente WHERE nome LIKE '%ri%';

-- termine com na
SELECT nome FROM cliente WHERE nome LIKE '%na';

/*Funções de agregação
Soma - SUM()
Maior - MAX()
Menor - MIN()
Média - AVG()
Contar - COUNT() */

-- Mostre quantos clientes há cadastrado: 
SELECT COUNT(*) FROM cliente;

-- Mostre quantos produtos há em estoque:
SELECT SUM(qtde_estoque) AS "Quantidade em Estoque"
FROM produto;

-- Mostre o produto mais caro: 
SELECT MAX(preco)::Money FROM produto;

-- Mostre o produto mais barato:
SELECT MIN(preco)::Money FROM produto;

-- Mostre a média de preço dos produtos:  
SELECT AVG(preco)::Money FROM produto;

-- Mostre a quantidade total vendida de cada produto.
SELECT produto.nome, itens_venda.qtde
FROM produto INNER JOIN itens_venda
ON produto.idprod = itens_venda.idprod 
ORDER BY produto.nome  ASC;

SELECT produto.nome, avg(itens_venda.qtde)
FROM produto INNER JOIN itens_venda
ON produto.idprod = itens_venda.idprod
GROUP BY produto.nome;

SELECT produto.nome, itens_venda.qtde
FROM produto INNER JOIN itens_venda
ON produto.idprod = itens_venda.idprod;

-- Condição em função de agregação
/* Retornar os produtos que foram vendidos mais que 
3 unidades*/
SELECT produto.nome, COUNT(itens_venda.qtde), 
       SUM(itens_venda.qtde)
FROM produto INNER JOIN itens_venda
ON produto.idprod = itens_venda.idprod
INNER JOIN venda ON venda.idven = itens_venda.idven
WHERE venda.dataven >= '2017-07-01' AND 
      venda.dataven <= '2018-07-30' 
GROUP BY produto.nome
HAVING COUNT(itens_venda.qtde) >= 2
       OR SUM(itens_venda.qtde) > 3;


-- IS NULL e IS NOT NULL
SELECT cliente.nome
FROM cliente INNER JOIN pfisica
ON cliente.idcli = pfisica.idcli
WHERE pfisica.conjuge IS NOT NULL;



