-- DDL (Data Definition Language)
CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(255),
    preco DECIMAL(10, 2)
);

ALTER TABLE produtos ADD descricao TEXT;

DROP TABLE produtos;

-- DML (Data Manipulation Language)
INSERT INTO produtos (id, nome, preco) VALUES
    (1, 'Notebook', 1200.00),
    (2, 'Smartphone', 500.00),
    (3, 'Tablet', 300.00);

UPDATE produtos SET preco = 1300.00 WHERE nome = 'Notebook';

DELETE FROM produtos WHERE nome = 'Tablet';















-- DQL (Data Query Language)
SELECT * FROM produtos;

SELECT nome, preco FROM produtos WHERE preco > 1000.00;

SELECT nome, preco FROM produtos ORDER BY preco DESC;

SELECT categoria, AVG(preco) AS media_preco FROM produtos GROUP BY categoria;







===================================================================
-- Criando uma tabela de alunos
CREATE TABLE alunos (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    idade INT,
    curso VARCHAR(50)
);


-- Inserindo dados na tabela de alunos
INSERT INTO alunos (id, nome, idade, curso) VALUES
    (1, 'Ana', 20, 'Engenharia'),
    (2, 'João', 22, 'Ciência da Computação'),
    (3, 'Maria', 21, 'Medicina');


-- Atualizando a idade de Ana
UPDATE alunos SET idade = 23 WHERE nome = 'Ana';



-- Excluindo o registro de Maria
DELETE FROM alunos WHERE nome = 'Maria';


-- Selecionando todos os registros da tabela de alunos
SELECT * FROM alunos;

-- Selecionando alunos de Engenharia
SELECT nome, idade FROM alunos WHERE curso = 'Engenharia';

-- Ordenando os alunos por idade decrescente
SELECT nome, idade FROM alunos ORDER BY idade DESC;

-- Agrupando e contando alunos por curso
SELECT curso, COUNT(*) AS quantidade_alunos FROM alunos GROUP BY curso;

-- Criando uma tabela de cursos
CREATE TABLE cursos (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    duracao INT
);

-- Inserindo dados na tabela de cursos
INSERT INTO cursos (id, nome, duracao) VALUES
    (1, 'Engenharia', 5),
    (2, 'Ciência da Computação', 4),
    (3, 'Medicina', 6);

-- Realizando uma junção entre as tabelas alunos e cursos
SELECT alunos.nome, cursos.nome AS curso FROM alunos
INNER JOIN cursos ON alunos.curso = cursos.nome;




===========================================================


/* comandos DDL - Linguagem de definição de dados */
/* criar uma tabela no banco de dados */

CREATE TABLE usuario ( 
    id INT PRIMARY KEY NOT NULL,
    nome VARCHAR(50),
    idade INT,
    email VARCHAR(100)
);
/* alteração de tabela, adicionar coluna*/
ALTER TABLE usuario ADD COLUMN telefone VARCHAR(20);
/* alterar coluna, renomear */
ALTER TABLE usuario rename telefone to telefone2;

/*excluir tabela*/
DROP TABLE usuario;

/* DML -  Linguagem de Manipulação de dados */
/* inserir dado */
INSERT INTO usuario (id, nome, idade, email) VALUES 
(1, 'Arlindo', 47, 'arlindo@gmail.com'),
(2, 'Irineu', 50, 'irineu@gmail.com');

/*alterar dado - altera pelo id*/
UPDATE usuario SET email = 'maicão@gmail.com' where id=1;
/*altera pelo nome*/
UPDATE usuario SET email = 'luther@gmail.com' where nome LIKE 'Irineu';

/*excluir*/
DELETE FROM usuario WHERE id=3;

/*selecionar todos clientes*/
SELECT * FROM usuario;




-- parte de relacionamentos
-- Modelo Conceitual e Modelo Lógico são termos usados na área de banco de dados para representar 
-- diferentes níveis de abstração no processo de projetar um banco de dados. Vamos explorar
-- os conceitos e elementos-chave de ambos:

-- a criar tabelas com chaves primárias e estrangeiras em um banco de dados PostgreSQL, aqui está o exemplo anterior adaptado para o PGAdmin:

-- Tabelas:

-- Tabela "Autores"

-- Chave Primária: Autor_ID (identificador único do autor)
-- Outros Atributos: Nome, Nacionalidade
-- Tabela "Livros"

