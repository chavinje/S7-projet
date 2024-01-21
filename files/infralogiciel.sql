-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 19 jan. 2024 à 17:41
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `infralogiciel`
--

-- --------------------------------------------------------

--
-- Structure de la table `equipes`
--

DROP TABLE IF EXISTS `equipes`;
CREATE TABLE IF NOT EXISTS `equipes` (
  `id_equipe` smallint NOT NULL AUTO_INCREMENT,
  `nom_equipe` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_equipe`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `joueurs`
--

DROP TABLE IF EXISTS `joueurs`;
CREATE TABLE IF NOT EXISTS `joueurs` (
  `id_joueur` smallint NOT NULL AUTO_INCREMENT,
  `nom_joueur` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `idequipe` smallint DEFAULT NULL,
  PRIMARY KEY (`id_joueur`),
  KEY `idequipe` (`idequipe`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `matchs`
--

DROP TABLE IF EXISTS `matchs`;
CREATE TABLE IF NOT EXISTS `matchs` (
  `id_match` smallint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `equipe1` smallint DEFAULT NULL,
  `equipe2` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `score_equipe1` int DEFAULT NULL,
  `score_equipe2` int DEFAULT NULL,
  PRIMARY KEY (`id_match`),
  KEY `equipe1` (`equipe1`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `statistiques`
--

DROP TABLE IF EXISTS `statistiques`;
CREATE TABLE IF NOT EXISTS `statistiques` (
  `id_statistique` smallint NOT NULL AUTO_INCREMENT,
  `idmatch` int DEFAULT NULL,
  `idjoueur` int DEFAULT NULL,
  `lf_reussi` int DEFAULT NULL,
  `lf_rate` int DEFAULT NULL,
  `2pts_reussi` int DEFAULT NULL,
  `2pts_rate` int DEFAULT NULL,
  `3pts_reussi` int DEFAULT NULL,
  `3pts_rate` int DEFAULT NULL,
  `passe_decisive` int DEFAULT NULL,
  `rebond_off` int DEFAULT NULL,
  `rebond_def` int DEFAULT NULL,
  `interception` int DEFAULT NULL,
  `contre` int DEFAULT NULL,
  `perte_balle` int DEFAULT NULL,
  PRIMARY KEY (`id_statistique`),
  KEY `idmatch` (`idmatch`),
  KEY `idjoueur` (`idjoueur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
