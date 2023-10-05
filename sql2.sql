-- Exercício 1
-- Pergunta: Criar uma tabela "Clientes" com campos para ID, Nome e Email.
CREATE TABLE Clientes (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(100),
    Email VARCHAR(100)
);

-- Exercício 2
-- Pergunta: Adicionar uma coluna "Telefone" à tabela "Clientes" usando ALTER TABLE.
ALTER TABLE Clientes
ADD Telefone VARCHAR(20);

-- Exercício 3
-- Pergunta: Remover a coluna "Email" da tabela "Clientes" usando ALTER TABLE.
ALTER TABLE Clientes
DROP COLUMN Email;

-- Exercício 4
-- Pergunta: Criar uma tabela "Produtos" com campos para ID, Nome e Preço.
CREATE TABLE Produtos (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(100),
    Preco DECIMAL(10, 2)
);

-- Exercício 5
-- Pergunta: Inserir um novo cliente na tabela "Clientes".
INSERT INTO Clientes (Nome, Telefone)
VALUES ('João Silva', '123-456-7890');

-- Exercício 6
-- Pergunta: Inserir 3 novos produtos na tabela "Produtos".
INSERT INTO Produtos (Nome, Preco)
VALUES
    ('Produto A', 19.99),
    ('Produto B', 29.99),
    ('Produto C', 9.99);

-- Exercício 7
-- Pergunta: Atualizar o nome de um cliente na tabela "Clientes".
UPDATE Clientes
SET Nome = 'Maria Oliveira'
WHERE ID = 1;

-- Exercício 8
-- Pergunta: Atualizar o preço de um produto na tabela "Produtos".
UPDATE Produtos
SET Preco = 24.99
WHERE ID = 2;

-- Exercício 9
-- Pergunta: Excluir um cliente da tabela "Clientes".
DELETE FROM Clientes
WHERE ID = 1;

-- Exercício 10
-- Pergunta: Excluir um produto da tabela "Produtos".
DELETE FROM Produtos
WHERE ID = 3;




-- Exercício 11
-- Pergunta: Criar uma tabela "Pedidos" com campos para ID, Data e ID do Cliente.
CREATE TABLE Pedidos (
    ID SERIAL PRIMARY KEY,
    Data DATE,
    Cliente_ID INT
);

-- Exercício 12
-- Pergunta: Adicionar uma coluna "Status" à tabela "Pedidos" usando ALTER TABLE.
ALTER TABLE Pedidos
ADD Status VARCHAR(50);

-- Exercício 13
-- Pergunta: Remover a coluna "Status" da tabela "Pedidos" usando ALTER TABLE.
ALTER TABLE Pedidos
DROP COLUMN Status;

-- Exercício 14
-- Pergunta: Inserir 5 novos pedidos na tabela "Pedidos".
INSERT INTO Pedidos (Data, Cliente_ID)
VALUES
    ('2023-09-01', 2),
    ('2023-09-02', 1),
    ('2023-09-03', 3),
    ('2023-09-04', 2),
    ('2023-09-05', 1);

-- Exercício 15
-- Pergunta: Atualizar a data de um pedido na tabela "Pedidos".
UPDATE Pedidos
SET Data = '2023-09-10'
WHERE ID = 3;

-- Exercício 16
-- Pergunta: Excluir um pedido da tabela "Pedidos".
DELETE FROM Pedidos
WHERE ID = 4;

-- Exercício 17
-- Pergunta: Criar uma tabela "Categorias" com campos para ID e Nome.
CREATE TABLE Categorias (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(100)
);

-- Exercício 18
-- Pergunta: Adicionar uma coluna "Descrição" à tabela "Categorias" usando ALTER TABLE.
ALTER TABLE Categorias
ADD Descricao TEXT;

-- Exercício 19
-- Pergunta: Remover a coluna "Descrição" da tabela "Categorias" usando ALTER TABLE.
ALTER TABLE Categorias
DROP COLUMN Descricao;

-- Exercício 20
-- Pergunta: Criar uma tabela "ItensPedido" com campos para ID, ID do Pedido, ID do Produto e Quantidade.
CREATE TABLE ItensPedido (
    ID SERIAL PRIMARY KEY,
    Pedido_ID INT,
    Produto_ID INT,
    Quantidade INT
);