SHOW DATABASES;
USE movies_db;
SHOW TABLES;

Antes de usar;

1- Mostrar todos os registros da tabela de filmes

SELECT *
FROM movies;

#############################################

2- Exibir o primeiro nome, o sobrenome e a classificação de todos os atores

SELECT first_name, last_name, rating
FROM actors;

#############################################

3- Exibir o título de todas as séries e usar aliases para que o nome da tabela e o campo estejam em inglês
Por exemplo, podemos chamar a tabela de Series e o campo de Title:

SELECT s.title AS 'Title'
FROM series AS s;

Se quiser incluir mais informações ou renomear a tabela em si, ficaria algo como:

SELECT s.title AS 'SeriesTitle'
FROM series AS Series;

#############################################

4- Exibir o primeiro nome e o sobrenome dos atores cuja classificação seja superior a 7,5

SELECT first_name, last_name
FROM actors
WHERE rating > 7.5;

#############################################

5- Exibir o título do filme, a classificação e os prêmios dos filmes com classificação superior a 7,5 e com mais de dois prêmios

SELECT title, rating, awards
FROM movies
WHERE rating > 7.5
  AND awards > 2;

#############################################

6- Exibir o título do filme e a classificação ordenados por classificação em ordem crescente

SELECT title, rating
FROM movies
ORDER BY rating ASC;


#############################################

7- Exibir os títulos dos filmes e a classificação ordenados por classificação
Caso não especifique ASC ou DESC, o MySQL ordena por padrão em ordem crescente. Então ficaria igual ao anterior:

SELECT title, rating
FROM movies
ORDER BY rating;

#############################################

8- Exibir os títulos dos três primeiros filmes no banco de dados

SELECT title
FROM movies
LIMIT 3;

#############################################

9- Exibir os 5 filmes mais bem classificados
Para pegar os “mais bem classificados” (ou seja, maior rating primeiro-, ordene em ordem decrescente:

SELECT title, rating
FROM movies
ORDER BY rating DESC
LIMIT 5;

#############################################

10- Listar os 10 primeiros atores

SELECT first_name, last_name
FROM actors
LIMIT 10;


#############################################

11- Exibir o título e a classificação de todos os filmes cujo título é "Toy Story"

SELECT title, rating
FROM movies
WHERE title = 'Toy Story';

#############################################

12- Exibir todos os atores cujos nomes começam com "Sam"

SELECT *
FROM actors
WHERE first_name LIKE 'Sam%';

#############################################

13- Exibir o título dos filmes lançados entre 2004 e 2008

SELECT title
FROM movies
WHERE YEAR(release_date- BETWEEN 2004 AND 2008;

#############################################

14- Exibir o título dos filmes com classificação superior a 3, com mais de 1 prêmio e com data de lançamento entre 1988 e 2009. Ordenar os resultados por classificação

SELECT title, rating, awards, release_date
FROM movies
WHERE rating > 3
  AND awards > 1
  AND YEAR(release_date- BETWEEN 1988 AND 2009
ORDER BY rating;

Caso queira do maior para o menor, use ORDER BY rating DESC;.


#############################################
