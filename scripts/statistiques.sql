SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

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
