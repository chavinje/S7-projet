-- MariaDB dump 10.19  Distrib 10.5.21-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: moodle
-- ------------------------------------------------------
-- Server version	10.5.21-MariaDB-0+deb11u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `moodle`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `moodle` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `moodle`;
CREATE TABLE `Equipes` (
  `id_equipe` SMALLINT NOT NULL AUTO_INCREMENT,
  `nom_equipe` varchar(255) NOT NULL,
   PRIMARY KEY(id_equipe)
);

CREATE TABLE `Joueurs` (
  `id_joueur` SMALLINT NOT NULL AUTO_INCREMENT,
  `nom_joueur` varchar(255) NOT NULL,
  `idequipe` SMALLINT,
   PRIMARY KEY(id_joueur),
   FOREIGN KEY( idequipe ) REFERENCES Equipes ( id_equipe )
);

CREATE TABLE `Matchs` (
  `id_match` SMALLINT NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `equipe1` SMALLINT,
  `equipe2` varchar(50),
  `score_equipe1` int(11),
  `score_equipe2` int(11),
     PRIMARY KEY(id_match),
   FOREIGN KEY( equipe1 ) REFERENCES Equipes ( id_equipe )
);

CREATE TABLE `Statistiques` (
  `id_statistique` SMALLINT NOT NULL AUTO_INCREMENT,
  `idmatch` int(11) DEFAULT NULL,
  `idjoueur` int(11) DEFAULT NULL,
  `lf_reussi` int(11) DEFAULT NULL,
  `lf_rate` int(11) DEFAULT NULL,
  `2pts_reussi` int(11) DEFAULT NULL,
  `2pts_rate` int(11) DEFAULT NULL,
  `3pts_reussi` int(11) DEFAULT NULL,
  `3pts_rate` int(11) DEFAULT NULL,
  `passe_decisive` int(11) DEFAULT NULL,
  `rebond_off` int(11) DEFAULT NULL,
  `rebond_def` int(11) DEFAULT NULL,
  `interception` int(11) DEFAULT NULL,
  `contre` int(11) DEFAULT NULL,
  `perte_balle` int(11) DEFAULT NULL,
    PRIMARY KEY(id_statistique),
   FOREIGN KEY( idmatch ) REFERENCES Matchs ( id_match ),
   FOREIGN KEY( idjoueur ) REFERENCES Joueurs ( id_joueur )
)
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-19 13:03:49
