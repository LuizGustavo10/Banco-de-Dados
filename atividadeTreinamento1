﻿
CREATE TABLE estado (
idest SERIAL NOT NULL PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
sigla CHAR(2) NOT NULL); 

INSERT INTO estado (nome, sigla) VALUES
('PARANÁ', 'PR'),
('SÃO PAULO', 'SP'),
('RIO DE JANEIRO', 'RJ');


CREATE TABLE cidade (
idcid SERIAL NOT NULL PRIMARY KEY,
nome VARCHAR(80) NOT NULL,
idest INT NOT NULL REFERENCES estado (idest));

INSERT INTO cidade (nome, idest) VALUES 
('PARANAVAÍ', 1),
('LONDRINA', 1),
('MARINGÁ', 1),
('SÃO PAULO', 2),
('RIO DE JANEIRO', 3);


CREATE TABLE editora (
idedi SERIAL NOT NULL PRIMARY KEY,
idcid INT NOT NULL REFERENCES cidade (idcid),
nome VARCHAR(100) NOT NULL,
email VARCHAR(200) NOT NULL,
url VARCHAR(255) NOT NULL,
fone VARCHAR(15) NOT NULL);

INSERT INTO editora (idcid, nome, email, url, fone) VALUES
(1, 'EDITORA PARANAVAÍ', 'PARANAVAI@EDITORA.COM.BR', 'WWW.EDITORAPARANAVAI.COM.BR', '34543434'),
(2, 'EDITORA LONDIRNA', 'LONDRINA@EDITORA.COM.BR', 'WWW.EDITORALONDRINA.COM.BR', '23442343'),
(3, 'EDITORA MARINGÁ', 'MARINGA@EDITORA.COM.BR', 'WWW.EDITORAMARINGA.COM.BR', '12365478'),
(4, 'EDITORA SÃO PAULO', 'SAOPAULO@EDITORA.COM.BR', 'WWW.EDITORASAOPAULO.COM.BR', '12354689'),
(5, 'EDITORA RIO DE JANEIRO', 'RIODEJANEIRO@EDITORA.COM.BR', 'WWW.EDITORARIODEJANEIRO.COM.BR', '32658978');


CREATE TABLE assunto (
idassunt SERIAL NOT NULL PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
fkcategoria INT REFERENCES assunto (idassunt));

INSERT INTO assunto (nome, fkcategoria) VALUES
('SISTEMAS DE INFORMAÇÃO', NULL),
('BANCO DE DADOS', 1),
('PROGRAMAÇÃO WEB', 1),
('ENGENHARIA DE SOFTWARE', 1),
('ANALISE E PROJETO DE SISTEMAS', 4),
('UML', 4);


CREATE TABLE livro (
idlivr SERIAL NOT NULL PRIMARY KEY,
titulo TEXT NOT NULL,
idedi INT NOT NULL REFERENCES editora (idedi),
idassunt INT NOT NULL REFERENCES assunto (idassunt),
precovenda NUMERIC(6,2) NOT NULL);

INSERT INTO livro (titulo, idedi, idassunt, precovenda) VALUES
('PROJETO DE BANCO DE DADOS', 1, 2, 50.00),
('ENGENHARIA DE SOFTWARE', 2, 4, 298.45),
('ANÁLISE E PROJETO DE SISTEMAS', 4, 5, 125.00),
('SQL', 3, 2, 278.00),
('PROJETO BD', 1, 2, 52.00);


CREATE TABLE autor (
idaut SERIAL NOT NULL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
rua VARCHAR(100) NOT NULL,
numero VARCHAR(6) NOT NULL,
cep CHAR(8) NOT NULL,
email VARCHAR(200) NOT NULL,
fone VARCHAR(15) NOT NULL,
dtnas DATE NOT NULL,
idcid INT NOT NULL REFERENCES cidade (idcid));

INSERT INTO autor (nome, rua, numero, cep, email, fone, dtnas, idcid) VALUES
('CARLOS HEUSER', 'RUA A', '12', '78789789', 'HEUSER@EMAIL.COM', '78978978', '1975-06-21', 2),
('LUIS DAMAS', 'RUA B', '45','45778789', 'DAMAS@EMAIL.COM', '45647845', '1984-02-21',1),
('EDUARDO BEZERRA', 'RUA B', '54','45789456', 'BEZERRA@EMAIL.COM','45675212','1965-04-12',3),
('SÉRGIO LUIZ TONSING','RUA C','56','45236589','LUIZ@EMAIL.COM','12365456','1998-07-23',1),
('ELMASRI', 'RUA X', '458','12546879', 'ELMASRI@EMAIL.COM','12354678', '1975-05-05',5);

CREATE TABLE publiacao (
idlivr INT NOT NULL REFERENCES livro (idlivr),
idaut INT NULL NULL REFERENCES autor (idaut),
PRIMARY KEY (idlivr, idaut));

