CREATE DATABASE clinica
GO
USE clinica
GO
CREATE TABLE especialidade 
(
	id_especialidade INT NOT NULL,
	especialidade VARCHAR(100) NOT NULL
	PRIMARY KEY(id_especialidade) 
)
GO
CREATE TABLE medico 
(
	codigo_medico		INT 			NOT NULL,
	nome				VARCHAR(100) 	NOT NULL,
	logradouro			VARCHAR(200)	NOT NULL,
	numero				INT				NOT NULL,
	cep					CHAR(8)			NOT NULL,
	complemento			VARCHAR(255)	NOT NULL,
	contato				VARCHAR(11)		NOT NULL,
	id_especialidade	INT				NOT NULL
	PRIMARY KEY (codigo_medico)
	FOREIGN KEY (id_especialidade) REFERENCES especialidade(id_especialidade)
)
GO
CREATE TABLE paciente
(
	num_beneficiario	INT 			NOT NULL,
	nome				VARCHAR(100)	NOT NULL,
	logradouro			VARCHAR(200)	NOT NULL,
	numero				INT				NOT NULL,
	cep					CHAR(8)			NOT NULL,
	complemento			VARCHAR(255)	NOT NULL,
	telefone			VARCHAR(11)		NOT NULL
	PRIMARY KEY (num_beneficiario)
)
GO
CREATE TABLE consulta
(
	num_beneficiario	INT 			NOT NULL,
	codigo_medico		INT				NOT NULL,
	data_hora			DATETIME		NOT NULL,
	observacao			VARCHAR(255)	NOT NULL
	PRIMARY KEY (num_beneficiario, codigo_medico, data_hora)
	FOREIGN KEY (num_beneficiario) REFERENCES paciente (num_beneficiario),
	FOREIGN KEY (codigo_medico) REFERENCES medico (codigo_medico)
)

INSERT INTO paciente (num_beneficiario, nome, logradouro, numero, cep, complemento, telefone) 
VALUES 
(99901, 'Washinton Silva', 'R. Anhaia', 150, '02345000', 'casa', '922229999'),
(99902, 'Luis Ricardo', 'R. Voluntários da Pátria', 2251, '03254010', 'Bloco B. Apto 25', '923450987'),
(99903, 'Maria Elisa', 'Av. Aguia de Haia', 1188, '06987020', 'Apto 1208', '912348765'),
(99904, 'José Araujo', 'R. XV de Novembro', 18, '03678000', 'casa', '945674312'),
(99905, 'Joana Paula', 'R. 7 de Abril', 97, '01214000', 'Conjunto 3 - Apto 801', '912095674')

INSERT INTO especialidade (id_especialidade, especialidade)
VALUES
(1, 'Otorrinolaringologista'),
(2, 'Urologista'),
(3, 'Geriatra'),
(4, 'Pediatra')

INSERT INTO medico (codigo_medico, nome, logradouro, numero, cep, complemento, contato, id_especialidade)
VALUES 
(100001, 'Ana Paula', 'R. 7 de Setembro', 256, '03698000', 'Casa', '915689456', 1),
(100002, 'Maria Aparecida', 'Av. Brasil', 32, '02145070', 'Casa', '923235454', 1),
(100003, 'Lucas Borges', 'Av. do Estado', 3210, '05241000', 'Apto 205', '963698585', 2),
(100004, 'Gabriel Oliveira', 'Av. Dom Helder Camara', 350, '03145000', 'Apto 602', '932458745', 3)

INSERT INTO consulta (num_beneficiario, codigo_medico, data_hora, observacao)
VALUES
(99901, 100002, '2021-09-04 13:20', 'Infecção Urina'),
(99903, 100003, '2021-09-04 13:15', 'Gripe'),
(99901, 100001, '2021-09-04 12:30', 'Infecção Garganta')

ALTER TABLE medico
ADD dia_atendimento VARCHAR(100)

UPDATE medico 
SET dia_atendimento = 'Passa a atender na 2° feira'
WHERE codigo_medico = 100001

UPDATE medico 
SET dia_atendimento = 'Passa a atender na 4° feira'
WHERE codigo_medico = 100002

UPDATE medico 
SET dia_atendimento = 'Passa a atender na 2° feira'
WHERE codigo_medico = 100003

UPDATE medico 
SET dia_atendimento = 'Passa a atender na 5° feira'
WHERE codigo_medico = 100004

DELETE especialidade WHERE especialidade = 'Pediatra'

EXEC sp_rename 'medico.dia_atendimento', 'dia_semana_atendimento', 'COLUMN'

UPDATE medico 
SET logradouro = 'Av. Bras Leme', numero = 876, complemento = 'Apto 504', cep = '02122000'
WHERE nome = 'Lucas Borges'

ALTER TABLE consulta 
ALTER COLUMN observacao VARCHAR(200) NOT NULL