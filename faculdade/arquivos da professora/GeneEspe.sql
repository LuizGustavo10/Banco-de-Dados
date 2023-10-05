CREATE TABLE pessoa (
idpessoa SERIAL NOT NULL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
telefone VARCHAR(14),
email VARCHAR(255) ); 

CREATE TABLE cliente (
idpessoa INT NOT NULL PRIMARY KEY, 
rg VARCHAR(15) NOT NULL,
cpf CHAR(11) NOT NULL,
FOREIGN KEY (idpessoa) REFERENCES pessoa (idpessoa) );

CREATE TABLE fornecedor (
idpessoa INT NOT NULL PRIMARY KEY,
cnpj CHAR(14) NOT NULL,
url VARCHAR(255),
FOREIGN KEY (idpessoa) REFERENCES pessoa (idpessoa) );

CREATE TABLE movimento (
idmov SERIAL NOT NULL PRIMARY KEY,
dtvenda DATE NOT NULL,
precototal DECIMAL(6,2),
idcliente INT REFERENCES cliente (idpessoa),
idfornecedor INT REFERENCES fornecedor (idpessoa) );

INSERT INTO pessoa (nome, telefone, email) VALUES
('Maria', null, null),
('José', '34534343', 'jose@gmail.com');






