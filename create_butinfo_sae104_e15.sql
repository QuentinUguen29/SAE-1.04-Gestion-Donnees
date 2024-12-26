drop schema if exists programme_but cascade;
create schema programme_but;
set schema 'programme_but';

CREATE TABLE _competences(
  lib_competences VARCHAR(20) PRIMARY KEY
);

CREATE TABLE _activites(
  lib_activites VARCHAR(20) PRIMARY KEY,
  lib_competences VARCHAR(20) NOT NULL,
  CONSTRAINT _releve_de_fk_comp 
    FOREIGN KEY (lib_competences) REFERENCES _competences(lib_competences)
);

CREATE TABLE _parcours (
  code_p CHAR(1) PRIMARY KEY,
  libelle_parcours VARCHAR(30) NOT NULL, 
  nbre_gpe_td_p INTEGER NOT NULL, 
  nbre_gpe_tp_p INTEGER NOT NULL
);

CREATE TABLE _niveau (
  numero_n INTEGER PRIMARY KEY
);

CREATE TABLE _semestre (
  numero_sem CHAR(1) PRIMARY KEY,
  numero_n INTEGER NOT NULL,
  CONSTRAINT _fait_partie_fk_n
        FOREIGN KEY (numero_n) REFERENCES _niveau(numero_n)
);

CREATE TABLE _ressources (
  code_r VARCHAR(10) PRIMARY KEY,
  lib_r VARCHAR(20) NOT NULL,
  nb_h_cm_pn INTEGER NOT NULL,
  nb_h_td_pn INTEGER NOT NULL,
  nb_h_tp_pn INTEGER NOT NULL,
  numero_sem CHAR(1),
  code_p CHAR(1),
  CONSTRAINT _quand_fk_semestre
    FOREIGN KEY (numero_sem) REFERENCES _semestre(numero_sem),
  CONSTRAINT _est_enseigne_fk_parcours
    FOREIGN KEY (code_p) REFERENCES _parcours(code_p)
);

CREATE TABLE _sae (
  code_sae VARCHAR(10) PRIMARY KEY,
  lib_sae VARCHAR(20) NOT NULL,
  nb_h_td_enc INTEGER NOT NULL,
  nb_h_td_projet_autonomie INTEGER NOT NULL
);

CREATE TABLE _comprend_r (
  code_r VARCHAR(10),
  code_sae VARCHAR(10),
  nb_h_td_c INTEGER NOT NULL,
  nb_h_tp_c INTEGER NOT NULL,
  CONSTRAINT _comprend_r_pk PRIMARY KEY (code_r, code_sae),
  CONSTRAINT _comprend_r_fk_r FOREIGN KEY (code_r) REFERENCES _ressources(code_r),
  CONSTRAINT _comprend_r_fk_sae FOREIGN KEY (code_sae) REFERENCES _sae(code_sae)
);

CREATE TABLE _ue(
  code_ue VARCHAR(10) PRIMARY KEY,
  lib_activites VARCHAR(20) NOT NULL,
  numero_sem CHAR(1) NOT NULL,
  CONSTRAINT _est_realisee_dans_fk_act 
    FOREIGN KEY (lib_activites) REFERENCES _activites(lib_activites),
  CONSTRAINT _dans_fk_sem 
    FOREIGN KEY (numero_sem) REFERENCES _semestre(numero_sem)
);

CREATE TABLE _correspond(
  lib_activites VARCHAR(20),
  numero_n INTEGER,
  code_p CHAR(1),
  CONSTRAINT _correspond_pk
    PRIMARY KEY (lib_activites, numero_n, code_p),
  CONSTRAINT _correspond_fk_act 
    FOREIGN KEY (lib_activites) REFERENCES _activites(lib_activites),
  CONSTRAINT _correspond_fk_niveau
    FOREIGN KEY (numero_n) REFERENCES _niveau(numero_n),
  CONSTRAINT _correspond_fk_parcours
    FOREIGN KEY (code_p) REFERENCES _parcours(code_p)
);

/*
SELECT * FROM _competences;
SELECT * FROM _activites;
SELECT * FROM _parcours;
SELECT * FROM _niveau;
SELECT * FROM _semestre;
SELECT * FROM _ressources;
SELECT * FROM _sae;
SELECT * FROM _comprend_r;
SELECT * FROM _ue;
SELECT * FROM _correspond;*/
