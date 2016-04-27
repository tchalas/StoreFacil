-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 10, 2014 at 11:36 AM
-- Server version: 5.5.32
-- PHP Version: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tedmaindb`
--
CREATE DATABASE IF NOT EXISTS `tedmaindb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `tedmaindb`;

-- --------------------------------------------------------

--
-- Table structure for table `authusers`
--

CREATE TABLE IF NOT EXISTS `authusers` (
  `username` varchar(20) NOT NULL,
  `auth` bit(1) DEFAULT NULL,
  `permissions` int(11) NOT NULL,
  UNIQUE KEY `uniAuthusers` (`username`),
  KEY `username` (`username`),
  KEY `permissions` (`permissions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `warehouses` varchar(5) DEFAULT NULL COMMENT 'read, write and nope',
  `products` varchar(5) DEFAULT NULL COMMENT 'read , write and nope',
  `suppliers` varchar(5) DEFAULT NULL COMMENT 'read , write and nope',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniPermissions` (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `warehouses`, `products`, `suppliers`) VALUES
(1, 'NOPE', 'NOPE', 'NOPE'),
(2, 'READ', 'READ', 'READ'),
(3, 'WRITE', 'WRITE', 'WRITE');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `name` varchar(20) NOT NULL,
  `description` varchar(60) NOT NULL,
  `serial` int(11) NOT NULL,
  `weight` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `dimensions` varchar(20) DEFAULT NULL,
  `mass` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`,`serial`),
  UNIQUE KEY `uniProduct` (`name`,`serial`),
  KEY `name` (`name`),
  KEY `serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
  `name` varchar(20) NOT NULL,
  `address` varchar(40) NOT NULL,
  `afm` varchar(10) NOT NULL,
  `phone` varchar(10) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `unisUPP` (`name`,`afm`),
  KEY `name` (`name`),
  KEY `afm` (`afm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(20) DEFAULT NULL,
  `surname` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `admin` bit(1) DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `uniUser` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `name`, `surname`, `password`, `email`, `admin`) VALUES
('admin', 'admin', 'admin', 'admin', 'admin@admin.com', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse`
--

CREATE TABLE IF NOT EXISTS `warehouse` (
  `name` varchar(20) NOT NULL,
  `description` varchar(60) NOT NULL,
  `open` bit(1) DEFAULT NULL,
  `location` varchar(20) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `uniWare` (`name`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ware_last_movement_product`
--

CREATE TABLE IF NOT EXISTS `ware_last_movement_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nameW` varchar(20) NOT NULL,
  `nameP` varchar(20) NOT NULL,
  `serialP` int(11) NOT NULL,
  `commentP` varchar(10) NOT NULL COMMENT 'insert, delete and transport',
  `timeP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `nameW` (`nameW`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ware_product_supp`
--

CREATE TABLE IF NOT EXISTS `ware_product_supp` (
  `nameW` varchar(20) NOT NULL,
  `nameP` varchar(20) NOT NULL,
  `serialP` int(11) NOT NULL,
  `nameS` varchar(20) NOT NULL,
  `capacity` int(11) NOT NULL,
  `cost` float NOT NULL,
  UNIQUE KEY `uniWareProduct` (`nameW`,`nameP`,`serialP`,`nameS`),
  KEY `nameW` (`nameW`),
  KEY `nameP` (`nameP`),
  KEY `serialP` (`serialP`),
  KEY `nameS` (`nameS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authusers`
--
ALTER TABLE `authusers`
  ADD CONSTRAINT `authusers_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ware_last_movement_product`
--
ALTER TABLE `ware_last_movement_product`
  ADD CONSTRAINT `ware_last_movement_product_ibfk_1` FOREIGN KEY (`nameW`) REFERENCES `warehouse` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ware_product_supp`
--
ALTER TABLE `ware_product_supp`
  ADD CONSTRAINT `ware_product_supp_ibfk_1` FOREIGN KEY (`nameW`) REFERENCES `warehouse` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ware_product_supp_ibfk_2` FOREIGN KEY (`nameP`) REFERENCES `product` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ware_product_supp_ibfk_3` FOREIGN KEY (`serialP`) REFERENCES `product` (`serial`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ware_product_supp_ibfk_4` FOREIGN KEY (`nameS`) REFERENCES `supplier` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
