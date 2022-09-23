Create schema boot_oficina;
use boot_oficina;

-- criei as tabelas e inseri os dados nas tabelas 
-- Criar a tabela cliente
create table Cliente(
Idcliente varchar(8) not null primary key,
Nome Varchar(40),
CPF varchar(11) not null, 
Endereco Varchar(45),
Telefone varchar(12),
Idplaca varchar(9) not null);

-- criado o alter table após a criação da tabela veiculo 
alter table Cliente add constraint fk_placa_veiculo foreign key (Idplaca) references Veiculo (Placa_veiculo);

insert into Cliente (Idcliente, Nome, CPF, Endereco, Telefone, Idplaca)
values ('C1','ROSE SANTOS', '12346789876', 'rua canário 56, Cidade das Flores', '11999214315', 'abc0123'),
	('C2', 'FELIPE TEIXEIRA', '12345789876', 'rua pavão 289, Cidade das Flores', '11955844801', 'abc0023'),
	('C3', 'SIMONE RODRIGUES', '23456898654', 'avenida curuça 79 Cidade das Flores', '11988819500','ddc0112'),
	('C4', 'FABIANE SANTOS',  '12345679765', 'rua  sabiá 861 Cidade das Flores', '11973352118', 'ccd1100'),
	('C5', 'LUCAS CRUZ', '12345678765', 'avenida gaivota 19 Cidade das Flores', '11988005772', 'bbc0011'),
	('C6', 'LUCAS CRUZ', '12345678765', 'avenida gaivota 19 Cidade das Flores', '11988005772', 'bcl1010');


-- criar tabela veiculo
create table Veiculo(
Placa_veiculo varchar(9) primary key not null,
Modelo varchar(50),
Cor varchar(12));

insert into veiculo (Placa_veiculo, Modelo, Cor)
values ('abc0123', 'celta veloz - 2003', 'cinza'),
       ('abc0023', 'gol bolinha - 1999', 'preto'),
       ('ddc0112', 'siena senna - 2002', 'vinho'),
       ('ccd1100', 'palio xxt - 2001', 'branco'),
       ('bbc0011', 'parati gcl - 2015', 'preto'),
       ('bcl1010', 'uno 3x - 2007', 'cinza');


-- criar tabela Autorização

create table Autorizacao(
Idautorizacao varchar(8) primary key not null,
IdCliente_autorizacao varchar(8) not null,
Idmecanico_autorizacao varchar(4) not null,
Andamento enum ('Autorizado', 'Cancelado'),
Pagamento enum ('Boleto', 'Cartão débito', 'Cartão crédito', 'Dinheiro', 'Cancelado'),
constraint fk_autorizacao_cliente foreign key (IdCliente_autorizacao) references Cliente (Idcliente),
constraint fk_autorizacao_mecanico foreign key (Idmecanico_autorizacao) references Mecanico (Idmecanico));

Alter table Autorizacao add IdOS_autorizacao varchar(8) not null;
update Autorizacao set IdOS_autorizacao = 'OS1' where Idautorizacao = 'A1';
update Autorizacao set IdOS_autorizacao = 'OS2' where Idautorizacao = 'A2';
update Autorizacao set IdOS_autorizacao = 'OS3' where Idautorizacao = 'A3';
update Autorizacao set IdOS_autorizacao = 'OS4' where Idautorizacao = 'A4';
update Autorizacao set IdOS_autorizacao = 'OS5' where Idautorizacao = 'A5';
update Autorizacao set IdOS_autorizacao = 'OS6' where Idautorizacao = 'A6';


Select *from Autorizacao; 

insert into Autorizacao (Idautorizacao, IdCliente_autorizacao, Idmecanico_autorizacao, 
Andamento, Pagamento)
values ('A1', 'C1', 'M1', 'Autorizado', 'Boleto'),
       ('A2', 'C2', 'M2', 'Cancelado', 'Cancelado'),
       ('A3', 'C3', 'M3', 'Autorizado', 'Cartão crédito'),
       ('A4', 'C4', 'M4', 'Cancelado', 'Cancelado'),
       ('A5', 'C5', 'M2', 'Autorizado', 'Dinheiro'),
       ('A6', 'C6', 'M3', 'Autorizado', 'Cartão débito');

-- criar tabela ordem_servico
create table Ordem_servico(
Idos varchar(8) not null primary key,
Idautorizacao_os varchar(8) not null,
Placa_veiculo_os varchar(8) not null,
Idpecas_os varchar(8) not null,
Idreferencia_servico_os varchar(8) not null,
Idmecanico_os varchar(8) not null,
Data_emissao date,
Data_conclussao date,
Satus_os enum ('Em Processamento', 'Finalizado'),
constraint fk_os_autorizacao foreign key (Idautorizacao_os) references Autorizacao (Idautorizacao),
constraint fk_os_placaveiculo foreign key (Placa_veiculo_os) references Veiculo (Placa_veiculo),
constraint fk_os_pecas foreign key (Idpecas_os) references Pecas (Idpecas),
constraint fk_os_referenciaservico foreign key (Idreferencia_servico_os) references Referencia_servico (Idreferencia_servico),
constraint fk_os_mecanico foreign key (Idmecanico_os) references Mecanico (Idmecanico));

-- Devido alguns erros para incluir os dados tive que fazer drop nas duas tabelas
Drop table Ordem_servico, Autorizacao;

insert into Ordem_servico (Idos, Idautorizacao_os, Placa_veiculo_os, Idpecas_os, Idreferencia_servico_os,
 Idmecanico_os, Data_emissao, Data_conclussao, Satus_os)