INSERT INTO publiacao VALUES 
(1, 1),
(2, 3),
(2, 4),
(3, 3),
(4, 2),
(4, 5),
(5, 1),
(5, 2);

/*Questão 1*/
SELECT titulo, precovenda FROM livro
WHERE precovenda BETWEEN 100.00 AND 200.00;

/*Questão 2*/
SELECT titulo, precovenda FROM livro
WHERE precovenda IN (50.00,100.00); /*Clausula "IN" exprime uma coisa ou outra,50 ou 100*/

/*Questão 3*/
SELECT livro.titulo, assunto.nome, livro.precovenda
FROM livro INNER JOIN assunto
ON livro.idassunt = assunto.idassunt
WHERE precovenda IN (50.00,100.00);

/*Questão 4*/
SELECT livro.titulo, editora.nome, assunto.nome, livro.precovenda
FROM editora INNER JOIN livro
ON editora.idedi = livro.idedi
INNER JOIN assunto
ON livro.idassunt = assunto.idassunt
ORDER BY 2;

/*Questão 5*/
SELECT livro.titulo, assunto.nome
FROM livro INNER JOIN assunto
ON livro.idassunt = assunto.idassunt

/*Questão 6*/
SELECT livro.titulo, editora.nome, assunto.nome, livro.precovenda
FROM editora INNER JOIN livro
ON editora.idedi = livro.idedi
INNER JOIN assunto
ON livro.idassunt = assunto.idassunt
ORDER BY 4;

/*Questão 6*/

SELECT livro.titulo, livro.precovenda, assunto.nome
FROM livro INNER JOIN assunto
ON livro.idassunt = assunto.idassunt
ORDER BY 2;

/*Questão 7*/

SELECT livro.titulo, livro.precovenda, assunto.nome
FROM livro INNER JOIN assunto
ON livro.idassunt = assunto.idassunt
WHERE livro.precovenda BETWEEN  50.00 AND 100.00;

/*Questão 8*/

SELECT nome "Nome", dtnas"Data de Nascimento" FROM autor
ORDER BY 1;

/*Questão 9*/

SELECT nome FROM assunto
WHERE fkcategoria IS NOT NULL;

/*Questão 10*/

SELECT nome FROM assunto
WHERE fkcategoria IS NULL;

/*Questão 11*/

SELECT nome FROM assunto
WHERE fkcategoria IS NULL
ORDER BY 1;


/*Questão 12*/
SELECT editora.nome, SUM(livro.precovenda)
FROM editora INNER JOIN livro
ON editora.idedi = livro.idedi
GROUP BY editora.nome

/*Questão 13*/
/*Considerando que a editora tenha 1 exemplar de cada livro, escreva o script SQL que retorne o valor total em livros que a 
editora possui, agrupando pelo autor. Para isto, na projeção exiba o nome do autor e o valor total.COUNT(livros)*/

SELECT editora.nome, autor.nome, COUNT(livro)
FROM autor INNER JOIN publiacao
ON autor.idaut = publiacao.idaut
INNER JOIN livro
ON publiacao.idlivr = livro.idlivr
INNER JOIN editora
ON livro.idedi = editora.idedi
GROUP BY 1;
??????????????????????????????????????????????????????????????????

/*
Questão 14
Escreva o script sql que exiba o total de livros que cada autor tem publicado. */

SELECT autor.nome, COUNT(publiacao)
FROM autor INNER JOIN publiacao
ON autor.idaut = publiacao.idaut
GROUP BY 1;

/*
Questão 15
Considerando que a editora tenha 2 exemplares de cada livro, escreva o script SQL que retorne o valor total em livros 
que a editora possui, agrupando pelo autor. Para isto, na projeção exiba o nome do autor e o valor total e permita que seja 
exibido apenas os autores que possuam valores superiores a R$100,00. */

SELECT editora.nome, autor.nome, COUNT(livro)
FROM autor INNER JOIN publiacao
ON autor.idaut = publiacao.idaut
INNER JOIN livro
ON publiacao.idlivr = livro.idlivr
INNER JOIN editora
ON livro.idedi = editora.idedi
GROUP BY 1;?????????????????????????????????????????????????????????????????

/*
Questão 16
Considerando que a editora tenha 1 exemplar de cada livro, escreva o script SQL que retorne o valor total em livros que a 
editora possui, por assunto. Entretanto, mostra apenas os assuntos que possuam um valor total superior a R$50,00. */

SELECT assunto.nome, ??????????????????????????????

/*
Questão 17
Escreva o script SQL que retorne os títulos dos livros que possuam a sequencia de caracteres "ANC" em qualquer posição. 
*/
SELECT titulo FROM livro
WHERE titulo LIKE '%ANC%';

