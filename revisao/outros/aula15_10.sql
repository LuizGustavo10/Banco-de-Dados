/* Exiba a lista de clientes, mostrando o seu nome e 
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