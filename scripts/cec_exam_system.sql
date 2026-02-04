-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2026 at 04:14 PM
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
-- Database: `cec_exam_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrators`
--

CREATE TABLE `administrators` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('super_admin','admin') DEFAULT 'admin',
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administrators`
--

INSERT INTO `administrators` (`id`, `name`, `email`, `password_hash`, `role`, `status`, `created_at`, `updated_at`) VALUES
(1, 'System Administrator', 'admin@itproctool.edu', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'super_admin', 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(2, 'IT Admin', 'it.admin@itproctool.edu', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10');

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `form_url` text NOT NULL,
  `duration_minutes` int(11) DEFAULT 60,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `teacher_id` int(11) NOT NULL,
  `unique_id` varchar(20) NOT NULL,
  `status` enum('draft','active','completed','cancelled') DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exams`
--

INSERT INTO `exams` (`id`, `title`, `description`, `form_url`, `duration_minutes`, `start_time`, `end_time`, `teacher_id`, `unique_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Database Systems Midterm', 'Midterm examination covering database design and SQL', 'https://forms.google.com/sample1', 120, NULL, NULL, 1, 'EXAM001', 'completed', '2025-09-25 03:28:10', '2025-09-25 03:31:20'),
(2, 'Programming Fundamentals Quiz', 'Weekly quiz on programming concepts', 'https://forms.google.com/sample2', 60, NULL, NULL, 2, 'EXAM002', 'draft', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(3, 'Data Structures Final', 'Final examination on data structures and algorithms', 'https://forms.google.com/sample3', 180, NULL, NULL, 3, 'EXAM003', 'completed', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(4, 'survey', 'asd', 'https://docs.google.com/forms/d/e/1FAIpQLSfheAWc2_SwzseI0X0T6CQIzeDkQdwJwN4OsM9031-3DINoPA/viewform?usp=dialog', 60, '2025-09-25 16:31:00', '2025-09-26 09:36:00', 1, 'SURV065932', 'active', '2025-09-25 03:31:05', '2025-09-25 06:46:00');

-- --------------------------------------------------------

--
-- Table structure for table `exam_sessions`
--

CREATE TABLE `exam_sessions` (
  `id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `session_token` varchar(255) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_time` timestamp NULL DEFAULT NULL,
  `status` enum('active','completed','terminated') DEFAULT 'active',
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exam_sessions`
--

INSERT INTO `exam_sessions` (`id`, `exam_id`, `student_id`, `session_token`, `start_time`, `end_time`, `status`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 4, 1, '4-1-1769009890583', '2026-01-21 15:38:10', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-21 15:38:10'),
(2, 4, 1, '4-1-1769414483144', '2026-01-26 08:01:23', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-26 08:01:23'),
(3, 4, 1, '4-1-1769414818165', '2026-01-26 08:06:58', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-26 08:06:58'),
(4, 4, 1, '4-1-1769415007106', '2026-01-26 08:10:07', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-26 08:10:07'),
(5, 4, 1, '4-1-1769415435153', '2026-01-26 08:17:15', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-26 08:17:15'),
(6, 4, 1, '4-1-1769415555491', '2026-01-26 08:19:15', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-26 08:19:15'),
(7, 4, 1, '4-1-1769415648393', '2026-01-26 08:20:48', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-26 08:20:48'),
(8, 4, 1, '4-1-1769415657114', '2026-01-26 08:20:57', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-26 08:20:57'),
(9, 4, 1, '4-1-1769415766818', '2026-01-26 08:22:46', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-26 08:22:46'),
(10, 4, 1, '4-1-1769526426957', '2026-01-27 15:07:07', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-01-27 15:07:07'),
(11, 4, 1, '4-1-1769527512194', '2026-01-27 15:25:12', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-01-27 15:25:12'),
(12, 4, 1, '4-1-1769527697328', '2026-01-27 15:28:18', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-01-27 15:28:18'),
(13, 4, 1, '4-1-1769527862175', '2026-01-27 15:31:02', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-01-27 15:31:02'),
(14, 4, 1, '4-1-1769527906565', '2026-01-27 15:31:46', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-01-27 15:31:46'),
(15, 4, 1, '4-1-1769528879527', '2026-01-27 15:48:00', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-01-27 15:48:00'),
(16, 4, 1, '4-1-1769529398660', '2026-01-27 15:56:43', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-01-27 15:56:43'),
(17, 4, 1, '4-1-1769530920821', '2026-01-27 16:22:01', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-01-27 16:22:01'),
(18, 4, 1, '4-1-1769944807228', '2026-02-01 11:20:07', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 11:20:07'),
(19, 4, 1, '4-1-1769944866194', '2026-02-01 11:21:06', '2026-02-01 11:21:27', 'terminated', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 11:21:06'),
(20, 4, 1, '4-1-1769946317189', '2026-02-01 11:45:18', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 11:45:18'),
(21, 4, 1, '4-1-1769947061919', '2026-02-01 11:57:42', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 11:57:42'),
(22, 4, 1, '4-1-1769947532320', '2026-02-01 12:05:32', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 12:05:32'),
(23, 4, 1, '4-1-1769947559633', '2026-02-01 12:05:59', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 12:05:59'),
(24, 4, 1, '4-1-1769947623406', '2026-02-01 12:07:04', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 12:07:04'),
(25, 4, 1, '4-1-1769947884082', '2026-02-01 12:11:25', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 12:11:25'),
(26, 4, 1, '4-1-1769948526079', '2026-02-01 12:22:06', NULL, 'active', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 12:22:06');

-- --------------------------------------------------------

--
-- Table structure for table `proctoring_settings`
--

CREATE TABLE `proctoring_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proctoring_settings`
--

INSERT INTO `proctoring_settings` (`id`, `setting_key`, `setting_value`, `description`, `updated_by`, `updated_at`) VALUES
(1, 'violation_threshold', '5', 'Maximum violations before automatic termination', NULL, '2026-02-01 11:25:37'),
(2, 'tab_switch_enabled', 'true', 'Enable tab switching detection', NULL, '2025-09-25 03:28:10'),
(3, 'right_click_disabled', 'true', 'Disable right-click during exams', NULL, '2025-09-25 03:28:10'),
(4, 'copy_paste_disabled', 'true', 'Disable copy-paste during exams', NULL, '2025-09-25 03:28:10'),
(5, 'fullscreen_required', 'true', 'Require fullscreen mode during exams', NULL, '2025-09-25 03:28:10');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `year_level` int(11) DEFAULT NULL,
  `teacher_id` int(11) NOT NULL,
  `status` enum('active','inactive','graduated') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `name`, `student_id`, `email`, `department`, `year_level`, `teacher_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Alice Johnson', 'STU001', 'alice.johnson@student.cec.edu', 'Computer Science', 3, 1, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(2, 'Bob Wilson', 'STU002', 'bob.wilson@student.cec.edu', 'Information Technology', 2, 2, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(3, 'Carol Davis', 'STU003', 'carol.davis@student.cec.edu', 'Computer Science', 4, 1, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(4, 'David Brown', 'STU004', 'david.brown@student.cec.edu', 'Information Technology', 1, 3, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(5, 'Eva Martinez', 'STU005', 'eva.martinez@student.cec.edu', 'Computer Science', 3, 1, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(6, 'Frank Taylor', 'STU006', 'frank.taylor@student.cec.edu', 'Computer Engineering', 2, 2, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(7, 'Grace Lee', 'STU007', 'grace.lee@student.cec.edu', 'Software Engineering', 4, 3, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(8, 'Henry Chen', 'STU008', 'henry.chen@student.cec.edu', 'Information Technology', 3, 1, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(9, 'Ivy Rodriguez', 'STU009', 'ivy.rodriguez@student.cec.edu', 'Computer Science', 1, 2, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(10, 'Jack Thompson', 'STU010', 'jack.thompson@student.cec.edu', 'Computer Engineering', 2, 3, 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10');

-- --------------------------------------------------------

--
-- Table structure for table `system_logs`
--

CREATE TABLE `system_logs` (
  `id` int(11) NOT NULL,
  `user_type` enum('admin','teacher','student') NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_logs`
--

INSERT INTO `system_logs` (`id`, `user_type`, `user_id`, `action`, `description`, `ip_address`, `user_agent`, `timestamp`) VALUES
(1, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2025-09-25 03:29:21'),
(2, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2025-09-25 03:29:37'),
(3, 'admin', 1, 'login', 'Admin login: admin@itproctool.edu', '::1', NULL, '2025-09-25 03:41:10'),
(4, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2025-09-25 03:45:06'),
(5, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2025-09-25 06:18:32'),
(6, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2025-09-25 06:43:56'),
(7, 'admin', 1, 'login', 'Admin login: admin@itproctool.edu', '::1', NULL, '2025-09-25 06:48:22'),
(8, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 13:53:31'),
(9, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 13:54:13'),
(10, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 13:59:00'),
(11, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 14:00:23'),
(12, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 14:00:37'),
(13, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 14:02:04'),
(14, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 14:03:37'),
(15, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 14:04:01'),
(16, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 14:04:11'),
(17, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 14:32:54'),
(18, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 14:36:14'),
(19, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 14:38:27'),
(20, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 14:48:08'),
(21, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 14:48:35'),
(22, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 15:03:55'),
(23, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 15:04:17'),
(24, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 15:05:24'),
(25, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 15:10:56'),
(26, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 15:24:49'),
(27, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 15:25:19'),
(28, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-21 15:37:29'),
(29, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-21 15:38:02'),
(30, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-26 08:00:43'),
(31, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-26 08:01:15'),
(32, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-27 15:06:43'),
(33, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-27 15:06:59'),
(34, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-27 15:21:30'),
(35, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-27 15:25:07'),
(36, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-27 15:28:02'),
(37, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-27 15:44:18'),
(38, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-27 15:47:14'),
(39, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-27 15:47:55'),
(40, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-27 15:51:25'),
(41, 'teacher', 1, 'login', 'Teacher login: teacher@cec.edu', '::1', NULL, '2026-01-27 15:57:35'),
(42, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-01-27 16:21:50'),
(43, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-02-01 11:19:58'),
(44, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-02-01 11:21:01'),
(45, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-02-01 11:44:32'),
(46, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-02-01 11:57:32'),
(47, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-02-01 12:05:52'),
(48, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-02-01 12:06:55'),
(49, 'student', 1, 'login', 'Student login: STU001', '::1', NULL, '2026-02-01 12:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `department` varchar(255) DEFAULT NULL,
  `employee_id` varchar(50) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `name`, `email`, `password_hash`, `department`, `employee_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Dr. John Smith', 'teacher@cec.edu', 'teacher123', 'Computer Science', 'EMP001', 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(2, 'Prof. Sarah Johnson', 'sarah.johnson@cec.edu', 'password123', 'Information Technology', 'EMP002', 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(3, 'Dr. Michael Brown', 'michael.brown@cec.edu', 'password123', 'Computer Engineering', 'EMP003', 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(4, 'Prof. Lisa Davis', 'lisa.davis@cec.edu', 'password123', 'Software Engineering', 'EMP004', 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10'),
(5, 'Dr. Robert Wilson', 'robert.wilson@cec.edu', 'password123', 'Computer Science', 'EMP005', 'active', '2025-09-25 03:28:10', '2025-09-25 03:28:10');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','teacher','staff','admin') NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `name`, `created_at`) VALUES
(1, 'student1', '$2y$10$XspEZoJnCf1RYMio1Ygg2uB23Nja4mrSfRgX9QjDND.CbrZuQFEcG', 'student', 'John Student', '2025-10-29 14:58:36'),
(2, 'teacher1', '$2y$10$HOetT4dGQm0soesPyoXM1.yJmjx1So28NJsOwzxXB0ktyDRXQQH0K', 'teacher', 'Ms. Teacher', '2025-10-29 14:58:36'),
(3, 'staff1', '$2y$10$zkjWQKu8PVzaKJKuKA01u.nYvU.EeSV6PlW6jWpCENsOqUK8xXl0C', 'staff', 'Staff Member', '2025-10-29 14:58:36'),
(4, 's2', '$2y$10$JKH22Eu3uTd8boUyVlUpmOgbXSRzgbGwO047xGewX9gVh26JUwFta', 'student', '12', '2025-10-29 15:00:18'),
(5, 'admin1', '$2y$10$HOetT4dGQm0soesPyoXM1.yJmjx1So28NJsOwzxXB0ktyDRXQQH0K', 'admin', 'Admin User', '2025-10-29 17:55:43');

-- --------------------------------------------------------

--
-- Table structure for table `violations`
--

CREATE TABLE `violations` (
  `id` int(11) NOT NULL,
  `exam_session_id` int(11) DEFAULT NULL,
  `student_name` varchar(255) NOT NULL,
  `exam_title` varchar(255) NOT NULL,
  `violation_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `severity` enum('low','medium','high') DEFAULT 'medium',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `violations`
--

INSERT INTO `violations` (`id`, `exam_session_id`, `student_name`, `exam_title`, `violation_type`, `description`, `severity`, `timestamp`, `metadata`) VALUES
(112, 1, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-01-21 07:38:13', NULL),
(113, 1, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-01-21 07:38:26', NULL),
(114, 1, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-01-21 07:38:40', NULL),
(115, 1, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-01-21 07:40:23', NULL),
(116, 1, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-21 07:40:43', NULL),
(117, 1, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-21 07:40:43', NULL),
(118, 1, 'Alice Johnson', 'Unknown Exam', 'COPY_ATTEMPT', 'Student attempted to copy content', 'medium', '2026-01-21 07:40:55', NULL),
(119, 2, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-01-26 00:01:25', NULL),
(120, 2, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-01-26 00:01:38', NULL),
(121, 3, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-01-26 00:06:59', NULL),
(122, 3, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-01-26 00:07:27', NULL),
(123, 3, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-01-26 00:07:39', NULL),
(124, 3, 'Alice Johnson', 'Unknown Exam', 'TAB_SWITCH', 'Student switched tabs or minimized window', 'medium', '2026-01-26 00:08:28', NULL),
(125, 3, 'Alice Johnson', 'survey', 'TAB_SWITCH', 'Student switched tabs, minimized window, or switched applications', 'medium', '2026-01-26 00:08:43', NULL),
(126, 3, 'Alice Johnson', 'survey', 'TAB_SWITCH', 'Student switched tabs, minimized window, or switched applications', 'medium', '2026-01-26 00:08:55', NULL),
(127, 4, 'Alice Johnson', 'Unknown Exam', 'TAB_SWITCH', 'Student switched tabs, minimized window, or switched applications', 'medium', '2026-01-26 00:10:14', NULL),
(128, 4, 'Alice Johnson', 'Unknown Exam', 'TAB_SWITCH', 'Student switched tabs, minimized window, or switched applications', 'medium', '2026-01-26 00:10:21', NULL),
(129, 4, 'Alice Johnson', 'Unknown Exam', 'TAB_SWITCH', 'Student switched tabs, minimized window, or switched applications', 'medium', '2026-01-26 00:10:23', NULL),
(130, 4, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-26 00:11:30', NULL),
(131, 4, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-26 00:11:30', NULL),
(132, 4, 'Alice Johnson', 'Unknown Exam', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-01-26 00:11:34', NULL),
(133, 9, 'Alice Johnson', 'Unknown Exam', 'TAB_SWITCH', 'Student switched tabs, minimized window, or switched applications', 'medium', '2026-01-26 00:22:58', NULL),
(134, 9, 'Alice Johnson', 'Unknown Exam', 'TAB_SWITCH', 'Student switched tabs, minimized window, or switched applications', 'medium', '2026-01-26 00:23:11', NULL),
(135, 9, 'Alice Johnson', 'Unknown Exam', 'TAB_SWITCH', 'Student switched tabs, minimized window, or switched applications', 'medium', '2026-01-26 00:25:32', NULL),
(136, 10, 'Alice Johnson', 'Unknown Exam', 'COPY_ATTEMPT', 'Student attempted to copy content', 'medium', '2026-01-27 07:07:31', NULL),
(137, 10, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:08:33', NULL),
(138, 10, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:08:34', NULL),
(139, 10, 'Alice Johnson', 'Unknown Exam', 'PASTE_ATTEMPT', 'Student attempted to paste content', 'medium', '2026-01-27 07:09:35', NULL),
(140, 12, 'Alice Johnson', 'survey', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-01-27 07:28:30', NULL),
(141, 12, 'Alice Johnson', 'survey', 'TAB_SWITCH', 'Student switched tabs, minimized window, or switched applications', 'medium', '2026-01-27 07:28:32', NULL),
(142, 13, 'Alice Johnson', 'survey', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-01-27 07:31:04', NULL),
(143, 14, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:31:51', NULL),
(144, 14, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:31:51', NULL),
(145, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click on exam content', 'medium', '2026-01-27 07:47:22', NULL),
(146, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:22', NULL),
(147, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:23', NULL),
(148, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click on exam content', 'medium', '2026-01-27 07:47:23', NULL),
(149, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:24', NULL),
(150, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click on exam content', 'medium', '2026-01-27 07:47:24', NULL),
(151, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:25', NULL),
(152, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click on exam content', 'medium', '2026-01-27 07:47:25', NULL),
(153, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:30', NULL),
(154, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:31', NULL),
(155, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:31', NULL),
(156, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:32', NULL),
(157, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:32', NULL),
(158, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:32', NULL),
(159, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:32', NULL),
(160, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:32', NULL),
(161, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:47:34', NULL),
(162, 14, 'Alice Johnson', 'survey', 'RIGHT_CLICK', 'Student attempted to right-click on exam content', 'medium', '2026-01-27 07:47:34', NULL),
(163, 14, 'Alice Johnson', 'survey', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-01-27 07:47:35', NULL),
(164, 15, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:48:08', NULL),
(165, 15, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-01-27 07:48:08', NULL),
(166, 17, 'Alice Johnson', 'Unknown Exam', 'COPY_ATTEMPT', 'Student attempted to copy content', 'medium', '2026-01-27 08:22:09', NULL),
(167, 17, 'Alice Johnson', 'Unknown Exam', 'PASTE_ATTEMPT', 'Student attempted to paste content', 'medium', '2026-01-27 08:22:19', NULL),
(168, 17, 'Alice Johnson', 'Unknown Exam', 'PASTE_ATTEMPT', 'Student attempted to paste content', 'medium', '2026-01-27 08:22:21', NULL),
(169, 18, 'Alice Johnson', 'Unknown Exam', 'COPY_ATTEMPT', 'Student attempted to copy content', 'medium', '2026-02-01 03:20:12', '{\"ip_address\":\"::1\",\"user_agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36\",\"logged_at\":\"2026-02-01T11:20:12.871Z\"}'),
(170, 19, 'Alice Johnson', 'Unknown Exam', 'COPY_ATTEMPT', 'Student attempted to copy content', 'medium', '2026-02-01 03:21:08', '{\"ip_address\":\"::1\",\"user_agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36\",\"logged_at\":\"2026-02-01T11:21:08.436Z\"}'),
(171, 19, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-02-01 03:21:26', '{\"ip_address\":\"::1\",\"user_agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36\",\"logged_at\":\"2026-02-01T11:21:26.877Z\"}'),
(172, 19, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-02-01 03:21:26', '{\"ip_address\":\"::1\",\"user_agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36\",\"logged_at\":\"2026-02-01T11:21:26.970Z\"}'),
(173, 19, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-02-01 03:21:26', '{\"ip_address\":\"::1\",\"user_agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36\",\"logged_at\":\"2026-02-01T11:21:27.011Z\"}'),
(174, 19, 'Alice Johnson', 'Unknown Exam', 'RIGHT_CLICK', 'Student attempted to right-click', 'medium', '2026-02-01 03:21:26', '{\"ip_address\":\"::1\",\"user_agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36\",\"logged_at\":\"2026-02-01T11:21:27.047Z\"}'),
(175, 20, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:45:20', NULL),
(176, 20, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:45:33', NULL),
(177, 20, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:45:44', NULL),
(178, 20, 'Alice Johnson', 'Unknown Exam', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-02-01 03:45:45', NULL),
(179, 20, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:49:19', NULL),
(180, 20, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:49:50', NULL),
(181, 20, 'Alice Johnson', 'Unknown Exam', 'INACTIVITY', 'Student inactive for more than 5 minutes', 'medium', '2026-02-01 03:50:47', NULL),
(182, 20, 'Alice Johnson', 'Unknown Exam', 'INACTIVITY', 'Student inactive for more than 5 minutes', 'medium', '2026-02-01 03:51:47', NULL),
(183, 20, 'Alice Johnson', 'Unknown Exam', 'INACTIVITY', 'Student inactive for more than 5 minutes', 'medium', '2026-02-01 03:52:59', NULL),
(184, 20, 'Alice Johnson', 'Unknown Exam', 'INACTIVITY', 'Student inactive for more than 5 minutes', 'medium', '2026-02-01 03:53:59', NULL),
(185, 20, 'Alice Johnson', 'Unknown Exam', 'INACTIVITY', 'Student inactive for more than 5 minutes', 'medium', '2026-02-01 03:54:59', NULL),
(186, 20, 'Alice Johnson', 'Unknown Exam', 'INACTIVITY', 'Student inactive for more than 5 minutes', 'medium', '2026-02-01 03:55:59', NULL),
(187, 20, 'Alice Johnson', 'survey', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:57:06', NULL),
(188, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:57:45', NULL),
(189, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:57:57', NULL),
(190, 21, 'Alice Johnson', 'Unknown Exam', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-02-01 03:58:03', NULL),
(191, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:58:25', NULL),
(192, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:58:37', NULL),
(193, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:58:49', NULL),
(194, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 03:59:48', NULL),
(195, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:00:29', NULL),
(196, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:01:16', NULL),
(197, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:01:29', NULL),
(198, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:01:58', NULL),
(199, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:02:12', NULL),
(200, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:02:29', NULL),
(201, 21, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:02:43', NULL),
(202, 22, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:05:34', NULL),
(203, 22, 'Alice Johnson', 'Unknown Exam', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-02-01 04:05:44', NULL),
(204, 22, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:05:46', NULL),
(205, 23, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:06:02', NULL),
(206, 23, 'Alice Johnson', 'Unknown Exam', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-02-01 04:06:03', NULL),
(207, 24, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:07:06', NULL),
(208, 24, 'Alice Johnson', 'Unknown Exam', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-02-01 04:07:11', NULL),
(209, 24, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:11:06', NULL),
(210, 24, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:11:18', NULL),
(211, 25, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:11:27', NULL),
(212, 25, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:11:45', NULL),
(213, 25, 'Alice Johnson', 'Unknown Exam', 'COPY_ATTEMPT', 'Student attempted to copy content', 'medium', '2026-02-01 04:11:58', NULL),
(214, 26, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:22:15', NULL),
(215, 26, 'Alice Johnson', 'Unknown Exam', 'FULLSCREEN_EXIT', 'Student exited fullscreen mode during exam', 'medium', '2026-02-01 04:22:25', NULL),
(216, 26, 'Alice Johnson', 'Unknown Exam', 'WINDOW_SWITCH', 'Student switched to another application or window', 'medium', '2026-02-01 04:22:26', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrators`
--
ALTER TABLE `administrators`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_id` (`unique_id`),
  ADD KEY `idx_exams_unique_id` (`unique_id`),
  ADD KEY `idx_exams_teacher_id` (`teacher_id`);

--
-- Indexes for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `idx_exam_sessions_exam_id` (`exam_id`);

--
-- Indexes for table `proctoring_settings`
--
ALTER TABLE `proctoring_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_id` (`student_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_students_student_id` (`student_id`),
  ADD KEY `idx_students_teacher_id` (`teacher_id`);

--
-- Indexes for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_system_logs_user_type_id` (`user_type`,`user_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `employee_id` (`employee_id`),
  ADD KEY `idx_teachers_email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `violations`
--
ALTER TABLE `violations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_violations_exam_session_id` (`exam_session_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrators`
--
ALTER TABLE `administrators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `proctoring_settings`
--
ALTER TABLE `proctoring_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `system_logs`
--
ALTER TABLE `system_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `violations`
--
ALTER TABLE `violations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exams`
--
ALTER TABLE `exams`
  ADD CONSTRAINT `exams_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  ADD CONSTRAINT `exam_sessions_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_sessions_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `violations`
--
ALTER TABLE `violations`
  ADD CONSTRAINT `violations_ibfk_1` FOREIGN KEY (`exam_session_id`) REFERENCES `exam_sessions` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
