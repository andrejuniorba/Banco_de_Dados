-- CONSTRUINDO BANCO DE DADOS PARA UM CENÁRIO DE OFICINA

create database if not exists oficina;
use oficina;

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
    
    create table estado(
	IdEstado int auto_increment,
    UF char(2) not null,
    constraint pk_IdEstado primary key (IdEstado)
    );
    
    create table cidade(
	IdCidade int auto_increment,
    Cidade varchar(45) not null,
    Estado_Id int not null,
    constraint pk_IdCliente_cliente primary key (IdCidade, Estado_Id),
    constraint fk_Cidade foreign key (Estado_Id) references estado (IdEstado)
    );
    
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
    
create table veiculo(
	IdVeiculo int auto_increment,
    Cliente_IdCliente int not null,
    Marca varchar(45) not null,
    Modelo varchar(45) not null,
	Ano int not null,
    constraint pk_IdVeiculo primary key (IdVeiculo, Cliente_IdCliente),
    constraint fk_Cliente_IdCliente foreign key (Cliente_IdCliente) references cliente (IdCliente)
);

create table servico(
	IdServico int auto_increment,
    Veiculo_IdVeiculo int not null,
    Descricao varchar(100) not null,
    Data_entrada date not null,
	Custo float not null,
    constraint pk_IdServico primary key (IdServico, Veiculo_IdVeiculo),
    constraint fk_Servico_IdVeiculo foreign key (Veiculo_IdVeiculo) references veiculo (IdVeiculo)
);

create table peca(
	IdPeca int auto_increment,
    Descricao varchar(45) not null,
    Quantidade int not null,
	Preco float not null,
    constraint pk_IdPeca primary key (IdPeca)
);

create table servicopeca(
	Servico_IdServico int not null,
    Peca_IdPeca int not null,
    constraint pk_IdPeca primary key (Servico_IdServico, Peca_IdPeca),
    constraint fk_Servico_IdServico foreign key (Servico_IdServico) references servico (IdServico),
    constraint fk_Peca_IdPeca foreign key (Peca_IdPeca) references peca (IdPeca)
);

create table ordemservico(
	IdOrdem int auto_increment,
    Veiculo_IdVeiculo int not null,
    Data_Inicio date not null,
    Data_Fim date not null,
    Situacao enum('Em reparo','Serviço concluído') default 'Em reparo',
    Valor float not null,
    constraint pk_IdPeca primary key (IdOrdem, Veiculo_IdVeiculo),
    constraint fk_Veiculo_IdVeiculo foreign key (Veiculo_IdVeiculo) references veiculo (IdVeiculo)
);

-- INSERINDO DADOS NAS TABELAS --

insert into cliente (Primeiro_nome,Meio_nome,Sobrenome,Cpf,Data_nascimento,Email) values 
('João', 'Silva', 'da Costa', '12345678900', '1990-05-10', 'joao.silva@gmail.com'),
('Maria', 'Santos', 'Oliveira', '98765432100', '1985-09-15', 'maria.santos@gmail.com'),
('Ana', 'Ferreira', 'Gomes', '54467896898', '1992-08-18', 'ferreira@gmail.com'),
('Pedro', 'Ferreira', 'Gomes', '45678912300', '1992-07-20', 'pedro.ferreira@gmail.com');

insert into estado (UF) values
("SP"),("RJ"),("ES"),("MG");

insert into cidade (Cidade, Estado_Id) values
("São Paulo", 1),
("Rio de Janeiro", 2),
("Vila Velha", 3),
("Belo Horizonte", 4);

insert into endereco (Cliente_Id, Cidade_Id, Cep, Logradouro, Numero, Complemento, Bairro) values
(1,1,"01234567","Rua das Flores","35","Apto 101", "Centro"),
(2,2,"54684525","Avenida das Palmeiras","15","Casa 20","Jardim Botânico"),
(3,3,"32156874","Rua dos Pinheiros","42","Sala 302", "Vila Mariana"),
(4,4,"08598745","Avenida das Acácias","33","Cobertura 501", "Barra da Tijuca");

insert into veiculo (IdVeiculo, Cliente_IdCliente, Marca, Modelo, Ano) values
(1, 1, 'Chevrolet', 'Onix', 2020),
(2, 1, 'Volkswagen', 'Gol', 2018),
(3, 2, 'Fiat', 'Uno', 2019),
(4, 3, 'Ford', 'Ka', 2017);

insert into servico (IdServico, Veiculo_IdVeiculo, Descricao, Data_entrada, Custo) values
(1, 1, 'Troca de óleo', '2023-06-01', 100.0),
(2, 1, 'Revisão completa', '2023-06-15', 350.0),
(3, 2, 'Alinhamento e balanceamento', '2023-06-05', 150.0),
(4, 3, 'Troca de pastilhas de freio', '2023-06-10', 200.0);

insert into peca (IdPeca, Descricao, Quantidade, Preco) values
(1, 'Óleo do motor', 5, 50.0),
(2, 'Filtro de ar', 10, 20.0),
(3, 'Pastilhas de freio', 4, 80.0),
(4, 'Amortecedor dianteiro', 2, 200.0);

insert into ordemservico (IdOrdem, Veiculo_IdVeiculo, Data_Inicio, Data_Fim, Situacao, Valor) values
(1, 1, '2023-06-01', '2023-06-02', 'Em reparo',100.00),
(2, 2, '2023-06-15', '2023-06-16', 'Serviço concluído',200.00),
(3, 3, '2023-06-05', '2023-06-07', default,200.00),
(4, 4, '2023-06-10', '2023-06-11', 'Serviço concluído',50.00);

insert into servicopeca (Servico_IdServico, Peca_IdPeca) values
(1,1),
(2,2),
(3,3),
(4,4);


-- APLICANDO QUERIES --

show tables;
-- Recuperações simples
SELECT * FROM Cliente;
SELECT * FROM Veiculo;
SELECT * FROM Servico;

-- Filtros
SELECT * FROM Servico WHERE data_entrada > '2023-06-01';
SELECT * FROM Veiculo WHERE marca = 'Chevrolet';

-- Ordenação
SELECT concat(Primeiro_nome,' ', Meio_nome,' ', Sobrenome) AS Nome FROM Cliente ORDER BY Nome ASC;
SELECT * FROM Servico ORDER BY custo DESC;

-- Condições de filtros aos grupos - HAVING Statement:
SELECT Veiculo_IdVeiculo, COUNT(*) AS total_servicos FROM Servico GROUP BY Veiculo_IdVeiculo HAVING COUNT(*) >= 2;
SELECT marca, AVG(ano) AS media_ano FROM Veiculo GROUP BY marca HAVING AVG(ano) > 2015;

-- Junção entre 2 tabelas
SELECT  c.Primeiro_nome, c.Sobrenome, v.Modelo FROM Cliente c INNER JOIN Veiculo v ON c.IdCliente = v.Cliente_IdCliente;

-- Junção entre 3 tabelas
SELECT  c.Primeiro_nome, c.Sobrenome, v.Modelo, s.Descricao 
FROM Cliente c INNER JOIN Veiculo v ON c.IdCliente = v.Cliente_IdCliente 
INNER JOIN Servico s ON c.IdCliente = s.Veiculo_IdVeiculo;







