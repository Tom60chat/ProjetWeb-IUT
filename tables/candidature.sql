-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : lun. 29 nov. 2021 à 08:41
-- Version du serveur : 5.7.33
-- Version de PHP : 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `m3104`
--

-- --------------------------------------------------------

--
-- Structure de la table `candidature`
--

CREATE TABLE `candidature` (
  `num_groupe` int(5) NOT NULL,
  `nom_groupe` varchar(250) DEFAULT NULL,
  `departement_groupe` varchar(250) DEFAULT NULL,
  `type_scene` varchar(250) DEFAULT NULL,
  `nom_representant` varchar(250) DEFAULT NULL,
  `prenom_representant` varchar(250) DEFAULT NULL,
  `adresse_representant` varchar(250) DEFAULT NULL,
  `cp_representant` varchar(250) DEFAULT NULL,
  `ville_representant` varchar(250) DEFAULT NULL,
  `email_representant` varchar(250) DEFAULT NULL,
  `telephone_representant` varchar(250) DEFAULT NULL,
  `style_groupe` varchar(250) DEFAULT NULL,
  `annee_crea_groupe` int(4) DEFAULT NULL,
  `presentation_groupe` varchar(500) DEFAULT NULL,
  `experience_groupe` varchar(500) DEFAULT NULL,
  `lien_web` varchar(250) DEFAULT NULL,
  `lien_soundcloud` varchar(250) DEFAULT NULL,
  `lien_youtube` varchar(250) DEFAULT NULL,
  `statut` binary(1) DEFAULT NULL,
  `sacem` binary(1) DEFAULT NULL,
  `producteur` binary(1) DEFAULT NULL,
  `fichiermp3_1` varchar(250) DEFAULT NULL,
  `fichiermp3_2` varchar(250) DEFAULT NULL,
  `fichiermp3_3` varchar(250) DEFAULT NULL,
  `pressepdf` varchar(250) DEFAULT NULL,
  `photo_1` varchar(250) DEFAULT NULL,
  `photo_2` varchar(250) DEFAULT NULL,
  `fichepdf` varchar(250) DEFAULT NULL,
  `sacempdf` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `candidature`
--
ALTER TABLE `candidature`
  ADD PRIMARY KEY (`num_groupe`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