-- Chave Primária: Livro_ID (identificador único do livro)
-- Outros Atributos: Título, Ano, ISBN
-- Tabela "LivrosAutores" (uma tabela de junção para representar o relacionamento muitos para muitos entre Autores e Livros)

-- Chave Primária: ID (identificador único da entrada na tabela de junção)
-- Chaves Estrangeiras:
-- Autor_ID (referência a tabela "Autores")
-- Livro_ID (referência a tabela "Livros")
-- SQL para Criar as Tabelas no PGAdmin:

-- Abra o PGAdmin e conecte-se ao seu servidor PostgreSQL.
-- No painel de navegação à esquerda, clique com o botão direito em "Databases" e crie um novo banco de dados (por exemplo, "Biblioteca").
-- Clique com o botão direito no banco de dados recém-criado e selecione "Query Tool" para abrir uma nova janela SQL.
-- Execute o seguinte SQL para criar as tabelas:

-- Tabela de Autores
CREATE TABLE Autores (
    Autor_ID SERIAL PRIMARY KEY,
    Nome VARCHAR(100),
    Nacionalidade VARCHAR(50)
);

-- Inserir dados na tabela Autores
INSERT INTO Autores (Nome, Nacionalidade)
VALUES
    ('George Orwell', 'Reino Unido'),
    ('Harper Lee', 'Estados Unidos'),
    ('J.K. Rowling', 'Reino Unido');

-- Tabela de Livros
CREATE TABLE Livros (
    Livro_ID SERIAL PRIMARY KEY,
    Título VARCHAR(200),
    Ano INT,
    Editora VARCHAR(100)  -- Substituído por "Editora"
);

-- Inserir dados na tabela Livros (livros reais)
INSERT INTO Livros (Título, Ano, Editora)
VALUES
    ('1984', 1949, 'Penguin Books'),
    ('O Sol é para Todos', 1960, 'Harper Perennial'),
    ('Harry Potter e a Pedra Filosofal', 1997, 'Bloomsbury');

-- Tabela de junção LivrosAutores
CREATE TABLE LivrosAutores (
    ID SERIAL PRIMARY KEY,
    Autor_ID INT,
    Livro_ID INT,
    FOREIGN KEY (Autor_ID) REFERENCES Autores(Autor_ID),
    FOREIGN KEY (Livro_ID) REFERENCES Livros(Livro_ID)
);

-- Inserir dados na tabela LivrosAutores (relacionar autores e livros reais)
INSERT INTO LivrosAutores (Autor_ID, Livro_ID)
VALUES
    (1, 1),  -- George Orwell é o autor de "1984"
    (2, 2),  -- Harper Lee é a autora de "O Sol é para Todos"
    (3, 3);  -- J.K. Rowling é a autora de "Harry Potter e a Pedra Filosofal"







--==========================================================================

-- Criação da tabela de estados
CREATE TABLE estados (
    id_estado SERIAL PRIMARY KEY,
    nome_estado VARCHAR(50) NOT NULL
);

-- Criação da tabela de cidades
CREATE TABLE cidades (
    id_cidade SERIAL PRIMARY KEY,
    nome_cidade VARCHAR(50) NOT NULL,
    id_estado INT REFERENCES estados(id_estado)
);

-- Inserir dados de exemplo
INSERT INTO estados (nome_estado)
VALUES
    ('São Paulo'),
    ('Rio de Janeiro'),
    ('Minas Gerais');

INSERT INTO cidades (nome_cidade, id_estado)
VALUES
    ('São Paulo', 1),
    ('Campinas', 1),
    ('Rio de Janeiro', 2),
    ('Niterói', 2),
    ('Belo Horizonte', 3);



-- Selecionar todas as cidades e seus estados correspondentes, incluindo estados sem cidades
SELECT c.nome_cidade, e.nome_estado
FROM estados e
LEFT JOIN cidades c ON e.id_estado = c.id_estado;

-- Selecionar todas as cidades e seus estados correspondentes, excluindo estados sem cidades
SELECT c.nome_cidade, e.nome_estado
FROM cidades c
INNER JOIN estados e ON c.id_estado = e.id_estado;

