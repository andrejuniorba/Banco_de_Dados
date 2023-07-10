-- Criação do BD para o cenário E-commerce --
-- drop database ecommerce;
create database if not exists ecommerce;
use ecommerce;

-- criação da tabela cliente --

create table cliente(
	IdCliente int auto_increment,
    Primeiro_nome varchar(45) not null,
    Meio_nome varchar(20) not null,
    Sobrenome varchar(20) not null,
    Cpf char(11) not null,
    Data_nascimento date not null,
    Email varchar(255) not null,
    constraint pk_IdCliente_cliente primary key (IdCliente),
    constraint unique_Cpf_cliente unique (Cpf),
    constraint unique_Email_cliente unique (Email)
);

-- alter table cliente auto_increment = 1;

create table endereco(
	IdEndereco int auto_increment,
    Cliente_Id int not null,
    Cidade_Id int not null,
    Cep char(8) not null,
    Logradouro varchar(100) not null,
    Numero int not null,
    Complemento varchar(255),
    Bairro varchar(45) not null,
    constraint pk_IdCliente_cliente primary key (IdEndereco,Cliente_Id, Cidade_Id),
    constraint fk_Cliente_Endereco foreign key (Cliente_Id) references cliente (IdCliente),
    constraint fk_Endereco_Cidade foreign key (Cidade_Id) references cidade (IdCidade)
    );
    
    create table cidade(
	IdCidade int auto_increment,
    Cidade varchar(45) not null,
    Estado_Id int not null,
    constraint pk_IdCliente_cliente primary key (IdCidade, Estado_Id),
    constraint fk_Cidade foreign key (Estado_Id) references estado (IdEstado)
    );
    
    create table estado(
	IdEstado int auto_increment,
    UF char(2) not null,
    constraint pk_IdEstado primary key (IdEstado)
    );

-- desc cliente;

-- criação da tabela produto --

create table produto(
	IdProduto int auto_increment,
    Nome varchar(45) not null,
    Categoria enum('Eletrônico', 'Educação', 'Música', 'Tecnologia') not null,
    Descricao longtext not null,
	Valor varchar(45) not null,
    Avaliacao float default 0,
    constraint pk_IdProduto_produto primary key (IdProduto)
);

-- alter table produto auto_increment = 1;
-- desc produto;

-- criação da tabela pagamento --

create table pagamento(
	IdPagamento int auto_increment,
    Data_pagamento datetime not null,
    Pagamento_confirmado bool not null,
    constraint pk_IdPagamento primary key (IdPagamento)
    );

create table notafiscal(
	IdNota_fiscal int auto_increment,
    Data_emissao datetime not null,
    Numero_nota int not null,
    Valor float not null,
    constraint pk_IdPagamento primary key (IdNota_fiscal)
    );
-- criação da tabela pedido --

create table pedido(
	IdPedido int auto_increment,
    Cliente_Id int not null,
    Pagamento_Id int not null,
    Nota_fiscal_Id int not null,
    Status_pedido enum('Processando o pedido', 'Produto enviado', 'Produto entregue') default 'Processando o pedido',
    Descricao varchar(100),
    Frete float default 0,
	Data_pedido_realizado datetime not null,
    Data_pedido_concluido datetime not null,
    constraint pk_IdPedido_ClienteId_pedido primary key (IdPedido, Cliente_Id, Pagamento_Id,Nota_fiscal_Id),
    constraint fk_ClientePedido_IdPagamento foreign key (Pagamento_Id) references pagamento (IdPagamento),
    constraint fk_ClientePedido_NotaFiscal foreign key (Nota_fiscal_Id) references notafiscal (IdNota_fiscal),
    constraint fk_ClientePedido_IdCliente_pedido foreign key (Cliente_Id) references cliente (IdCliente)
		on update cascade
);

-- criação da tabela vendedor --

create table vendedor(
	IdVendedor int auto_increment,
    Cpf_vendedor char(11) not null,
    Razao_social varchar(45) not null,
    Localidade varchar(100),
    constraint pk_IdVendedor_vendedor primary key (IdVendedor),
    constraint unique_Cpf_vendedor unique (Cpf_vendedor),
    constraint unique_Razao_social_vendedor unique (Razao_social)
);

-- criação da tabela fornecedor --

create table fornecedor(
	IdFornecedor int auto_increment,
    Fornecedor_Razao_social varchar(20) not null,
    Cnpj varchar(20) not null,
    Contato char(11),
    constraint pk_IdFornecedor primary key (IdFornecedor),
    constraint Fornecedor_Razao_social_vendedor unique (Fornecedor_Razao_social),
    constraint Cnpj_Razao_social_vendedor unique (Cnpj)
);

-- criação da tabela estoque --

create table estoque(
	IdEstoque int auto_increment,
    Localidade varchar(45) not null,
    Quantidade int default 0,
    constraint pk_IdEstoque primary key (IdEstoque)
);

-- criação da tabela de relação Vendedor/produto --

create table vendedorproduto(
	idVendedorProduto int,
    idProduto int,
    Quantidade int default 1,
    primary key (idVendedorProduto,idProduto), 
    constraint fk_Vendedor_Produto foreign key (idVendedorProduto) references vendedor (IdVendedor),
    constraint fk_Produto_Produto foreign key (idProduto) references produto (IdProduto)
);

-- criação da tabela de relação produto/estoque --

create table produtoestoque(
	IdProduto_estoque int,
    IdEstoque_produto int,
    Localizacao varchar(45) not null,
    primary key (IdProduto_estoque,IdEstoque_produto), 
    constraint fk_Produto_estoque foreign key (IdProduto_estoque) references produto (IdProduto),
    constraint fk_Estoque_Produto foreign key (idEstoque_produto) references estoque (IdEstoque)
);

-- criação da tabela de relação produto/estoque --

create table produtopedido(
	IdProduto_pedido int,
    IdPedido_pedido int,
    Quantidade int not null,
    Status_disponibilidade enum('Disponível', 'Indisponível') default 'Disponível',
    primary key (IdProduto_pedido,IdPedido_pedido), 
    constraint fk_Produto_pedido foreign key (IdProduto_pedido) references produto (IdProduto),
    constraint fk_Pedido_pedido foreign key (IdPedido_pedido) references pedido (IdPedido)
);

-- show tables;
-- use information_schema;
-- show tables;
-- desc referential_constraints;
-- select * from referential_constraints where constraint_schema = 'ecommerce';