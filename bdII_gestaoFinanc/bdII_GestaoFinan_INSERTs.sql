CREATE DATABASE GestaoFinanceira;
USE GestaoFinanceira;

#DROP DATABASE GestaoFinanceira;

CREATE TABLE IF NOT EXISTS Funcionarios (
	id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Caixas (
	id_caixa INT PRIMARY KEY AUTO_INCREMENT,
	saldo_inicio DECIMAL NOT NULL,
    saldo_final DECIMAL NOT NULL,
    total_entradas DECIMAL NOT NULL,
    total_saidas DECIMAL NOT NULL,
    status_caixa VARCHAR(10) NOT NULL,
    id_funcionario_fk INT NOT NULL,
    FOREIGN KEY (id_funcionario_fk) REFERENCES Funcionarios(id_funcionario)
);

CREATE TABLE IF NOT EXISTS Fornecedores (
	id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    cnpj VARCHAR(24),
    ativo BOOLEAN,
    atividade_economica VARCHAR(255),
    telefone VARCHAR(16),
    email VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Despesas (
	id_despesa INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE,
    status_despesa VARCHAR(10) NOT NULL,
    id_caixa_fk INT NOT NULL,
    id_fornecedores_fk INT NOT NULL,
    FOREIGN KEY (id_caixa_fk) REFERENCES Caixas(id_caixa),
    FOREIGN KEY (id_fornecedores_fk) REFERENCES Fornecedores(id_fornecedor)
);

CREATE TABLE IF NOT EXISTS Dispositivos (
	id_dispositivo INT PRIMARY KEY AUTO_INCREMENT,
    aliquota DECIMAL NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    status_dispositivos VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Clientes (
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL,
    telefone VARCHAR(16) NOT NULL,
    data_nascimento DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Servicos (
	id_servico INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    tempo VARCHAR(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS Vendas (
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    hora TIME NOT NULL,
    valorTotal DECIMAL NOT NULL,
    desconto DECIMAL NOT NULL,
    valorFinal DECIMAL NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    id_cliente_fk INT,
    FOREIGN KEY (id_cliente_fk) REFERENCES Clientes(id_cliente)
);

CREATE TABLE IF NOT EXISTS vendasServicos (
	id_vendaServico INT PRIMARY KEY AUTO_INCREMENT,
    id_venda_fk INT,
    id_servico_fk INT NOT NULL,
    valor_unitario DECIMAL NOT NULL,
    qtd INT NOT NULL,
    FOREIGN KEY (id_venda_fk) REFERENCES Vendas(id_venda) ON DELETE CASCADE,
    FOREIGN KEY (id_servico_fk) REFERENCES Servicos(id_servico)
);

CREATE TABLE IF NOT EXISTS Recebimentos (
	id_recebimento INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL NOT NULL,
    data_vencimento DATE NOT NULL,
    status_recebimento VARCHAR(50) NOT NULL,
    data_lancamento DATE NOT NULL,
    id_caixa_fk INT NOT NULL,
    id_venda_fk INT,
    FOREIGN KEY (id_caixa_fk) REFERENCES Caixas(id_caixa),
    FOREIGN KEY (id_venda_fk) REFERENCES vendas(id_venda)
);

CREATE TABLE IF NOT EXISTS Encargos (
	id_encargo  INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL NOT NULL,
    descricao VARCHAR (255) NOT NULL,
    id_recebimento_fk INT NOT NULL,
    id_dispositivo_fk INT NOT NULL,
    FOREIGN KEY (id_recebimento_fk) REFERENCES Recebimentos (id_recebimento) ON DELETE CASCADE,
    FOREIGN KEY (id_dispositivo_fk) REFERENCES Dispositivos (id_dispositivo)
);

INSERT INTO Fornecedores(razao_social,nome_fantasia,cnpj,ativo,atividade_economica,telefone,email) VALUES
('B2W- Companhia Global do Varejo','lojas americanas','33.014.556/1598-96',true,'varejista','0800-4500','americanassuporte@org.com.br');

INSERT INTO Clientes (nome,cpf,email,telefone,data_nascimento) VALUES 
('lucayan','02514705207','lucayanfelips@hotmail.com','69992050073','2000-02-18'),
('joana dark','54332412363','joanaDarkGuerra@gmail.com','11993431231','1995-02-18');

INSERT INTO Servicos (valor, descricao, tempo) VALUES (70, 'massagem','00:30'), 
(200,'assassino de aluguel', '24:00'),
(300,'troca de oleo', '30:00'),
(50,'corte na regua','01:00'),
(120,'manutenção do ar condicionado','01:30'),
(100,'baba do pedro','24:00'),
(100,'disk entulho','72:00');

INSERT INTO Vendas (data_venda,hora,valorTotal,desconto,valorFinal,tipo,id_cliente_fk) VALUES
('2024-07-30','15:21',100,0,100,'a vista',null),
('2024-07-30','14:00',50,0,50,'a vista',null),
('2024-07-30','13:00',100,0,100,'a vista',null),
('2024-07-30','14:30',300,5,295,'parcelado',1);

INSERT INTO vendasservicos (id_venda_fk,id_servico_fk,valor_unitario,qtd) VALUES
(1,6,100,1),
(2,4,50,1),
(3,6,100,1),
(4,3,300,1);


INSERT INTO funcionarios (nome,cpf) VALUES 
('alicy rodrigues', '53245234123'), ('lucayan felipe','02514705207');

INSERT INTO caixas (saldo_inicio,saldo_final,total_entradas,total_saidas,status_caixa,id_funcionario_fk) VALUES 
(0,0,0,0,'aberto','1'),
(50,3400,3600,200,'fechado','2');

INSERT INTO despesas (valor,data_vencimento,data_pagamento,status_despesa,id_caixa_fk,id_fornecedores_fk) VALUES
(50, '2024-08-10', '2024-07-28','pago',1,1);

INSERT INTO recebimentos(valor,data_vencimento,status_recebimento,data_lancamento,id_caixa_fk,id_venda_fk) VALUES
(100,'2024-07-30','pago','2024-07-30',1,1),
(50,'2024,07-30','pago','2024-07-30',1,2),
(100,'2024-07-30','pago','2024-07-30',1,3),
(65,'2024-07-30','pago','2024-07-30',1,4),
(65,'2024-08-30','a pagar','2024-07-30',1,4);

INSERT INTO dispositivos(aliquota, descricao, status_dispositivos) VALUES
(5,'maquina mercado pago turbo flex 1001', 'funcionando');

INSERT INTO encargos(valor,descricao,id_recebimento_fk,id_dispositivo_fk) VALUES
(5,'taxa maquina mercado pago', 1,1);

#DELETE FROM venda WHERE id_venda = 1;
#SELECT * FROM vendaservico;




