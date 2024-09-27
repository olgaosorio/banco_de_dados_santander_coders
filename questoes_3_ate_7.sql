-- ==============================================================
-- | TURMA 1175 - Santander Coders 2024.1 | Data Science        |
-- | Banco de Dados I                                           |
-- ==============================================================
-- | INTEGRANTES DO GRUPO 5:                                    |
-- |    Matheus Fonseca Chaves                                  |
-- |    Olga Alejandra Osrio Aburto                             |
-- |    Matheus Gouveia De Deus Bastos                          |
-- |    Michael Gustavo Dos Santos                              |
-- ==============================================================

CREATE DATABASE database_grupo_5;  
USE database_grupo_5;

-- Criando as 3 tabelas para utilizar nos exercícios 3, 4 e 5:
CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE produtos_categorias (
    produto_id INTEGER REFERENCES produtos(id),
    categoria_id INTEGER REFERENCES categorias(id)
);

-- Adicionando itens na tabela produtos:
INSERT INTO produtos (nome, preco)
VALUES 
("Xbox Series X", 4500.00),
("Xbox Series S", 2500.00),
("PS5", 4500.00),
("Nintendo Switch", 3000.00),
("Controle Xbox Series X", 300.00),
("Headset PS5", 450.00),
("God of War PS5", 350.00),
("The Last of Us PS4", 200.00),
("Cabo HDMI 4K", 120.00),
("Teclado Mecânico", 800.00),
("Promoção Bundle Xbox", 4800.00),
("Capa Protetora PS5", 90.00),
("Película Protetora Nintendo Switch", 45.00),
("Carregador USB-C Rápido", 80.00),
("Adaptador HDMI para VGA", 65.00),
("Cabo de Áudio P2", 30.00),
("Suporte para Controle", 85.00),
("Cabo Lightning para USB", 75.00),
("Mouse Pad Gamer", 50.00),
("Cabo USB-C", 40.00),
("Fone de Ouvido", 99.00);

SELECT * FROM produtos;

-- Adicionando itens na tabela categorias:
INSERT INTO categorias (nome)
VALUES 
("Console"),
("Acessórios"),
("Jogos"),
("Cabos/Conectividade"),
("Bundle"),
("Categoria Nova");

SELECT * FROM categorias;

-- Adicionando itens na tabela produtos_categorias:
INSERT INTO produtos_categorias (produto_id, categoria_id)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(10, 2),
(7, 3),
(8, 3),
(9, 4),
(11, 5),
(12,2),
(13,2),
(14,4),
(15,4),
(16,4),
(17,2),
(18,4),
(19,2),
(20,4),
(21,2);

SELECT * FROM produtos_categorias;

-- 3) Liste os nomes de todos os produtos que custam mais de 100 reais, ordenando-os primeiramente pelo preço
-- e em segundo lugar pelo nome. Use alias para mostrar o nome da coluna nome como "Produto" e da coluna
-- preco como "Valor". A resposta da consulta não deve mostrar outras colunas de dados. 

SELECT nome AS Produto, preco AS Valor
FROM produtos
WHERE preco > 100
ORDER BY preco, nome;

-- 4) Liste todos os ids e preços de produtos cujo preço seja maior do que a média de todos os preços
-- encontrados na tabela "produtos". 

SELECT id AS ID, preco AS Valor
FROM produtos
WHERE preco > (
    SELECT AVG(preco)
    FROM produtos
);

-- 5) Para cada categoria, mostre o preço médio do conjunto de produtos a ela associados. Caso uma categoria
-- não tenha nenhum produto a ela associada, esta categoria não deve aparecer no resultado final. A consulta
-- deve estar ordenada pelos nomes 

SELECT cat.nome AS Categoria, AVG(prod.preco) AS "Preço Médio"
FROM produtos prod
JOIN produtos_categorias prod_cat
    ON prod.id = prod_cat.produto_id
JOIN categorias cat
    ON prod_cat.categoria_id = cat.id
GROUP BY cat.nome
ORDER BY cat.nome;

-- 6) Com o objetivo de demonstrar o seu conhecimento através de um exemplo contextualizado com o dia-a-dia
-- da escola, utilize os comandos do subgrupo de funções DDL para construir o banco de dados simples abaixo,
-- que representa um relacionamento do tipo 1,n entre as entidades "aluno" e "turma":

--      Tabela 1
--      Nome da tabela: aluno
--      Colunas da tabela: id_aluno (INT), nome_aluno (VARCHAR), aluno_alocado (BOOLEAN), id_turma (INT)

--      Tabela 2
--      Nome da tabela: turma
--      Colunas da tabela: id_turma (INT), código_turma (VARCHAR), nome_turma (VARCHAR)

CREATE TABLE turma (
    id_turma INT PRIMARY KEY AUTO_INCREMENT,
    codigo_turma VARCHAR(10) NOT NULL,
    nome_turma VARCHAR(80) NOT NULL
);

CREATE TABLE aluno (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome_aluno VARCHAR(80) NOT NULL,
    aluno_alocado BOOLEAN DEFAULT NULL,
    id_turma INT,
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

-- 7) Agora que você demonstrou que consegue ser mais do que um simples usuário do banco de dados, mostre
-- separadamente cada um dos códigos DML necessários para cumprir cada uma das etapas a seguir:

-- a) Inserir pelo menos duas turmas diferentes em a tabela de turmas.

INSERT INTO turma (codigo_turma, nome_turma)
VALUES ('T001', 'Turma de Matematica'),
       ('T002', 'Turma de Física');

-- b) Inserir pelo menos 1 aluno alocado em cada uma destas turmas na tabela aluno.

INSERT INTO aluno (nome_aluno, aluno_alocado, id_turma)
VALUES ('Ana Silva', NULL, 1),
       ('Carlos Souza', NULL, 2);

-- c) Inserir pelo menos 2 alunos não alocados em nenhuma turma na tabela aluno.

INSERT INTO aluno (nome_aluno, aluno_alocado, id_turma)
VALUES ('João Pereira', NULL, NULL),
       ('Maria Lima', NULL, NULL);

-- d) Atualizar a coluna aluno_alocado da tabela aluno, de modo que os alunos associados a 
-- uma disciplina recebam o valor True e alunos não associdos a nenhuma disciplina recebam o falor False para esta coluna

-- O código abaixo está correto e funciona, mas precisa desativar a opção de "Safe Mode"
-- nas configurações do MySQL, pois ela proíbe realizar update sem where
-- UPDATE aluno
-- SET aluno_alocado = CASE 
--                         WHEN id_turma IS NOT NULL THEN TRUE 
--                         ELSE FALSE 
--                     END;

UPDATE aluno
SET aluno_alocado = TRUE
WHERE id_turma IS NOT NULL;

UPDATE aluno
SET aluno_alocado = FALSE
WHERE id_turma IS NULL;
