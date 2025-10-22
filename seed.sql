-- Base : universite_db
CREATE DATABASE IF NOT EXISTS universite_db;
USE universite_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS notes;
DROP TABLE IF EXISTS inscriptions;
DROP TABLE IF EXISTS cours;
DROP TABLE IF EXISTS professeurs;
DROP TABLE IF EXISTS departements;
DROP TABLE IF EXISTS etudiants;
SET FOREIGN_KEY_CHECKS = 1;

-- Départements
CREATE TABLE departements (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  batiment VARCHAR(50)
);

-- Professeurs
CREATE TABLE professeurs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  departement_id INT,
  salaire DECIMAL(10,2),
  date_embauche DATE,
  FOREIGN KEY (departement_id) REFERENCES departements(id)
);

-- Étudiants
CREATE TABLE etudiants (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  ville VARCHAR(100),
  date_naissance DATE,
  annee INT,
  departement_id INT,
  FOREIGN KEY (departement_id) REFERENCES departements(id)
);

-- Cours
CREATE TABLE cours (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  credits INT,
  professeur_id INT,
  FOREIGN KEY (professeur_id) REFERENCES professeurs(id)
);

-- Inscriptions (relation N-N)
CREATE TABLE inscriptions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  etudiant_id INT,
  cours_id INT,
  date_inscription DATE,
  FOREIGN KEY (etudiant_id) REFERENCES etudiants(id),
  FOREIGN KEY (cours_id) REFERENCES cours(id)
);

-- Notes
CREATE TABLE notes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  inscription_id INT,
  note DECIMAL(4,2),
  date_eval DATE,
  FOREIGN KEY (inscription_id) REFERENCES inscriptions(id)
);

-- Données d'exemple
INSERT INTO departements (nom, batiment) VALUES
('Informatique', 'B1'),
('Lettres', 'C2'),
('Économie', 'A3'),
('Sciences', 'D4');

INSERT INTO professeurs (nom, prenom, email, departement_id, salaire, date_embauche) VALUES
('Martin', 'Sophie', 'sophie.martin@univ.fr', 1, 3200.00, '2018-09-01'),
('Durand', 'Lucas', 'lucas.durand@univ.fr', 2, 2900.00, '2020-01-10'),
('Petit', 'Emma', 'emma.petit@univ.fr', 3, 3100.00, '2017-03-15'),
('Bernard', 'Hugo', 'hugo.bernard@univ.fr', 4, 3400.00, '2016-05-20');

INSERT INTO etudiants (nom, prenom, ville, date_naissance, annee, departement_id) VALUES
('Lemoine', 'Alice', 'Paris', '2002-04-10', 3, 1),
('Rossi', 'Clara', 'Bordeaux', '2003-01-15', 2, 1),
('Nguyen', 'Paul', 'Lyon', '2001-11-03', 4, 3),
('Dubois', 'Émile', 'Nantes', '2002-07-08', 3, 2),
('Morel', 'Lucie', 'Toulouse', '2004-02-25', 1, 4),
('Leroy', 'Antoine', 'Marseille', '2003-05-17', 2, 1),
('Marchand', 'Camille', 'Nice', '2001-12-02', 4, 3),
('Fabre', 'Jules', 'Rennes', '2002-10-09', 3, 4);

INSERT INTO cours (nom, credits, professeur_id) VALUES
('Algorithmique', 4, 1),
('Programmation Web', 5, 1),
('Littérature Française', 3, 2),
('Macroéconomie', 4, 3),
('Biologie Générale', 5, 4),
('Physique Avancée', 6, 4);

INSERT INTO inscriptions (etudiant_id, cours_id, date_inscription) VALUES
(1, 1, '2024-09-01'),
(1, 2, '2024-09-02'),
(2, 1, '2024-09-05'),
(3, 4, '2024-09-03'),
(4, 3, '2024-09-01'),
(5, 5, '2024-09-07'),
(6, 2, '2024-09-01'),
(7, 4, '2024-09-10'),
(8, 5, '2024-09-04'),
(8, 6, '2024-09-06');

INSERT INTO notes (inscription_id, note, date_eval) VALUES
(1, 15.5, '2024-12-10'),
(2, 13.0, '2024-12-12'),
(3, 10.0, '2024-12-10'),
(4, 14.5, '2024-12-15'),
(5, 11.0, '2024-12-13'),
(6, 16.0, '2024-12-14'),
(7, 9.0, '2024-12-10'),
(8, 17.0, '2024-12-11'),
(9, 14.0, '2024-12-15'),
(10, 12.5, '2024-12-16');
