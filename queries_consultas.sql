use ecommerce;

SELECT * FROM cliente;  -- Retorna todos os registros e colunas da tabela
SELECT Cpf, Data_nascimento FROM cliente;  -- Retorna apenas as colunas especificadas da tabela

SELECT * FROM produto;
SELECT * FROM endereco WHERE Bairro = 'Vila Mariana';  -- Retorna os registros onde a coluna é igual ao valor
SELECT * FROM produto WHERE Valor < 'R$ 2.000,00' and Valor > 'R$ 1.500,00'; -- Retorna os registros que atendem às condições especificadas

SELECT Nome, Valor FROM produto ORDER BY Nome ASC;  -- Ordena os resultados em ordem ascendente com base na coluna1
SELECT Nome, Valor FROM produto ORDER BY Nome DESC;  -- Ordena os resultados em ordem descendente com base na coluna2


SELECT * FROM pedido;

-- Quantos pedidos foram feitos por cada cliente?

SELECT IdPedido, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY IdPedido;
