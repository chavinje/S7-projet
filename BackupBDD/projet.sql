-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : sam. 09 déc. 2023 à 22:00
-- Version du serveur :  10.3.39-MariaDB-0+deb10u1
-- Version de PHP : 7.3.31-1~deb10u5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projet`
--

-- --------------------------------------------------------

--
-- Structure de la table `Equipes`
--

CREATE TABLE `Equipes` (
  `idEquipe` int(11) NOT NULL,
  `NomEquipe` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `Equipes`
--

INSERT INTO `Equipes` (`idEquipe`, `NomEquipe`) VALUES
(1, 'Test1'),
(2, 'Test2');

-- --------------------------------------------------------

--
-- Structure de la table `Joueurs`
--

CREATE TABLE `Joueurs` (
  `idJoueur` int(11) NOT NULL,
  `NomJoueur` varchar(255) NOT NULL,
  `idEquipe` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `Joueurs`
--

INSERT INTO `Joueurs` (`idJoueur`, `NomJoueur`, `idEquipe`) VALUES
(1, 'Joueur1', 1),
(2, 'Joueur2', 1),
(3, 'Joueur3', 1),
(4, 'Joueur4', 1),
(5, 'Joueur5', 1),
(6, 'Joueur6', 2),
(7, 'Joueur7', 2),
(8, 'Joueur8', 2),
(9, 'Joueur9', 2),
(10, 'Joueur10', 2);

-- --------------------------------------------------------

--
-- Structure de la table `Matchs`
--

CREATE TABLE `Matchs` (
  `idMatch` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Equipe1` int(11) DEFAULT NULL,
  `Equipe2` varchar(50) DEFAULT NULL,
  `ScoreEquipe1` int(11) DEFAULT NULL,
  `ScoreEquipe2` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `Matchs`
--

INSERT INTO `Matchs` (`idMatch`, `Date`, `Equipe1`, `Equipe2`, `ScoreEquipe1`, `ScoreEquipe2`) VALUES
(1, '2023-12-09', 1, 'Angers', 50, 47),
(2, '2023-12-09', 2, 'Angers', 45, 60),
(3, '2023-12-11', 1, 'Tours', 67, 31);

-- --------------------------------------------------------

--
-- Structure de la table `Statistiques`
--

CREATE TABLE `Statistiques` (
  `idStatistique` int(11) NOT NULL,
  `idMatch` int(11) DEFAULT NULL,
  `idJoueur` int(11) DEFAULT NULL,
  `lancerFrancTente` int(11) DEFAULT NULL,
  `lancerFrancReussi` int(11) DEFAULT NULL,
  `lancerFrancRate` int(11) DEFAULT NULL,
  `deuxPointsTente` int(11) DEFAULT NULL,
  `deuxPointsReussi` int(11) DEFAULT NULL,
  `deuxPointsRate` int(11) DEFAULT NULL,
  `troisPointsTente` int(11) DEFAULT NULL,
  `troisPointsReussi` int(11) DEFAULT NULL,
  `troisPointsRate` int(11) DEFAULT NULL,
  `passeDecisive` int(11) DEFAULT NULL,
  `rebondOff` int(11) DEFAULT NULL,
  `rebondDef` int(11) DEFAULT NULL,
  `interceptions` int(11) DEFAULT NULL,
  `contre` int(11) DEFAULT NULL,
  `pertesBalle` int(11) DEFAULT NULL,
  `fautes` int(11) DEFAULT NULL,
  `minutes` time DEFAULT NULL,
  `plusMinus` int(11) DEFAULT NULL,
  `noteEvaluation` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `Statistiques`
--

INSERT INTO `Statistiques` (`idStatistique`, `idMatch`, `idJoueur`, `lancerFrancTente`, `lancerFrancReussi`, `lancerFrancRate`, `deuxPointsTente`, `deuxPointsReussi`, `deuxPointsRate`, `troisPointsTente`, `troisPointsReussi`, `troisPointsRate`, `passeDecisive`, `rebondOff`, `rebondDef`, `interceptions`, `contre`, `pertesBalle`, `fautes`, `minutes`, `plusMinus`, `noteEvaluation`) VALUES
(1, 1, 1, 0, 0, 0, 8, 5, 3, 0, 0, 0, 3, 5, 4, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2, 1, 2, 0, 0, 0, 8, 5, 3, 0, 0, 0, 3, 5, 4, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3, 1, 3, 0, 0, 0, 8, 5, 3, 0, 0, 0, 3, 5, 4, 1, 1, NULL, NULL, NULL, NULL, NULL),
(4, 1, 4, 0, 0, 0, 8, 5, 3, 0, 0, 0, 3, 5, 4, 1, 1, NULL, NULL, NULL, NULL, NULL),
(5, 1, 5, 0, 0, 0, 8, 5, 3, 0, 0, 0, 3, 5, 4, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6, 3, 5, 0, 0, 0, 8, 5, 3, 0, 0, 0, 3, 5, 4, 1, 1, NULL, NULL, NULL, NULL, NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Equipes`
--
ALTER TABLE `Equipes`
  ADD PRIMARY KEY (`idEquipe`);

--
-- Index pour la table `Joueurs`
--
ALTER TABLE `Joueurs`
  ADD PRIMARY KEY (`idJoueur`),
  ADD KEY `idEquipe` (`idEquipe`);

--
-- Index pour la table `Matchs`
--
ALTER TABLE `Matchs`
  ADD PRIMARY KEY (`idMatch`),
  ADD KEY `Equipe1` (`Equipe1`);

--
-- Index pour la table `Statistiques`
--
ALTER TABLE `Statistiques`
  ADD PRIMARY KEY (`idStatistique`),
  ADD KEY `idMatch` (`idMatch`),
  ADD KEY `idJoueur` (`idJoueur`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Joueurs`
--
ALTER TABLE `Joueurs`
  ADD CONSTRAINT `Joueurs_ibfk_1` FOREIGN KEY (`idEquipe`) REFERENCES `Equipes` (`idEquipe`);

--
-- Contraintes pour la table `Matchs`
--
ALTER TABLE `Matchs`
  ADD CONSTRAINT `Matchs_ibfk_1` FOREIGN KEY (`Equipe1`) REFERENCES `Equipes` (`idEquipe`);

--
-- Contraintes pour la table `Statistiques`
--
ALTER TABLE `Statistiques`
  ADD CONSTRAINT `Statistiques_ibfk_1` FOREIGN KEY (`idMatch`) REFERENCES `Matchs` (`idMatch`),
  ADD CONSTRAINT `Statistiques_ibfk_2` FOREIGN KEY (`idJoueur`) REFERENCES `Joueurs` (`idJoueur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
