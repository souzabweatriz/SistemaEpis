CREATE TABLE epi (
    id_epi SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(60),
    numero_ca VARCHAR(20) NOT NULL,
    fabricante VARCHAR(80),
    dt_validade DATE NOT NULL,
    periodicidade_meses INTEGER DEFAULT 12,
    estoque INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE alunos (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    curso TEXT NOT NULL,
    sala TEXT NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(100),
    foto TEXT,
    email TEXT NOT NULL,
    senha TEXT NOT NULL
);

CREATE TABLE departamento (
    id_departamento SERIAL PRIMARY KEY,
    nome_departamento TEXT NOT NULL,
    email TEXT NOT NULL,
    telefone INTEGER,
    senha TEXT NOT NULL
);

CREATE TABLE funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    senha TEXT NOT NULL,
    cargo TEXT NOT NULL,
    email TEXT NOT NULL,
    foto TEXT,
    data_nascimento DATE NOT NULL,
    id_departamento INTEGER,
    FOREIGN KEY (id_departamento)
        REFERENCES departamento(id_departamento)
);

CREATE TABLE entregas (
    id_entrega SERIAL PRIMARY KEY,
    id_funcionario INTEGER NOT NULL,
    id_epi INTEGER NOT NULL,
    quantidade INTEGER NOT NULL DEFAULT 1,
    data_entrega DATE NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (id_funcionario)
        REFERENCES funcionarios(id_funcionario),
    FOREIGN KEY (id_epi)
        REFERENCES epi(id_epi)
);

INSERT INTO epi (nome, tipo, numero_ca, fabricante, dt_validade, periodicidade_meses, estoque) VALUES
('Capacete de Segurança', 'Proteção da cabeça', 'CA12345', '3M', '2027-12-31', 24, 40),
('Luva de Proteção', 'Proteção das mãos', 'CA67890', 'Volk', '2026-06-15', 12, 120),
('Óculos de Segurança', 'Proteção dos olhos', 'CA54321', 'Danny', '2028-03-10', 18, 58),
('Protetor Auricular', 'Proteção auditiva', 'CA98765', '3M', '2027-08-20', 12, 80),
('Botina de Segurança', 'Proteção dos pés', 'CA45678', 'Bracol', '2029-01-15', 24, 33);

INSERT INTO alunos (nome, curso, sala, data_nascimento, endereco, foto, email, senha) VALUES
('Ana Beatriz de Souza', 'Desenvolvimento de Sistemas', 'A1', '2008-05-12', 'Rua das Flores, 123', NULL, 'ana@aluno.com', '123456'),
('Carlos Silva', 'Mecânica', 'B2', '2007-09-20', 'Av. Brasil, 456', NULL, 'carlos@aluno.com', '123456'),
('Juliana Souza', 'Eletrotécnica', 'C3', '2006-11-02', 'Rua Verde, 789', NULL, 'juliana@aluno.com', '123456'),
('Pedro Almeida', 'Automação Industrial', 'D1', '2007-03-18', 'Rua Azul, 222', NULL, 'pedro@aluno.com', '123456'),
('Larissa Gomes', 'Desenvolvimento de Sistemas', 'A2', '2008-07-25', 'Av. Central, 999', NULL, 'larissa@aluno.com', '123456');

INSERT INTO funcionarios (nome, senha, cargo, email, foto, data_nascimento, id_departamento) VALUES
('Marcos Pereira', 'senha123', 'Técnico de Segurança', 'marcos@empresa.com', NULL, '1990-04-10', 2),
('Fernanda Lima', 'senha456', 'Analista de RH', 'fernanda@empresa.com', NULL, '1988-07-22', 1),
('Lucas Martins', 'senha789', 'Desenvolvedor', 'lucas@empresa.com', NULL, '1995-01-30', 3),
('Ricardo Souza', 'senha321', 'Supervisor', 'ricardo@empresa.com', NULL, '1985-02-14', 4),
('Patricia Alves', 'senha654', 'Assistente Administrativo', 'patricia@empresa.com', NULL, '1992-09-05', 4);

INSERT INTO departamento (nome_departamento, email, telefone, senha) VALUES
('RH', 'rh@epicloud.com', 119999999, '123456'),
('Segurança do Trabalho', 'seguranca@epicloud.com', 118888888, '123456'),
('TI', 'ti@epicloud.com', 117777777, '123456'),
('Administração', 'adm@epicloud.com', 116666666, '123456');

INSERT INTO entregas (id_funcionario, id_epi, quantidade, data_entrega, observacoes) VALUES
(1, 1, 2, '2026-04-20', 'Entrega no turno matinal'),
(2, 2, 1, '2026-04-18', NULL),
(3, 3, 3, '2026-04-19', 'Kit para equipe de suporte'),
(4, 1, 1, '2026-04-21', 'Substituição de equipamento danificado'),
(5, 4, 2, '2026-04-17', 'Estoque para manutenção');