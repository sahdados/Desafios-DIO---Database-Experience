create database ecommerce;
use ecommerce;
drop database ecommerce;
-- criar tabela cliente

create table cliente(
idCliente int auto_increment primary key,
PNome varchar(10),
SNome char(3),
UNome varchar(20),
CPF char(11) not null,
Endereço varchar(200),
constraint unique_cpf_cliente unique (CPF));

alter table cliente auto_increment = 1;

insert into cliente (PNome, SNome, UNome, CPF, Endereço)
values ('Maria', 'M', 'Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das Flores'),
       ('Matheus', 'O', 'Pimentel', 987654321, 'rua alameda 289, Centro - Cidade das Flores'),
       ('Ricardo', 'F', 'Silva', 45678913, 'avenida alameda vinha 1009, Centro - Cidade das Flores'),
       ('Julia', 'S', 'França', 789123456, 'rua laranjeiras 861, Centro - Cidade das Flores'),
       ('Roberta', 'G', 'Assis', 98745631, 'avenida koller 19, Centro - Cidade das Flores'),
       ('Isabela', 'M', 'Cruz', 654789123, 'rua alameda das flores 28, Centro - Cidade das Flores');

select * from cliente;

-- criar tabela produto

create table produto(
idProduto int auto_increment primary key,
Pname varchar (50) not null,
categoria enum ('Eletrônico', 'Vestimenta', 'Briquendo', 'Alimento', 'Movéis') not null, 
avaliacao float default 0,
dimensao varchar(10));
 
 alter table produto auto_increment = 1;
 
 insert into produto (PName, categoria, avaliacao, dimensao)
values ('Fone de ouvido', 'Eletrônico', '4', null),
       ('Barbie Elsa', 'Briquendo', '3', null),
       ('Body Carters', 'Vestimenta', '4', null),
       ('Microfone Vedo - Youtuber', 'Eletrônico', '4', null),
       ('Sofá retrátil', 'Móveis', '3', '3x57x80');
       
select * from produto;

-- criar tabela pedido


create table pedido(
idPedido int auto_increment primary key,
id_pedido_cliente int,
Status_pedido enum ('Cancelado', 'Confirmado', 'Em Processamento') default 'Em Processamento',
Descricao_pedido varchar (255),
Frete float default 10,
constraint fk_pedido_clientes foreign key (id_pedido_cliente) references cliente(idCliente));


delete from pedido where id_pedido_cliente in (1, 2, 3, 4);
insert into pedido (id_pedido_cliente, Status_pedido, Descricao_pedido, Frete)
values (1, default,'Compra via aplicativo', null),
       (2, default, 'Compra via aplicativo', 50),
       (3, 'Confirmado', 'Body Carters', null),
       (4, default,'Compra via Web Site', 150);
       
 select * from pedido;
 
-- criar tabela de estoque

create table estoque(
idEstoque int auto_increment primary key,
local_estoque varchar(255),
quantidade int default 0);

insert into estoque (local_estoque, quantidade) values
('Rio de Janeiro' ,1000),
('Rio de Janeiro' ,500),
('São Paulo' ,10),
('São Paulo' ,100),
('São Paulo' ,10),
('Brasília' , 600);


-- criar tabela fornecedor

create table fornecedor(
idFornecedor int auto_increment primary key,
Razao_social varchar(255) not null,
CNPJ char(15) not null unique,
Contato varchar(11) not null);

insert into fornecedor (Razao_social, CNPJ, Contato) values
('Almeida e filho', 123456789123456, 21985474),
('Eletrênicos Silva', 854519649143457, 21985484),
('Eletônicos Valma', 934567893934695, 21975474);

-- criar tabela vendedor

drop table vendedor;
create table vendedor(
idVendedor int auto_increment primary key,
nome_social varchar (255) not null,
CNPJ char(15) unique,
CPF char (9) unique,
contato char (11) not null);

insert into vendedor (nome_social, CNPJ, CPF, contato) values
('Tech eletronics', 12356789456321, null, 219946287),
('Botique Durgas', null, 123456783, 219567895),
('Kids World', 456789123654485, null, 1198657484);

create table produto_vendedor(
idPvendedor int,
idPproduto int,
prod_quantidade int default 0,
primary key (idPvendedor, idPproduto),
constraint fk_produto_vendedor foreign key (idPvendedor) references vendedor (idVendedor),
constraint fk_produto_produto foreign key (idPproduto) references produto (idProduto));

insert into produto_vendedor (idPvendedor, idPproduto, prod_quantidade) values
(1, 1, 500),
(1, 2, 400),
(2, 4, 633),
(3, 3, 5),
(2, 5, 10);

create table produto_pedido(
idPOpedido int,
idPOproduto int,
po_quantidade int default 1,
po_status enum ('Disponível' ,'Sem estoque') default 'Disponível',
primary key (idPOpedido, idPOproduto),
constraint fk_produto_pedido foreign key (idPOpedido) references pedido (idPedido),
constraint fk_produto_produto_pedido foreign key (idPOproduto) references produto (idProduto));

insert into produto_pedido (idPOpedido, idPOproduto, po_quantidade, po_status)
values (1, 1, 2, null),
       (2, 1, 1, null),
       (3, 2, 1, null);  

create table localidade_estoque(
idLestoque int,
idLproduto int,
localidade varchar (255) not null,
primary key (idLestoque, idLproduto),
constraint fk_produto_estoque_pedido foreign key (idLestoque) references estoque (idEstoque),
constraint fk_produto_estoque_produto foreign key (idLproduto) references produto (idProduto));

insert into localidade_estoque (idLestoque, idLproduto, localidade) values
(1, 2, 'RJ'),
(2, 5, 'GO');

create table produto_fornecedor(
idPFornecedor int,
idPFproduto int,
quantidade int not null,
primary key (idPFornecedor, idPFproduto),
constraint fk_produto_fornecedor foreign key (idPFornecedor) references fornecedor (idFornecedor),
constraint fk_produto_fornecedor_produto foreign key (idPFproduto) references produto (idProduto));

insert into produto_fornecedor(idPFornecedor, idPFproduto, quantidade) values
(1, 2, 10),
(2, 4, 10);
 
show tables;

-- inserindo informações

select count(*) from cliente;
select * from cliente;
select * from pedido;

select concat(PNome, ' ', UNome) as nome_completo, count(*) as total_pedido, CPF, Status_pedido, Frete from cliente c, pedido p where c.idCliente = p.idPedido
group by P.idPedido;

select * from estoque e ; 

select sum(quantidade) as total_estoque, max(quantidade) as max_estoque, min(quantidade) as min_estoque, round(avg(quantidade),2) as media_estoque from estoque;

select * from estoque e, localidade_estoque l where  e.idEstoque = l.idLestoque;

select * from vendedor;
select * from fornecedor;

select nome_social from vendedor v, fornecedor f where idFornecedor = idVendedor;

select * from fornecedor f
inner join  produto p on f.idFornecedor = p.idProduto;