values ('OS1', 'A1', 'abc0123', 'P1', 'RS1', 'M1', '2021-03-15', '2021-04-02', 'Em Processamento');
insert into ordem_servico (Idos, Idautorizacao_os, Placa_veiculo_os, Idpecas_os, Idreferencia_servico_os,
 Idmecanico_os, Data_emissao, Data_conclussao, Satus_os)
values('OS2', 'A2', 'abc0023', 'P2', 'RS2', 'M2', '2021-03-17', '2021-03-20', 'Finalizado');
insert into ordem_servico (Idos, Idautorizacao_os, Placa_veiculo_os, Idpecas_os, Idreferencia_servico_os,
 Idmecanico_os, Data_emissao, Data_conclussao, Satus_os)
values ('OS3', 'A3', 'ddc0112',  'P3', 'RS3','M3', '2021-05-20', '2021-06-28', 'Em Processamento'),
      ('OS4', 'A4', 'ccd1100',  'P4', 'RS4', 'M4', '2021-04-30', '2021-05-15', 'Finalizado'),
      ('OS5', 'A5', 'bbc0011',  'P1', 'RS5', 'M2', '2021-05-02', '2021-05-17', 'Em Processamento'),
      ('OS6', 'A6', 'bcl1010',  'P1', 'RS3', 'M1', '2021-05-30', '2021-07-15', 'Em Processamento');


create table Referencia_servico(
Idreferencia_servico varchar(5) primary key Not null,
Servico varchar(50),
Tempo_execucao varchar(10),
Valor_servico float);

insert into Referencia_servico (Idreferencia_servico, Servico, Tempo_execucao, Valor_servico)
values ('RS1', 'trocar o parachoque', '5 horas', 200.00),
	('RS2', 'lixar e pintar', ' 210 horas', 1100.00),
        ('RS3', 'troca de oleo', '2 horas', 60.00),
        ('RS4', 'troca de vela', '4 horas', 100.00),
        ('RS5', 'alinhamento', '3 horas', 230.00);

-- criar tabela pecas

create table Pecas(
Idpecas varchar(5) primary key,
Nome varchar(20),
Valor_pecas float,
Estoque int, 
Fornecedor_CNPJ char(14),
Razao_social Varchar(20));

insert into Pecas (Idpecas, Nome, Valor_pecas, Estoque, Fornecedor_CNPJ, Razao_social)
values ('P1', 'parachoque', 1000.00, 3, '47596012000156', 'Rei das peças');
insert into Pecas (Idpecas, Nome, Valor_pecas, Estoque, Fornecedor_CNPJ, Razao_social)
values('P2', 'óleo', 60.00, 15, '06872943000176', 'Milagres oleos');
insert into Pecas (Idpecas, Nome, Valor_pecas, Estoque, Fornecedor_CNPJ, Razao_social)
values('P3', 'vela', 100.00, 7, '96829305000123', 'Joao automotivo');
insert into Pecas (Idpecas, Nome, Valor_pecas, Estoque, Fornecedor_CNPJ, Razao_social)
values('P4', 'rolamento', 100.00, 10, '86763485000178', 'Peças João e Maria');
        
-- criar tabela Mecanico
create table mecanico(
Idmecanico varchar(4) not null primary key,
Nome varchar(40),
CPF varchar(11) not null,
Endereco varchar(45),
Telefone varchar(11));


insert into Mecanico (Idmecanico, Nome, CPF, Endereco, Telefone)
values ('M1','BRUNO PORTE', '56789012345', 'Rua Paraná - 38, Jardim da borboleta', '11988821779'),
	('M2','VANDERLEI AUGUSTO', '56890123456', 'Avenida Brasil - 51, Parque dos passaros', '11977537518'),
        ('M3','RODRIGO RIBEIRO', '56790123456', 'Rua Bela Vista - 89, Cidade das abelhas', '11999419073'),
        ('M4','Antonio Amo', '49548605127', 'Rua Copacabana - 783, Vila das formigas', '11999546684');

Select * From Cliente;
Select * From Veiculo;
Select * From Mecanico;
Select * From Pecas;
Select * From Referencia_servico;
Select * From Autorizacao;
Select * From Ordem_servico;

-- Relação de clientes, veiculo e modelo
Select Idcliente, Nome, Placa_veiculo, Modelo, Cor from Cliente join Veiculo on Idplaca = Placa_veiculo; 

-- Relação de clientes e autorização de serviço
Select Idcliente, Nome, Idautorizacao, Andamento, Pagamento from cliente join autorizacao 
on idcliente = IdCliente_autorizacao where Andamento = 'autorizado';

-- Placas, valor das peças e serviços
Select Idos, Placa_veiculo_os, valor_pecas, Valor_servico From Ordem_servico
inner join Pecas on Idpecas_os = Idpecas
right join Referencia_servico on Idreferencia_servico_os = Idreferencia_servico;

-- Para saber o Mecanico que finalizou o serviço
Select Idos, Placa_veiculo_os, Satus_os, Idmecanico_os, Nome From Ordem_servico join Mecanico on Idmecanico_os = Idmecanico 
order by Satus_os desc;

-- Placas, valor das peças, serviços e total
Select Idos, Placa_veiculo_os, valor_pecas, Valor_servico, SUM(valor_pecas + Valor_servico) as Total From Ordem_servico
join Pecas on Idpecas_os = Idpecas
join Referencia_servico on Idreferencia_servico_os = Idreferencia_servico
Group by Placa_veiculo_os;

-- Placas, valor das peças, serviços e total com condição maior que 200
Select Idos, Placa_veiculo_os, valor_pecas, Valor_servico, SUM(valor_pecas + Valor_servico) as Total From Ordem_servico
join Pecas on Idpecas_os = Idpecas
join Referencia_servico on Idreferencia_servico_os = Idreferencia_servico
Group by Placa_veiculo_os having valor_pecas >200;

