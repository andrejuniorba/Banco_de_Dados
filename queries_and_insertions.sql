use ecommerce;
show tables;
desc cliente;

-- ('Primeiro_nome','Meio_nome','Sobrenome','Cpf','Data_nascimento','Email') 
-- Inserindo clientes --
insert into cliente (Primeiro_nome,Meio_nome,Sobrenome,Cpf,Data_nascimento,Email)
values 
	("João", "Carlos", "Silva","12345678900", "1990-03-15", "joao.silva@example.com"),
	("Maria", "Fernanda", "Santos","98765432100", "1985-08-10", "maria.santos@example.com"),
	("Pedro", "Henrique", "Oliveira","45612378900", "1995-11-05", "pedro.oliveira@example.com"),
	("Ana", "Luiza", "Pereira","78932165400", "1992-09-02", "ana.pereira@example.com"),
    ("Rosana", "Silva", "Lima","78932356400", "1992-10-02", "rosana@example.com");

insert into endereco (Cliente_Id, Cidade_Id, Cep, Logradouro, Numero, Complemento, Bairro) values
(1,1,"01234567","Rua das Flores","35","Apto 101", "Centro"),
(2,2,"54684525","Avenida das Palmeiras","15","Casa 20","Jardim Botânico"),
(3,3,"32156874","Rua dos Pinheiros","42","Sala 302", "Vila Mariana"),
(4,4,"08598745","Avenida das Acácias","33","Cobertura 501", "Barra da Tijuca");

insert into estado (UF) values
("SP"),("RJ"),("ES"),("MG");

insert into cidade (Cidade, Estado_Id) values
("São Paulo", 1),
("Rio de Janeiro", 2),
("Vila Velha", 3),
("Belo Horizonte", 4);

select * from cliente;

insert into produto (Nome, Categoria, Descricao, Valor, Avaliacao)
values
    ('Smartphone XYZ', 'Eletrônico', 'Um smartphone de última geração com uma câmera de alta resolução e um processador poderoso.', 'R$ 1.500,00', 4.5),
    ('Livro de Matemática Avançada', 'Educação', 'Um livro abrangente sobre tópicos avançados de matemática, adequado para estudantes e profissionais.', 'R$ 120,00', 4.2),
    ('Guitarra Elétrica Modelo ABC', 'Música', 'Uma guitarra elétrica de alta qualidade com um design elegante e um som potente.', 'R$ 800,00', 4.7),
    ('Notebook XYZ', 'Tecnologia', 'Um notebook leve e poderoso, perfeito para trabalho e entretenimento.', 'R$ 2.000,00', 4.8);
    
 select * from produto;
 
 insert into pagamento (Data_pagamento, pagamento_confirmado) values
    ('2023-07-01 09:00:00', True),
    ('2023-07-02 14:30:00', False),
    ('2023-07-03 18:45:00', True),
    ('2023-07-04 11:15:00', True);

insert into notafiscal (Data_emissao, Numero_nota, Valor) values
	('2023-07-01 09:30:00', 123456, 1500.50),
	('2023-07-02 14:45:00', 789012, 2500.75),
	('2023-07-03 18:20:00', 345678, 1000.00),
	('2023-07-04 10:00:00', 901234, 500.25);

 
 
 insert into pedido (Cliente_Id,Pagamento_Id,Nota_fiscal_Id, Status_pedido, Descricao, Frete,Data_pedido_realizado, Data_pedido_concluido) values 
	(1,1,1,'Produto enviado', 'Camiseta branca', 8.5, '2023-07-01 10:30:00', '2023-07-02 15:45:00'),
	(2,2,2,default, 'Calça jeans azul', 5.0, '2023-07-02 14:15:00', '2023-07-03 11:20:00'),
	(3,3,3,'Produto entregue', 'Tênis preto', 12.0, '2023-07-03 09:00:00', '2023-07-04 16:10:00'),
	(4,4,4,'Processando o pedido', 'Bolsa de couro marrom', 7.2, '2023-07-04 13:20:00', '2023-07-05 10:05:00');    

select * from pedido;

insert into vendedor (Cpf_vendedor,Razao_social,Localidade) values
("12345678901", "Empresa A", "São Paulo"),
("15365432109", "Empresa B", "Rio de Janeiro"),
("98765432109", "Empresa C", "Rio de Janeiro"),
("45612378904", "Empresa D", "Belo Horizonte");

insert into fornecedor (Fornecedor_Razao_social,Cnpj,Contato) values
("Fornecedor1", "12345678901234", "12345678901"),
("Fornecedor2", "98765432109876", "98765432109"),
("Fornecedor3", "56789012345678", "56789012345"),
("Fornecedor4", "09876543210987", "09876543210");

insert into estoque (Localidade, Quantidade) values 
	("Localidade1", 10),
    ("Localidade2", 5),
    ("Localidade3", 20),
    ("Localidade4", 15);
    
insert into vendedorproduto (idVendedorProduto,idProduto,Quantidade) values 
	(9,1, 15),
    (10,2, 50),
    (11,3, 20),
    (12,4, 15);
    
    select * from pedido;
    
insert into produtoestoque (IdProduto_estoque, IdEstoque_produto, Localizacao) values
    (1,1,"São Paulo"),
	(2,2,"Rio de Janeiro"),
	(3,3,"Vila Velha"),
	(4,4,"Belo Horizonte");

insert into produtopedido (IdProduto_pedido,IdPedido_pedido,Quantidade,Status_disponibilidade) values
	(1,5,500,"Disponível"),
	(2,6,50,"Disponível"),
	(3,7,0,"Indisponível"),
	(4,8,650,"Disponível");
    
-- Número de clientes
select count(*) from cliente;

select * from cliente;

-- Verificar pedidos feitos pelos clientes
select * from cliente c, pedido p where c.idCliente = IdPedido;

-- concatenando o nome completo e adicionando alias (apelido)
select concat(Primeiro_nome,' ', Meio_nome,' ', Sobrenome) as Nome, IdPedido as Pedido, Status_pedido as Status from cliente c, pedido p where c.idCliente = IdPedido;

select * from pedido;

insert into pedido (Cliente_Id,Pagamento_Id,Nota_fiscal_Id, Status_pedido, Descricao, Frete,Data_pedido_realizado, Data_pedido_concluido) values 
	(4,4,4,'Produto enviado', 'Camiseta branca', 8.5, '2023-07-01 10:30:00', '2023-07-02 15:45:00');