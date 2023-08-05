-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 22, 2019 at 03:42 PM
-- Server version: 5.7.24
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pos1`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_account`
--

DROP TABLE IF EXISTS `tbl_account`;
CREATE TABLE IF NOT EXISTS `tbl_account` (
  `Acc_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(11) NOT NULL,
  `Acc_Code` varchar(50) NOT NULL,
  `Acc_Tr_Type` varchar(25) DEFAULT NULL,
  `Acc_Name` varchar(200) NOT NULL,
  `Acc_Type` varchar(50) NOT NULL,
  `Acc_Description` varchar(255) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Acc_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_account`
--

INSERT INTO `tbl_account` (`Acc_SlNo`, `branch_id`, `Acc_Code`, `Acc_Tr_Type`, `Acc_Name`, `Acc_Type`, `Acc_Description`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 1, 'A1000', '', 'Test Account', 'Official', 'test', 'a', 'Admin', '2019-08-05 14:44:06', NULL, NULL),
(2, 1, 'A1001', '', 'Entertainment ', 'Official', '', 'a', 'Admin', '2019-08-06 16:18:56', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_assets`
--

DROP TABLE IF EXISTS `tbl_assets`;
CREATE TABLE IF NOT EXISTS `tbl_assets` (
  `as_id` int(11) NOT NULL AUTO_INCREMENT,
  `as_date` date DEFAULT NULL,
  `as_name` varchar(50) DEFAULT NULL,
  `as_qty` int(11) DEFAULT NULL,
  `as_rate` decimal(10,2) DEFAULT NULL,
  `as_amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `branchid` int(11) DEFAULT NULL,
  PRIMARY KEY (`as_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_bank_accounts`
--

DROP TABLE IF EXISTS `tbl_bank_accounts`;
CREATE TABLE IF NOT EXISTS `tbl_bank_accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(500) NOT NULL,
  `account_number` varchar(250) NOT NULL,
  `account_type` varchar(200) NOT NULL,
  `bank_name` varchar(250) NOT NULL,
  `branch_name` varchar(250) DEFAULT NULL,
  `initial_balance` float NOT NULL,
  `description` varchar(2000) NOT NULL,
  `saved_by` int(11) NOT NULL,
  `saved_datetime` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `branch_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`account_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_bank_accounts`
--

INSERT INTO `tbl_bank_accounts` (`account_id`, `account_name`, `account_number`, `account_type`, `bank_name`, `branch_name`, `initial_balance`, `description`, `saved_by`, `saved_datetime`, `updated_by`, `updated_datetime`, `branch_id`, `status`) VALUES
(1, 'Test Account 101', '100001', 'Savings', 'DBBL', 'Mirpur', 50000, 'test', 1, '2019-08-06 15:58:50', 1, '2019-08-21 17:27:17', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_bank_transactions`
--

DROP TABLE IF EXISTS `tbl_bank_transactions`;
CREATE TABLE IF NOT EXISTS `tbl_bank_transactions` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `transaction_date` date NOT NULL,
  `transaction_type` varchar(10) NOT NULL,
  `amount` float NOT NULL,
  `note` varchar(500) DEFAULT NULL,
  `saved_by` int(11) NOT NULL,
  `saved_datetime` datetime NOT NULL,
  `branch_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`transaction_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_bank_transactions`
--

INSERT INTO `tbl_bank_transactions` (`transaction_id`, `account_id`, `transaction_date`, `transaction_type`, `amount`, `note`, `saved_by`, `saved_datetime`, `branch_id`, `status`) VALUES
(1, 1, '2019-08-06', 'deposit', 10000, '', 1, '2019-08-06 15:59:06', 1, 1),
(2, 1, '2019-08-06', 'deposit', 6000, 'test', 1, '2019-08-06 19:24:56', 1, 1),
(3, 1, '2019-08-22', 'withdraw', 2000, '', 1, '2019-08-22 18:09:00', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_brand`
--

DROP TABLE IF EXISTS `tbl_brand`;
CREATE TABLE IF NOT EXISTS `tbl_brand` (
  `brand_SiNo` int(11) NOT NULL AUTO_INCREMENT,
  `ProductCategory_SlNo` int(11) NOT NULL,
  `brand_name` varchar(100) NOT NULL,
  `status` char(2) NOT NULL,
  `brand_branchid` int(11) NOT NULL,
  PRIMARY KEY (`brand_SiNo`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_brand`
--

INSERT INTO `tbl_brand` (`brand_SiNo`, `ProductCategory_SlNo`, `brand_name`, `status`, `brand_branchid`) VALUES
(1, 0, 'Lion ', 'a', 1),
(2, 0, 'R and D ', 'a', 1),
(3, 0, 'Dong', 'a', 3),
(4, 0, 'H/W', 'a', 3),
(5, 0, 'Ken', 'a', 3),
(6, 0, 'Megh', 'a', 3),
(7, 0, 'Jaf', 'a', 3),
(8, 0, 'H.M', 'a', 3),
(9, 0, 'A.R', 'a', 3),
(10, 0, 'Afs', 'a', 3),
(11, 0, 'Hus', 'a', 3),
(12, 0, 'Mabud', 'a', 3),
(13, 0, 'Kano', 'a', 3),
(14, 0, 'Amtech', 'a', 3),
(15, 0, 'Fukung', 'a', 3),
(16, 0, 'Yamato', 'a', 3),
(17, 0, 'Wim', 'a', 3),
(18, 0, 'Tanaka', 'a', 3),
(19, 0, 'Richu', 'a', 3),
(20, 0, 'Murex', 'a', 3),
(21, 0, 'Ridgid', 'a', 3),
(22, 0, 'Weldro', 'a', 3),
(23, 0, 'Sander', 'a', 3),
(24, 0, 'Others', 'a', 3),
(25, 0, 'DCA', 'a', 3),
(26, 0, 'Unison', 'a', 3),
(27, 0, 'OP', 'a', 3),
(28, 0, 'Horse', 'a', 3),
(29, 0, 'AIWA', 'a', 3),
(30, 0, 'Boky', 'a', 3),
(31, 0, 'Yokohama', 'a', 3),
(32, 0, 'Morris', 'a', 3),
(33, 0, 'Deson', 'a', 3),
(34, 0, 'Revo', 'a', 3),
(35, 0, 'Runner', 'a', 3),
(36, 0, 'STL', 'a', 3),
(37, 0, 'Dass', 'a', 3),
(38, 0, 'Red Horse', 'a', 3),
(39, 0, 'pipe', 'a', 3),
(40, 0, 'Nokia', 'a', 3),
(41, 0, 'Excel', 'a', 3),
(42, 0, 'Dragon', 'a', 3),
(43, 0, 'Langya', 'a', 3),
(44, 0, 'Osaka', 'a', 3),
(45, 0, 'Teka', 'a', 3),
(46, 0, 'Mira', 'a', 3),
(47, 0, 'Kyoto', 'a', 3),
(48, 0, 'Kawasaki', 'a', 3),
(49, 0, 'aaa', 'a', 2),
(50, 0, 'Sky High', 'a', 3),
(51, 0, 'SME', 'a', 3),
(52, 0, 'Silver Isuzu', 'a', 3),
(53, 0, 'Local', 'a', 3),
(54, 0, 'Aluminium', 'a', 3),
(55, 0, 'Orient', 'a', 3),
(56, 0, 'Koshan', 'a', 3),
(57, 0, 'Diamond', 'a', 3),
(58, 0, 'Mosay', 'a', 3),
(59, 0, 'Prince', 'a', 3),
(60, 0, 'Kaifeng', 'a', 3),
(61, 0, 'YETR', 'a', 3),
(62, 0, 'Ronix', 'a', 3),
(63, 0, 'Taiwan', 'a', 3),
(64, 0, 'Kings', 'a', 3),
(65, 0, 'Red Arrow', 'a', 3),
(66, 0, 'R.A-170', 'd', 3),
(67, 0, 'Kapro', 'a', 3),
(68, 0, 'HAWK', 'a', 3),
(69, 0, 'Wido', 'a', 3),
(70, 0, 'China', 'a', 3),
(71, 0, 'Pech', 'a', 3),
(72, 0, '-', 'a', 3),
(73, 0, 'Insize', 'a', 3),
(74, 0, 'HMBR', 'a', 3),
(75, 0, 'Poland', 'a', 3),
(76, 0, 'Super', 'a', 3),
(77, 0, 'Kesla', 'a', 3),
(78, 0, 'Auto', 'a', 3),
(79, 0, 'King Star', 'a', 3),
(80, 0, 'WIKA', 'a', 3),
(81, 0, 'Wooden Box', 'a', 3),
(82, 0, 'NISSAN', 'a', 3),
(83, 0, 'Test Brand 101', 'a', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_brunch`
--

DROP TABLE IF EXISTS `tbl_brunch`;
CREATE TABLE IF NOT EXISTS `tbl_brunch` (
  `brunch_id` int(11) NOT NULL AUTO_INCREMENT,
  `Brunch_name` varchar(250) CHARACTER SET utf8 NOT NULL,
  `Brunch_title` varchar(250) CHARACTER SET utf8 NOT NULL,
  `Brunch_address` text CHARACTER SET utf8 NOT NULL,
  `Brunch_sales` varchar(1) NOT NULL COMMENT 'Wholesales = 1, Retail = 2',
  `add_date` date NOT NULL,
  `add_time` datetime NOT NULL,
  `add_by` char(50) NOT NULL,
  `update_by` char(50) NOT NULL,
  `status` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`brunch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_brunch`
--

INSERT INTO `tbl_brunch` (`brunch_id`, `Brunch_name`, `Brunch_title`, `Brunch_address`, `Brunch_sales`, `add_date`, `add_time`, `add_by`, `update_by`, `status`) VALUES
(1, 'Branch-1', '95/1, Rahima Plaza,(1st Floor) Nawabpur Road,Dhaka', '95/1, Rahima Plaza, (1st Floor)\nNawabpur Road,\nDhaka', '2', '2019-08-07', '2019-08-07 23:09:25', '', 'Admin', 'a'),
(2, 'Branch-3', '95/1, Rahima Plaza(1st Floor) ,Nawabpur Road,Dhaka-1100', '95/1, Rahima Plaza(1st Floor) ,Nawabpur Road,Dhaka-1100', '2', '2019-08-07', '2019-08-07 23:09:25', '', '', 'a'),
(3, 'Branch-2', '95/1, Rahima Plaza(1st Floor), Nawabpur Road,Dhaka', '95/1, Rahima Plaza(1st Floor), Nawabpur Road,Dhaka', '2', '2019-08-07', '2019-08-07 23:09:25', '', '', 'a'),
(4, 'Branch-4', 'Retail Sales', 'Mirpur, Dhaka', '2', '2019-08-07', '2019-08-07 23:09:25', '', '', 'a'),
(5, 'Branch-5', 'test 123', 'Dhaka, Bangladesh', '2', '2019-08-07', '2019-08-07 23:09:25', 'Admin', 'Admin', 'd'),
(6, 'নতুন ব্রাঞ্চ', 'নতুন ব্রাঞ্চ', 'নতুন ব্রাঞ্চ', '2', '0000-00-00', '2019-08-07 23:11:18', 'Admin', '', 'a');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cashregister`
--

DROP TABLE IF EXISTS `tbl_cashregister`;
CREATE TABLE IF NOT EXISTS `tbl_cashregister` (
  `Transaction_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Transaction_Date` varchar(20) NOT NULL,
  `IdentityNo` varchar(50) DEFAULT NULL,
  `Narration` varchar(100) NOT NULL,
  `InAmount` decimal(18,2) NOT NULL,
  `OutAmount` decimal(18,2) NOT NULL,
  `Description` longtext NOT NULL,
  `Status` char(1) DEFAULT NULL,
  `Saved_By` varchar(50) DEFAULT NULL,
  `Saved_Time` datetime DEFAULT NULL,
  `Edited_By` varchar(50) DEFAULT NULL,
  `Edited_Time` datetime DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cashtransaction`
--

DROP TABLE IF EXISTS `tbl_cashtransaction`;
CREATE TABLE IF NOT EXISTS `tbl_cashtransaction` (
  `Tr_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Tr_Id` varchar(50) NOT NULL,
  `Tr_date` date NOT NULL,
  `Tr_Type` varchar(20) NOT NULL,
  `Tr_account_Type` varchar(50) NOT NULL,
  `Acc_SlID` int(11) NOT NULL,
  `Tr_Description` varchar(255) NOT NULL,
  `In_Amount` decimal(18,2) NOT NULL,
  `Out_Amount` decimal(18,2) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(100) NOT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Tr_branchid` int(11) NOT NULL,
  PRIMARY KEY (`Tr_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_cashtransaction`
--

INSERT INTO `tbl_cashtransaction` (`Tr_SlNo`, `Tr_Id`, `Tr_date`, `Tr_Type`, `Tr_account_Type`, `Acc_SlID`, `Tr_Description`, `In_Amount`, `Out_Amount`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Tr_branchid`) VALUES
(1, 'TR00001', '2019-08-05', 'In Cash', 'Official', 1, 'test', '10000.00', '0.00', 'a', 'Admin', '2019-08-05 14:44:18', NULL, NULL, 1),
(2, 'TR00002', '2019-08-06', 'Out Cash', 'Official', 1, 'test', '0.00', '500.00', 'a', 'Admin', '2019-08-06 15:54:04', NULL, NULL, 1),
(3, 'TR00003', '2019-08-06', 'Out Cash', 'Official', 1, 'test', '0.00', '400.00', 'a', 'Admin', '2019-08-06 15:54:15', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_checks`
--

DROP TABLE IF EXISTS `tbl_checks`;
CREATE TABLE IF NOT EXISTS `tbl_checks` (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cus_id` int(20) DEFAULT NULL,
  `SM_id` int(20) UNSIGNED DEFAULT NULL,
  `bank_name` varchar(250) DEFAULT NULL,
  `branch_name` varchar(250) DEFAULT NULL,
  `check_no` varchar(250) DEFAULT NULL,
  `check_amount` decimal(18,2) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `check_date` timestamp NULL DEFAULT NULL,
  `remid_date` timestamp NULL DEFAULT NULL,
  `sub_date` timestamp NULL DEFAULT NULL,
  `note` varchar(250) DEFAULT NULL,
  `check_status` char(5) DEFAULT 'Pe' COMMENT 'Pe =Pending, Pa = Paid',
  `status` char(5) NOT NULL DEFAULT 'a',
  `created_by` varchar(250) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `branch_id` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `id_2` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_color`
--

DROP TABLE IF EXISTS `tbl_color`;
CREATE TABLE IF NOT EXISTS `tbl_color` (
  `color_SiNo` int(11) NOT NULL AUTO_INCREMENT,
  `color_name` varchar(100) NOT NULL,
  `status` char(2) NOT NULL,
  PRIMARY KEY (`color_SiNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_color`
--

INSERT INTO `tbl_color` (`color_SiNo`, `color_name`, `status`) VALUES
(1, 'Red', 'a'),
(2, 'Blue', 'a');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_company`
--

DROP TABLE IF EXISTS `tbl_company`;
CREATE TABLE IF NOT EXISTS `tbl_company` (
  `Company_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Company_Name` varchar(150) NOT NULL,
  `Repot_Heading` text NOT NULL,
  `Company_Logo_org` varchar(250) NOT NULL,
  `Company_Logo_thum` varchar(250) NOT NULL,
  `Invoice_Type` int(11) NOT NULL,
  `Currency_Name` varchar(50) DEFAULT NULL,
  `Currency_Symbol` varchar(10) DEFAULT NULL,
  `SubCurrency_Name` varchar(50) DEFAULT NULL,
  `print_type` int(11) NOT NULL,
  `company_BrunchId` int(11) NOT NULL,
  PRIMARY KEY (`Company_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_company`
--

INSERT INTO `tbl_company` (`Company_SlNo`, `Company_Name`, `Repot_Heading`, `Company_Logo_org`, `Company_Logo_thum`, `Invoice_Type`, `Currency_Name`, `Currency_Symbol`, `SubCurrency_Name`, `print_type`, `company_BrunchId`) VALUES
(1, 'Pos Express Mother', 'Mirpur 10, Dhaka, Bangladesh, \r\nEarth, Milk\r\ny way', 'logo-samples-34.png', 'logo-samples-34.png', 1, NULL, NULL, NULL, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_country`
--

DROP TABLE IF EXISTS `tbl_country`;
CREATE TABLE IF NOT EXISTS `tbl_country` (
  `Country_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `CountryName` varchar(50) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Country_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_country`
--

INSERT INTO `tbl_country` (`Country_SlNo`, `CountryName`, `Status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 'Bangladesh', 'a', '1', '2019-05-11 00:00:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_currentinventory`
--

DROP TABLE IF EXISTS `tbl_currentinventory`;
CREATE TABLE IF NOT EXISTS `tbl_currentinventory` (
  `inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `purchase_quantity` float NOT NULL,
  `purchase_return_quantity` float NOT NULL,
  `sales_quantity` float NOT NULL,
  `sales_return_quantity` float NOT NULL,
  `damage_quantity` float NOT NULL,
  `transfer_from_quantity` float NOT NULL,
  `transfer_to_quantity` float NOT NULL,
  `branch_id` int(11) NOT NULL,
  PRIMARY KEY (`inventory_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_currentinventory`
--

INSERT INTO `tbl_currentinventory` (`inventory_id`, `product_id`, `purchase_quantity`, `purchase_return_quantity`, `sales_quantity`, `sales_return_quantity`, `damage_quantity`, `transfer_from_quantity`, `transfer_to_quantity`, `branch_id`) VALUES
(1, 1, 0, 0, 0, 0, 0, 0, 0, 1),
(2, 4, 40, 0, 30, 0, 0, 5, 0, 1),
(3, 10, 20, 0, 1, 0, 0, 0, 0, 1),
(4, 11, 100, 0, 5, 0, 2, 0, 0, 1),
(5, 14, 0, 0, 2, 0, 0, 0, 0, 1),
(6, 12, 100, 0, 7, 0, 0, 10, 0, 1),
(7, 13, 40, 0, 3, 0, 0, 0, 0, 1),
(8, 5, 2, 0, 1, 0, 3, 0, 0, 1),
(9, 7, 10, 0, 3, 0, 0, 0, 0, 1),
(10, 4, 0, 0, 1, 0, 0, 0, 5, 2),
(11, 12, 0, 0, 0, 0, 0, 0, 10, 2),
(12, 4, 100, 0, 1, 0, 0, 0, 0, 3),
(13, 21, 80, 0, 0, 0, 0, 0, 0, 1),
(14, 19, 40, 0, 0, 0, 0, 0, 0, 1),
(15, 17, 30, 0, 0, 0, 0, 0, 0, 1),
(16, 16, 60, 0, 0, 0, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_customer`
--

DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE IF NOT EXISTS `tbl_customer` (
  `Customer_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_Code` varchar(50) NOT NULL,
  `Customer_Name` varchar(150) NOT NULL,
  `Customer_Type` varchar(50) NOT NULL,
  `Customer_Phone` varchar(50) NOT NULL,
  `Customer_Mobile` varchar(15) NOT NULL,
  `Customer_Email` varchar(50) NOT NULL,
  `Customer_OfficePhone` varchar(50) NOT NULL,
  `Customer_Address` varchar(300) NOT NULL,
  `owner_name` varchar(250) DEFAULT NULL,
  `Country_SlNo` int(11) NOT NULL,
  `area_ID` int(11) NOT NULL,
  `Customer_Web` varchar(50) NOT NULL,
  `Customer_Credit_Limit` decimal(18,2) NOT NULL,
  `previous_due` decimal(18,2) NOT NULL,
  `image_name` varchar(1000) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Customer_brunchid` int(11) NOT NULL,
  PRIMARY KEY (`Customer_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_customer`
--

INSERT INTO `tbl_customer` (`Customer_SlNo`, `Customer_Code`, `Customer_Name`, `Customer_Type`, `Customer_Phone`, `Customer_Mobile`, `Customer_Email`, `Customer_OfficePhone`, `Customer_Address`, `owner_name`, `Country_SlNo`, `area_ID`, `Customer_Web`, `Customer_Credit_Limit`, `previous_due`, `image_name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Customer_brunchid`) VALUES
(0, 'C00045', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'C00045.png', 'd', 'Admin', '2019-07-19 22:29:13', 'Admin', '2019-07-19 22:41:43', 1),
(1, 'C00001', 'General Customer', 'retail', '', '-', '', '-', '-', NULL, 0, 2, '', '0.00', '0.00', NULL, 'a', 'Admin', '2018-09-05 05:02:57', NULL, NULL, 0),
(15, 'C02200', 'A and J Enterprise ', 'retail', '', '01711388617', '', '01761852513', 'Bazar Road, Barishal ', NULL, 0, 12, '', '9999999999999999.99', '15000.00', NULL, 'd', 'Admin', '2019-03-06 11:34:52', 'Admin', '2019-03-12 04:06:36', 1),
(16, 'C16', 'Shovo Hardware and Tools.', 'retail', '', '01778006977', '', '029558930', '95/1, Rahima Plaza, Nawabpur Road, Dhaka-1100', NULL, 0, 14, '', '0.00', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:54:09', 'Admin', '2019-03-06 07:01:13', 3),
(17, 'C17', 'D M Tools and Machineries.', 'retail', '', '01937152522', '', '', '98, Nawabpur Road, Dhaka-1100', NULL, 0, 14, '', '0.00', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:56:11', 'Admin', '2019-03-06 06:59:30', 3),
(18, 'C18', 'Haq Corporation', 'retail', '', '01716861058', '', '', 'Nawabpur Road, Dhaka-1100', NULL, 0, 14, '', '0.00', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:57:19', NULL, NULL, 3),
(19, 'C19', 'Mr. Axe', 'retail', '', '01795075081', '', '', 'China Town', NULL, 0, 10, '', '50000.00', '0.00', NULL, 'd', 'Admin', '2019-04-14 04:31:22', NULL, NULL, 1),
(20, 'C20', 'Abu Zoha', 'retail', '', '01987387', '', '', 'Dhaka', NULL, 0, 14, '', '100000.00', '0.00', NULL, 'd', 'Admin', '2019-04-17 04:08:55', NULL, NULL, 1),
(21, 'C21', 'Customer 101', 'retail', '', '01680548096', '', '', 'Mirpur, Dhaka', NULL, 0, 1, '', '50000.00', '10000.00', NULL, 'd', 'Admin', '2019-05-12 09:57:47', 'Admin', '2019-05-23 04:27:00', 1),
(22, 'C22', 'Md. Mozammel Hossain', 'retail', '', '01911978897', '', '01674543354', '187- ERast Kazi Para\nMirpur-10, Dhaka', NULL, 0, 1, '', '50000.00', '5000.00', NULL, 'd', 'Admin', '2019-05-18 09:49:40', 'Admin', '2019-05-23 04:51:59', 1),
(23, 'C23', 'Wholesale customer 1001', 'wholesale', '', '01680548096', '', '01761852513', 'Mirpur, Dhaka', NULL, 0, 1, '', '50000.00', '10000.00', NULL, 'd', 'Admin', '2019-05-23 04:52:42', 'Admin', '2019-05-23 04:52:52', 1),
(24, 'C00024', 'Test Customer 101', 'retail', '', '01680549696', '', '01680549698', 'Mirpur', NULL, 0, 1, '', '10000.00', '0.00', 'C00024.jpg', 'a', 'Admin', '2019-06-19 08:36:25', 'Admin', '2019-07-19 22:47:34', 1),
(25, 'C00025', 'Test Customer 2083', 'retail', '', '64654846', '', '68684648', 'Mirpur', NULL, 0, 1, '', '50000.00', '0.00', 'C00025.png', 'd', 'Admin', '2019-06-22 02:27:06', 'Admin', '2019-07-19 22:48:11', 1),
(26, 'C00026', 'Test Customer 08237', 'retail', '', '01680549652', '', '654688', 'Mirpur 10', 'Mr. XXXXYYXX', 0, 1, '', '50000.00', '0.00', NULL, 'a', 'Admin', '2019-06-22 09:28:09', 'Admin', '2019-07-20 16:35:50', 1),
(27, 'C00027', '\'', 'retail', '', '\'', '', '\'', '\'', '\'', 0, 0, '', '0.00', '0.00', NULL, 'd', 'Admin', '2019-07-05 03:33:24', NULL, NULL, 1),
(28, 'C00028', 'Test Customer 82732', 'retail', '', '01680549651', '', '01680549651', 'Mirpur', 'Mr.XXX', 0, 1, '', '0.00', '0.00', '28', 'a', 'Admin', '2019-07-19 21:47:13', NULL, NULL, 1),
(29, 'C00029', 'Test Customer 98798', 'retail', '', '01680549654', '', '01680549654', 'Mirpur', 'Mr.XXX', 0, 1, '', '0.00', '0.00', '29.jpg', 'a', 'Admin', '2019-07-19 21:48:50', NULL, NULL, 1),
(30, 'C00030', 'Test Customer 09878', 'retail', '', '01680549514', '', '01680549514', 'Mirpur', 'Mr. YYY', 0, 1, '', '0.00', '0.00', '30.jpg', 'a', 'Admin', '2019-07-19 21:49:34', NULL, NULL, 1),
(31, 'C00031', 'Test Customer 87878', 'retail', '', '01680549558', '', '01680549558', 'Mirpur', 'Mr.ZZZZ', 0, 1, '', '0.00', '0.00', NULL, 'a', 'Admin', '2019-07-19 21:53:01', NULL, NULL, 1),
(32, 'C00031', 'Test Customer 87878', 'retail', '', '01680549558', '', '01680549558', 'Mirpur', 'Mr.ZZZZ', 0, 1, '', '0.00', '0.00', NULL, 'a', 'Admin', '2019-07-19 21:53:08', NULL, NULL, 1),
(33, 'C00031', 'Test Customer 87878', 'retail', '', '01680549558', '', '01680549558', 'Mirpur', 'Mr.ZZZZ', 0, 1, '', '0.00', '0.00', '33', 'a', 'Admin', '2019-07-19 21:53:48', NULL, NULL, 1),
(34, 'C00034', 'Test Customer 65486', 'retail', '', '01680549658', '', '01680549658', 'Mirpur', 'Mr.AAA', 0, 1, '', '0.00', '0.00', '34', 'a', 'Admin', '2019-07-19 21:54:56', NULL, NULL, 1),
(35, 'C00035', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', '35.jpg', 'a', 'Admin', '2019-07-19 21:56:56', NULL, NULL, 1),
(36, 'C00036', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', '36.jpg', 'a', 'Admin', '2019-07-19 21:57:56', NULL, NULL, 1),
(37, 'C00037', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'C00037', 'a', 'Admin', '2019-07-19 22:01:15', NULL, NULL, 1),
(38, 'C00038', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'C00038.jpg', 'a', 'Admin', '2019-07-19 22:01:33', NULL, NULL, 1),
(39, 'C00039', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', NULL, 'a', 'Admin', '2019-07-19 22:07:28', NULL, NULL, 1),
(40, 'C00040', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'download_(1).jpg', 'a', 'Admin', '2019-07-19 22:20:45', NULL, NULL, 1),
(41, 'C00041', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'C00041.jpg', 'a', 'Admin', '2019-07-19 22:22:02', NULL, NULL, 1),
(42, 'C00042', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'C00042', 'a', 'Admin', '2019-07-19 22:25:31', NULL, NULL, 1),
(43, 'C00043', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'C00043jpg', 'a', 'Admin', '2019-07-19 22:27:16', NULL, NULL, 1),
(44, 'C00044', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'C00044', 'a', 'Admin', '2019-07-19 22:28:16', NULL, NULL, 1),
(46, 'C00045', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'C00045.png', 'd', 'Admin', '2019-07-19 22:44:43', NULL, NULL, 1),
(47, 'C00045', 'Customer 55555', 'retail', '01680549954', '01680549954', '', '01680549954', 'Mirpur', 'Mr. BBB', 0, 1, '', '0.00', '0.00', 'C00045.jpg', 'a', 'Admin', '2019-07-19 22:45:30', NULL, NULL, 1),
(48, 'C00048', 'asdfasdf', 'retail', '', '01680549485', '', '01680549654', 'asdfasdf', 'sdfasdf', 0, 1, '', '0.00', '0.00', NULL, 'd', 'Admin', '2019-07-20 15:58:47', NULL, NULL, 1),
(49, 'C00049', 'asdfasdfasf', 'retail', '', '654654648', '', '654654648', 'asdfasdfsa', 'asdfasdfasf', 0, 1, '', '0.00', '0.00', NULL, 'a', 'Admin', '2019-07-20 17:17:29', NULL, NULL, 1),
(50, 'C00050', 'sadfasd sadf', 'retail', '', '65165465168', '', '65165465168', 'asdfasdf asdf', 'asdf asdfasf', 0, 1, '', '0.00', '0.00', NULL, 'a', 'Admin', '2019-07-20 20:32:24', NULL, NULL, 1),
(51, 'C00051', 'Customer 9882', 'retail', '', '01685496325', '', '01685496325', 'Mirpur ', '', 0, 1, '', '10000.00', '5000.00', NULL, 'a', 'Admin', '2019-08-18 16:40:42', NULL, NULL, 1),
(52, 'C00052', 'General Customer 1011', 'G', '', '01680549548', '', '', 'Mirpur, Dhaka', NULL, 0, 0, '', '0.00', '0.00', NULL, 'a', 'Admin', '2019-08-19 19:36:56', 'Admin', '2019-08-19 19:48:45', 1),
(53, 'C00053', 'Rayhan', 'retail', '', '01708556674', '', '01708556674', 'Mirpur, Dhaka', '', 0, 1, '', '50000.00', '0.00', NULL, 'a', 'Admin', '2019-08-19 22:08:35', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_customer_payment`
--

DROP TABLE IF EXISTS `tbl_customer_payment`;
CREATE TABLE IF NOT EXISTS `tbl_customer_payment` (
  `CPayment_id` int(11) NOT NULL AUTO_INCREMENT,
  `CPayment_date` date DEFAULT NULL,
  `CPayment_invoice` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `CPayment_customerID` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `CPayment_TransactionType` varchar(20) DEFAULT NULL,
  `CPayment_amount` decimal(18,2) DEFAULT NULL,
  `out_amount` float NOT NULL DEFAULT '0',
  `CPayment_Paymentby` varchar(50) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `CPayment_notes` varchar(225) CHARACTER SET latin1 DEFAULT NULL,
  `CPayment_brunchid` int(11) DEFAULT NULL,
  `CPayment_previous_due` float NOT NULL DEFAULT '0',
  `CPayment_Addby` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `CPayment_AddDAte` date DEFAULT NULL,
  `CPayment_status` varchar(1) DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `CPayment_UpdateDAte` date DEFAULT NULL,
  PRIMARY KEY (`CPayment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_customer_payment`
--

INSERT INTO `tbl_customer_payment` (`CPayment_id`, `CPayment_date`, `CPayment_invoice`, `CPayment_customerID`, `CPayment_TransactionType`, `CPayment_amount`, `out_amount`, `CPayment_Paymentby`, `account_id`, `CPayment_notes`, `CPayment_brunchid`, `CPayment_previous_due`, `CPayment_Addby`, `CPayment_AddDAte`, `CPayment_status`, `update_by`, `CPayment_UpdateDAte`) VALUES
(1, '2019-07-11', 'TR-001', '26', 'CR', '2000.00', 0, 'By Cash', 0, 'test', 1, 0, 'Admin', '2019-07-11', 'd', NULL, NULL),
(2, '2019-08-04', 'TR00002', '24', 'CR', '17780.00', 0, NULL, 0, 'test', 1, 0, 'Admin', '2019-08-04', 'a', NULL, NULL),
(3, '2019-08-04', 'TR00003', '24', 'CR', '5000.00', 0, NULL, 0, 'test', 1, 40000, 'Admin', '2019-08-04', 'a', NULL, NULL),
(4, '2019-08-04', 'TR00004', '24', 'CR', '5000.00', 0, NULL, 0, 'test', 1, 35000, 'Admin', '2019-08-04', 'a', NULL, NULL),
(5, '2019-08-05', 'TR00005', '24', 'CR', '15000.00', 0, NULL, 0, 'test', 1, 35500, 'Admin', '2019-08-05', 'a', NULL, NULL),
(6, '2019-08-06', 'TR00006', '24', 'CR', '500.00', 0, NULL, 0, 'test', 1, 20500, 'Admin', '2019-08-06', 'a', NULL, NULL),
(7, '2019-08-06', 'TR00007', '24', 'CR', '15000.00', 0, NULL, 0, 'test', 1, 20000, 'Admin', '2019-08-06', 'a', NULL, NULL),
(8, '2019-08-18', 'TR00008', '51', 'CR', '10000.00', 0, NULL, 0, 'test', 1, 17000, 'Admin', '2019-08-18', 'a', NULL, NULL),
(9, '2019-08-22', 'TR00009', '51', 'CR', '2000.00', 0, 'bank', 1, 'test', 1, 9000, 'Admin', '2019-08-22', 'a', NULL, NULL),
(10, '2019-08-22', 'TR00010', '51', 'CR', '1000.00', 0, 'cash', NULL, '', 1, 7000, 'Admin', '2019-08-22', 'a', NULL, NULL),
(11, '2019-08-22', 'TR00011', '51', 'CP', '500.00', 0, 'bank', 1, 'paid', 1, 6000, 'Admin', '2019-08-22', 'a', NULL, NULL),
(12, '2019-08-22', 'TR00012', '51', 'CR', '5000.00', 0, 'bank', 1, '', 1, 6500, 'Admin', '2019-08-22', 'a', NULL, NULL),
(13, '2019-08-22', 'TR00013', '51', 'CR', '500.00', 0, 'cash', 1, '', 1, 1500, 'Admin', '2019-08-22', 'a', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_damage`
--

DROP TABLE IF EXISTS `tbl_damage`;
CREATE TABLE IF NOT EXISTS `tbl_damage` (
  `Damage_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Damage_InvoiceNo` varchar(50) NOT NULL,
  `Damage_Date` date NOT NULL,
  `Damage_Description` varchar(300) NOT NULL,
  `status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Damage_brunchid` int(11) NOT NULL,
  PRIMARY KEY (`Damage_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_damage`
--

INSERT INTO `tbl_damage` (`Damage_SlNo`, `Damage_InvoiceNo`, `Damage_Date`, `Damage_Description`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Damage_brunchid`) VALUES
(1, 'D1000', '2019-07-17', 'just for test', 'a', 'Admin', '2019-07-17 19:51:09', 'Admin', '2019-08-07 20:00:07', 1),
(2, 'D1001', '2019-07-17', 'sd', 'a', 'Admin', '2019-07-17 19:52:00', 'Admin', '2019-08-07 23:21:23', 1),
(3, 'D1002', '2019-07-17', 'ssss', 'd', 'Admin', '2019-07-17 19:52:45', NULL, NULL, 1),
(4, 'D1003', '2019-07-17', 'testing...', 'd', 'Admin', '2019-07-17 20:28:16', NULL, NULL, 1),
(5, 'TR0005', '2019-08-07', 'test', 'a', 'Admin', '2019-08-07 18:39:03', NULL, NULL, 1),
(6, 'TR0005', '2019-08-07', 'test', 'a', 'Admin', '2019-08-07 18:39:48', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_damagedetails`
--

DROP TABLE IF EXISTS `tbl_damagedetails`;
CREATE TABLE IF NOT EXISTS `tbl_damagedetails` (
  `DamageDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Damage_SlNo` int(11) NOT NULL,
  `Product_SlNo` int(11) NOT NULL,
  `DamageDetails_DamageQuantity` int(11) NOT NULL,
  `damage_amount` float NOT NULL,
  `status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`DamageDetails_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_damagedetails`
--

INSERT INTO `tbl_damagedetails` (`DamageDetails_SlNo`, `Damage_SlNo`, `Product_SlNo`, `DamageDetails_DamageQuantity`, `damage_amount`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 1, 11, 1, 2000, 'a', 'Admin', '2019-07-17 19:51:09', 'Admin', '2019-08-07 20:00:07'),
(2, 2, 11, 1, 500, 'a', 'Admin', '2019-07-17 19:52:00', 'Admin', '2019-08-07 23:21:23'),
(3, 3, 5, 2, 0, 'd', 'Admin', '2019-07-17 19:52:45', NULL, NULL),
(4, 4, 5, 1, 0, 'd', 'Admin', '2019-07-17 20:28:16', NULL, NULL),
(5, 6, 21, 1, 1500, 'a', 'Admin', '2019-08-07 18:39:48', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_department`
--

DROP TABLE IF EXISTS `tbl_department`;
CREATE TABLE IF NOT EXISTS `tbl_department` (
  `Department_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Department_Name` varchar(50) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Department_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_department`
--

INSERT INTO `tbl_department` (`Department_SlNo`, `Department_Name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 'Foreign Trade, Administration, Marketing ', 'a', 'Admin', '2019-03-05 06:24:54', NULL, NULL),
(2, 'Sales', 'a', 'Admin', '2019-03-05 06:25:11', NULL, NULL),
(3, 'Conveyor', 'a', 'Admin', '2019-03-05 06:28:26', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_designation`
--

DROP TABLE IF EXISTS `tbl_designation`;
CREATE TABLE IF NOT EXISTS `tbl_designation` (
  `Designation_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Designation_Name` varchar(50) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Designation_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_designation`
--

INSERT INTO `tbl_designation` (`Designation_SlNo`, `Designation_Name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 'Manager', 'a', 'Admin', '2019-03-05 06:15:13', NULL, NULL),
(2, 'Warehouse Manager ', 'a', 'Admin', '2019-03-05 06:16:08', NULL, NULL),
(3, 'Employee ', 'a', 'Admin', '2019-03-05 06:16:49', NULL, NULL),
(4, 'Admin ', 'a', 'Admin', '2019-03-05 06:18:34', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district`
--

DROP TABLE IF EXISTS `tbl_district`;
CREATE TABLE IF NOT EXISTS `tbl_district` (
  `District_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `District_Name` varchar(50) NOT NULL,
  `status` char(10) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`District_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_district`
--

INSERT INTO `tbl_district` (`District_SlNo`, `District_Name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 'Mirpur 10', 'a', 'Admin', '2019-05-12 09:55:12', 'Admin', '2019-05-12 09:55:26');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employee`
--

DROP TABLE IF EXISTS `tbl_employee`;
CREATE TABLE IF NOT EXISTS `tbl_employee` (
  `Employee_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Designation_ID` int(11) NOT NULL,
  `Department_ID` int(11) NOT NULL,
  `Employee_ID` varchar(50) NOT NULL,
  `Employee_Name` varchar(150) NOT NULL,
  `Employee_JoinDate` date NOT NULL,
  `Employee_Gender` varchar(20) NOT NULL,
  `Employee_BirthDate` date NOT NULL,
  `Employee_NID` varchar(50) NOT NULL,
  `Employee_ContactNo` varchar(20) NOT NULL,
  `Employee_Email` varchar(50) NOT NULL,
  `Employee_MaritalStatus` varchar(50) NOT NULL,
  `Employee_FatherName` varchar(150) NOT NULL,
  `Employee_MotherName` varchar(150) NOT NULL,
  `Employee_PrasentAddress` text NOT NULL,
  `Employee_PermanentAddress` text NOT NULL,
  `Employee_Pic_org` varchar(250) NOT NULL,
  `Employee_Pic_thum` varchar(250) NOT NULL,
  `salary_range` int(11) NOT NULL,
  `status` char(10) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) NOT NULL,
  `AddTime` varchar(50) NOT NULL,
  `UpdateBy` varchar(50) NOT NULL,
  `UpdateTime` varchar(50) NOT NULL,
  `Employee_brinchid` int(11) NOT NULL,
  PRIMARY KEY (`Employee_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_employee`
--

INSERT INTO `tbl_employee` (`Employee_SlNo`, `Designation_ID`, `Department_ID`, `Employee_ID`, `Employee_Name`, `Employee_JoinDate`, `Employee_Gender`, `Employee_BirthDate`, `Employee_NID`, `Employee_ContactNo`, `Employee_Email`, `Employee_MaritalStatus`, `Employee_FatherName`, `Employee_MotherName`, `Employee_PrasentAddress`, `Employee_PermanentAddress`, `Employee_Pic_org`, `Employee_Pic_thum`, `salary_range`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Employee_brinchid`) VALUES
(1, 3, 1, 'E1001', 'Roni Mazumder', '2019-03-05', 'Male', '2019-03-05', '', '01932598574', 'r', 'married', '', 'r', 's', 's', '12.jpg', '12.jpg', 12000, 'a', 'Admin', '2019-06-25 09:01:06', '', '', 1),
(2, 1, 2, 'E1002', 'Tareque Islam', '2017-10-01', 'Male', '1980-01-17', '', '01720208244', 'tareque.islam12@gmail.com', 'married', 'Md. Jalil Miah', 'Nibaron Nesa', '283, Tushardhara R/A, Fatullah, Narayangonj.', 'Vill-Raypur, P.O-Satani, P.S-Titas, Dist-Cumilla', '', '', 0, 'a', 'Admin', '2019-03-13 02:07:35', '', '', 3),
(3, 3, 1, 'E1003', 'Rayhan Hasnat', '2019-01-01', 'Male', '1989-01-01', '', 'none', 'rayhan@host.com', 'unmarried', 'Father\'s Name', 'Mother\'s Name', 'none', 'none', '121.jpg', '121.jpg', 10000, 'a', 'Admin', '2019-06-26 03:54:01', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employee_payment`
--

DROP TABLE IF EXISTS `tbl_employee_payment`;
CREATE TABLE IF NOT EXISTS `tbl_employee_payment` (
  `employee_payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `Employee_SlNo` int(11) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `month_id` int(11) NOT NULL,
  `payment_amount` decimal(18,2) NOT NULL,
  `deduction_amount` decimal(18,2) NOT NULL,
  `status` varchar(1) DEFAULT NULL,
  `save_by` char(30) NOT NULL,
  `save_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` int(11) DEFAULT NULL,
  `update_date` varchar(12) NOT NULL,
  `paymentBranch_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_employee_payment`
--

INSERT INTO `tbl_employee_payment` (`employee_payment_id`, `Employee_SlNo`, `payment_date`, `month_id`, `payment_amount`, `deduction_amount`, `status`, `save_by`, `save_date`, `update_by`, `update_date`, `paymentBranch_id`) VALUES
(1, 3, '2019-07-13', 7, '8000.00', '0.00', 'a', 'Admin', '2019-07-13 13:30:38', NULL, '2019-07-18', 1),
(2, 1, '2019-07-13', 6, '10000.00', '0.00', 'd', 'Admin', '2019-07-13 13:37:30', NULL, '', 1),
(3, 1, '2019-08-05', 7, '5000.00', '0.00', 'a', 'Admin', '2019-08-05 12:30:55', NULL, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_expense_head`
--

DROP TABLE IF EXISTS `tbl_expense_head`;
CREATE TABLE IF NOT EXISTS `tbl_expense_head` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `head_name` varchar(100) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `status` enum('a','d') DEFAULT 'a',
  `saved_by` int(11) DEFAULT NULL,
  `saved_datetime` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `update_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_month`
--

DROP TABLE IF EXISTS `tbl_month`;
CREATE TABLE IF NOT EXISTS `tbl_month` (
  `month_id` int(11) NOT NULL AUTO_INCREMENT,
  `month_name` char(30) NOT NULL,
  PRIMARY KEY (`month_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_month`
--

INSERT INTO `tbl_month` (`month_id`, `month_name`) VALUES
(1, 'January-2019'),
(2, 'February-2019'),
(3, 'March-2019'),
(4, 'April-2019'),
(5, 'May-2019'),
(6, 'June-2019'),
(7, 'July-2019'),
(8, 'August-2019');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_product`
--

DROP TABLE IF EXISTS `tbl_product`;
CREATE TABLE IF NOT EXISTS `tbl_product` (
  `Product_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Product_Code` varchar(50) NOT NULL,
  `Product_Name` varchar(150) NOT NULL,
  `ProductCategory_ID` int(11) NOT NULL,
  `color` int(11) NOT NULL,
  `brand` int(11) NOT NULL,
  `size` varchar(11) NOT NULL DEFAULT 'na',
  `vat` float NOT NULL,
  `Product_ReOrederLevel` int(11) NOT NULL,
  `Product_Purchase_Rate` decimal(18,2) NOT NULL,
  `Product_SellingPrice` decimal(18,2) NOT NULL,
  `Product_MinimumSellingPrice` decimal(18,2) NOT NULL,
  `Product_WholesaleRate` decimal(18,2) NOT NULL,
  `one_cartun_equal` varchar(20) NOT NULL,
  `is_service` varchar(10) NOT NULL DEFAULT 'false',
  `Unit_ID` int(11) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(100) NOT NULL,
  `AddTime` varchar(30) NOT NULL,
  `UpdateBy` varchar(50) NOT NULL,
  `UpdateTime` varchar(30) NOT NULL,
  `Product_branchid` int(11) NOT NULL,
  PRIMARY KEY (`Product_SlNo`),
  UNIQUE KEY `Product_Code` (`Product_Code`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_product`
--

INSERT INTO `tbl_product` (`Product_SlNo`, `Product_Code`, `Product_Name`, `ProductCategory_ID`, `color`, `brand`, `size`, `vat`, `Product_ReOrederLevel`, `Product_Purchase_Rate`, `Product_SellingPrice`, `Product_MinimumSellingPrice`, `Product_WholesaleRate`, `one_cartun_equal`, `is_service`, `Unit_ID`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Product_branchid`) VALUES
(1, 'P00001', 'Test Product 101', 1, 0, 1, 'undefined', 0, 10, '1000.00', '2000.00', '0.00', '1500.00', 'undefined', 'true', 1, 'a', 'Admin', '2019-05-15 10:03:17', 'Admin', '2019-07-09 22:08:27', 1),
(2, 'P00002', 'Test Product 102', 1, 0, 2, 'na', 0, 5, '1500.00', '2500.00', '0.00', '0.00', 'undefined', 'false', 1, 'd', 'Admin', '2019-05-15 10:03:26', '', '', 1),
(3, 'P00003', 'Test Product 103', 1, 0, 2, 'undefined', 0, 10, '2300.00', '3300.00', '0.00', '3300.00', 'undefined', 'false', 1, 'd', 'Admin', '2019-05-15 10:03:40', 'Admin', '2019-05-23 03:30:42', 1),
(4, 'P00004', 'Test Product 104', 1, 0, 2, 'na', 0, 5, '1400.00', '2000.00', '0.00', '2000.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-05-15 10:03:57', 'Admin', '2019-05-23 03:14:00', 1),
(5, 'P00005', 'Test Product 105', 2, 0, 83, 'na', 0, 5, '1600.00', '2600.00', '0.00', '2200.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-05-23 02:31:34', 'Admin', '2019-05-23 03:03:45', 1),
(7, 'P00006', 'Test Product 106', 2, 0, 1, 'na', 0, 10, '2400.00', '3600.00', '0.00', '3200.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-05-23 03:14:39', '', '', 1),
(8, 'P00007', 'Test Product 107', 2, 0, 83, 'na', 0, 10, '1800.00', '2800.00', '0.00', '2500.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-05-23 03:15:51', '', '', 1),
(9, 'P00008', 'Test Product 108', 2, 0, 83, 'na', 0, 10, '1700.00', '2700.00', '0.00', '2100.00', 'undefined', 'false', 1, 'd', 'Admin', '2019-05-23 03:26:29', 'Admin', '2019-05-23 03:28:32', 1),
(10, 'P00010', 'Test Product 3232', 1, 0, 83, 'undefined', 0, 10, '3000.00', '3500.00', '0.00', '3200.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-06-16 09:06:06', '', '', 1),
(11, 'P00011', 'Product 558', 1, 0, 1, 'undefined', 20, 10, '66.67', '200.00', '0.00', '80.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-06-22 09:51:40', 'Admin', '2019-07-05 04:29:16', 1),
(12, 'P00012', 'Test Product 654814', 1, 0, 83, 'undefined', 15, 10, '1800.00', '2200.00', '0.00', '2000.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-07-05 04:24:11', '', '', 1),
(13, 'P00013', 'Product 098097', 1, 0, 0, 'undefined', 0, 10, '7000.00', '8000.00', '0.00', '7500.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-07-09 14:56:29', '', '', 1),
(14, 'P00014', 'Product 98798789', 1, 0, 0, 'undefined', 0, 0, '2000.00', '3000.00', '0.00', '0.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-07-09 14:59:23', 'Admin', '2019-07-09 21:49:55', 1),
(15, 'P00015', 'Mobile repare', 1, 0, 0, 'undefined', 0, 0, '4000.00', '5000.00', '0.00', '4500.00', 'undefined', 'true', 1, 'a', 'Admin', '2019-07-09 21:11:03', '', '', 1),
(16, 'P00016', 'Test Product 6546584', 1, 0, 0, 'undefined', 0, 10, '4500.00', '5500.00', '0.00', '0.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-07-10 17:51:56', '', '', 1),
(17, 'P00017', 'Product 9838966', 1, 0, 0, 'undefined', 0, 10, '3000.00', '4000.00', '0.00', '3500.00', 'undefined', 'false', 1, 'a', 'Admin', '2019-07-10 18:50:55', '', '', 1),
(18, 'P00018', 'Product 987283', 1, 0, 0, 'na', 5, 5, '1000.00', '1500.00', '0.00', '1200.00', '', 'false', 1, 'a', 'Admin', '2019-07-20 21:41:36', 'Admin', '2019-07-20 22:04:40', 0),
(19, 'P00019', 'adfasd sadf asdf', 1, 0, 0, 'na', 0, 5, '1500.00', '2500.00', '0.00', '0.00', '', 'false', 1, 'a', 'Admin', '2019-07-20 22:09:57', '', '', 0),
(20, 'P00020', 'asdfa sdf sadf', 1, 0, 0, 'na', 0, 10, '2500.00', '3500.00', '0.00', '0.00', '', 'false', 1, 'a', 'Admin', '2019-07-20 22:10:26', '', '', 0),
(21, 'P00021', 'adfas asdf', 1, 0, 0, 'na', 0, 5, '1800.00', '2500.00', '0.00', '0.00', '', 'false', 1, 'a', 'Admin', '2019-07-20 22:11:04', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_productcategory`
--

DROP TABLE IF EXISTS `tbl_productcategory`;
CREATE TABLE IF NOT EXISTS `tbl_productcategory` (
  `ProductCategory_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `ProductCategory_Name` varchar(150) NOT NULL,
  `ProductCategory_Description` varchar(300) NOT NULL,
  `status` char(1) NOT NULL,
  `AddBy` varchar(50) NOT NULL,
  `AddTime` varchar(30) NOT NULL,
  `UpdateBy` varchar(50) NOT NULL,
  `UpdateTime` varchar(30) NOT NULL,
  `category_branchid` int(11) NOT NULL,
  PRIMARY KEY (`ProductCategory_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_productcategory`
--

INSERT INTO `tbl_productcategory` (`ProductCategory_SlNo`, `ProductCategory_Name`, `ProductCategory_Description`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `category_branchid`) VALUES
(1, 'Category 1', '', 'a', 'Admin', '2019-05-15 09:44:39', '', '', 1),
(2, 'Category 2', 'Test Category', 'a', 'Admin', '2019-05-23 02:30:34', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchasedetails`
--

DROP TABLE IF EXISTS `tbl_purchasedetails`;
CREATE TABLE IF NOT EXISTS `tbl_purchasedetails` (
  `PurchaseDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `PurchaseMaster_IDNo` int(11) NOT NULL,
  `Product_IDNo` int(11) NOT NULL,
  `PurchaseDetails_TotalQuantity` float NOT NULL,
  `PurchaseDetails_Rate` decimal(18,2) NOT NULL,
  `purchase_cost` decimal(18,2) NOT NULL,
  `PurchaseDetails_Discount` decimal(18,2) NOT NULL,
  `PurchaseDetails_TotalAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `PurchaseDetails_branchID` int(11) NOT NULL,
  PRIMARY KEY (`PurchaseDetails_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_purchasedetails`
--

INSERT INTO `tbl_purchasedetails` (`PurchaseDetails_SlNo`, `PurchaseMaster_IDNo`, `Product_IDNo`, `PurchaseDetails_TotalQuantity`, `PurchaseDetails_Rate`, `purchase_cost`, `PurchaseDetails_Discount`, `PurchaseDetails_TotalAmount`, `Status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `PurchaseDetails_branchID`) VALUES
(1, 1, 1, 100, '1000.00', '0.00', '0.00', '100000.00', 'd', 'Admin', '2019-07-11 17:00:49', NULL, NULL, 1),
(2, 1, 4, 150, '1400.00', '0.00', '0.00', '210000.00', 'd', 'Admin', '2019-07-11 17:00:49', NULL, NULL, 1),
(3, 1, 10, 200, '3000.00', '0.00', '0.00', '600000.00', 'd', 'Admin', '2019-07-11 17:00:49', NULL, NULL, 1),
(4, 1, 11, 80, '66.67', '0.00', '0.00', '5333.60', 'd', 'Admin', '2019-07-11 17:00:49', NULL, NULL, 1),
(5, 2, 14, 50, '2000.00', '0.00', '0.00', '100000.00', 'd', 'Admin', '2019-07-11 17:01:04', NULL, NULL, 1),
(6, 3, 12, 100, '1800.00', '0.00', '0.00', '180000.00', 'a', 'Admin', '2019-07-11 17:01:18', NULL, NULL, 1),
(7, 4, 4, 40, '1400.00', '0.00', '0.00', '56000.00', 'a', 'Admin', '2019-07-11 17:20:59', NULL, NULL, 1),
(8, 4, 10, 20, '3000.00', '0.00', '0.00', '60000.00', 'a', 'Admin', '2019-07-11 17:21:00', NULL, NULL, 1),
(9, 4, 11, 100, '66.67', '0.00', '0.00', '6667.00', 'a', 'Admin', '2019-07-11 17:21:00', NULL, NULL, 1),
(10, 5, 13, 10, '7000.00', '0.00', '0.00', '70000.00', 'a', 'Admin', '2019-07-11 20:05:10', NULL, NULL, 1),
(11, 6, 5, 2, '1600.00', '0.00', '0.00', '3200.00', 'a', 'Admin', '2020-07-13 21:28:40', NULL, NULL, 1),
(12, 7, 7, 10, '2400.00', '0.00', '0.00', '24000.00', 'a', 'Admin', '2020-07-13 21:28:53', NULL, NULL, 1),
(13, 8, 5, 1, '1600.00', '0.00', '0.00', '1600.00', 'd', 'Admin', '2019-07-19 19:56:10', NULL, NULL, 1),
(14, 9, 5, 10, '1600.00', '0.00', '0.00', '16000.00', 'd', 'Admin', '2019-07-20 20:36:35', NULL, NULL, 1),
(15, 10, 4, 100, '1400.00', '0.00', '0.00', '140000.00', 'a', 'Admin', '2019-08-04 22:11:48', NULL, NULL, 3),
(16, 11, 21, 50, '1800.00', '0.00', '0.00', '90000.00', 'a', 'Admin', '2019-08-19 20:42:26', NULL, NULL, 1),
(17, 11, 19, 40, '1500.00', '0.00', '0.00', '60000.00', 'a', 'Admin', '2019-08-19 20:42:26', NULL, NULL, 1),
(18, 12, 21, 20, '1800.00', '0.00', '0.00', '36000.00', 'a', 'Admin', '2019-08-19 20:45:06', NULL, NULL, 1),
(19, 12, 17, 30, '3000.00', '0.00', '0.00', '90000.00', 'a', 'Admin', '2019-08-19 20:45:06', NULL, NULL, 1),
(20, 13, 16, 50, '4500.00', '0.00', '0.00', '225000.00', 'a', 'Admin', '2019-08-19 20:46:17', NULL, NULL, 1),
(21, 14, 13, 10, '7000.00', '0.00', '0.00', '70000.00', 'a', 'Admin', '2019-08-19 20:47:29', NULL, NULL, 1),
(22, 15, 13, 20, '7000.00', '0.00', '0.00', '140000.00', 'a', 'Admin', '2019-08-19 20:48:54', NULL, NULL, 1),
(24, 17, 21, 10, '1800.00', '0.00', '0.00', '18000.00', 'a', 'Admin', '2019-08-19 20:50:24', NULL, NULL, 1),
(25, 16, 16, 10, '4500.00', '0.00', '0.00', '45000.00', 'a', NULL, NULL, 'Admin', '2019-08-19 20:56:46', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchasemaster`
--

DROP TABLE IF EXISTS `tbl_purchasemaster`;
CREATE TABLE IF NOT EXISTS `tbl_purchasemaster` (
  `PurchaseMaster_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Supplier_SlNo` int(11) NOT NULL,
  `Employee_SlNo` int(11) NOT NULL,
  `PurchaseMaster_InvoiceNo` varchar(50) NOT NULL,
  `PurchaseMaster_OrderDate` date NOT NULL,
  `PurchaseMaster_PurchaseFor` varchar(50) NOT NULL,
  `PurchaseMaster_Description` longtext NOT NULL,
  `PurchaseMaster_TotalAmount` decimal(18,2) NOT NULL,
  `PurchaseMaster_DiscountAmount` decimal(18,2) NOT NULL,
  `PurchaseMaster_Tax` decimal(18,2) NOT NULL,
  `PurchaseMaster_Freight` decimal(18,2) NOT NULL,
  `commission` decimal(10,2) NOT NULL,
  `PurchaseMaster_SubTotalAmount` decimal(18,2) NOT NULL,
  `PurchaseMaster_PaidAmount` decimal(18,2) NOT NULL,
  `PurchaseMaster_DueAmount` decimal(18,2) NOT NULL,
  `previous_due` float DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `PurchaseMaster_BranchID` int(11) NOT NULL,
  PRIMARY KEY (`PurchaseMaster_SlNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchasereturn`
--

DROP TABLE IF EXISTS `tbl_purchasereturn`;
CREATE TABLE IF NOT EXISTS `tbl_purchasereturn` (
  `PurchaseReturn_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `PurchaseMaster_InvoiceNo` varchar(50) NOT NULL,
  `Supplier_IDdNo` int(11) NOT NULL,
  `PurchaseReturn_ReturnDate` date NOT NULL,
  `PurchaseReturn_ReturnAmount` decimal(18,2) NOT NULL,
  `PurchaseReturn_Description` varchar(300) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `PurchaseReturn_brunchID` int(11) NOT NULL,
  PRIMARY KEY (`PurchaseReturn_SlNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchasereturndetails`
--

DROP TABLE IF EXISTS `tbl_purchasereturndetails`;
CREATE TABLE IF NOT EXISTS `tbl_purchasereturndetails` (
  `PurchaseReturnDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `PurchaseReturn_SlNo` int(11) NOT NULL,
  `PurchaseReturnDetailsProduct_SlNo` int(11) NOT NULL,
  `PurchaseReturnDetails_ReturnQuantity` int(11) NOT NULL,
  `PurchaseReturnDetails_ReturnAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `PurchaseReturnDetails_brachid` int(11) NOT NULL,
  PRIMARY KEY (`PurchaseReturnDetails_SlNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_quotaion_customer`
--

DROP TABLE IF EXISTS `tbl_quotaion_customer`;
CREATE TABLE IF NOT EXISTS `tbl_quotaion_customer` (
  `quotation_customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` char(50) NOT NULL,
  `contact_number` varchar(35) NOT NULL,
  `customer_address` text NOT NULL,
  `quation_customer_branchid` int(11) NOT NULL,
  PRIMARY KEY (`quotation_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_quotation_details`
--

DROP TABLE IF EXISTS `tbl_quotation_details`;
CREATE TABLE IF NOT EXISTS `tbl_quotation_details` (
  `SaleDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `SaleMaster_IDNo` int(11) NOT NULL,
  `Product_IDNo` int(11) NOT NULL,
  `SaleDetails_TotalQuantity` int(11) NOT NULL,
  `SaleDetails_Rate` decimal(18,2) NOT NULL,
  `SaleDetails_Discount` decimal(18,2) NOT NULL,
  `SaleDetails_Tax` decimal(18,2) NOT NULL,
  `SaleDetails_Freight` decimal(18,2) NOT NULL,
  `SaleDetails_TotalAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleDetails_BranchId` int(11) NOT NULL,
  PRIMARY KEY (`SaleDetails_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_quotation_details`
--

INSERT INTO `tbl_quotation_details` (`SaleDetails_SlNo`, `SaleMaster_IDNo`, `Product_IDNo`, `SaleDetails_TotalQuantity`, `SaleDetails_Rate`, `SaleDetails_Discount`, `SaleDetails_Tax`, `SaleDetails_Freight`, `SaleDetails_TotalAmount`, `Status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `SaleDetails_BranchId`) VALUES
(1, 1, 10, 10, '3500.00', '0.00', '0.00', '0.00', '35000.00', 'a', 'Admin', '2019-07-13 20:02:34', NULL, NULL, 1),
(2, 1, 4, 5, '2000.00', '0.00', '0.00', '0.00', '10000.00', 'a', 'Admin', '2019-07-13 20:02:34', NULL, NULL, 1),
(3, 1, 1, 10, '2000.00', '0.00', '0.00', '0.00', '20000.00', 'a', 'Admin', '2019-07-13 20:02:34', NULL, NULL, 1),
(4, 2, 4, 2, '2000.00', '0.00', '0.00', '0.00', '4000.00', 'a', 'Admin', '2020-07-13 21:31:28', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_quotation_master`
--

DROP TABLE IF EXISTS `tbl_quotation_master`;
CREATE TABLE IF NOT EXISTS `tbl_quotation_master` (
  `SaleMaster_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `SaleMaster_InvoiceNo` varchar(50) NOT NULL,
  `SaleMaster_customer_name` varchar(500) NOT NULL,
  `SaleMaster_customer_mobile` varchar(50) NOT NULL,
  `SaleMaster_customer_address` varchar(1000) NOT NULL,
  `SaleMaster_SaleDate` date NOT NULL,
  `SaleMaster_Description` longtext,
  `SaleMaster_TotalSaleAmount` decimal(18,2) NOT NULL,
  `SaleMaster_TotalDiscountAmount` decimal(18,2) NOT NULL,
  `SaleMaster_TaxAmount` decimal(18,2) NOT NULL,
  `SaleMaster_Freight` decimal(18,2) NOT NULL,
  `SaleMaster_SubTotalAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleMaster_branchid` int(11) NOT NULL,
  PRIMARY KEY (`SaleMaster_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_quotation_master`
--

INSERT INTO `tbl_quotation_master` (`SaleMaster_SlNo`, `SaleMaster_InvoiceNo`, `SaleMaster_customer_name`, `SaleMaster_customer_mobile`, `SaleMaster_customer_address`, `SaleMaster_SaleDate`, `SaleMaster_Description`, `SaleMaster_TotalSaleAmount`, `SaleMaster_TotalDiscountAmount`, `SaleMaster_TaxAmount`, `SaleMaster_Freight`, `SaleMaster_SubTotalAmount`, `Status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `SaleMaster_branchid`) VALUES
(1, 'Q-201900001', 'Company 101', '035465486', 'Mirpur, Dhaka', '2019-07-13', NULL, '65000.00', '0.00', '0.00', '0.00', '65000.00', 'a', 'Admin', '2019-07-13 20:02:34', NULL, NULL, 1),
(2, 'Q-202000001', 'Customer 2323', '654846518', 'Mirpur, Dhaka', '2019-07-13', NULL, '4000.00', '0.00', '0.00', '0.00', '4000.00', 'a', 'Admin', '2020-07-13 21:31:28', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_saledetails`
--

DROP TABLE IF EXISTS `tbl_saledetails`;
CREATE TABLE IF NOT EXISTS `tbl_saledetails` (
  `SaleDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `SaleMaster_IDNo` int(11) NOT NULL,
  `Product_IDNo` int(11) NOT NULL,
  `SaleDetails_TotalQuantity` float NOT NULL,
  `Purchase_Rate` decimal(18,2) DEFAULT NULL,
  `SaleDetails_Rate` decimal(18,2) NOT NULL,
  `SaleDetails_Discount` decimal(18,2) NOT NULL,
  `Discount_amount` decimal(18,2) DEFAULT NULL,
  `SaleDetails_Tax` decimal(18,2) NOT NULL,
  `SaleDetails_TotalAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleDetails_BranchId` int(11) NOT NULL,
  PRIMARY KEY (`SaleDetails_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_saledetails`
--

INSERT INTO `tbl_saledetails` (`SaleDetails_SlNo`, `SaleMaster_IDNo`, `Product_IDNo`, `SaleDetails_TotalQuantity`, `Purchase_Rate`, `SaleDetails_Rate`, `SaleDetails_Discount`, `Discount_amount`, `SaleDetails_Tax`, `SaleDetails_TotalAmount`, `Status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `SaleDetails_BranchId`) VALUES
(1, 1, 12, 1, '1800.00', '2200.00', '0.00', NULL, '0.00', '2200.00', 'a', 'Admin', '2019-07-11 17:03:18', NULL, NULL, 1),
(2, 1, 11, 1, '66.67', '200.00', '0.00', NULL, '0.00', '200.00', 'a', 'Admin', '2019-07-11 17:03:18', NULL, NULL, 1),
(3, 1, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-07-11 17:03:18', NULL, NULL, 1),
(4, 2, 14, 2, '2000.00', '3000.00', '0.00', NULL, '0.00', '6000.00', 'a', 'Admin', '2019-07-11 17:03:31', NULL, NULL, 1),
(5, 2, 11, 2, '66.67', '200.00', '0.00', NULL, '0.00', '400.00', 'a', 'Admin', '2019-07-11 17:03:31', NULL, NULL, 1),
(6, 3, 12, 5, '1800.00', '2200.00', '0.00', NULL, '0.00', '11000.00', 'a', 'Admin', '2019-07-11 17:05:35', NULL, NULL, 1),
(7, 4, 12, 1, '1800.00', '2200.00', '0.00', NULL, '0.00', '2200.00', 'd', 'Admin', '2019-07-11 17:06:23', NULL, NULL, 1),
(8, 4, 14, 1, '2000.00', '3000.00', '0.00', NULL, '0.00', '3000.00', 'd', 'Admin', '2019-07-11 17:06:23', NULL, NULL, 1),
(9, 4, 10, 5, '3000.00', '3500.00', '0.00', NULL, '0.00', '17500.00', 'd', 'Admin', '2019-07-11 17:06:23', NULL, NULL, 1),
(10, 5, 12, 1, '1800.00', '2200.00', '0.00', NULL, '0.00', '2200.00', 'a', 'Admin', '2019-07-11 20:33:26', NULL, NULL, 1),
(11, 6, 11, 2, '66.67', '200.00', '0.00', NULL, '20.00', '400.00', 'a', 'Admin', '2019-07-13 18:12:53', NULL, NULL, 1),
(12, 7, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2020-07-13 21:22:08', NULL, NULL, 1),
(13, 8, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2020-07-13 21:25:28', NULL, NULL, 1),
(14, 9, 13, 1, '7000.00', '8000.00', '0.00', NULL, '0.00', '8000.00', 'a', 'Admin', '2020-07-13 21:26:31', NULL, NULL, 1),
(15, 10, 10, 1, '3000.00', '3500.00', '0.00', NULL, '0.00', '3500.00', 'a', 'Admin', '2020-07-13 21:26:40', NULL, NULL, 1),
(16, 10, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2020-07-13 21:26:40', NULL, NULL, 1),
(17, 11, 7, 1, '2400.00', '3600.00', '0.00', NULL, '0.00', '3600.00', 'a', 'Admin', '2019-07-16 21:14:45', NULL, NULL, 1),
(18, 12, 5, 1, '1600.00', '2600.00', '0.00', NULL, '0.00', '2600.00', 'a', 'Admin', '2019-07-16 21:15:02', NULL, NULL, 1),
(19, 13, 15, 1, '4000.00', '5000.00', '0.00', NULL, '0.00', '5000.00', 'a', 'Admin', '2019-07-19 19:31:39', NULL, NULL, 1),
(20, 14, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-07-20 18:16:22', NULL, NULL, 1),
(21, 15, 4, 5, '1400.00', '2000.00', '0.00', NULL, '0.00', '10000.00', 'a', 'Admin', '2019-07-20 18:56:10', NULL, NULL, 1),
(22, 16, 13, 2, '7000.00', '8000.00', '0.00', NULL, '0.00', '16000.00', 'a', 'Admin', '2019-07-20 19:35:07', NULL, NULL, 1),
(23, 17, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-07-20 20:37:10', NULL, NULL, 1),
(24, 18, 7, 1, '2400.00', '3600.00', '0.00', NULL, '0.00', '3600.00', 'a', 'Admin', '2019-07-20 20:38:09', NULL, NULL, 1),
(25, 18, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-07-20 20:38:09', NULL, NULL, 1),
(26, 19, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-07-20 20:40:30', NULL, NULL, 1),
(27, 20, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-04 22:08:17', NULL, NULL, 2),
(28, 21, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-04 22:11:59', NULL, NULL, 3),
(29, 22, 4, 2, '1400.00', '2000.00', '0.00', NULL, '0.00', '4000.00', 'a', 'Admin', '2019-08-05 18:21:39', NULL, NULL, 1),
(30, 23, 7, 1, '2400.00', '3600.00', '0.00', NULL, '0.00', '3600.00', 'a', 'Admin', '2019-08-05 19:03:16', NULL, NULL, 1),
(31, 24, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-18 16:37:47', NULL, NULL, 1),
(32, 25, 4, 5, '1400.00', '2000.00', '0.00', NULL, '0.00', '10000.00', 'a', 'Admin', '2019-08-18 16:38:00', NULL, NULL, 1),
(33, 26, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-18 16:41:21', NULL, NULL, 1),
(34, 27, 4, 2, '1400.00', '2000.00', '0.00', NULL, '0.00', '4000.00', 'a', 'Admin', '2019-08-18 16:41:44', NULL, NULL, 1),
(35, 28, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-18 16:42:51', NULL, NULL, 1),
(36, 29, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-18 16:43:19', NULL, NULL, 1),
(37, 30, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-18 16:44:23', NULL, NULL, 1),
(38, 31, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-18 16:46:58', NULL, NULL, 1),
(40, 33, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-19 19:38:01', NULL, NULL, 1),
(41, 32, 4, 1, '1400.00', '2000.00', '0.00', NULL, '0.00', '2000.00', 'a', 'Admin', '2019-08-19 19:48:45', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_salereturn`
--

DROP TABLE IF EXISTS `tbl_salereturn`;
CREATE TABLE IF NOT EXISTS `tbl_salereturn` (
  `SaleReturn_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `SaleMaster_InvoiceNo` varchar(50) NOT NULL,
  `SaleReturn_ReturnDate` date NOT NULL,
  `SaleReturn_ReturnAmount` decimal(18,2) NOT NULL,
  `SaleReturn_Description` varchar(300) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleReturn_brunchId` int(11) NOT NULL,
  PRIMARY KEY (`SaleReturn_SlNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_salereturndetails`
--

DROP TABLE IF EXISTS `tbl_salereturndetails`;
CREATE TABLE IF NOT EXISTS `tbl_salereturndetails` (
  `SaleReturnDetails_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `SaleReturn_IdNo` int(11) NOT NULL,
  `SaleReturnDetailsProduct_SlNo` int(11) NOT NULL,
  `SaleReturnDetails_ReturnQuantity` int(11) NOT NULL,
  `SaleReturnDetails_ReturnAmount` decimal(18,2) NOT NULL,
  `Status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleReturnDetails_brunchID` int(11) NOT NULL,
  PRIMARY KEY (`SaleReturnDetails_SlNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_salesmaster`
--

DROP TABLE IF EXISTS `tbl_salesmaster`;
CREATE TABLE IF NOT EXISTS `tbl_salesmaster` (
  `SaleMaster_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `SaleMaster_InvoiceNo` varchar(50) NOT NULL,
  `SalseCustomer_IDNo` int(11) DEFAULT NULL,
  `employee_id` int(11) NULL,
  `SaleMaster_SaleDate` date NOT NULL,
  `SaleMaster_Description` longtext,
  `SaleMaster_SaleType` varchar(50) DEFAULT NULL,
  `payment_type` varchar(50) DEFAULT 'Cash',
  `SaleMaster_TotalSaleAmount` decimal(18,2) NOT NULL,
  `SaleMaster_TotalDiscountAmount` decimal(18,2) NOT NULL,
  `SaleMaster_TaxAmount` decimal(18,2) NOT NULL,
  `SaleMaster_Freight` decimal(18,2) DEFAULT '0.00',
  `SaleMaster_SubTotalAmount` decimal(18,2) NOT NULL,
  `SaleMaster_PaidAmount` decimal(18,2) NOT NULL,
  `SaleMaster_DueAmount` decimal(18,2) NOT NULL,
  `SaleMaster_Previous_Due` double(18,2) DEFAULT NULL,
  `Status` char(1) NOT NULL DEFAULT 'a',
  `is_service` varchar(10) NOT NULL DEFAULT 'false',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `SaleMaster_branchid` int(11) NOT NULL,
  PRIMARY KEY (`SaleMaster_SlNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `tbl_sms`
--

DROP TABLE IF EXISTS `tbl_sms`;
CREATE TABLE IF NOT EXISTS `tbl_sms` (
  `row_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(30) NOT NULL,
  `sms_text` varchar(500) NOT NULL,
  `sent_by` int(11) NOT NULL,
  `sent_datetime` datetime NOT NULL,
  PRIMARY KEY (`row_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_sms`
--

INSERT INTO `tbl_sms` (`row_id`, `number`, `sms_text`, `sent_by`, `sent_datetime`) VALUES
(1, '01708556674', 'Hello%20World%21', 1, '2019-08-19 10:08:50');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_supplier`
--

DROP TABLE IF EXISTS `tbl_supplier`;
CREATE TABLE IF NOT EXISTS `tbl_supplier` (
  `Supplier_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Supplier_Code` varchar(50) NOT NULL,
  `Supplier_Name` varchar(150) NOT NULL,
  `Supplier_Type` varchar(50) NOT NULL,
  `Supplier_Phone` varchar(50) NOT NULL,
  `Supplier_Mobile` varchar(15) NOT NULL,
  `Supplier_Email` varchar(50) NOT NULL,
  `Supplier_OfficePhone` varchar(50) NOT NULL,
  `Supplier_Address` varchar(300) NOT NULL,
  `contact_person` varchar(250) DEFAULT NULL,
  `District_SlNo` int(11) NOT NULL,
  `Country_SlNo` int(11) NOT NULL,
  `Supplier_Web` varchar(150) NOT NULL,
  `previous_due` decimal(18,2) NOT NULL,
  `image_name` varchar(1000) DEFAULT NULL,
  `Status` char(1) NOT NULL DEFAULT 'a',
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Supplier_brinchid` int(11) NOT NULL,
  PRIMARY KEY (`Supplier_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_supplier`
--

INSERT INTO `tbl_supplier` (`Supplier_SlNo`, `Supplier_Code`, `Supplier_Name`, `Supplier_Type`, `Supplier_Phone`, `Supplier_Mobile`, `Supplier_Email`, `Supplier_OfficePhone`, `Supplier_Address`, `contact_person`, `District_SlNo`, `Country_SlNo`, `Supplier_Web`, `previous_due`, `image_name`, `Status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`, `Supplier_brinchid`) VALUES
(1, 'S01', 'General Supplier', 'G', '', '-', '', '-', '-', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2018-09-05 06:11:05', NULL, NULL, 0),
(8, 'S02', 'CASSIE', 'local', '', '65465156', '.', '', '', '', 0, 0, 'undefined', '0.00', 'S02.jpg', 'a', 'Admin', '2019-03-06 12:32:53', 'Admin', '2019-07-20 17:35:37', 1),
(9, 'S09', 'SANDY', 'local', '', '01911978897	', '', '', '', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 12:33:28', 'Admin', '2019-07-20 16:34:55', 1),
(10, 'S010', 'JHON', 'undefined', '', '01911978897', '', '', '', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 12:33:53', 'Admin', '2019-03-13 06:01:30', 1),
(11, 'S11', 'MR YEA', 'local', '', '.', '', '', '', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 12:34:50', NULL, NULL, 1),
(12, 'S12', 'Mabud Trading', 'local', '', '031-633153', '', '', '1465/4, Cheman Building, Asadgonj, Chittagong.', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:28:27', NULL, NULL, 3),
(13, 'S13', 'Kamrul Trading', 'local', '', '01787-928135', '', '', '198-202, Nawabpur Road, Dhaka-1100', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:31:10', NULL, NULL, 3),
(14, 'S14', 'Afsar Enterprise', 'local', '', '01710-990347', '', '', '218, Nawabpur Road (Fazlul Rahman Plaza), Dhaka-1100', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:34:35', NULL, NULL, 3),
(15, 'S15', 'Jafree Traders', 'local', '', '01711-325119', '', '', '212, Jubilee Road, Chittagong.', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:36:01', NULL, NULL, 3),
(16, 'S16', 'Shuruchi', 'local', '', ' 01712-072425', '', '', '214, Jubilee Road, Chittagong.', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:38:21', NULL, NULL, 3),
(17, 'S17', 'Ken power tools.', 'local', '', '01730-330992', '', '', '198-202, Nawabpur Road, Dhaka-1100', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:40:00', NULL, NULL, 3),
(18, 'S18', 'Dongcheng power tools.', 'local', '', '01730-330992', '', '', '198-202, Nawabpur Road, Dhaka-1100', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:41:39', NULL, NULL, 3),
(19, 'S19', 'HW power tools', 'local', '', '01730-330992', '', '', '198-202, Nawabpur Road, Dhaka-1100', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:43:11', NULL, NULL, 3),
(20, 'S20', 'Kaiser Trade International', 'local', '', '01731-467662', '', '', '198-202, Nawabpur Road, Dhaka-1100', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:47:40', NULL, NULL, 3),
(21, 'S21', 'Hussain Traders', 'local', '', '01816-282397', '', '', 'Haji Yousuf Plaza, 345 Assadgonj, Chittagong.', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-03-06 04:49:19', NULL, NULL, 3),
(22, 'S22', 'Supplier 1, Supplier for test', 'undefined', '', '01708446685', 'supplier1@host.com', '', 'Mirpur, Dhaka', '', 0, 0, 'undefined', '0.00', NULL, 'a', 'Admin', '2019-05-12 04:01:05', 'Admin', '2019-06-14 08:44:52', 1),
(23, 'S23', 'Supplier 2', 'local', '', '01680548091', 'supplier2@host.com', '', 'Mirpur, Dhaka', '', 0, 0, 'undefined', '8000.00', NULL, 'a', 'Admin', '2019-05-26 10:43:18', NULL, NULL, 1),
(24, 'S00024', 'Test Supplier 3232', 'undefined', '', '01684685154', 'supplier3232@host.com', '', 'Mirpur', 'Mr. ZZZZ11', 0, 0, 'undefined', '0.00', 'S00024.png', 'a', 'Admin', '2019-06-22 09:38:12', 'Admin', '2019-07-19 23:02:04', 1),
(25, 'S00025', 'Supplier 55555', '', '', '01680549954', 'supplier 5555@host.com', '', 'Mirpur', 'Mr. BBB', 0, 0, '', '0.00', 'S00025.jpg', 'd', 'Admin', '2019-07-19 23:00:50', NULL, NULL, 1),
(26, 'S00026', 'asdfasdfsad', '', '', '6848456', '6848456', '', 'sdfsdfsdf', 'sdfsdfsdf', 0, 0, '', '0.00', NULL, 'a', 'Admin', '2019-07-20 17:21:52', NULL, NULL, 1),
(27, 'S00027', 'adsfas dfasf', '', '', '654651658', '', '', 'sdfsdfs', 'asdf sadfsa ', 0, 0, '', '0.00', NULL, 'a', 'Admin', '2019-07-20 17:22:15', NULL, NULL, 1),
(28, 'S00028', 'asdfasdfas', '', '', '2165456156', '', '', 'fasdfsadf', 'asdfsad', 0, 0, '', '0.00', NULL, 'a', 'Admin', '2019-07-20 17:23:51', NULL, NULL, 1),
(29, 'S00029', 'adfasd asdfsadf', '', '', '6516518165', '', '', 'adsf asdfas', 'as fsadfas', 0, 0, '', '0.00', NULL, 'a', 'Admin', '2019-07-20 17:24:26', NULL, NULL, 1),
(30, 'S00030', 'asdfas asdfasd', '', '', '9846586518', '', '', 'fasfasdf', 'fa sdfasd', 0, 0, '', '0.00', NULL, 'a', 'Admin', '2019-07-20 17:24:45', NULL, NULL, 1),
(31, 'S00031', 'adfasdf asdf', '', '', '216468468', '', '', 'dddd', 'adfasd asdf', 0, 0, '', '0.00', NULL, 'a', 'Admin', '2019-07-20 17:35:05', NULL, NULL, 1),
(32, 'S00032', 'General Supplier 3232', 'G', '', '016805498451', '', '', 'Dhaka', NULL, 0, 0, '', '0.00', NULL, 'a', 'Admin', '2019-08-19 20:49:58', 'Admin', '2019-08-19 20:56:46', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_supplier_payment`
--

DROP TABLE IF EXISTS `tbl_supplier_payment`;
CREATE TABLE IF NOT EXISTS `tbl_supplier_payment` (
  `SPayment_id` int(11) NOT NULL AUTO_INCREMENT,
  `SPayment_date` date DEFAULT NULL,
  `SPayment_invoice` varchar(20) DEFAULT NULL,
  `SPayment_customerID` varchar(20) DEFAULT NULL,
  `SPayment_TransactionType` varchar(25) DEFAULT NULL,
  `SPayment_amount` decimal(18,2) DEFAULT NULL,
  `SPayment_Paymentby` varchar(20) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `SPayment_notes` varchar(225) DEFAULT NULL,
  `SPayment_brunchid` int(11) DEFAULT NULL,
  `SPayment_status` varchar(2) DEFAULT NULL,
  `SPayment_Addby` varchar(100) DEFAULT NULL,
  `SPayment_AddDAte` date DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `SPayment_UpdateDAte` date DEFAULT NULL,
  PRIMARY KEY (`SPayment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_supplier_payment`
--

INSERT INTO `tbl_supplier_payment` (`SPayment_id`, `SPayment_date`, `SPayment_invoice`, `SPayment_customerID`, `SPayment_TransactionType`, `SPayment_amount`, `SPayment_Paymentby`, `account_id`, `SPayment_notes`, `SPayment_brunchid`, `SPayment_status`, `SPayment_Addby`, `SPayment_AddDAte`, `update_by`, `SPayment_UpdateDAte`) VALUES
(1, '2019-07-11', 'TR-001', '23', 'CP', '5000.00', 'By Cash', NULL, 'test', 1, 'd', 'Admin', '2019-07-11', NULL, NULL),
(2, '2019-07-11', 'TR-002', '23', 'CP', '100000.00', 'By Cash', NULL, 'test', 1, 'a', 'Admin', '2019-07-11', NULL, NULL),
(3, '2019-08-05', 'TR00003', '9', 'CP', '20000.00', NULL, NULL, 'test', 1, 'a', 'Admin', '2019-08-05', NULL, NULL),
(4, '2019-08-06', 'TR00004', '9', 'CP', '5000.00', NULL, NULL, 'test', 1, 'a', 'Admin', '2019-08-06', NULL, NULL),
(5, '2019-08-06', 'TR00005', '9', 'CP', '12000.00', NULL, NULL, 'test', 1, 'a', 'Admin', '2019-08-06', NULL, NULL),
(6, '2019-08-22', 'TR00006', '31', 'CP', '50000.00', 'bank', 1, '', 1, 'a', 'Admin', '2019-08-22', NULL, NULL),
(7, '2019-08-22', 'TR00007', '23', 'CP', '40000.00', 'bank', 1, '', 1, 'a', 'Admin', '2019-08-22', NULL, NULL),
(8, '2019-08-22', 'TR00008', '23', 'CP', '10000.00', 'cash', NULL, '', 1, 'a', 'Admin', '2019-08-22', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transferdetails`
--

DROP TABLE IF EXISTS `tbl_transferdetails`;
CREATE TABLE IF NOT EXISTS `tbl_transferdetails` (
  `transferdetails_id` int(11) NOT NULL AUTO_INCREMENT,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` float NOT NULL,
  PRIMARY KEY (`transferdetails_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_transferdetails`
--

INSERT INTO `tbl_transferdetails` (`transferdetails_id`, `transfer_id`, `product_id`, `quantity`) VALUES
(1, 1, 4, 5),
(2, 1, 12, 10);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transfermaster`
--

DROP TABLE IF EXISTS `tbl_transfermaster`;
CREATE TABLE IF NOT EXISTS `tbl_transfermaster` (
  `transfer_id` int(11) NOT NULL AUTO_INCREMENT,
  `transfer_date` date NOT NULL,
  `transfer_by` int(11) NOT NULL,
  `transfer_from` int(11) NOT NULL,
  `transfer_to` int(11) NOT NULL,
  `note` varchar(500) DEFAULT NULL,
  `added_by` int(11) NOT NULL,
  `added_datetime` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`transfer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_transfermaster`
--

INSERT INTO `tbl_transfermaster` (`transfer_id`, `transfer_date`, `transfer_by`, `transfer_from`, `transfer_to`, `note`, `added_by`, `added_datetime`, `updated_by`, `updated_datetime`) VALUES
(1, '2019-07-20', 1, 1, 2, '', 0, '0000-00-00 00:00:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_unit`
--

DROP TABLE IF EXISTS `tbl_unit`;
CREATE TABLE IF NOT EXISTS `tbl_unit` (
  `Unit_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `Unit_Name` varchar(150) NOT NULL,
  `status` char(1) NOT NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Unit_SlNo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_unit`
--

INSERT INTO `tbl_unit` (`Unit_SlNo`, `Unit_Name`, `status`, `AddBy`, `AddTime`, `UpdateBy`, `UpdateTime`) VALUES
(1, 'PCS', 'a', 'Admin', '2019-03-06 12:11:15', 'Admin', '2019-05-12 06:53:41');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE IF NOT EXISTS `tbl_user` (
  `User_SlNo` int(11) NOT NULL AUTO_INCREMENT,
  `User_ID` varchar(50) NOT NULL,
  `FullName` varchar(150) NOT NULL,
  `User_Name` varchar(150) NOT NULL,
  `UserEmail` varchar(200) NOT NULL,
  `userBrunch_id` int(11) NOT NULL,
  `User_Password` varchar(50) NOT NULL,
  `UserType` varchar(50) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'a',
  `verifycode` int(11) NOT NULL,
  `image_name` varchar(1000) NULL,
  `AddBy` varchar(50) DEFAULT NULL,
  `AddTime` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `Brunch_ID` int(11) NOT NULL,
  PRIMARY KEY (`User_SlNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_access`
--

DROP TABLE IF EXISTS `tbl_user_access`;
CREATE TABLE IF NOT EXISTS `tbl_user_access` (
  `access_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `access` text NOT NULL,
  `saved_by` int(11) NOT NULL,
  `saved_datetime` timestamp NOT NULL,
  PRIMARY KEY (`access_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_user_access`
--

INSERT INTO `tbl_user_access` (`access_id`, `user_id`, `access`, `saved_by`, `saved_datetime`) VALUES
(1, 2, '[\"sales\\/product\",\"sales\\/service\",\"salesReturn\",\"customer\",\"customerPaymentPage\",\"currentStock\",\"quotation\"]', 1, '2019-07-16 16:13:11');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sms_settings`
--

DROP TABLE IF EXISTS `tbl_sms_settings`;
CREATE TABLE IF NOT EXISTS `tbl_sms_settings` (
  `sms_enabled` varchar(10) NOT NULL DEFAULT 'false',
  `api_key` varchar(500) NOT NULL,
  `url` varchar(1000) NOT NULL,
  `bulk_url` varchar(1000) NOT NULL,
  `sms_type` varchar(50) NOT NULL,
  `sender_id` varchar(200) NOT NULL,
  `sender_name` varchar(200) NOT NULL,
  `sender_phone` varchar(50) NOT NULL,
  `saved_by` int(11) DEFAULT NULL,
  `saved_datetime` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
