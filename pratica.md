SHOW DATABASES;
USE movies_db;
SHOW TABLES;

Antes de usar;

1- Adicionar um filme à tabela de movies

INSERT INTO movies (title, rating, awards, release_date, length, genre_id)
VALUES ('My New Movie', 8.0, 3, '2020-01-01 00:00:00', 120, NULL);

#############################################

2- Adicionar um gênero à tabela de genres

INSERT INTO genres (name, ranking, active)
VALUES ('Mystery', 13, 1);

#############################################

3- Associe o gênero criado no ponto 2 ao filme do ponto 1

Se o filme (ponto 1) é o ID 22 e o gênero (ponto 2) é o ID 13 (exemplo), basta atualizar o registro do filme para apontar para esse gênero.

UPDATE movies
SET genre_id = 13
WHERE id = 22;

#############################################

4- Modifique a tabela de atores para que pelo menos um ator tenha como favorito o filme adicionado no ponto 1
Supondo que queremos atualizar o ator de id=1 para ter seu favorite_movie_id = 22 (o novo filme).

UPDATE actors
SET favorite_movie_id = 22
WHERE id = 1;

#############################################

5- Crie uma cópia temporária da tabela de movies
No MySQL, você pode criar uma tabela temporária usando o comando:

CREATE TEMPORARY TABLE movies_temp AS
SELECT *
FROM movies;

As tabelas temporárias só existem durante a sessão atual do cliente. Ao fechar a conexão MySQL, elas são descartadas automaticamente.

#############################################

6- Remova dessa tabela temporária todos os filmes que ganharam menos de 5 awards

DELETE
FROM movies_temp
WHERE awards < 5;

#############################################

7- Obtenha a lista de todos os gêneros que têm pelo menos um movie
Uma forma de obter apenas gêneros que estão associados a pelo menos um filme:

SELECT DISTINCT g.id, g.name
FROM genres g
JOIN movies m ON g.id = m.genre_id;

O JOIN só retornará linhas se houver correspondência (m.genre_id = g.id).
O DISTINCT garante que não haja repetição de gêneros caso tenha vários filmes no mesmo gênero.

Outra maneira (mais explícita) seria:

SELECT g.id, g.name
FROM genres g
WHERE g.id IN (
    SELECT m.genre_id
    FROM movies m
    WHERE m.genre_id IS NOT NULL
);

#############################################

8- Obtenha a lista de atores cujo filme favorito ganhou mais de 3 awards
Pressupondo que o campo favorite_movie_id em actors faz referência a movies.id:

SELECT a.*
FROM actors a
JOIN movies m ON a.favorite_movie_id = m.id
WHERE m.awards > 3;

#############################################

9- Crie um índice sobre o nome (título) na tabela de movies
Em MySQL, para criar um índice em uma coluna específica (por exemplo, title):

CREATE INDEX idx_movie_title
ON movies (title);

O ideal é analisar se há necessidade real de indexar title. Caso você faça muitas buscas (queries) baseadas em title (por exemplo, WHERE title = ... ou WHERE title LIKE 'X%'), isso pode melhorar a performance.

#############################################

10- Verifique se o índice foi criado corretamente
Você pode ver os índices existentes na tabela movies usando:

SHOW INDEX FROM movies;
Isso listará todos os índices existentes (nome do índice, coluna, tipo etc.).

#############################################

11- No banco de dados de movies, notaria uma melhora significativa com a criação de índices? Analise e justifique
Análise resumida
Se o volume de dados for pequeno, muitas vezes o ganho de performance não é tão significativo, pois a leitura de poucas linhas na memória é rápida.
Se o volume de dados for grande e frequentemente precisamos pesquisar filmes por título, ou filtrar por algum campo específico (como title, rating ou release_date), então sim, a criação de índices tende a melhorar bastante a velocidade das consultas.
Também depende do tipo de queries que a aplicação executa. Por exemplo, se há muitas queries do tipo SELECT * FROM movies WHERE title LIKE 'Harr%', o índice em title vai ajudar.
Em resumo, a utilidade dos índices depende do tamanho da tabela e de como as consultas são realizadas. Com poucas linhas, o ganho não é tão perceptível; com muitas linhas e buscas frequentes por esses campos, há um benefício claro.

#############################################

12- Em qual outra tabela você criaria um índice e por quê? Justifique
Sugestões:

Criar um índice em actors (last_name) ou actors (first_name, last_name), se houver buscas frequentes pelo nome do ator.
Criar um índice em actors (favorite_movie_id), se há muitas consultas ou joins que relacionam actors e movies usando favorite_movie_id.
Criar um índice em tabelas associativas (por exemplo, actor_movie) nas colunas (actor_id, movie_id) se quisermos fazer buscas rápidas de todos os filmes de um ator ou todos os atores de um filme.
Justificativa:

Se a aplicação listar atores pelo sobrenome ou fizer autocompletes e buscas por ator, indexar last_name (ou first_name) ajuda na performance.
Se houver muitas consultas de junção (JOIN) com base no campo favorite_movie_id, indexar essa coluna otimiza o join, pois o banco vai localizá-lo mais rapidamente.

### Recapitulação

INSERT em movies e genres.
UPDATE do genre_id no filme e favorite_movie_id no ator.
CREATE TEMPORARY TABLE e DELETE para manipular a tabela temporária.
SELECT com JOIN e/ou DISTINCT para encontrar gêneros com filmes e atores cujo filme favorito tem mais de 3 awards.
Criação e verificação de índice (CREATE INDEX, SHOW INDEX).
Análise do benefício de ter índices.
Proposta de criar outro índice em uma tabela (por exemplo, actors).
