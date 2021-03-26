-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 26 Mar 2021, 21:12
-- Wersja serwera: 10.3.27-MariaDB-0+deb10u1
-- Wersja PHP: 7.3.27-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `mailserver`
--
CREATE DATABASE IF NOT EXISTS `mailserver` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mailserver`;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `virtual_aliases`
--

DROP TABLE IF EXISTS `virtual_aliases`;
CREATE TABLE IF NOT EXISTS `virtual_aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Tabela Truncate przed wstawieniem `virtual_aliases`
--

TRUNCATE TABLE `virtual_aliases`;
--
-- Zrzut danych tabeli `virtual_aliases`
--

INSERT INTO `virtual_aliases` (`id`, `domain_id`, `source`, `destination`) VALUES
(1, 1, 'alias@example.com', 'email1@example.com');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `virtual_domains`
--

DROP TABLE IF EXISTS `virtual_domains`;
CREATE TABLE IF NOT EXISTS `virtual_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Tabela Truncate przed wstawieniem `virtual_domains`
--

TRUNCATE TABLE `virtual_domains`;
--
-- Zrzut danych tabeli `virtual_domains`
--

INSERT INTO `virtual_domains` (`id`, `name`) VALUES
(1, 'example.com'),
(2, 'hostname.example.com'),
(3, 'hostname'),
(4, 'localhost.example.com');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `virtual_users`
--

DROP TABLE IF EXISTS `virtual_users`;
CREATE TABLE IF NOT EXISTS `virtual_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `password` varchar(106) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Tabela Truncate przed wstawieniem `virtual_users`
--

TRUNCATE TABLE `virtual_users`;
--
-- Zrzut danych tabeli `virtual_users`
--

INSERT INTO `virtual_users` (`id`, `domain_id`, `password`, `email`) VALUES
(1, 1, '$6$4676f225e2988d78$iMvMbrHsOKu0k8FSgKMxlv5fE6460vt/njtPLZJ2gfphxj6Fuo6xJBfB8VbKuVwERNtlzCxikGsA4EzwWnUZn1', 'email1@example.com'),
(2, 1, '$6$29512b77bf1ca730$gOdhKcgihQ9dn7p15VDiDnZUa3hkv4eGFc2ye83UzUatbfWgDUZLubuXNol/Mn4ZbisyX4N3XnhVdq000UD6A0', 'email2@example.com');

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `virtual_aliases`
--
ALTER TABLE `virtual_aliases`
  ADD CONSTRAINT `virtual_aliases_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains` (`id`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `virtual_users`
--
ALTER TABLE `virtual_users`
  ADD CONSTRAINT `virtual_users_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
