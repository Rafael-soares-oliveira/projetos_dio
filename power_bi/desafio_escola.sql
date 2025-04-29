create SCHEMA desafio_escola;

-- Criar tabelas sem as relações
create table desafio_escola.disciplina (
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome varchar(50) NOT NULL
);

create table desafio_escola.professor (
	id integer generated always as identity primary key,
	nome varchar(50) not null
);

create table desafio_escola.departamento (
	id integer generated always as identity primary key,
	nome varchar(45) not null,
	campus varchar(45)
);

create table desafio_escola.curso (
	id integer generated always as identity primary key,
	nome varchar(50) not null
);

create table desafio_escola.aluno (
	id integer generated always as identity primary key,
	nome varchar(50) not null
);

create table desafio_escola.pre_requisitos (
	id integer generated always as identity primary key,
	requisito varchar(255) not null
);

-- Criar as relações
alter table desafio_escola.disciplina
add column id_professor integer references desafio_escola.professor(id) on delete set null;

alter table desafio_escola.professor
add column id_departamento integer references desafio_escola.departamento(id) on delete set null;

alter table desafio_escola.departamento
add column id_professor_coordenador integer references desafio_escola.professor(id) on delete set null;

alter table desafio_escola.curso
add column id_departamento integer references desafio_escola.departamento(id) on delete set null;

-- Criar tabelas que possuem apenas FOREIGN KEYS
create table desafio_escola.disciplina_curso (
	id integer generated always as identity primary key,
	id_disciplina integer not null,
	id_curso integer not null,
	constraint fk_disciplina foreign key (id_disciplina) references desafio_escola.disciplina(id) on delete set null,
	constraint fk_curso foreign key (id_curso) references desafio_escola.curso(id) on delete set null
);

create table desafio_escola.pre_requisitos_disciplinas (
	id integer generated always as identity primary key,
	id_disciplina integer not null,
	id_pre_requisito integer not null,
	constraint fk_disciplina foreign key (id_disciplina) references desafio_escola.disciplina(id) on delete cascade,
	constraint fk_pre_requisito foreign key (id_pre_requisito) references desafio_escola.pre_requisitos(id)
);

create table desafio_escola.matriculado (
	id integer generated always as identity primary key,
	id_aluno integer not null,
	id_disciplina integer not null,
	constraint fk_aluno foreign key (id_aluno) references desafio_escola.aluno(id) on delete cascade,
	constraint fk_disciplina foreign key (id_disciplina) references desafio_escola.disciplina(id)
);

select t.table_name
from information_schema.tables t
where t.table_schema = 'desafio_escola';