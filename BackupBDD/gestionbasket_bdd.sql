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