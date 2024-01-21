SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

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