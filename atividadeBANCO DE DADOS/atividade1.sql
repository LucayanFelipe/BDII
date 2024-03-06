CREATE DATABASE atividade1;
USE atividade1;

CREATE TABLE Usuario (
    id_usuario INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(50) NOT NULL,
    data_cadastro DATE NOT NULL,
    email_usu VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Disciplina (
    id_disciplina INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_dis VARCHAR(50) NOT NULL
);

CREATE TABLE Assunto (
    id_assunto INTEGER PRIMARY KEY AUTO_INCREMENT,
    texto_ass VARCHAR(250) NOT NULL,
    id_disciplina_FK INTEGER NOT NULL,
    FOREIGN KEY (id_disciplina_FK) REFERENCES Disciplina (id_disciplina)
);

CREATE TABLE Banca (
		id_banca INTEGER PRIMARY KEY AUTO_INCREMENT,
		nome_ban VARCHAR(50) NOT NULL,
		sigla_ban VARCHAR(10) NOT NULL
);
 
CREATE TABLE Professor (
		id_professor INTEGER PRIMARY KEY AUTO_INCREMENT,
		nome_prof VARCHAR(50) NOT NULL,
		telefone_prof VARCHAR(14) NOT NULL,
		email_prof VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Questao (
		id_questao INTEGER PRIMARY KEY AUTO_INCREMENT,
		enunciado VARCHAR(300) NOT NULL,
		modalidade VARCHAR(50) NOT NULL,
		nivel INTEGER NOT NULL,
		id_assunto_FK INTEGER NOT NULL,
		id_banca_FK INTEGER NOT NULL,
		FOREIGN KEY (id_assunto_FK) REFERENCES Assunto (id_assunto),
		FOREIGN KEY (id_banca_FK) REFERENCES Banca (id_banca)
);

CREATE TABLE Questao_professor (
		id INTEGER PRIMARY KEY AUTO_INCREMENT,
		id_questao_FK INTEGER NOT NULL,
		id_professor_FK INTEGER NOT NULL,
		texto_com VARCHAR(255) NOT NULL,
		data_com DATE NOT NULL,
		FOREIGN KEY (id_questao_FK) REFERENCES Questao (id_questao),
		FOREIGN KEY (id_professor_FK) REFERENCES Professor (id_professor)
);

CREATE TABLE Alternativas (
		id_alternativa INTEGER PRIMARY KEY AUTO_INCREMENT,
		texto_alter VARCHAR(250) NOT NULL,
		gabarito_alter VARCHAR(10) NOT NULL,
		id_questao_FK INTEGER NOT NULL
);
 
CREATE TABLE Usuario_questao (
		id INTEGER PRIMARY KEY AUTO_INCREMENT,
		id_usuario_FK INTEGER NOT NULL,
		id_questao_FK INTEGER NOT NULL,
		data_res DATE NOT NULL,
		resultado VARCHAR(50) NOT NULL,
		resposta_usu VARCHAR(50) NOT NULL,
		FOREIGN KEY (id_usuario_FK) REFERENCES Usuario (id_usuario),
		FOREIGN KEY (id_questao_FK) REFERENCES Questao (id_questao)
);








 