-- Selecionar o estado com o maior número de cidades
SELECT e.nome_estado, COUNT(c.id_cidade) AS total_cidades
FROM estados e
INNER JOIN cidades c ON e.id_estado = c.id_estado
GROUP BY e.nome_estado
ORDER BY total_cidades DESC
LIMIT 1;

-- Selecionar todas as cidades que não são capitais (supondo que tenha uma coluna 'capital' na tabela estados)
SELECT c.nome_cidade
FROM cidades c
INNER JOIN estados e ON c.id_estado = e.id_estado
WHERE e.capital = false;

-- Selecionar todas as cidades e seus estados correspondentes, ordenados pelo nome da cidade
SELECT c.nome_cidade, e.nome_estado
FROM cidades c
INNER JOIN estados e ON c.id_estado = e.id_estado
ORDER BY c.nome_cidade;
-- Selecionar todas as cidades em ordem alfabética
SELECT * FROM cidades ORDER BY nome_cidade;

-- Selecionar estados com mais de 5 cidades
SELECT e.nome_estado, COUNT(c.id_cidade) AS total_cidades
FROM estados e
INNER JOIN cidades c ON e.id_estado = c.id_estado
GROUP BY e.nome_estado
HAVING COUNT(c.id_cidade) > 5;

-- Atualizar o nome de uma cidade (por exemplo, Campinas para Nova Campinas)
UPDATE cidades
SET nome_cidade = 'Nova Campinas'
WHERE nome_cidade = 'Campinas';

-- Excluir uma cidade (por exemplo, excluir Niterói)
DELETE FROM cidades WHERE nome_cidade = 'Niterói';

-- Selecionar todas as cidades com seus estados e ordenar por estado e nome da cidade
SELECT c.nome_cidade, e.nome_estado
FROM cidades c
INNER JOIN estados e ON c.id_estado = e.id_estado
ORDER BY e.nome_estado, c.nome_cidade;

--para atividade dos diagramas

-- Criar a tabela Professor
CREATE TABLE Professor (
    id INT PRIMARY KEY,
    nome VARCHAR(255),
    cpf VARCHAR(14) UNIQUE
);

-- Criar a tabela Aula
CREATE TABLE Aula (
    id INT PRIMARY KEY,
    data_aula DATE,
    hora_aula TIME,
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES Professor(id)
);

-- Inserir dados de exemplo na tabela Professor
INSERT INTO Professor (id, nome, cpf) VALUES
    (1, 'Professor 1', '123.456.789-01'),
    (2, 'Professor 2', '987.654.321-09'),
    (3, 'Professor 3', '456.789.123-45');

-- Inserir dados de exemplo na tabela Aula
INSERT INTO Aula (id, data_aula, hora_aula, professor_id) VALUES
    (101, '2023-09-25', '09:00:00', 1),
    (102, '2023-09-26', '14:30:00', 2),
    (103, '2023-09-27', '10:15:00', 1),
    (104, '2023-09-28', '16:45:00', 3);


-- Listar todos os professores:
SELECT * FROM Professor;

-- Listar todas as aulas:
SELECT * FROM Aula;

-- Listar todas as aulas agendadas para uma data específica:
SELECT * FROM Aula WHERE data_aula = '2023-09-25';

-- Listar todas as aulas agendadas para um professor específico (por exemplo, Professor 1):
SELECT * FROM Aula WHERE professor_id = 1;

-- Listar todas as aulas agendadas para um período de tempo específico (por exemplo, entre '2023-09-25' e '2023-09-27'):
SELECT * FROM Aula WHERE data_aula BETWEEN '2023-09-25' AND '2023-09-27';

-- Listar o nome do professor para cada aula:
SELECT Aula.id, Aula.data_aula, Aula.hora_aula, Professor.nome AS nome_professor
FROM Aula
INNER JOIN Professor ON Aula.professor_id = Professor.id;

-- Contar quantas aulas cada professor ministrou:
SELECT Professor.nome, COUNT(Aula.id) AS total_aulas
FROM Professor
LEFT JOIN Aula ON Professor.id = Aula.professor_id
GROUP BY Professor.nome;

-- Listar os professores que não têm aulas agendadas:
SELECT Professor.nome
FROM Professor
LEFT JOIN Aula ON Professor.id = Aula.professor_id
WHERE Aula.id IS NULL;

-- Listar aulas agendadas ordenadas por data e hora:
SELECT * FROM Aula
ORDER BY data_aula, hora_aula;



