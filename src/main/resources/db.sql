-- Verificar se a tabela existe e descartá-la se já existir
DROP TABLE IF EXISTS UsuarioBackOffice;

-- Criar a tabela UsuarioBackOffice
CREATE TABLE UsuarioBackOffice (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Senha VARCHAR(128) NOT NULL,
    Grupo VARCHAR(50),
    Status BOOLEAN,
    CPF VARCHAR(14) UNIQUE NOT NULL
);

-- Inserir um usuário Admin
INSERT INTO UsuarioBackOffice (Nome, Email, Senha, Grupo, Status, CPF)
VALUES ('admin', 'admin@admin', '$2a$10$JdPVJ.lNR.uwv4HPlJeAMuA8h1ZFve93cddOf8coYrnNGjKX/Ujsi', 'Admin Group', TRUE, '123.456.789-00');

-- Verificar se a tabela existe e descartá-la se já existir
DROP TABLE IF EXISTS Produtos;

-- Criação da tabela de produtos
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY AUTO_INCREMENT,
    NomeProduto VARCHAR(200) NOT NULL,
    StatusProduto boolean NOT NULL,
    Avaliacao DECIMAL(2,1) CHECK (Avaliacao >= 1 AND Avaliacao <= 5),
    DescricaoDetalhada TEXT,
    PrecoProduto DECIMAL(10,2),
    QtdEstoque INT,
	ImagePATH VARCHAR(200)
);

DROP TABLE IF EXISTS ImagensProduto;

CREATE TABLE ImagensProduto (
    idImagem INT AUTO_INCREMENT PRIMARY KEY,
    idProduto INT,
    caminhoImagem VARCHAR(255),
    FOREIGN KEY (idProduto) REFERENCES Produtos(produtoID)
);


-- corrigido e funcionando
-- Drop existing tables if they exist
DROP TABLE IF EXISTS Endereco;
DROP TABLE IF EXISTS Cliente;

-- Create Cliente table
CREATE TABLE Cliente (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         nomeCompleto VARCHAR(255) NOT NULL,
                         email VARCHAR(255) UNIQUE NOT NULL,
                         dataNascimento DATE NOT NULL,
                         genero VARCHAR(15) NOT NULL,
                         cpf VARCHAR(11) UNIQUE NOT NULL,
                         senha VARCHAR(255) NOT NULL,
                         cepFaturamento VARCHAR(8) NOT NULL,
                         logradouroFaturamento VARCHAR(255) NOT NULL,
                         numeroFaturamento INT NOT NULL,
                         complementoFaturamento VARCHAR(255),
                         bairroFaturamento VARCHAR(255) NOT NULL,
                         cidadeFaturamento VARCHAR(255) NOT NULL,
                         ufFaturamento VARCHAR(2) NOT NULL,
                         idEnderecoPadrao INT
);

-- Create Endereco table
CREATE TABLE Endereco (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          cep VARCHAR(8) NOT NULL,
                          logradouro VARCHAR(255) NOT NULL,
                          numero INT NOT NULL,
                          complemento VARCHAR(255),
                          bairro VARCHAR(255) NOT NULL,
                          cidade VARCHAR(255) NOT NULL,
                          uf VARCHAR(2) NOT NULL,
                          enderecoAtivo BOOLEAN NOT NULL DEFAULT TRUE,
                          idCliente INT NOT NULL,
                          FOREIGN KEY (idCliente) REFERENCES Cliente(id)
);



CREATE TABLE pedido (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        cliente_id INT,
                        status VARCHAR(255),
                        valor_total DECIMAL(10, 2),
                        data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        endereco_entrega_id INT,
                        forma_pagamento VARCHAR(255)
);

-- Drop table if exists
DROP TABLE IF EXISTS item_pedido;

-- Create table item_pedido
CREATE TABLE item_pedido (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             pedido_id INT,
                             produto_id INT,
                             quantidade INT,
                             preco_unitario DECIMAL(10, 2),
                             subtotal DECIMAL(10, 2)
);

-- Drop table if exists
DROP TABLE IF EXISTS endereco_entrega;

-- Create table endereco_entrega
CREATE TABLE endereco_entrega (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  cliente_id INT,
                                  cep VARCHAR(10),
                                  logradouro VARCHAR(255),
                                  numero INT,
                                  complemento VARCHAR(255),
                                  cidade VARCHAR(255),
                                  estado VARCHAR(255)
);

-- Drop table if exists
DROP TABLE IF EXISTS pedido;

-- Create table pedido
CREATE TABLE pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    status VARCHAR(255),
    valor_total DECIMAL(10, 2),
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    endereco_entrega_id INT,
    forma_pagamento VARCHAR(255)
);

-- Drop table if exists
DROP TABLE IF EXISTS item_pedido;

-- Create table item_pedido
CREATE TABLE item_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    subtotal DECIMAL(10, 2)
);

-- Drop table if exists
DROP TABLE IF EXISTS endereco_entrega;

-- Create table endereco_entrega
CREATE TABLE endereco_entrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    cep VARCHAR(10),
    logradouro VARCHAR(255),
    numero INT,
    complemento VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(255)
);
