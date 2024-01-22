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
  `id_match` int DEFAULT NULL,
  `id_joueur` int DEFAULT NULL,
  `lf_reussi` int DEFAULT NULL,
  `lf_rate` int DEFAULT NULL,
  `IIpts_reussi` int DEFAULT NULL,
  `IIpts_rate` int DEFAULT NULL,
  `IIIpts_reussi` int DEFAULT NULL,
  `IIIpts_rate` int DEFAULT NULL,
  `passe_decisive` int DEFAULT NULL,
  `rebond_off` int DEFAULT NULL,
  `rebond_def` int DEFAULT NULL,
  `interception` int DEFAULT NULL,
  `contre` int DEFAULT NULL,
  `perte_balle` int DEFAULT NULL,
  `faute` int DEFAULT NULL,
  PRIMARY KEY (`id_statistique`),
  KEY `id_match` (`id_match`),
  KEY `id_joueur` (`id_joueur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;
