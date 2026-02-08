-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 07, 2026 at 01:16 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_lifeband_website`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_accounts`
--

CREATE TABLE `tbl_accounts` (
  `acc_id` int(11) NOT NULL,
  `acc_name` varchar(500) NOT NULL,
  `acc_email` varchar(255) NOT NULL,
  `acc_password` varchar(60) NOT NULL,
  `acc_region` enum('Asia','Europe','North America','South America','Oceania') NOT NULL,
  `acc_birthdate` date NOT NULL,
  `acc_role` enum('Patient','Caregiver/Family Member','Admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_accounts`
--

INSERT INTO `tbl_accounts` (`acc_id`, `acc_name`, `acc_email`, `acc_password`, `acc_region`, `acc_birthdate`, `acc_role`) VALUES
(3, 'Lawrence Cabonce', 'caboncel256@gmail.com', '$2y$10$h.01GlCAQAlTO0kvX7FR6uqf35b4IECs8Es03KGuAQBP899cwTop.', 'Asia', '2026-01-28', 'Admin'),
(7, 'testemail', 'testing@gmail.com', '$2y$10$ERs3fy2fGLrxd3zj2B8kvu785RCaFQwxGhXFC/J0I57S/aMExt0Tm', 'Asia', '2026-02-05', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_chat_messages`
--

CREATE TABLE `tbl_chat_messages` (
  `msg_id` int(11) NOT NULL,
  `acc_id` int(11) NOT NULL,
  `msg_text` text NOT NULL,
  `msg_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_admin_reply` tinyint(1) DEFAULT 0,
  `sender_name` varchar(255) NOT NULL,
  `admin_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_contact_messages`
--

CREATE TABLE `tbl_contact_messages` (
  `cm_id` int(11) NOT NULL,
  `cm_name` varchar(255) NOT NULL,
  `cm_email` varchar(255) NOT NULL,
  `cm_phone` int(11) NOT NULL,
  `cm_subject` varchar(255) NOT NULL,
  `cm_message` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_feedback`
--

CREATE TABLE `tbl_feedback` (
  `fback_id` int(11) NOT NULL,
  `fback_rating` int(11) NOT NULL,
  `fback_content` varchar(500) NOT NULL,
  `fback_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_feedback`
--

INSERT INTO `tbl_feedback` (`fback_id`, `fback_rating`, `fback_content`, `fback_name`) VALUES
(1, 5, 'testtt', 'aa');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_past_system_updates`
--

CREATE TABLE `tbl_past_system_updates` (
  `past_id` int(11) NOT NULL,
  `past_title` varchar(255) NOT NULL,
  `past_date` date NOT NULL,
  `past_details` text NOT NULL,
  `past_status` varchar(50) NOT NULL,
  `system_id` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_past_system_updates`
--

INSERT INTO `tbl_past_system_updates` (`past_id`, `past_title`, `past_date`, `past_details`, `past_status`, `system_id`, `updated_at`) VALUES
(5, 'sana gumana', '2026-02-06', 'weh', 'working', 6, '2026-02-06 12:57:56'),
(6, 'e nagana', '2026-02-06', 'eee', 'down', 6, '2026-02-06 12:58:18');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_system_alerts`
--

CREATE TABLE `tbl_system_alerts` (
  `alerts_id` int(11) NOT NULL,
  `alerts_title` varchar(60) NOT NULL,
  `alerts_detail` varchar(500) NOT NULL,
  `alerts_severity` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_system_alerts`
--

INSERT INTO `tbl_system_alerts` (`alerts_id`, `alerts_title`, `alerts_detail`, `alerts_severity`) VALUES
(6, 'admiintesting', 'test', 'low'),
(7, 'testing', '123', 'high');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_system_status`
--

CREATE TABLE `tbl_system_status` (
  `status_id` int(11) NOT NULL,
  `system_title` varchar(255) DEFAULT NULL,
  `system_description` text DEFAULT NULL,
  `system_status` varchar(50) DEFAULT NULL,
  `status_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_system_status`
--

INSERT INTO `tbl_system_status` (`status_id`, `system_title`, `system_description`, `system_status`, `status_date`) VALUES
(6, 'e nagana', 'eee', 'down', '2026-02-06');

--
-- Triggers `tbl_system_status`
--
DELIMITER $$
CREATE TRIGGER `trg_archive_system_status_update` AFTER UPDATE ON `tbl_system_status` FOR EACH ROW BEGIN
    INSERT INTO `tbl_past_system_updates` (
        `past_title`,
        `past_date`,
        `past_details`,
        `past_status`,
        `system_id`
    ) VALUES (
        NEW.`system_title`,
        NEW.`status_date`,
        NEW.`system_description`,
        NEW.`system_status`,
        NEW.`status_id`
    );
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_accounts`
--
ALTER TABLE `tbl_accounts`
  ADD PRIMARY KEY (`acc_id`);

--
-- Indexes for table `tbl_chat_messages`
--
ALTER TABLE `tbl_chat_messages`
  ADD PRIMARY KEY (`msg_id`),
  ADD KEY `acc_id` (`acc_id`),
  ADD KEY `msg_date` (`msg_date`),
  ADD KEY `is_admin_reply` (`is_admin_reply`);

--
-- Indexes for table `tbl_contact_messages`
--
ALTER TABLE `tbl_contact_messages`
  ADD PRIMARY KEY (`cm_id`);

--
-- Indexes for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  ADD PRIMARY KEY (`fback_id`);

--
-- Indexes for table `tbl_past_system_updates`
--
ALTER TABLE `tbl_past_system_updates`
  ADD PRIMARY KEY (`past_id`),
  ADD KEY `system_id` (`system_id`),
  ADD KEY `past_date` (`past_date`);

--
-- Indexes for table `tbl_system_alerts`
--
ALTER TABLE `tbl_system_alerts`
  ADD PRIMARY KEY (`alerts_id`);

--
-- Indexes for table `tbl_system_status`
--
ALTER TABLE `tbl_system_status`
  ADD PRIMARY KEY (`status_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_accounts`
--
ALTER TABLE `tbl_accounts`
  MODIFY `acc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_chat_messages`
--
ALTER TABLE `tbl_chat_messages`
  MODIFY `msg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_contact_messages`
--
ALTER TABLE `tbl_contact_messages`
  MODIFY `cm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  MODIFY `fback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_past_system_updates`
--
ALTER TABLE `tbl_past_system_updates`
  MODIFY `past_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_system_alerts`
--
ALTER TABLE `tbl_system_alerts`
  MODIFY `alerts_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_system_status`
--
ALTER TABLE `tbl_system_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
