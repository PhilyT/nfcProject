-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Client : localhost
-- Généré le : mar 02 Mai 2015
-- Version du serveur : 5.6.20-log



--
-- Base de donnée rfid_badgeuse
--

CREATE DATABASE IF  NOT EXISTS `rfid_badgeuse` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE rfid_badgeuse;
--
-- Table structure for table `cours`
--


CREATE TABLE IF NOT  EXISTS `cours` (
  `id_c` int(11) NOT NULL AUTO_INCREMENT,
  `heureDebut` time NOT NULL,
  `heureFin` time NOT NULL,
  `libelle` varchar(45) NOT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `eleve`
--

CREATE TABLE IF NOT EXISTS `eleve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(45) NOT NULL,
  `id_historisation` VARCHAR (45),
  `nom` varchar(45) NOT NULL,
  `idCarte` varchar(45) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `presence`
--

CREATE TABLE IF NOT EXISTS `presence` (
  `idEtud` int(11) NOT NULL,
  `idCours` int(11) NOT NULL,
  `presence` enum('a','p') DEFAULT 'a',
  `Date` date NOT NULL,
  PRIMARY KEY (`idEtud`,`idCours`, `Date`),
  KEY `idCours` (`idCours`),
  CONSTRAINT `presence_ibfk_1` FOREIGN KEY (`idCours`) REFERENCES `cours` (`id_c`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `presence_ibfk_2` FOREIGN KEY (`idEtud`) REFERENCES `eleve` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO cours (`heureDebut`, `heureFin`,`libelle`) VALUES('9:00:00','14:00:00',"JEE");
INSERT INTO cours (`heureDebut`, `heureFin`,`libelle`) VALUES('14:00:00','17:00:00',"RFID");
INSERT INTO eleve (prenom, nom, idCarte) VALUES('Tom','Phily','8B1D8B16');
INSERT INTO eleve (prenom, nom, idCarte) VALUES('Marina','Helie-Zadeh','7B498C16');
INSERT INTO eleve (prenom, nom, idCarte) VALUES('Stéphanie','Carrié','0BD09816');
INSERT INTO presence (idEtud, idCours, Date) VALUES(1,1,'2016-05-10');
INSERT INTO presence (idEtud, idCours, Date) VALUES(2,1,'2016-05-10');
INSERT INTO presence (idEtud, idCours, Date) VALUES(1,2,'2016-05-10');
INSERT INTO presence (idEtud, idCours, Date) VALUES(2,2,'2016-05-10');



--
-- Table stucture for table `admin`
--

CREATE TABLE IF NOT EXISTS `administration` (
`idAdmin` int (11) NOT NULL AUTO_INCREMENT,
`nomAdmin` VARCHAR (50),
`prenomAdmin` VARCHAR (50),
`mp` TEXT,
`mailAdmin` Varchar (50),
PRIMARY key (`idAdmin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO administration (nomAdmin, prenomAdmin, mp, mailAdmin) VALUES ('admin', 'admin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC','admin.badgeuse@unice.fr');

 GRANT SELECT,UPDATE,INSERT, DELETE ON rfid_badgeuse.* TO 'rfid'@'localhost' IDENTIFIED BY 'rfid' WITH MAX_QUERIES_PER_HOUR 100000 MAX_UPDATES_PER_HOUR 10000 MAX_CONNECTIONS_PER_HOUR 10000 MAX_USER_CONNECTIONS 10000;
 SET PASSWORD FOR 'rfid'@'localhost' = PASSWORD('rfid');