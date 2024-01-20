CREATE USER 'gpi2'@'loc' IDENTIFIED BY 'network';

CREATE DATABASE basket DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;





GRANT ALL PRIVILEGES ON baset.* TO gpi2@localhost;

GRANT ALL PRIVILEGES ON tp_videos.* TO gpi2@localhost;
GRANT ALL PRIVILEGES ON tp_films.* TO gpi2@localhost;
GRANT ALL PRIVILEGES ON tp_etudiants.* TO gpi2@localhost;
GRANT ALL PRIVILEGES ON tp_livres.* TO gpi2@localhost;

GRANT ALL PRIVILEGES ON exm_juin2019_1.* TO gpi2@localhost;
GRANT ALL PRIVILEGES ON exm_juin2019_2.* TO gpi2@localhost;
GRANT ALL PRIVILEGES ON exm_juin2020_1.* TO gpi2@localhost;
GRANT ALL PRIVILEGES ON exm_juin2020_2.* TO gpi2@localhost;
