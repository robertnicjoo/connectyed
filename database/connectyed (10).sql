-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 14, 2024 at 01:39 PM
-- Server version: 10.6.20-MariaDB-cll-lve
-- PHP Version: 8.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `connectyed`
--

-- --------------------------------------------------------

--
-- Table structure for table `availabilities`
--

CREATE TABLE `availabilities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_all_day` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `availabilities`
--

INSERT INTO `availabilities` (`id`, `user_id`, `start_date`, `end_date`, `start_time`, `end_time`, `is_all_day`, `created_at`, `updated_at`) VALUES
(32, 154, '2024-11-19', '2024-11-29', NULL, NULL, 1, '2024-11-13 07:32:43', '2024-11-13 07:32:43'),
(34, 154, '2024-12-05', '2024-12-05', NULL, NULL, 1, '2024-11-22 17:43:07', '2024-11-22 17:43:07'),
(35, 154, '2024-11-29', '2024-12-06', NULL, NULL, 1, '2024-11-28 13:18:17', '2024-11-28 13:18:17'),
(36, 283, '2024-12-13', '2025-12-31', NULL, NULL, 1, '2024-12-14 00:31:01', '2024-12-14 00:31:01');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('431bf3b995a99c2cd6899b97187d1542a965cec9', 'i:2;', 1733981481),
('431bf3b995a99c2cd6899b97187d1542a965cec9:timer', 'i:1733981481;', 1733981481),
('b70706fdb0027063c33c00f7ce3e040221dd70bb', 'i:2;', 1734057443),
('b70706fdb0027063c33c00f7ce3e040221dd70bb:timer', 'i:1734057443;', 1734057443),
('iq64hTlajPvHvmLB', 's:7:\"forever\";', 2049341491),
('JRjGPbKGw8oChQWM', 's:7:\"forever\";', 2049389837),
('jwMOcv9gB2HxkBMK', 's:7:\"forever\";', 2049310543),
('wwrBn6fxTYW7nzEE', 's:7:\"forever\";', 2049310743);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `category_slug` varchar(255) NOT NULL,
  `category_index` int(11) DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `lang` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `category_slug`, `category_index`, `parent_id`, `lang`, `created_at`, `updated_at`) VALUES
(1, 'Page', 'page', NULL, 0, 'en', '2024-09-08 17:23:08', '2024-09-08 17:23:08'),
(2, 'Blog', 'blog', NULL, 0, 'en', '2024-09-08 17:23:08', '2024-09-08 17:23:08');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `parent_id`, `body`, `created_at`, `updated_at`) VALUES
(1, 1, 21, NULL, 'ada', '2024-05-17 19:49:01', '2024-05-17 19:49:01'),
(2, 1, 21, NULL, 'sd', '2024-05-17 19:49:17', '2024-05-17 19:49:17'),
(3, 1, 21, NULL, 'aaaaaaaaaaaaaaaaaa', '2024-05-17 19:49:22', '2024-05-17 19:49:22'),
(4, 1, 21, NULL, 'sds', '2024-05-17 19:50:05', '2024-05-17 19:50:05'),
(5, 1, 21, NULL, 'ggg', '2024-05-17 19:51:07', '2024-05-17 19:51:07'),
(6, 1, 21, NULL, 'sss', '2024-05-17 19:51:28', '2024-05-17 19:51:28'),
(7, 1, 20, NULL, 'sd', '2024-05-17 19:52:28', '2024-05-17 19:52:28'),
(8, 1, 20, NULL, 'sd', '2024-05-17 19:52:52', '2024-05-17 19:52:52'),
(9, 1, 20, NULL, 'asd', '2024-05-17 19:53:05', '2024-05-17 19:53:05'),
(10, 1, 20, NULL, 'dsa', '2024-05-17 19:53:10', '2024-05-17 19:53:10'),
(11, 1, 20, NULL, '888', '2024-05-17 19:53:15', '2024-05-17 19:53:15'),
(12, 1, 20, NULL, 'ttt', '2024-05-17 19:53:21', '2024-05-17 19:53:21'),
(13, 1, 20, NULL, 'sss', '2024-05-17 19:53:40', '2024-05-17 19:53:40'),
(14, 1, 20, NULL, 'dds', '2024-05-17 19:53:49', '2024-05-17 19:53:49'),
(15, 1, 20, NULL, 'sss', '2024-05-17 19:54:04', '2024-05-17 19:54:04'),
(16, 1, 19, NULL, 'ss', '2024-05-17 19:54:55', '2024-05-17 19:54:55'),
(17, 1, 19, NULL, 'ds', '2024-05-17 19:54:58', '2024-05-17 19:54:58'),
(18, 1, 19, NULL, 'a', '2024-05-17 19:57:21', '2024-05-17 19:57:21'),
(19, 1, 19, NULL, 'sd', '2024-05-17 20:02:30', '2024-05-17 20:02:30'),
(20, 1, 19, NULL, 'ada deh', '2024-05-17 20:17:13', '2024-05-17 20:17:13'),
(21, 1, 3, NULL, 'ada', '2024-05-17 20:19:11', '2024-05-17 20:19:11'),
(22, 1, 3, NULL, 'dddaaa', '2024-05-17 20:19:13', '2024-05-17 20:19:13'),
(23, 1, 3, NULL, 'diaa', '2024-05-17 20:19:18', '2024-05-17 20:19:18'),
(24, 2, 21, NULL, 'tau ah', '2024-05-17 20:21:27', '2024-05-17 20:21:27'),
(25, 2, 20, NULL, 'ooooooooooooooo', '2024-05-17 20:55:30', '2024-05-17 20:55:30'),
(26, 1, 27, NULL, 'please restore this article', '2024-05-18 02:19:22', '2024-05-18 02:19:22');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `userable_type` varchar(255) NOT NULL,
  `userable_id` bigint(20) UNSIGNED NOT NULL,
  `likeable_type` varchar(255) NOT NULL,
  `likeable_id` bigint(20) UNSIGNED NOT NULL,
  `is_liked` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`userable_type`, `userable_id`, `likeable_type`, `likeable_id`, `is_liked`, `created_at`, `updated_at`) VALUES
('user', 1, 'comment', 22, 1, '2024-05-17 20:20:26', '2024-05-17 20:20:26'),
('user', 1, 'post', 1, 1, '2024-05-17 10:51:17', '2024-05-17 10:51:17'),
('user', 1, 'post', 21, 1, '2024-05-17 10:50:40', '2024-05-17 10:50:40'),
('user', 1, 'post', 27, 1, '2024-05-18 02:19:03', '2024-05-18 02:19:03'),
('user', 2, 'comment', 4, 1, '2024-05-17 20:21:32', '2024-05-17 20:21:32'),
('user', 2, 'comment', 6, 1, '2024-05-17 20:21:31', '2024-05-17 20:21:31'),
('user', 2, 'comment', 24, 1, '2024-05-17 20:21:34', '2024-05-17 20:21:34'),
('user', 2, 'comment', 25, 1, '2024-05-17 20:55:33', '2024-05-17 20:55:33'),
('user', 2, 'comment', 26, 1, '2024-05-18 02:19:47', '2024-05-18 02:19:47'),
('user', 2, 'post', 2, 1, '2024-05-17 02:56:57', '2024-05-17 02:56:57'),
('user', 2, 'post', 3, 1, '2024-05-17 07:06:56', '2024-05-17 07:06:56'),
('user', 2, 'post', 6, 1, '2024-05-17 07:06:59', '2024-05-17 07:06:59');

-- --------------------------------------------------------

--
-- Table structure for table `matchmaker_clients`
--

CREATE TABLE `matchmaker_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `matchmaker_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `age` int(11) NOT NULL,
  `height_feet` int(11) NOT NULL,
  `height_inches` int(11) NOT NULL,
  `body_type` varchar(50) NOT NULL,
  `interests` text NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `marital_status` varchar(50) NOT NULL,
  `children` int(11) NOT NULL,
  `religion` varchar(100) NOT NULL,
  `thumbnail_image` varchar(255) NOT NULL,
  `additional_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional_images`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `matchmaker_clients`
--

INSERT INTO `matchmaker_clients` (`id`, `matchmaker_id`, `user_id`, `age`, `height_feet`, `height_inches`, `body_type`, `interests`, `city`, `state`, `country`, `marital_status`, `children`, `religion`, `thumbnail_image`, `additional_images`, `created_at`, `updated_at`) VALUES
(8, 157, 176, 37, 5, 1, 'Curvy', 'travel, different countries, cultures', 'Rio das Ostras', 'Rio de Janeiro', 'Brazil', 'Divorced', 1, 'Christian', 'clients/avatars/6JaTSEicjabZltHjoXyV3Wb1SCWWTW058T0b2K7v.jpg', '\"[\\\"clients\\\\\\/additional\\\\\\/pLpwWCMpTDzBZ4P7OEKa3WTjMcmpgo8srtrfIHlk.jpg\\\"]\"', '2024-11-21 00:11:41', '2024-11-21 00:11:41'),
(9, 157, 227, 21, 5, 3, 'Athletic', 'internet, communication', 'Los Angeles', 'California', 'United States', 'Single', 0, 'Other', 'clients/avatars/KCak9YsvtQzMaqhAgAL0BnFAVk66czEmOfddYtUJ.jpg', '\"[\\\"clients\\\\\\/additional\\\\\\/Il3Vo1XEkQjMsZZ7Zuwg3K8jFITadQ6OZhttN7eQ.jpg\\\"]\"', '2024-12-03 22:03:28', '2024-12-03 22:03:28'),
(10, 157, 237, 33, 5, 2, 'Curvy', 'I\'m looking for Caucasian under 35 professionally educated who believes in waiting for marriage and have never been in relationship so far for the same reason open for non Christian partner', 'Montreal', 'Montreal', 'Canada', 'Single', 0, 'Other', 'clients/avatars/ADMKeMQgJebYfa482zobwg3771jD6EbF9ZjZ7Ht5.jpg', '\"[\\\"clients\\\\\\/additional\\\\\\/jspUkQHsdEb2qfGOPOTkC9JALJBbIAfw8X61d778.png\\\"]\"', '2024-12-05 00:31:16', '2024-12-05 00:31:16'),
(11, 156, 252, 23, 5, 4, 'Curvy', 'Book, Video Games', 'CAGAYAN DE ORO CITY', 'misamis oriental', 'Philippines', 'Single', 0, 'Catholic', 'clients/avatars/nvq6LwLi9zcvM4SkuGuRcZXnYsNOa80gZYs6McSC.jpg', '\"[]\"', '2024-12-09 00:07:26', '2024-12-09 00:07:26'),
(12, 156, 266, 23, 5, 5, 'Average', 'Reading', 'Ozamiz City', 'Misamis Occidental', 'Philippines', 'Single', 0, 'Catholic', 'clients/avatars/SqcKp80ZBD2Msv2uURzPHKQphidKeoNfIFYOFtvl.jpg', '\"[]\"', '2024-12-10 23:18:03', '2024-12-10 23:18:03'),
(13, 156, 267, 22, 5, 2, 'Athletic', 'Watching movies', 'Gusa', 'Misamis Oriental', 'Philippines', 'Single', 0, 'Christian', 'clients/avatars/vCAaUtCO3ubIL8Hb12FypyRXaImrYkcF5FQuFNl1.jpg', '\"[]\"', '2024-12-10 23:27:11', '2024-12-10 23:27:11'),
(14, 156, 268, 23, 5, 0, 'Athletic', 'Going to the gym', 'Bugo', 'Misamis Oriental', 'Philippines', 'Single', 0, 'Catholic', 'clients/avatars/D4WHUBmjxQmzRNFRLdEewiiiXZUYTPEOvASSt7KW.jpg', '\"[]\"', '2024-12-10 23:36:06', '2024-12-10 23:36:06'),
(15, 156, 269, 22, 5, 0, 'Average', 'Coffee', 'Ozamis City', 'Misamis Occidental', 'Philippines', 'Single', 0, 'Catholic', 'clients/avatars/sJk1OolEmm1rFbQ4xdLVR57CxB0WHmPlzTRNW5tK.jpg', '\"[]\"', '2024-12-10 23:50:41', '2024-12-10 23:50:41');

-- --------------------------------------------------------

--
-- Table structure for table `meetings`
--

CREATE TABLE `meetings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` int(11) NOT NULL,
  `matchmaker_id` bigint(20) UNSIGNED NOT NULL,
  `google_meet_id` varchar(255) DEFAULT NULL,
  `google_meet_link` text DEFAULT NULL,
  `google_meet_password` varchar(256) NOT NULL,
  `meeting_response` text NOT NULL,
  `schedules` text DEFAULT NULL,
  `timezone` text DEFAULT NULL,
  `start_time` text NOT NULL,
  `end_time` text DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(20) DEFAULT 'pending',
  `scheduled_by` bigint(20) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT 0.00,
  `matchmaker_earnings` decimal(10,2) DEFAULT 0.00,
  `client_credit` decimal(10,2) DEFAULT 0.00,
  `admin_earnings` decimal(10,2) DEFAULT 0.00,
  `confirm_token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meetings`
--

INSERT INTO `meetings` (`id`, `client_id`, `matchmaker_id`, `google_meet_id`, `google_meet_link`, `google_meet_password`, `meeting_response`, `schedules`, `timezone`, `start_time`, `end_time`, `duration`, `created_at`, `updated_at`, `status`, `scheduled_by`, `amount`, `matchmaker_earnings`, `client_credit`, `admin_earnings`, `confirm_token`) VALUES
(49, 70, 154, '86214191130', 'https://us05web.zoom.us/j/86214191130?pwd=IJXEAfzupFQxPlUs5akm5K1q0WKhxN.1', '84765', '{\n    \"uuid\": \"PWqiVwnBRtuUSJhR5imF2A==\",\n    \"id\": 86214191130,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-11-29T06:21:03Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-11-29T06:21:03Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/86214191130?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NjIxNDE5MTEzMCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjUzZTY5YzU1YTY1ZjQ2OTI4MGM2NWJjODZkMjhlNjY0Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzI4Njg0NjMsImlhdCI6MTczMjg2MTI2MywiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.dlNILGgKxB2mi_ydrRJ8HWuD16WNmAaBTtcEtCuXHi4\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/86214191130?pwd=IJXEAfzupFQxPlUs5akm5K1q0WKhxN.1\",\n    \"password\": \"84765\",\n    \"h323_password\": \"84765\",\n    \"pstn_password\": \"84765\",\n    \"encrypted_password\": \"IJXEAfzupFQxPlUs5akm5K1q0WKhxN.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_ae465b12ef0645db886399e2322549e4\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-11-30 11:50:00', NULL, 30, '2024-11-29 13:21:03', '2024-11-29 13:21:03', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(50, 78, 154, '86214191130', 'https://us05web.zoom.us/j/86214191130?pwd=IJXEAfzupFQxPlUs5akm5K1q0WKhxN.1', '84765', '{\n    \"uuid\": \"PWqiVwnBRtuUSJhR5imF2A==\",\n    \"id\": 86214191130,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-11-29T06:21:03Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-11-29T06:21:03Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/86214191130?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NjIxNDE5MTEzMCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjUzZTY5YzU1YTY1ZjQ2OTI4MGM2NWJjODZkMjhlNjY0Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzI4Njg0NjMsImlhdCI6MTczMjg2MTI2MywiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.dlNILGgKxB2mi_ydrRJ8HWuD16WNmAaBTtcEtCuXHi4\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/86214191130?pwd=IJXEAfzupFQxPlUs5akm5K1q0WKhxN.1\",\n    \"password\": \"84765\",\n    \"h323_password\": \"84765\",\n    \"pstn_password\": \"84765\",\n    \"encrypted_password\": \"IJXEAfzupFQxPlUs5akm5K1q0WKhxN.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_ae465b12ef0645db886399e2322549e4\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-11-30 11:50:00', NULL, 30, '2024-11-29 13:21:16', '2024-11-29 13:21:16', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(51, 153, 154, '87329073852', 'https://us05web.zoom.us/j/87329073852?pwd=cBNI9c16b26pbXYHO7qjaPw30R2C1I.1', '29709', '{\n    \"uuid\": \"Jeh3ZRt0TPW4zxzX8zSSiA==\",\n    \"id\": 87329073852,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-11-29T06:23:26Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-11-29T06:23:26Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/87329073852?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NzMyOTA3Mzg1MiIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6Ijk5MDhmOTM3MzlmNDRmNDliYTQ3ZjIxMmYxYWQzZGYwIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzI4Njg2MDYsImlhdCI6MTczMjg2MTQwNiwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.RJrFHnuzohjV3iwgAmvcbYEj31vU5B3gPQKbmRMmbQs\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/87329073852?pwd=cBNI9c16b26pbXYHO7qjaPw30R2C1I.1\",\n    \"password\": \"29709\",\n    \"h323_password\": \"29709\",\n    \"pstn_password\": \"29709\",\n    \"encrypted_password\": \"cBNI9c16b26pbXYHO7qjaPw30R2C1I.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_a58b39b3a3cb42d5b06252f54cc6e5ca\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-11-23 18:30:00', NULL, 1440, '2024-11-29 13:23:26', '2024-11-29 13:23:26', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(52, 153, 154, '82341703318', 'https://us05web.zoom.us/j/82341703318?pwd=ZbBbDawFAPdyXuv8ksgEiDbhUdEU2k.1', '85686', '{\n    \"uuid\": \"zIcl4skYRrW+yTQyIyGQbw==\",\n    \"id\": 82341703318,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-11-29T07:15:35Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-11-29T07:15:35Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/82341703318?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4MjM0MTcwMzMxOCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImM3OGJkMzc2OGM4NjQyZTk4NDhlZThkZGRmNTE4OTFjIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzI4NzE3MzUsImlhdCI6MTczMjg2NDUzNSwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.RlfafuWGHz-6GU8-T8GwLUJYBPAeUudtdRfhdZxnmcI\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/82341703318?pwd=ZbBbDawFAPdyXuv8ksgEiDbhUdEU2k.1\",\n    \"password\": \"85686\",\n    \"h323_password\": \"85686\",\n    \"pstn_password\": \"85686\",\n    \"encrypted_password\": \"ZbBbDawFAPdyXuv8ksgEiDbhUdEU2k.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_30f689e8b31947a4b2e10a0e5a3626b8\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-11-28 22:00:00', NULL, 1440, '2024-11-29 14:15:35', '2024-11-29 14:15:35', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(53, 153, 154, '87627217741', 'https://us05web.zoom.us/j/87627217741?pwd=VUGb6y1EOHcFWIY2WBtmt0ITyAo12l.1', '57916', '{\n    \"uuid\": \"HKBA7W8wRie2e28rxUK20A==\",\n    \"id\": 87627217741,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-11-29T07:17:26Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-11-29T07:17:26Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/87627217741?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NzYyNzIxNzc0MSIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjExYThlNzQzOGYzYjRiYmVhNWJiM2NiMjJlYWM0MWI5Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzI4NzE4NDYsImlhdCI6MTczMjg2NDY0NiwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9._m2WW2J996WfnINj4TE3SFa56Z7Ua67dG3d_xForh54\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/87627217741?pwd=VUGb6y1EOHcFWIY2WBtmt0ITyAo12l.1\",\n    \"password\": \"57916\",\n    \"h323_password\": \"57916\",\n    \"pstn_password\": \"57916\",\n    \"encrypted_password\": \"VUGb6y1EOHcFWIY2WBtmt0ITyAo12l.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_28ff0e069cd04ffe977bc5b70d020fe6\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-11-30 09:17:00', NULL, 30, '2024-11-29 14:17:26', '2024-11-29 14:17:26', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(54, 175, 154, '87627217741', 'https://us05web.zoom.us/j/87627217741?pwd=VUGb6y1EOHcFWIY2WBtmt0ITyAo12l.1', '57916', '{\n    \"uuid\": \"HKBA7W8wRie2e28rxUK20A==\",\n    \"id\": 87627217741,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-11-29T07:17:26Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-11-29T07:17:26Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/87627217741?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NzYyNzIxNzc0MSIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjExYThlNzQzOGYzYjRiYmVhNWJiM2NiMjJlYWM0MWI5Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzI4NzE4NDYsImlhdCI6MTczMjg2NDY0NiwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9._m2WW2J996WfnINj4TE3SFa56Z7Ua67dG3d_xForh54\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/87627217741?pwd=VUGb6y1EOHcFWIY2WBtmt0ITyAo12l.1\",\n    \"password\": \"57916\",\n    \"h323_password\": \"57916\",\n    \"pstn_password\": \"57916\",\n    \"encrypted_password\": \"VUGb6y1EOHcFWIY2WBtmt0ITyAo12l.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_28ff0e069cd04ffe977bc5b70d020fe6\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-11-30 09:17:00', NULL, 30, '2024-11-29 14:17:35', '2024-11-29 14:17:35', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(55, 153, 154, '87093357770', 'https://us05web.zoom.us/j/87093357770?pwd=dPa3CVMHvF7JPb1Ta9WfMtlV9fCBag.1', '86628', '{\n    \"uuid\": \"Ujqr1JLoTgiAsBoBjeOWGQ==\",\n    \"id\": 87093357770,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-11-30T09:30:33Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-11-30T09:30:33Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/87093357770?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NzA5MzM1Nzc3MCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImFmOGI4MWM3MDhiMjQyNjJiZjUzOTgwZmY0MTEyNmQ2Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzI5NjYyMzMsImlhdCI6MTczMjk1OTAzMywiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.1gdBAhqO0bDyQlM4DKTv4ZVuJt3rTTfaxNKdXxTMuDM\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/87093357770?pwd=dPa3CVMHvF7JPb1Ta9WfMtlV9fCBag.1\",\n    \"password\": \"86628\",\n    \"h323_password\": \"86628\",\n    \"pstn_password\": \"86628\",\n    \"encrypted_password\": \"dPa3CVMHvF7JPb1Ta9WfMtlV9fCBag.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_2322d545c16046e4b31c6b866264b151\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-01 11:30:00', NULL, 30, '2024-11-30 16:30:33', '2024-11-30 16:30:33', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(56, 175, 154, '87093357770', 'https://us05web.zoom.us/j/87093357770?pwd=dPa3CVMHvF7JPb1Ta9WfMtlV9fCBag.1', '86628', '{\n    \"uuid\": \"Ujqr1JLoTgiAsBoBjeOWGQ==\",\n    \"id\": 87093357770,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-11-30T09:30:33Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-11-30T09:30:33Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/87093357770?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NzA5MzM1Nzc3MCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImFmOGI4MWM3MDhiMjQyNjJiZjUzOTgwZmY0MTEyNmQ2Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzI5NjYyMzMsImlhdCI6MTczMjk1OTAzMywiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.1gdBAhqO0bDyQlM4DKTv4ZVuJt3rTTfaxNKdXxTMuDM\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/87093357770?pwd=dPa3CVMHvF7JPb1Ta9WfMtlV9fCBag.1\",\n    \"password\": \"86628\",\n    \"h323_password\": \"86628\",\n    \"pstn_password\": \"86628\",\n    \"encrypted_password\": \"dPa3CVMHvF7JPb1Ta9WfMtlV9fCBag.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_2322d545c16046e4b31c6b866264b151\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-01 11:30:00', NULL, 30, '2024-11-30 16:30:42', '2024-11-30 16:30:42', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(57, 153, 154, '86594176855', 'https://us05web.zoom.us/j/86594176855?pwd=b0Mabvt5Az4sgwwCyXQwvwH09Hslux.1', '23244', '{\n    \"uuid\": \"iLhkOAc+S1e9YnpioMKK8A==\",\n    \"id\": 86594176855,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-02T05:25:02Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-02T05:25:02Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/86594176855?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NjU5NDE3Njg1NSIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6Ijk4MTYxODM2NmMzNzRlOTFiYmVmY2EyMDMxMmQ0YzIyIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzMxMjQzMDIsImlhdCI6MTczMzExNzEwMiwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.o0_mVdqTPwD2T26R1VWsm7N3iVepA46kBkoG6zP-6yA\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/86594176855?pwd=b0Mabvt5Az4sgwwCyXQwvwH09Hslux.1\",\n    \"password\": \"23244\",\n    \"h323_password\": \"23244\",\n    \"pstn_password\": \"23244\",\n    \"encrypted_password\": \"b0Mabvt5Az4sgwwCyXQwvwH09Hslux.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_a2eb7dea1938456fab86cc8163929932\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-01 22:00:00', NULL, 1440, '2024-12-02 12:25:02', '2024-12-02 12:25:02', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(58, 153, 154, '85990468690', 'https://us05web.zoom.us/j/85990468690?pwd=J9TyWs8RAerAYGkKgaUhLJjtajeAgv.1', '88133', '{\n    \"uuid\": \"0ASmTMJ2Rd6lQoXM\\/DmXHQ==\",\n    \"id\": 85990468690,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-03T16:05:08Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-03T16:05:08Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/85990468690?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NTk5MDQ2ODY5MCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImFhN2ZmYTVkNTc2NzQyOTdhMGYxOWU4MTdmNDE1MWJlIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzMyNDkxMDksImlhdCI6MTczMzI0MTkwOSwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.8J3wZN4zQvPcRflLVPBMkvyrFEKyuiEsEzPMPkkmVtU\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/85990468690?pwd=J9TyWs8RAerAYGkKgaUhLJjtajeAgv.1\",\n    \"password\": \"88133\",\n    \"h323_password\": \"88133\",\n    \"pstn_password\": \"88133\",\n    \"encrypted_password\": \"J9TyWs8RAerAYGkKgaUhLJjtajeAgv.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_4995869b5f5643529bad3e7f5a701dfb\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-03 19:05:00', NULL, 30, '2024-12-03 23:05:09', '2024-12-03 23:05:09', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(59, 175, 154, '85990468690', 'https://us05web.zoom.us/j/85990468690?pwd=J9TyWs8RAerAYGkKgaUhLJjtajeAgv.1', '88133', '{\n    \"uuid\": \"0ASmTMJ2Rd6lQoXM\\/DmXHQ==\",\n    \"id\": 85990468690,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-03T16:05:08Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-03T16:05:08Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/85990468690?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NTk5MDQ2ODY5MCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImFhN2ZmYTVkNTc2NzQyOTdhMGYxOWU4MTdmNDE1MWJlIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzMyNDkxMDksImlhdCI6MTczMzI0MTkwOSwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.8J3wZN4zQvPcRflLVPBMkvyrFEKyuiEsEzPMPkkmVtU\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/85990468690?pwd=J9TyWs8RAerAYGkKgaUhLJjtajeAgv.1\",\n    \"password\": \"88133\",\n    \"h323_password\": \"88133\",\n    \"pstn_password\": \"88133\",\n    \"encrypted_password\": \"J9TyWs8RAerAYGkKgaUhLJjtajeAgv.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_4995869b5f5643529bad3e7f5a701dfb\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-03 19:05:00', NULL, 30, '2024-12-03 23:05:25', '2024-12-03 23:05:25', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(60, 153, 154, '88204753033', 'https://us05web.zoom.us/j/88204753033?pwd=qjDBlVHZVcUdfbGGnrBgqnoMp9cpDl.1', '73481', '{\n    \"uuid\": \"iKEqyQYqSP+mMQ5lF\\/7e8w==\",\n    \"id\": 88204753033,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-03T16:07:49Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-03T16:07:49Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/88204753033?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4ODIwNDc1MzAzMyIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImNiMTAxOWZiODllOTRlMThhZTY4MTk4NWNhNzU4MmM1Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzMyNDkyNjksImlhdCI6MTczMzI0MjA2OSwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.atXHA4IZX2DoxhIrU6dahlI5fohzTRnC0UxAw2Xezrg\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/88204753033?pwd=qjDBlVHZVcUdfbGGnrBgqnoMp9cpDl.1\",\n    \"password\": \"73481\",\n    \"h323_password\": \"73481\",\n    \"pstn_password\": \"73481\",\n    \"encrypted_password\": \"qjDBlVHZVcUdfbGGnrBgqnoMp9cpDl.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_c9b37ed6dd1f4a26b1c290e4f2661224\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-02 22:00:00', NULL, 1440, '2024-12-03 23:07:49', '2024-12-03 23:07:49', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(61, 153, 154, '84560110377', 'https://us05web.zoom.us/j/84560110377?pwd=ZDudgLWqigSr8Ka9byDLdEklb9KhaI.1', '25004', '{\n    \"uuid\": \"K0rCYqOLQ1+y63WaoT8k0g==\",\n    \"id\": 84560110377,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T00:59:38Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T00:59:38Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/84560110377?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NDU2MDExMDM3NyIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImMyMDhjZGMxNTFkNDQzNjVhN2MwZTNhZGMwZGFlMjNlIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTM5NzgsImlhdCI6MTczMzQ0Njc3OCwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.SPC2CB4ZI2qWaQr7WT0EsyA4Ze4vPgjqt02g7dcYKtE\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/84560110377?pwd=ZDudgLWqigSr8Ka9byDLdEklb9KhaI.1\",\n    \"password\": \"25004\",\n    \"h323_password\": \"25004\",\n    \"pstn_password\": \"25004\",\n    \"encrypted_password\": \"ZDudgLWqigSr8Ka9byDLdEklb9KhaI.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_e36f652e26824646abd16adca132eef3\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-04 22:00:00', NULL, 1440, '2024-12-06 07:59:38', '2024-12-06 07:59:38', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL);
INSERT INTO `meetings` (`id`, `client_id`, `matchmaker_id`, `google_meet_id`, `google_meet_link`, `google_meet_password`, `meeting_response`, `schedules`, `timezone`, `start_time`, `end_time`, `duration`, `created_at`, `updated_at`, `status`, `scheduled_by`, `amount`, `matchmaker_earnings`, `client_credit`, `admin_earnings`, `confirm_token`) VALUES
(62, 153, 154, '88597482520', 'https://us05web.zoom.us/j/88597482520?pwd=pzaTnMVJudNrl7N2qpH0XO5hGLDTQR.1', '46046', '{\n    \"uuid\": \"W205OqG\\/QgOUpoHe4iUhNg==\",\n    \"id\": 88597482520,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T00:59:46Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T00:59:46Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/88597482520?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4ODU5NzQ4MjUyMCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjQ1N2U0MGM3ODAxODQ3NmI4ODA0ODE2Y2I4ZGI5YjYzIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTM5ODcsImlhdCI6MTczMzQ0Njc4NywiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.wW6NKjixMspYAxqLpTfl8Y8RGJz-aRWDCW-D1l_9PbE\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/88597482520?pwd=pzaTnMVJudNrl7N2qpH0XO5hGLDTQR.1\",\n    \"password\": \"46046\",\n    \"h323_password\": \"46046\",\n    \"pstn_password\": \"46046\",\n    \"encrypted_password\": \"pzaTnMVJudNrl7N2qpH0XO5hGLDTQR.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_b5115f2f6bc14f59a22a9059390c76cc\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-05 22:00:00', NULL, 1440, '2024-12-06 07:59:47', '2024-12-06 07:59:47', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(63, 153, 154, '82390468226', 'https://us05web.zoom.us/j/82390468226?pwd=c19cCwRfg7XKDzdwQDjtkamfEyTyjV.1', '50810', '{\n    \"uuid\": \"1M5DqHrsTZO3fkZNg+dhcg==\",\n    \"id\": 82390468226,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T00:59:49Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T00:59:49Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/82390468226?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4MjM5MDQ2ODIyNiIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjM5NmY0NGNjMzU4MjRjNmJhMDk1MzRjOGE3ODc5YmE5Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTM5OTAsImlhdCI6MTczMzQ0Njc5MCwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.PPMpImw03Ga-PBru30GOpsnlxLLob9q0ihMhneJIj3w\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/82390468226?pwd=c19cCwRfg7XKDzdwQDjtkamfEyTyjV.1\",\n    \"password\": \"50810\",\n    \"h323_password\": \"50810\",\n    \"pstn_password\": \"50810\",\n    \"encrypted_password\": \"c19cCwRfg7XKDzdwQDjtkamfEyTyjV.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_cac9b0b07eb3469c84b0ed29316ea25d\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-05 22:00:00', NULL, 1440, '2024-12-06 07:59:50', '2024-12-06 07:59:50', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(64, 153, 154, '83350502803', 'https://us05web.zoom.us/j/83350502803?pwd=rfAPM1x34a37pTfWrJ93OEOl7ZsS8s.1', '15206', '{\n    \"uuid\": \"3Q98nd53T0uGeGnF31IW6w==\",\n    \"id\": 83350502803,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T01:03:18Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T01:03:18Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/83350502803?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4MzM1MDUwMjgwMyIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjA0ZTlkMmNlNDVkZTQxZjg5ZTI0NzA5ODM2YmRmYjRmIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTQxOTgsImlhdCI6MTczMzQ0Njk5OCwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.8gJIbXjN7wlzdJgzUvOUfTwPBAegm75o6BEUNntHmKI\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/83350502803?pwd=rfAPM1x34a37pTfWrJ93OEOl7ZsS8s.1\",\n    \"password\": \"15206\",\n    \"h323_password\": \"15206\",\n    \"pstn_password\": \"15206\",\n    \"encrypted_password\": \"rfAPM1x34a37pTfWrJ93OEOl7ZsS8s.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_ebdf7815dca940318738d857001dac9e\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-07 06:03:00', NULL, 30, '2024-12-06 08:03:18', '2024-12-06 08:03:18', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(65, 175, 154, '83350502803', 'https://us05web.zoom.us/j/83350502803?pwd=rfAPM1x34a37pTfWrJ93OEOl7ZsS8s.1', '15206', '{\n    \"uuid\": \"3Q98nd53T0uGeGnF31IW6w==\",\n    \"id\": 83350502803,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T01:03:18Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T01:03:18Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/83350502803?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4MzM1MDUwMjgwMyIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjA0ZTlkMmNlNDVkZTQxZjg5ZTI0NzA5ODM2YmRmYjRmIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTQxOTgsImlhdCI6MTczMzQ0Njk5OCwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.8gJIbXjN7wlzdJgzUvOUfTwPBAegm75o6BEUNntHmKI\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/83350502803?pwd=rfAPM1x34a37pTfWrJ93OEOl7ZsS8s.1\",\n    \"password\": \"15206\",\n    \"h323_password\": \"15206\",\n    \"pstn_password\": \"15206\",\n    \"encrypted_password\": \"rfAPM1x34a37pTfWrJ93OEOl7ZsS8s.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_ebdf7815dca940318738d857001dac9e\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-07 06:03:00', NULL, 30, '2024-12-06 08:03:27', '2024-12-06 08:03:27', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(66, 153, 154, '85035938289', 'https://us05web.zoom.us/j/85035938289?pwd=5ZI1rxGAA6ZcZXl7XdGcUiCu7stzfF.1', '31680', '{\n    \"uuid\": \"+wdDncD\\/Sz+BflFby0LfIw==\",\n    \"id\": 85035938289,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T01:03:51Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T01:03:51Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/85035938289?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NTAzNTkzODI4OSIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImU2ODZhNDViNGMwMjQwNmI4NWE2ZjFlZmQ4YjgyYjQ5Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTQyMzEsImlhdCI6MTczMzQ0NzAzMSwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.kTs5JdHQ_Bz3cJmTy128mtgTHaW25i83hT1na5fCWmQ\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/85035938289?pwd=5ZI1rxGAA6ZcZXl7XdGcUiCu7stzfF.1\",\n    \"password\": \"31680\",\n    \"h323_password\": \"31680\",\n    \"pstn_password\": \"31680\",\n    \"encrypted_password\": \"5ZI1rxGAA6ZcZXl7XdGcUiCu7stzfF.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_dad8943531c540f88f001442706546fa\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-07 06:03:00', NULL, 30, '2024-12-06 08:03:51', '2024-12-06 08:03:51', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(67, 175, 154, '85035938289', 'https://us05web.zoom.us/j/85035938289?pwd=5ZI1rxGAA6ZcZXl7XdGcUiCu7stzfF.1', '31680', '{\n    \"uuid\": \"+wdDncD\\/Sz+BflFby0LfIw==\",\n    \"id\": 85035938289,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T01:03:51Z\",\n    \"duration\": 30,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T01:03:51Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/85035938289?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NTAzNTkzODI4OSIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImU2ODZhNDViNGMwMjQwNmI4NWE2ZjFlZmQ4YjgyYjQ5Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTQyMzEsImlhdCI6MTczMzQ0NzAzMSwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.kTs5JdHQ_Bz3cJmTy128mtgTHaW25i83hT1na5fCWmQ\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/85035938289?pwd=5ZI1rxGAA6ZcZXl7XdGcUiCu7stzfF.1\",\n    \"password\": \"31680\",\n    \"h323_password\": \"31680\",\n    \"pstn_password\": \"31680\",\n    \"encrypted_password\": \"5ZI1rxGAA6ZcZXl7XdGcUiCu7stzfF.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_dad8943531c540f88f001442706546fa\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-07 06:03:00', NULL, 30, '2024-12-06 08:04:00', '2024-12-06 08:04:00', 'confirmed', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(68, 153, 154, '83859782628', 'https://us05web.zoom.us/j/83859782628?pwd=D3jPWvnst3Z24aOwZVBiBRP3KjlFh5.1', '57384', '{\n    \"uuid\": \"gs8fplDkRFCQa1iBxIDX5w==\",\n    \"id\": 83859782628,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T01:08:53Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T01:08:53Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/83859782628?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4Mzg1OTc4MjYyOCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImM4Y2ZiYzkxOGY3MDQyZDRhMWJjYTAxNTE0MTM5MGM1Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTQ1MzMsImlhdCI6MTczMzQ0NzMzMywiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.WbrANDcbyHZWlHxSq4CZB04tXAkRxD3ruBFiGVkm-04\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/83859782628?pwd=D3jPWvnst3Z24aOwZVBiBRP3KjlFh5.1\",\n    \"password\": \"57384\",\n    \"h323_password\": \"57384\",\n    \"pstn_password\": \"57384\",\n    \"encrypted_password\": \"D3jPWvnst3Z24aOwZVBiBRP3KjlFh5.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_b2a587eed23e479f960a7745ce1ff23f\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-05 22:00:00', NULL, 1440, '2024-12-06 08:08:54', '2024-12-06 08:08:54', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(69, 153, 154, '82338919510', 'https://us05web.zoom.us/j/82338919510?pwd=H1QikJgX3JsGtYk0dbgyDvvASaKwJl.1', '92009', '{\n    \"uuid\": \"QNvyuRQYRveDHG\\/wDnG0AQ==\",\n    \"id\": 82338919510,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T01:34:25Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T01:34:25Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/82338919510?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4MjMzODkxOTUxMCIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjcxODVmZDRmZDM2YTRkYzZhZjc2YzczOTk5ZGM4Yjc1Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTYwNjUsImlhdCI6MTczMzQ0ODg2NSwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.0_h57OJ_w5T5K5-ZWJ_NjCzlOuhATQ5xU5fq-tDSMjk\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/82338919510?pwd=H1QikJgX3JsGtYk0dbgyDvvASaKwJl.1\",\n    \"password\": \"92009\",\n    \"h323_password\": \"92009\",\n    \"pstn_password\": \"92009\",\n    \"encrypted_password\": \"H1QikJgX3JsGtYk0dbgyDvvASaKwJl.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_83ce4556e75b4162a68d3d7d15711f0d\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-05 22:00:00', NULL, 1440, '2024-12-06 08:34:25', '2024-12-06 08:34:25', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(70, 153, 154, '82319634969', 'https://us05web.zoom.us/j/82319634969?pwd=gNAcIqzW6nvAVoiiRDXt0BFs7UAk6E.1', '38775', '{\n    \"uuid\": \"Qo3khsAjS4OBT\\/mRS5J63w==\",\n    \"id\": 82319634969,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T01:48:04Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T01:48:04Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/82319634969?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4MjMxOTYzNDk2OSIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6IjZjZmE5MmEwZWUzZjQ1MDY4ZjE0N2EzZGEzYWNjNDMwIiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTY4ODQsImlhdCI6MTczMzQ0OTY4NCwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.Knotw8sKWngJqVze1Q8ZEtVuqxuXrDV-vm1YS9SSR2s\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/82319634969?pwd=gNAcIqzW6nvAVoiiRDXt0BFs7UAk6E.1\",\n    \"password\": \"38775\",\n    \"h323_password\": \"38775\",\n    \"pstn_password\": \"38775\",\n    \"encrypted_password\": \"gNAcIqzW6nvAVoiiRDXt0BFs7UAk6E.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_267302d89dab4b999f4bc5e25b3b4b31\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-05 22:00:00', NULL, 1440, '2024-12-06 08:48:04', '2024-12-06 08:48:04', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL),
(71, 153, 154, '84323034879', 'https://us05web.zoom.us/j/84323034879?pwd=eEdh4wT4C4SFBq71BTbMv4Jtj21LJ1.1', '72925', '{\n    \"uuid\": \"pb7DuftXT7OJYiIolKZ75A==\",\n    \"id\": 84323034879,\n    \"host_id\": \"enhPvnPRTuqhlYc9hOFzBg\",\n    \"host_email\": \"bansarisorathiya74@gmail.com\",\n    \"topic\": \"Zoom Meeting\",\n    \"type\": 2,\n    \"status\": \"waiting\",\n    \"start_time\": \"2024-12-06T01:48:16Z\",\n    \"duration\": 1440,\n    \"timezone\": \"UTC\",\n    \"created_at\": \"2024-12-06T01:48:16Z\",\n    \"start_url\": \"https:\\/\\/us05web.zoom.us\\/s\\/84323034879?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJpc3MiOiJ3ZWIiLCJjbHQiOjAsIm1udW0iOiI4NDMyMzAzNDg3OSIsImF1ZCI6ImNsaWVudHNtIiwidWlkIjoiZW5oUHZuUFJUdXFobFljOWhPRnpCZyIsInppZCI6ImM3MDgzMWY2ZGVhZTQ5MzlhNmQ2NTI0OGE2ZTI4NGI0Iiwic2siOiIyOTkyMTMxNzk3NjUyMTgzMjQ1Iiwic3R5IjoxMDAsIndjZCI6InVzMDUiLCJleHAiOjE3MzM0NTY4OTYsImlhdCI6MTczMzQ0OTY5NiwiYWlkIjoiUnlIdGg5TGdUaS1pUUhZTzZDR0pFQSIsImNpZCI6IiJ9.229U6-0jGCp4xWunp5MNX1it1h5EBKpTZ3WUHY8IP1M\",\n    \"join_url\": \"https:\\/\\/us05web.zoom.us\\/j\\/84323034879?pwd=eEdh4wT4C4SFBq71BTbMv4Jtj21LJ1.1\",\n    \"password\": \"72925\",\n    \"h323_password\": \"72925\",\n    \"pstn_password\": \"72925\",\n    \"encrypted_password\": \"eEdh4wT4C4SFBq71BTbMv4Jtj21LJ1.1\",\n    \"settings\": {\n        \"host_video\": false,\n        \"participant_video\": false,\n        \"cn_meeting\": false,\n        \"in_meeting\": false,\n        \"join_before_host\": false,\n        \"jbh_time\": 0,\n        \"mute_upon_entry\": false,\n        \"watermark\": false,\n        \"use_pmi\": false,\n        \"approval_type\": 2,\n        \"audio\": \"voip\",\n        \"auto_recording\": \"none\",\n        \"enforce_login\": false,\n        \"enforce_login_domains\": \"\",\n        \"alternative_hosts\": \"\",\n        \"alternative_host_update_polls\": false,\n        \"close_registration\": false,\n        \"show_share_button\": false,\n        \"allow_multiple_devices\": false,\n        \"registrants_confirmation_email\": true,\n        \"waiting_room\": false,\n        \"request_permission_to_unmute_participants\": false,\n        \"registrants_email_notification\": true,\n        \"meeting_authentication\": false,\n        \"encryption_type\": \"enhanced_encryption\",\n        \"approved_or_denied_countries_or_regions\": {\n            \"enable\": false\n        },\n        \"breakout_room\": {\n            \"enable\": false\n        },\n        \"internal_meeting\": false,\n        \"continuous_meeting_chat\": {\n            \"enable\": true,\n            \"auto_add_invited_external_users\": false,\n            \"auto_add_meeting_participants\": false,\n            \"channel_id\": \"web_sch_10f1ecff16eb4736912c030a396dae8c\"\n        },\n        \"participant_focused_meeting\": false,\n        \"push_change_to_calendar\": false,\n        \"resources\": [],\n        \"alternative_hosts_email_notification\": true,\n        \"show_join_info\": false,\n        \"device_testing\": false,\n        \"focus_mode\": false,\n        \"meeting_invitees\": [],\n        \"enable_dedicated_group_chat\": true,\n        \"private_meeting\": false,\n        \"email_notification\": true,\n        \"host_save_video_order\": false,\n        \"sign_language_interpretation\": {\n            \"enable\": false\n        },\n        \"email_in_attendee_report\": false\n    },\n    \"supportGoLive\": false,\n    \"creation_source\": \"open_api\",\n    \"pre_schedule\": false\n}', NULL, NULL, '2024-12-05 22:00:00', NULL, 1440, '2024-12-06 08:48:16', '2024-12-06 08:48:16', 'pending', NULL, 0.00, 0.00, 0.00, 0.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `meeting_client`
--

CREATE TABLE `meeting_client` (
  `meeting_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `meeting_reviews`
--

CREATE TABLE `meeting_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `meeting_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','satisfied','complained') NOT NULL DEFAULT 'pending',
  `complaint_text` text DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `message`, `created_at`, `updated_at`) VALUES
(4, 180, 155, 'Hi good evening ! How was your day going today ?', '2024-11-22 03:53:22', '2024-11-22 03:53:22'),
(5, 180, 156, 'Hi good evening ! How was your day going today ?', '2024-11-22 03:54:34', '2024-11-22 03:54:34'),
(6, 180, 156, 'Hi good evening ! How was your day going today ?', '2024-11-22 03:55:22', '2024-11-22 03:55:22'),
(7, 183, 157, 'Hey, I wanna be your friend', '2024-11-22 04:57:13', '2024-11-22 04:57:13'),
(8, 183, 155, 'Hello, I wanna be your friend', '2024-11-22 04:57:40', '2024-11-22 04:57:40'),
(9, 156, 180, 'Hi Eric! I\'m doing well quite busy but productive at the same time', '2024-11-22 07:52:11', '2024-11-22 07:52:11'),
(10, 179, 154, 'sad', '2024-11-29 03:11:11', '2024-11-29 03:11:11');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_05_14_085007_create_personal_access_tokens_table', 1),
(5, '2024_05_15_154546_create_posts_table', 1),
(6, '2024_05_17_062309_create_comments_table', 2),
(7, '2024_05_17_062322_create_likes_table', 2),
(8, '2024_09_25_120111_create_meetings_table', 3),
(9, '2024_09_25_153706_create_meeting_client_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_subscribers`
--

CREATE TABLE `newsletter_subscribers` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `newsletter_subscribers`
--

INSERT INTO `newsletter_subscribers` (`id`, `email`, `confirmed`, `created_at`, `updated_at`) VALUES
(2, 'phoniex199940@gmail.com', 0, '2024-10-15 22:20:05', '2024-10-15 22:20:05'),
(4, 'phoniex1999402@gmail.com', 0, '2024-10-16 05:18:34', '2024-10-16 05:18:34'),
(5, 'abc1@mail.com', 0, '2024-10-17 18:29:40', '2024-10-17 18:29:40'),
(6, 'bccfr22@mail.com', 0, '2024-10-17 18:29:58', '2024-10-17 18:29:58'),
(7, '123a@mail.c', 0, '2024-10-17 19:36:30', '2024-10-17 19:36:30'),
(8, '123a@mai11.c', 0, '2024-10-17 19:36:38', '2024-10-17 19:36:38'),
(9, '123a@mail11.c', 0, '2024-10-17 19:36:48', '2024-10-17 19:36:48'),
(10, '211233223sdnkjsdfgkjfsd@yopmail.com', 0, '2024-10-17 19:37:45', '2024-10-17 19:37:45'),
(11, '1qw2@yopmail.com', 0, '2024-10-17 19:38:40', '2024-10-17 19:38:40'),
(12, 'aa22ss@yopmail.com', 0, '2024-10-17 19:39:55', '2024-10-17 19:39:55'),
(13, 'ddd44@ykl.com', 0, '2024-10-17 19:41:04', '2024-10-17 19:41:04'),
(14, 'goxey26643@gianes.com', 0, '2024-11-05 04:41:42', '2024-11-05 04:41:42'),
(15, 'thuannemunizoliveira@gmail.com', 0, '2024-11-09 01:29:30', '2024-11-09 01:29:30'),
(16, 'angeliquekauffmancawan@gmail.com', 0, '2024-11-14 04:42:49', '2024-11-14 04:42:49'),
(17, 'robinrhughes1@aol.com', 0, '2024-11-17 02:01:28', '2024-11-17 02:01:28'),
(18, 'miradelosr@gmail.com', 0, '2024-11-19 06:59:16', '2024-11-19 06:59:16'),
(19, 'hameddy9@gmail.com', 0, '2024-11-20 15:04:45', '2024-11-20 15:04:45'),
(20, 'magodaluis88@gmail.com', 0, '2024-11-20 15:15:12', '2024-11-20 15:15:12'),
(21, 'parshu1234.asn@gmail.com', 0, '2024-11-20 15:18:02', '2024-11-20 15:18:02'),
(22, 'gs241498@gmail.com', 0, '2024-11-22 08:42:09', '2024-11-22 08:42:09'),
(23, 'kane.jillow@gmail.com', 0, '2024-11-22 13:47:40', '2024-11-22 13:47:40'),
(24, 'arbindodas202@gmail.com', 0, '2024-11-22 13:52:24', '2024-11-22 13:52:24'),
(25, 'barriealphamohamed8@gmail.com', 0, '2024-11-22 17:32:14', '2024-11-22 17:32:14'),
(26, 'papakwesipayin2@yahoo.xom', 0, '2024-11-22 23:35:17', '2024-11-22 23:35:17'),
(27, 'fkubanda29@gmail.com', 0, '2024-11-23 00:30:08', '2024-11-23 00:30:08'),
(28, 'sulymatoheeb@gmail.com', 0, '2024-11-23 01:20:02', '2024-11-23 01:20:02'),
(29, 'melisatayy637@gmail.com', 0, '2024-11-23 01:22:48', '2024-11-23 01:22:48'),
(30, 'mouzumalim@gmail.com', 0, '2024-11-23 01:34:32', '2024-11-23 01:34:32'),
(31, 'ibrahimdream062@gmail.com', 0, '2024-11-23 03:39:03', '2024-11-23 03:39:03'),
(32, 'sarkeraraf33@gmail.com', 0, '2024-11-23 03:39:50', '2024-11-23 03:39:50'),
(33, 'IbrahimTifk@gmail.Com', 0, '2024-11-23 03:57:56', '2024-11-23 03:57:56'),
(34, 'hagerituhussen@gmail.con', 0, '2024-11-23 03:59:04', '2024-11-23 03:59:04'),
(35, 'hagerituhussen@gmail.com', 0, '2024-11-23 03:59:09', '2024-11-23 03:59:09'),
(36, 'jumadibwa350@gmail.com', 0, '2024-11-23 06:11:33', '2024-11-23 06:11:33'),
(37, 'heretaambo@gmail.com', 0, '2024-11-23 08:19:48', '2024-11-23 08:19:48'),
(38, 'twayibusayifullah@gmail.com', 0, '2024-11-23 16:37:59', '2024-11-23 16:37:59'),
(39, 'andreapmbo@gmail.com', 0, '2024-11-29 23:56:11', '2024-11-29 23:56:11'),
(40, 'acusa7372@gmail.com', 0, '2024-12-02 11:22:54', '2024-12-02 11:22:54'),
(41, 'dev@agnieve.com', 0, '2024-12-10 19:30:03', '2024-12-10 19:30:03'),
(42, 'matchmakercamille77@gmail.com', 0, '2024-12-12 12:30:21', '2024-12-12 12:30:21'),
(43, 'kdbrim0000@gmail.com', 0, '2024-12-13 09:36:23', '2024-12-13 09:36:23');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('bexise9604@opposir.com', '$2y$12$eQUmSHwmmLn9RaRXoatPAenmmfZzPfoxtFO9XmeyqgagijREAPxd.', '2024-12-06 03:30:43'),
('bilal.khalid@invozone.dev', '$2y$12$aPhNJ6kc.CJaVaSsCsTXg.WLIg3kqH2/EJ9JEOGHkImL8S0vQ0Jea', '2024-10-18 21:10:08'),
('cftestqa01@gmail.com', '$2y$12$ePpuuk1pq0Z7HjeRAYcHRuatdCCkQ1A5cBvufJC/aLQ11q/qVxtsC', '2024-10-13 14:20:21'),
('ciyoh86320@rustetic.com', '$2y$12$jcMhhCMOn0ccaYNRWPa/IOSdtX0qFZScylFoHwt.yhI/joj9aKNsC', '2024-12-06 07:11:03'),
('client105@yopmail.com', '$2y$12$JWDqZaAtqrc3LqQJfwGNDuRlOCDYO/BmsCUTOXmIFtdiBmmhmRJqK', '2024-10-13 14:19:59'),
('ellasmithhh214@gmail.com', '$2y$12$BwTafQvautbV6K7cPVqsQOdrc7jCVXLQx70wNBSqGmvbOxN5H9lIq', '2024-11-23 01:03:50'),
('lahcenabi90@gmail.com', '$2y$12$MwuExz77EEtrKWikleWdDuo4IsEQfySyShSNI/dblSvRCMgtVuQf.', '2024-11-15 01:28:14'),
('mgr01@yopmail.com', '$2y$12$rmfiUypZe3szjiNhn86K/.6mo9.2heDqvXkxgme1AeBn7MvVmq8Q6', '2024-10-17 19:34:24'),
('palm11@yopmail.com', '$2y$12$oZA.L5NY9m6BJE68LLTApeFjPLndInRlM7edLcsLvE8byQYuDijQe', '2024-10-17 19:33:36'),
('phoniex1999402@gmail.com', '$2y$12$HTvs3dgVhUA1rTFnmNxCZOEFnpnpiS1h1Fyc.AL.7IBmLykrPX8L6', '2024-11-13 06:31:35'),
('pmboandrea@gmail.com', '$2y$12$/79YcREpdVUgoyQTxeLkk.iaIEYnAKktUy2QF/9hSGVPzeQ6kHyQ.', '2024-12-10 23:20:06'),
('robinrhughes1@aol.com', '$2y$12$GLrcRRfndrSZdkXdW0HzMuX/DZCrL8zlgsA3JcLIoGXOsMnBeRSUC', '2024-11-17 02:38:15'),
('sarkeraraf33@gmail.com', '$2y$12$aSN4Naiyl23bqxKfSTq/6urONLY82qOtsur6qVbKdywtHGZ1j1tWG', '2024-11-23 03:40:58');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `featured` int(1) DEFAULT NULL,
  `post_date` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `slug`, `content`, `author_id`, `category_id`, `featured`, `post_date`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Privacy Policy', 'privacy-policy', 'Privacy Policy', 1, 1, NULL, '2024-08-15 16:54:07', NULL, '2024-08-15 09:54:07', '2024-08-15 09:54:07'),
(2, 'Terms of Use Agreement', 'terms-of-use-agreement', 'Terms of Use Agreement', 1, 1, NULL, '2024-08-15 17:54:07', NULL, '2024-08-15 10:54:07', '2024-08-15 10:54:07'),
(3, 'Dating Tips for Busy Professionals', 'dating-tips-for-busy-professionals', '<p><img style=\"width: 50%; float: left;\" class=\"note-float-left\" src=\"/upload/images/tips.png\" data-filename=\"/upload/images/tips.png\" data-caption=\"Dating Tips for Busy Professionals\">Navigating the world of dating can be challenging for anyone, but for busy professionals with packed schedules, finding time to search for love can seem nearly impossible. At Comnectyed, we understand that balancing your career with your personal life requires strategy and effort. Here are some essential tips to help you manage your busy schedule while still making meaningful connections:</p>\n\n<h3>1. Prioritize Your Time</h3>\n\n<p>To successfully integrate dating into your busy life, start by assessing and prioritizing your schedule. Identify pockets of time that you can dedicate to dating activities without overwhelming yourself. Even short, intentional moments can make a difference. Consider setting aside specific days or times each week for dating-related activities, whether it\'s chatting with a matchmaker, going on a date, or simply updating your dating profile.</p>\n\n<h3>2. Leverage Technology</h3>\n\n<p>Take advantage of technology to streamline the dating process. Use dating apps and platforms that allow you to connect with potential matches on the go. At Comnectyed, we offer personalized matchmaking services that are designed to save you time and provide high-quality connections based on your preferences and lifestyle. Embrace these tools to optimize your search for love without disrupting your professional life.</p>\n\n<h3>3. Be Clear About Your Goals</h3>\n\n<p>Communicate your dating goals and expectations upfront with potential matches. Being transparent about your busy schedule and the type of relationship you\'re seeking will help you attract individuals who understand and align with your lifestyle. This approach also ensures that you invest your time in connections that have the potential for meaningful outcomes.</p>\n\n<h3>4. Utilize Efficient Networking</h3>\n\n<p>Make the most of your existing professional and social networks. Attend events and gatherings related to your industry or interests where you can meet like-minded individuals. Sometimes, the best connections come from shared experiences and mutual acquaintances. Your professional environment can be a great place to find someone who understands the demands of a busy career.</p>\n\n<h3>5. Consider Professional Matchmaking</h3>\n\n<p>If managing your dating life feels overwhelming, consider enlisting the help of a professional matchmaker. At Comnectyed, our mission is to streamline the matchmaking process for busy professionals like you. We offer personalized and efficient connections, ensuring that every introduction has the potential to lead to a meaningful relationship. Let us handle the legwork and provide expert guidance tailored to your needs.</p>\n\n<h3>6. Maintain a Balanced Perspective</h3>\n\n<p>Remember that finding love is a journey, not a race. Be patient with yourself and your schedule. Balancing a career and a personal life requires flexibility and understanding, so give yourself grace as you navigate the dating world. Keep a positive attitude and remain open to new possibilities.</p>\n\n<p>Ready to find love while managing your busy schedule? At Comnectyed, we\'re dedicated to helping professionals like you make meaningful connections through expert matchmaking services. Discover how our personalized approach can transform your dating experience. <a href=\"#\">Contact us today</a> to learn more about how we can assist you in finding your perfect match.</p>', 1, 2, 1, '2024-08-15 18:54:07', NULL, '2024-08-15 11:54:07', '2024-08-15 11:54:07'),
(4, 'How to Choose the Right Matchmaker', 'how-to-choose-the-right-matchmaker', '<p><img style=\"width: 50%; float: left;\" class=\"note-float-left\" src=\"/upload/images/howto.png\" data-filename=\"/upload/images/howto.png\" data-caption=\"How to Choose the Right Matchmaker\">Finding the right matchmaker can be a pivotal step in your journey toward a meaningful relationship. With so many options available, it\'s crucial to select a matchmaker who aligns with your personal needs and goals.</p>\n\n<h3>Understand Your Needs</h3>\n\n<p>Before choosing a matchmaker, clarify what you\'re looking for in a relationship and what you expect from the matchmaking process. Are you seeking a serious, long-term relationship, or just someone to connect with on a casual level? Identifying your goals will help you find a matchmaker who specializes in what you’re after.</p>\n\n<h3>Research Their Approach</h3>\n\n<p>Different matchmakers use various approaches to make connections. Some might focus on traditional methods, while others use advanced algorithms or psychological assessments. Look for a matchmaker whose approach resonates with your preferences and values. At Comnectyed, we pride ourselves on a personalized service that goes beyond superficial criteria to match you based on your values and goals.</p>\n\n<h3>Check Their Reputation</h3>\n\n<p>Reputation speaks volumes about a matchmaker\'s effectiveness. Read reviews, ask for testimonials, and check their track record of successful matches. A reputable matchmaker will have positive feedback from clients and a history of helping people find meaningful relationships.</p>\n\n<h3>Evaluate Their Process</h3>\n\n<p>A good matchmaker should have a thorough and thoughtful process. They should take the time to understand your background, preferences, and relationship goals. At Comnectyed, our matchmakers invest time in getting to know you to ensure that every introduction has the potential to lead to something meaningful.</p>\n\n<h3>Assess Communication and Support</h3>\n\n<p>Effective communication and support are key to a successful matchmaking experience. Ensure that the matchmaker is responsive, approachable, and supportive throughout the process. They should be willing to address your concerns and provide guidance at every step.</p>\n\n<h3>Consider Their Professionalism and Confidentiality</h3>\n\n<p>Professionalism and confidentiality are crucial in the matchmaking process. Choose a matchmaker who adheres to high standards of professionalism and respects your privacy. At Comnectyed, we are committed to maintaining the highest levels of confidentiality and professionalism.</p>\n\n<h3>Trust Your Instincts</h3>\n\n<p>Ultimately, trust your instincts when choosing a matchmaker. If something feels off or if you’re not comfortable with the matchmaker’s approach, it’s okay to look elsewhere. The right matchmaker will make you feel at ease and confident in their ability to help you find a meaningful connection.</p>\n\n<h3>Ready to Find Your Perfect Match?</h3>\n\n<p>At Comnectyed, we’re dedicated to streamlining the matchmaking process for busy professionals like you. Our mission is to provide personalized and efficient connections that lead to genuine relationships. With our expert guidance and innovative solutions, you’ll be one step closer to finding meaningful connections that align with your values and goals.</p>\n\n<p>Start your journey with Comnectyed today and let us help you find the love you deserve. <a href=\"#\">Visit our website</a> to learn more and schedule a consultation with one of our expert matchmakers. Your perfect match is just a connection away!</p>', 1, 2, 1, '2024-08-15 19:54:07', NULL, '2024-08-15 12:54:07', '2024-08-15 12:54:07'),
(13, 'Curate Personalized Content:', 'curate-personalized-content:', 'AI can suggest relevant articles, videos, and other content from your blog based on a reader\'s preferences. Let\'s say a reader has shown interest in vegan recipes on your blog; AI tools can identify this pattern. They might then recommend other vegan-related articles or suggest videos demonstrating vegan cooking techniques from your blog. This not only keeps the reader engaged but also enhances their overall experience by providing them with more of what they love.', 1, 2, NULL, '2024-08-17 15:06:47', NULL, '2024-08-17 08:06:47', '2024-08-17 08:06:47'),
(23, 'Paragraph Generator', 'paragraph-generator', 'A Paragraph Generator is an AI-driven writing tool designed to make a writer\'s life easier by generating coherent, well-structured paragraphs on any given topic. These innovative tools create custom content that aligns with the target audience’s preferences and interests, enhancing reader engagement. Here\'s a closer look at how these impressive generators operate:', 1, 2, NULL, '2024-08-19 16:59:51', NULL, '2024-08-19 09:59:51', '2024-08-19 09:59:51'),
(24, 'Providing suggestions for article structure', 'suggestions-for-article-structure', 'Crafting an attention-grabbing headline, Choosing the right subheadings and arranging your content into an interesting story can be tough without help. AI blog post generators come to the rescue by suggesting captivating headlines, relevant subheadings, and even providing an overall structure for your article to ensure maximum readability and engagement. For example, for a post about \'Healthy Eating\', an AI could suggest a headline like \'The Ultimate Guide to Healthy Eating\', with subheadings like \'Benefits of a Balanced Diet\', \'Easy Healthy Recipes\', etc', 1, 2, NULL, '2024-08-18 03:21:49', NULL, '2024-08-17 20:21:49', '2024-08-17 20:21:49'),
(28, 'Generating ideas based on keywords or topic input', 'generating-ideas', 'No more writer\'s block! With an AI blog post generator, all you need to do is input a few keywords or a specific topic. The AI gets to work and generates a list of unique ideas for you to choose from or even construct your entire article around. For example, if you enter \'digital marketing\' as your keyword, the tool might suggest topics like \'The Future of Digital Marketing\' or \'How Digital Marketing affects consumer behavior\'', 1, 2, NULL, '2024-08-18 08:58:51', NULL, '2024-08-18 01:58:51', '2024-08-18 01:58:51');

-- --------------------------------------------------------

--
-- Table structure for table `pre_schedules`
--

CREATE TABLE `pre_schedules` (
  `id` int(11) NOT NULL,
  `token` text DEFAULT NULL,
  `matchmaker_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `schedules` text NOT NULL,
  `timezone` text DEFAULT NULL,
  `start_time` text NOT NULL,
  `end_time` text NOT NULL,
  `duration` int(11) NOT NULL,
  `meeting_response` text DEFAULT NULL,
  `scheduled_by` int(11) NOT NULL,
  `updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `matchmaker_id` bigint(20) UNSIGNED DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `age` int(11) NOT NULL,
  `gender` varchar(25) DEFAULT NULL,
  `bodytype` varchar(50) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `inches` int(11) DEFAULT NULL,
  `haircolor` varchar(50) DEFAULT NULL,
  `maritalstatus` varchar(50) DEFAULT NULL,
  `children` int(11) DEFAULT NULL,
  `religion` varchar(100) DEFAULT NULL,
  `smoker` tinyint(1) DEFAULT NULL,
  `drinker` varchar(20) DEFAULT NULL,
  `education` varchar(100) DEFAULT NULL,
  `yearsexperience` int(11) DEFAULT NULL,
  `jobtitle` varchar(100) DEFAULT NULL,
  `sports` text DEFAULT NULL,
  `hobbies` text DEFAULT NULL,
  `languages` text DEFAULT NULL,
  `english_level` varchar(50) DEFAULT NULL,
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_image1` varchar(255) DEFAULT NULL,
  `profile_image2` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `user_id`, `name`, `matchmaker_id`, `city`, `state`, `country`, `location`, `age`, `gender`, `bodytype`, `height`, `inches`, `haircolor`, `maritalstatus`, `children`, `religion`, `smoker`, `drinker`, `education`, `yearsexperience`, `jobtitle`, `sports`, `hobbies`, `languages`, `english_level`, `bio`, `profile_image1`, `profile_image2`, `created_at`, `updated_at`) VALUES
(1, 1, 'Admin', NULL, 'Kiev', 'Other', 'Ukraine', NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-08 17:23:08', '2024-09-08 19:02:21'),
(33, 41, 'George', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-13 03:45:03', '2024-09-13 03:45:03'),
(35, 43, 'George', NULL, 'San Francisco', 'Other', 'United States of America', NULL, 50, NULL, NULL, 188, 0, 'Black', 'Single', 0, 'Christianity', 0, 'Yes', 'Engineering', NULL, 'CEO', 'Basketball, Football', 'Travel, Arts, Music, Dancing', 'English, Spanish', NULL, NULL, NULL, NULL, '2024-09-13 06:10:59', '2024-09-13 06:36:53'),
(36, 44, 'rebeca', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-13 07:04:16', '2024-09-13 07:04:16'),
(37, 45, 'Ana Paula', NULL, 'São Paulo', 'Other', 'United States of America', 'São Paulo', 27, NULL, NULL, 171, 0, 'Red', 'Single', 0, 'Christianity', 0, 'Yes', 'UNESP', NULL, 'Supply Chain Analyst', 'Running', 'Read', 'Portuguese English', NULL, NULL, NULL, NULL, '2024-09-13 07:20:41', '2024-09-13 07:29:35'),
(38, 46, 'John Subsuban', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-13 23:34:26', '2024-09-13 23:34:26'),
(39, 47, 'Andrea Loraine Gabo', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-13 23:39:56', '2024-09-13 23:39:56'),
(40, 48, 'John Subsuban', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-13 23:40:20', '2024-09-13 23:40:20'),
(41, 49, 'Juls Pansa', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-13 23:57:57', '2024-09-13 23:57:57'),
(42, 50, 'Daisy Enot', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-14 00:00:36', '2024-09-14 00:00:36'),
(43, 51, 'Michelle Feun', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-14 00:13:52', '2024-09-14 00:13:52'),
(44, 52, 'Joy', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-15 00:52:42', '2024-09-15 00:52:42'),
(45, 53, 'Crystal', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-15 02:43:11', '2024-09-15 02:43:11'),
(46, 54, '', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-17 01:32:13', '2024-09-20 02:15:50'),
(48, 56, 'Carolina', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-17 04:06:23', '2024-09-17 04:06:23'),
(51, 59, 'Sikandar', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-23 04:33:09', '2024-09-23 04:33:09'),
(52, 60, 'Carolina Osorno', NULL, '', '', '', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-24 03:14:22', '2024-09-24 03:14:22'),
(53, 61, 'Andre', NULL, 'Bogor', 'Jawa Barat', 'United States of America', 'Bogor', 55, 'Male', NULL, 5, 7, 'Black', 'Single', 0, 'Islam', 0, 'None', 'University', NULL, 'Pilot', 'Rugby', 'Swiming', 'English', NULL, NULL, NULL, NULL, '2024-09-24 11:13:22', '2024-09-24 11:13:22'),
(55, 63, 'efriel', NULL, 'Bogor', 'Jawa Barat', 'United States of America', 'Bogor', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-24 11:31:26', '2024-09-27 08:36:33'),
(56, 64, 'Joy Marie', NULL, 'Cagayan de Oro City', 'Test', 'United States of America', 'Test', 35, 'Female', NULL, 5, 0, 'Black', 'Single', 0, 'Christian', 0, 'None', 'Test', NULL, 'Test', 'Test', 'test', 'test', NULL, NULL, NULL, NULL, '2024-09-24 23:54:46', '2024-09-24 23:54:46'),
(57, 65, 'Carolina Osorno', NULL, 'Bello', 'Antioquia', 'Canada', 'Bello', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-25 04:18:12', '2024-09-25 04:18:12'),
(58, 66, 'Angelique Kauff Mancawan', NULL, 'Naperville', 'Illinois', 'United States of America', 'Naperville, Illinois, USA', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-27 00:21:52', '2024-09-28 01:43:14'),
(61, 70, 'CF Test', NULL, 'CA', 'CA', 'United States of America', 'CA', 30, 'Male', 'Athletic', 5, 11, 'Black', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-13 04:16:32', '2024-10-13 04:16:32'),
(62, 71, 'Match Maker', NULL, 'CA', 'CA', 'United States of America', 'CA', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-13 05:19:51', '2024-10-13 05:19:51'),
(63, 72, 'CF  T', NULL, 'New York', 'New York', 'United States of America', 'New York', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-13 13:04:06', '2024-10-13 13:04:06'),
(64, 73, 'Client Mark', NULL, 'Newyork', 'Newyork', 'United States of America', 'Newyork', 30, 'Male', 'Athletic', 5, 11, 'Brown', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-13 13:43:06', '2024-10-13 13:43:06'),
(65, 74, 'Maker Jack', NULL, 'Newyork', 'Newyork', 'United States of America', 'Newyork', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-13 13:45:30', '2024-10-13 13:45:30'),
(66, 75, 'dsd', NULL, 'Cairo', 'ain shams', 'United States of America', 'Cairo', 2, 'Female', 'Slender', 1, 1, 'ds', 'Single', 0, 'Zoroastrianism', 1, 'Often', 'ds', NULL, 'ds', 'ds', 'ds', 'ds', NULL, NULL, NULL, NULL, '2024-10-16 02:34:32', '2024-10-16 02:34:32'),
(67, 76, 'ds', NULL, 'Cairo', 'ain shams', 'United States of America', 'Cairo', 12, 'Male', 'Slender', 1, 1, '1', 'Single', 0, 'Judaism', 1, 'None', 'f', NULL, 'fds', 'fd', 'fds', 'fd', NULL, NULL, NULL, NULL, '2024-10-16 04:38:24', '2024-10-16 04:38:24'),
(68, 77, 'MG R', NULL, 'Ny', 'NY', 'United States of America', 'NY', 32, 'Male', 'Athletic', 5, 10, 'Black', 'Single', 0, 'Christian', 1, 'Occasionally', 'BA', NULL, 'Consultant', 'Baseball', 'Movies', 'English', NULL, NULL, NULL, NULL, '2024-10-17 00:01:58', '2024-10-17 00:01:58'),
(69, 78, 'TEST One', NULL, 'NY', 'NY', 'United States of America', 'NY', 30, 'Male', 'Athletic', 5, 11, 'Brown', 'Single', 0, 'Christian', 1, 'Occasionally', 'BA', NULL, 'Consultant', 'Baseball', 'Movies', 'English', NULL, NULL, NULL, NULL, '2024-10-17 18:43:23', '2024-10-17 18:43:23'),
(70, 79, 'abc', NULL, 'NY', 'NY', 'United States of America', 'NY', 30, 'Male', 'Average', 5, 10, 'Black', 'Single', 0, 'Buddhism', 0, 'None', 'ba', NULL, 'Consultant', 'Bollyball', 'movie', 'English', NULL, NULL, NULL, NULL, '2024-10-17 19:26:49', '2024-10-17 19:26:49'),
(72, 82, 'Bilal Khalid', NULL, 'Lahore', 'Punjab', 'United States of America', 'Lahore', 31, 'Male', 'Average', 5, 11, 'Black', 'Single', 0, 'Islam', 1, 'None', 'Software Engineer', NULL, 'Senior Software Engineer', 'Cricket', 'Travel', 'English', NULL, NULL, NULL, NULL, '2024-10-18 20:13:23', '2024-10-18 20:13:23'),
(73, 83, 'Sidharth', NULL, 'Gurgaon', 'Haryana', 'Canada', 'Gurgaon', 23, 'Male', 'Slender', 5, 10, 'Brown', 'Single', 0, 'Buddhism', 0, 'None', 'None', NULL, 'None', 'None', 'None', 'English', NULL, NULL, NULL, NULL, '2024-10-21 16:36:13', '2024-10-21 16:36:13'),
(76, 86, 'Teal Bryze', NULL, 'Los Angeles', 'California', 'United States of America', 'Los Angeles', 23, 'Male', 'Average', 5, 11, 'Black', 'Single', 0, 'Christian', 0, 'None', 'Bachelors', NULL, 'Bistro Chef', 'Basketball', 'Writing', 'Native English', NULL, NULL, NULL, NULL, '2024-10-30 13:04:49', '2024-10-30 13:04:49'),
(77, 87, 'Red John', NULL, 'Dover', 'Delaware', 'United States of America', 'Dover', 23, 'Male', 'Average', 6, 1, 'Black', 'Single', 0, 'Christian', 0, 'None', 'Bachelor\'s', NULL, 'Writer', 'Soccer', 'Woodworking', 'Native Enlish', NULL, NULL, NULL, NULL, '2024-10-30 13:11:50', '2024-10-30 13:11:50'),
(86, 96, '', NULL, 'Cairo', 'ain shams', 'United States of America', 'Cairo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-11-08 00:37:38', '2024-11-08 00:37:38'),
(88, 98, 'asdasdsad', NULL, 'Cairo', 'ain shams', 'United States of America', 'Cairo', 2, 'Male', 'Slender', 1, 1, 'dasd', 'Single', 0, 'Catholic', 1, 'None', 'dsa', NULL, 'das', 'dsa', 'dsa', 'das', NULL, NULL, NULL, NULL, '2024-11-08 01:56:40', '2024-11-08 01:56:40'),
(89, 99, 'Thuanne Oliveira', NULL, 'Rio das Ostras, RJ', 'Rio de janeiro', 'Brazil', 'Rio das Ostras, RJ', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-11-09 01:27:28', '2024-11-09 01:27:28'),
(90, 100, 'Lame', NULL, 'marrakech', 'Marrakech', 'Morocco', 'marrakech', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-11-09 02:14:49', '2024-11-09 02:14:49'),
(91, 101, 'Yara', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-11-09 11:12:05', '2024-11-09 11:12:05'),
(92, 102, 'test', NULL, 'Cairo', 'ain shams', 'Egypt', 'Cairo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-11-10 04:12:28', '2024-11-10 04:12:28'),
(106, 144, 'carolina', NULL, 'Bello', 'Antioquia', 'Colombia', 'Bello', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 'Matchmaker here to help others find their spark\r\nWith a passion for connecting people and a knack for understanding what makes relationships work, I\'m here to make dating fun and meaningful for everyone I meet. I\'m a great listener, full of tips, and ready to offer honest insights into the dating world. Let\'s turn first dates into best dates and find those unforgettable connections.', '/storage/profiles/144/a606d290-2e18-4c14-89c4-d8cd1ef3fffc.jpg', NULL, '2024-11-12 09:32:17', '2024-11-12 09:32:17'),
(107, 145, 'Pam H', NULL, 'Ny', 'NY', 'United States', 'NY', 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, 'I am from USA.', '/storage/profiles/145/733e3934-423f-45cf-94a1-0a85b12398e2.jpg', '/storage/profiles/145/820b0322-e5ed-4307-bee3-6d9ef7e06ae1.jpg', '2024-11-12 17:55:01', '2024-11-12 17:55:01'),
(115, 153, 'George is a motherfucker scammer be alert', NULL, 'Cairo', 'ain shams', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'black', 'Single', 0, 'Islam', 0, 'None', 'engineering', NULL, 'machine learning engineer', 'swiming', 'gaming', 'arabic , english', NULL, 'friendly dev for the site', '/storage/upload/images/profiles/153/c1037fca-2fd1-456d-9f84-5677faddc910.jpg', '/storage/upload/images/profiles/153/9393355f-53c1-45f7-aa46-62f0785f25e8.jpg', '2024-11-13 07:02:54', '2024-12-04 15:26:51'),
(116, 154, 'phoenix test matchmaker 2', NULL, 'Cairo', 'ain shams', 'Egypt', 'Cairo', 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, 'matchmaker', NULL, NULL, NULL, NULL, 'testing everything on the site from the shadows..', '/storage/profiles/154/88d2c2cf-e3d5-43f2-843c-26fafeb303e6.jpg', '/storage/upload/images/profiles/154/cdedc613-d340-449b-aa1d-bed93d13bba5.jpg', '2024-11-13 07:09:51', '2024-12-06 00:50:07'),
(117, 155, 'Yulia', NULL, 'Rivne', 'Rivne', 'Ukraine', 'Rivne', 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, 'International Dating and Relationship Matchmaker. I usually work with slavic girls which are open to date with foreign guys.\r\nI use holistic method of work', '/storage/profiles/155/192622c2-29d1-427c-bc58-6794dac4b57b.jpeg', NULL, '2024-11-13 16:11:04', '2024-11-13 16:11:04'),
(118, 156, 'Angelique Kauff Mancawan', NULL, 'CAGAYAN DE ORO CITY', 'Misamis Oriental', 'Philippines', 'CAGAYAN DE ORO CITY', 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 'I\'m an experienced dating assistant who knows the ins and outs of online dating. My aim is straightforward: to assist clients in finding genuine connections. With a practical approach and a focus on tangible results, I\'ve guided numerous clients toward their desired goals in dating.\r\n\r\nSkills:\r\n- Proficiency across various dating platforms: Tinder, Bumble, Hinge, Coffee Meets Bagel, Seeking.com, Match, Muslima, OkCupid, Twinby, Pure, VK, and The League\r\n- Expert in creating engaging profiles\r\n- Skilled in starting and maintaining conversations\r\n- Track record of successfully arranging dates for clients\r\n- Strong attention to detail and understanding of individual preferences\r\n- Dedication to improving the dating experience\r\n- Commitment to helping clients navigate modern dating with confidence and ease', '/storage/profiles/156/9920e3e3-43fc-48c4-b031-1a4d978c1d37.jpg', NULL, '2024-11-14 04:40:36', '2024-11-14 04:40:36'),
(119, 157, 'Thuanne', NULL, 'Rio das Ostras', 'Rio das Ostras', 'Brazil', 'Rio das Ostras', 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'Matchmaker', NULL, NULL, NULL, NULL, 'Connecting people around the globe through the power of communication', '/storage/profiles/157/02fa5d96-34fe-4e94-af58-c984cec6cb22.jpg', NULL, '2024-11-14 04:48:23', '2024-11-14 04:51:47'),
(120, 158, 'abi', NULL, 'marrakech', 'Marrakech asfi', 'Morocco', 'marrakech', 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 'Travel Assistance: Virtual guiding and travel planning', '/storage/profiles/158/460bcc06-117a-4d80-84d8-6660979fb2ab.jpg', '/storage/profiles/158/464de3e8-8c14-4fc7-9dba-ec9cdaf4363f.jpg', '2024-11-15 01:19:53', '2024-11-15 01:19:53'),
(121, 160, 'suraj', NULL, 'lucknow', 'UP', 'India', 'lko', 25, 'Male', 'Average', 5, 5, 'black', 'Single', 0, 'Hinduism', 0, 'None', 'jame', NULL, 'james', '12122', 'ddskdjk', 'english', NULL, NULL, NULL, NULL, '2024-11-16 16:33:01', '2024-11-16 16:33:01'),
(122, 161, 'Robin Hughes', NULL, 'Altadena', 'CA', 'United States', 'Altadena', 62, 'Female', 'Curvy', 5, 7, 'Black', 'Divorced', 1, 'Christian', 0, 'Occasionally', 'Masters', NULL, 'President and CEO', 'None', 'Exploring the world.', 'No others', NULL, NULL, NULL, NULL, '2024-11-17 01:55:08', '2024-11-17 01:55:08'),
(123, 162, 'Aut maiores aut cons', NULL, 'Lahore', 'Lahore', 'Pakistan', 'Lahore', 40, 'Male', 'Average', 5, 10, 'Black', 'Single', 0, 'Islam', 0, 'None', 'Sed molestias vero u', NULL, 'Laboris distinctio', 'Laboris vel incididu', 'Excepteur reprehende', 'In necessitatibus co', NULL, NULL, NULL, NULL, '2024-11-18 16:41:11', '2024-11-18 16:41:11'),
(124, 163, 'Michelle L. Alas', NULL, 'cagayan de oro city', 'Misamis Oriental', 'Philippines', 'Cagayan de Oro', 23, 'Female', 'Curvy', 5, 5, 'Black', 'Single', 0, 'Catholic', 0, 'Occasionally', 'Bachelor of Science in Nursing', NULL, 'Nurse', 'Volleyball', 'Playing video games, reading books, running', 'Tagalog', NULL, NULL, '/storage/upload/images/profiles/163/3b61bae5-4903-4c7c-9c69-0163526563a7.jpg', NULL, '2024-11-19 00:09:15', '2024-11-19 00:13:40'),
(125, 164, 'Mary', NULL, 'Cebu', 'Province of cebu', 'Philippines', 'Cebu', 23, 'Female', 'Average', 5, 5, 'Black', 'Single', 0, 'Catholic', 0, 'None', 'Psychology Graduate', NULL, 'Counselor', 'Badminton', 'Badminton', '3', NULL, NULL, NULL, NULL, '2024-11-19 07:14:40', '2024-11-19 07:14:40'),
(126, 165, 'Abi', NULL, 'marrakech', 'marrakech', 'Morocco', 'marrakech', 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 'I will add it later', '/storage/profiles/165/2da24f7d-fa94-445d-894c-3e72c987f3d7.jpg', '/storage/profiles/165/babcdeb8-7097-43be-800b-9aba7d5965c6.jpg', '2024-11-20 01:10:04', '2024-11-20 01:10:04'),
(127, 167, 'Yasmin', NULL, 'Atlanta', 'Ga', 'United States', 'Atlanta', 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, 'Experienced matchmaker specializing in long term relationships and marriage. Let me set you up and show you how to find matches organically.', '/storage/profiles/167/1fa646ec-4634-41e6-8bb2-267178af2c73.jpg', NULL, '2024-11-20 07:50:35', '2024-11-20 07:54:42'),
(128, 168, 'Ariel Francis Fernando Gacilo', NULL, 'Makati', 'Manila', 'Philippines', 'Rizal Makati', 33, 'Male', 'Average', 5, 5, 'Black', 'Married', 1, 'Catholic', 0, 'Occasionally', 'Bachelor', NULL, 'Full Stack Developer', 'Playing Dota 2', 'Playing Guitar', 'English', NULL, NULL, NULL, NULL, '2024-11-20 13:24:27', '2024-11-20 13:24:27'),
(129, 174, 'Becky', NULL, 'Kalamazoo', 'Michigan', 'United States', 'Kalamazoo', 30, 'Female', 'Average', 5, 4, 'Blonde', 'Single', 0, 'Christian', 0, 'Occasionally', 'College', NULL, 'Carer', 'Soceer', 'Reading', 'English', NULL, NULL, NULL, NULL, '2024-11-20 15:35:07', '2024-11-20 15:35:07'),
(130, 175, 'Ahmed Khaled', 154, 'Cairo', 'ain shams', 'Egypt', NULL, 25, NULL, 'Slender', 6, 1, NULL, 'Single', 0, 'Islam', 1, 'None', 'engineering', NULL, 'machine learning engineering', 'swiming', 'gaming', 'arabic', 'Proficient', NULL, 'clients/avatars/P6v5ACsbgAJmkRqk9tjp6EtuMnwQosQIte7p83dC.jpg', NULL, '2024-11-20 23:52:01', '2024-11-20 23:52:01'),
(131, 176, 'Rose Aguiar', 157, 'Rio das Ostras', 'Rio de Janeiro', 'Brazil', NULL, 37, NULL, 'Curvy', 5, 1, NULL, 'Divorced', 1, 'Christian', 0, 'None', 'stheticitian', NULL, 'Hairdresser', 'none', 'manicure, hairdresser, travel, quality time with family', 'portuguese (native) english (beginner)', 'Beginner', NULL, 'clients/avatars/6JaTSEicjabZltHjoXyV3Wb1SCWWTW058T0b2K7v.jpg', NULL, '2024-11-21 00:11:41', '2024-11-21 00:11:41'),
(132, 177, 'Rebecca', NULL, 'Cagayan de Oro', 'Misamis Oriental', 'Philippines', 'Cagayan de Oro City', 22, 'Female', 'Average', 5, 3, 'Brown/Black', 'Single', 0, 'Christian', 0, 'Occasionally', 'College level', NULL, 'N/A', 'Volleyball', 'Loves to listen to music, surf the internet', 'Filipino, Cebuano', NULL, NULL, NULL, NULL, '2024-11-21 07:41:43', '2024-11-21 07:41:43'),
(133, 178, 'Rebecca', NULL, 'Cagayan de Oro City', 'Misamis Oriental', 'Philippines', 'Cagayan de Oro City', 22, 'Female', 'Average', 5, 3, 'Brown/Black', 'Single', 0, 'Christian', 0, 'Occasionally', 'Undergraduate degree', NULL, 'N/A', 'Volleyball', 'Surf the internet & watch movie', 'Filipino, cebuano', NULL, NULL, NULL, NULL, '2024-11-21 07:52:09', '2024-11-21 07:52:09'),
(134, 179, 'test clients', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'black', 'Single', 0, 'Islam', 0, 'None', 'engineering', NULL, 'engineering', 'swiming', 'gaming', 'arabic', NULL, NULL, NULL, NULL, '2024-11-21 21:34:13', '2024-11-21 21:34:13'),
(135, 180, 'Eric', NULL, 'New York', 'New York', 'United States', 'New York', 52, 'Male', 'Average', 4, 4, 'Black', 'Separated', 1, 'Christian', 0, 'Occasionally', 'University', NULL, 'Navy', 'Rugby', 'Baseball', 'English', NULL, NULL, '/storage/upload/images/profiles/180/28803a06-60a0-41ee-8bb4-6760c90cbaac.jpeg', NULL, '2024-11-22 03:16:22', '2024-11-22 03:44:48'),
(136, 183, 'Bwambale praise', NULL, 'Kampala', 'Kasubi', 'Uganda', 'Kampala', 20, 'Male', 'Average', 3, 5, 'Black', 'Single', 0, 'Other', 0, 'None', 'High school', NULL, 'Peasant', 'Football', 'Watching, listening to music', 'English', NULL, NULL, NULL, NULL, '2024-11-22 04:52:53', '2024-11-22 04:52:53'),
(137, 184, 'Mary De los reyes', NULL, 'cebu city', 'Cebu', 'Philippines', 'Cagayan de Oro City', 23, 'Female', 'Average', 5, 5, 'Black', 'Single', 0, 'Christian', 0, 'None', 'College graduate', NULL, 'None', 'Tennis', 'Running', '3', NULL, NULL, NULL, NULL, '2024-11-22 07:40:59', '2024-11-22 07:40:59'),
(138, 185, 'Arhan', NULL, 'Delhi', 'Delhi', 'India', 'Delhi', 35, 'Male', 'Average', 5, 9, 'Brown', 'Divorced', 0, 'Other', 0, 'Occasionally', 'Graduate', NULL, 'Self employed', 'None', 'None', 'Hindi', NULL, NULL, NULL, NULL, '2024-11-22 09:36:50', '2024-11-22 09:36:50'),
(139, 186, 'Prince Singh', NULL, 'Bemetara', 'Chhattisgarh', 'India', 'Bemetara', 22, 'Male', 'Slender', 5, 9, 'BlackBlack', 'Single', 0, 'Hinduism', 0, 'None', 'College', NULL, 'Business', 'Football', 'Bike riding', 'Hindi', NULL, NULL, NULL, NULL, '2024-11-22 11:43:50', '2024-11-22 11:43:50'),
(140, 187, 'govind', NULL, 'dhule', 'maharashtra', 'India', 'dhule', 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'simple boy', '/storage/profiles/187/e7bb45fb-238a-4861-b36d-6e69a04360ff.jpg', NULL, '2024-11-22 15:13:04', '2024-11-22 15:13:04'),
(141, 189, 'rey', NULL, 'jounieh', 'keserwan', 'Lebanon', 'haret sakher', 20, 'Male', 'Athletic', 6, 5, 'brunette', 'Single', 0, 'Christian', 0, 'Occasionally', 'university', NULL, 'business owner', 'swimming', 'football', 'arabic french english german', NULL, NULL, NULL, NULL, '2024-11-22 16:06:23', '2024-11-22 16:06:23'),
(142, 190, 'Dipak', NULL, 'Nashik', 'Maharashtra', 'India', 'Nashik', 34, 'Male', 'Average', 5, 6, 'Black', 'Single', 0, 'Hinduism', 0, 'Occasionally', 'Graduate', NULL, 'Business', 'Football', 'Swimming', 'Hindi', NULL, NULL, NULL, NULL, '2024-11-22 21:26:06', '2024-11-22 21:26:06'),
(143, 192, 'Brian', NULL, 'Ndola', 'central province', 'Zambia', 'Ndola', 20, 'Male', 'Slender', 5, 2, 'Black', 'Single', 0, 'Catholic', 0, 'None', 'College', NULL, 'Engineer', 'Football', 'Basketball', 'Bemba', NULL, NULL, NULL, NULL, '2024-11-22 21:59:00', '2024-11-22 21:59:00'),
(144, 193, 'Fareed', NULL, 'Tanga', 'Tanga mjini', 'Tanzania', 'Tanga', 23, 'Male', 'Average', 5, 7, 'Black', 'Single', 0, 'Islam', 0, 'None', 'Secondary', NULL, 'Electrician', 'Football', 'Movie', 'Kiswahili', NULL, NULL, NULL, NULL, '2024-11-23 00:30:16', '2024-11-23 00:30:16'),
(145, 200, 'Ella smith', NULL, 'Miami', 'Florida', 'United States', 'Chicago', 31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 'Naughty', '/storage/profiles/200/bcaf92f5-602a-4578-b51f-e893b61c2a35.jpg', '/storage/profiles/200/90f3cca7-6ef3-4ff9-bca9-59d810cd24c0.jpg', '2024-11-23 01:00:43', '2024-11-23 01:00:43'),
(146, 206, 'Araf Sarker', NULL, 'Dhaka', 'Uttara', 'Bangladesh', 'Uttara 11', 21, 'Female', 'Average', 6, 1, 'Black brown', 'Single', 0, 'Islam', 0, 'Occasionally', 'HSC23', NULL, 'Nothing', 'Esports', 'Playing PUBG', 'Bangla, English', NULL, NULL, NULL, NULL, '2024-11-23 03:38:57', '2024-11-23 03:38:57'),
(147, 209, 'Ibrahim', NULL, 'Sebata', 'oromiya', 'Ethiopia', 'Alemegena', 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 'thanks Lord', '/storage/profiles/209/8de4062c-0653-4a09-8cb2-0ed178b7ae7f.jpg', '/storage/profiles/209/16d213e3-8aa3-432e-87d1-fe3a4512e99c.jpg', '2024-11-23 03:44:22', '2024-11-23 03:44:22'),
(148, 213, 'Ibrahim', NULL, 'sebeta', 'Oromiya', 'Ethiopia', 'Alemegena', 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 'live is past live present', '/storage/profiles/213/ecd26848-904c-4a65-9478-018a19be7016.jpg', '/storage/profiles/213/f9738d22-79f2-4992-b8e0-37b822a61515.jpg', '2024-11-23 03:52:23', '2024-11-23 03:52:23'),
(149, 219, 'Pela', NULL, 'Limbe', 'Limbe', 'Cameroon', 'Limbe', 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 'I\'m a mother of 1 child and I am 22 years old', '/storage/profiles/219/574cfc37-883a-47c2-8499-916d6ee733ff.png', '/storage/profiles/219/bd732ba5-278a-4cfc-90b0-8bacf56ca934.png', '2024-11-23 08:18:23', '2024-11-23 08:18:23'),
(150, 220, 'Francey', NULL, 'Dar es salam', 'Mbinga', 'Tanzania', 'Songea', 25, 'Male', 'Average', 5, 8, 'Black', 'Single', 0, 'Catholic', 0, 'None', 'Form 6', NULL, 'Soldier', 'football', 'Play football', 'English', NULL, NULL, NULL, NULL, '2024-11-23 13:04:35', '2024-11-23 13:04:35'),
(151, 221, 'Fritz Gerald', NULL, 'Lapu-Lapu', 'Cebu', 'Philippines', 'Marigondon, Lapu-Lapu City', 26, 'Male', 'Curvy', 5, 5, 'Black', 'Single', 0, 'Catholic', 0, 'Occasionally', 'Bachelor of Science in Information Technology', NULL, 'Full Stack Developer', 'eSports', 'Coding and Gaming', 'English', NULL, NULL, NULL, NULL, '2024-11-28 10:55:57', '2024-11-28 10:55:57'),
(152, 222, 'ruhan', NULL, 'Surat', 'Surat', 'India', 'Surat', 20, 'Male', 'Average', 3, 4, 'Black', 'Separated', 1, 'Taoism', 0, 'None', 'fdg', NULL, 'gfdg', 'gdf', 'gdf', 'dfgd', NULL, NULL, NULL, NULL, '2024-11-28 13:07:10', '2024-11-28 13:07:10'),
(153, 223, 'Andrea', NULL, 'Medellin', 'Antioquia', 'Colombia', 'Medellin', 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 'I\'m new to the world of matchmaking, but I have great communication skills and love connecting people in relationships.', '/storage/profiles/223/9fb1c910-22cc-46b3-9180-95adc5e05939.jpg', '/storage/profiles/223/e1a8f39f-454a-4fc9-b55b-45bcc4f684e2.jpg', '2024-11-29 23:50:42', '2024-11-29 23:50:42'),
(154, 224, 'test', NULL, 'wqe', 'qwe', 'Afghanistan', 'ewq', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, 'hello', '/storage/profiles/224/67b83e1e-a5e4-4af7-8e6c-44bee186522e.png', NULL, '2024-12-03 14:26:58', '2024-12-03 14:26:58'),
(155, 226, 'test', NULL, 'das', 'dsa', 'Belgium', 'dddddddddddddddddd', 45, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, 'fsfd', '/storage/profiles/226/0a1b6d1b-5602-47a0-b505-c8c00c6f572f.png', NULL, '2024-12-03 14:32:31', '2024-12-03 14:32:31'),
(156, 227, 'Sophie', 157, 'Los Angeles', 'California', 'United States', NULL, 21, NULL, 'Athletic', 5, 3, NULL, 'Single', 0, 'Other', 0, 'Occasionally', 'College', NULL, 'n/a', 'n/a', 'n/a', 'english', 'Proficient', NULL, 'clients/avatars/KCak9YsvtQzMaqhAgAL0BnFAVk66czEmOfddYtUJ.jpg', NULL, '2024-12-03 22:03:28', '2024-12-03 22:03:28'),
(157, 228, 'Diana Wadie', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'Hello,\r\nI will your assistance in the process of finding your best fit. I got wide experience in communication between different culture.', '/storage/profiles/228/e4e7a3df-a81b-4fdc-9569-6b9cce29d85a.jpg', NULL, '2024-12-04 01:46:18', '2024-12-04 01:46:18'),
(158, 236, 'Andrea Acuña', NULL, 'Guapiles', 'Limon', 'Costa Rica', 'Guapiles', 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 'I\'m from Costa Rica, I\'m a professional nurse, 2 years ago after entering a partner search page, I met my husband through a partner search application, we had 2 years of courtship and this year we got married, he is American and I from Costa Rica, love breaks any barrier, for example he speaks English and understands little Spanish and I speak Spanish but I speak basic English, even so we understand each other and communicate well', '/storage/profiles/236/0e308e0f-d9c3-4fe8-9048-78bd949718a4.jpeg', NULL, '2024-12-04 13:43:35', '2024-12-04 13:43:35'),
(159, 237, 'Antarjot Kaur', 157, 'Montreal', 'Montreal', 'Canada', NULL, 33, NULL, 'Curvy', 5, 2, NULL, 'Single', 0, 'Other', 0, 'Occasionally', 'n/a', NULL, 'n/a', 'n/a', 'n/a', 'english, franch, arabic', 'Proficient', NULL, 'clients/avatars/ADMKeMQgJebYfa482zobwg3771jD6EbF9ZjZ7Ht5.jpg', NULL, '2024-12-05 00:31:16', '2024-12-05 00:31:16'),
(160, 238, 'adsasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'sdasd', 'Single', 0, 'Buddhism', 0, 'None', 'asdas', NULL, 'asdas', 'dasdasd', 'asdasd', 'asdasd', NULL, NULL, NULL, NULL, '2024-12-06 03:32:30', '2024-12-06 03:32:30'),
(161, 239, 'adsasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'sdasd', 'Single', 0, 'Buddhism', 0, 'None', 'asdas', NULL, 'asdas', 'dasdasd', 'asdasd', 'asdasd', NULL, NULL, NULL, NULL, '2024-12-06 03:38:16', '2024-12-06 03:38:16'),
(162, 240, 'adsasdasda', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'dasdas', 'Single', 0, 'Buddhism', 0, 'None', 'asdasd', NULL, 'asdas', 'dasdasd', 'asdasd', 'asdasd', NULL, NULL, NULL, NULL, '2024-12-06 03:43:42', '2024-12-06 03:43:42'),
(163, 241, 'dasdasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'adasd', 'Single', 0, 'Buddhism', 0, 'None', 'asdasd', NULL, 'asdasdas', 'dsadas', 'dasdas', 'dasdasd', NULL, NULL, NULL, NULL, '2024-12-06 03:52:49', '2024-12-06 03:52:49'),
(164, 242, 'dasdasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'adasd', 'Single', 0, 'Buddhism', 0, 'None', 'asdasd', NULL, 'asdasdas', 'dsadas', 'dasdas', 'dasdasd', NULL, NULL, NULL, NULL, '2024-12-06 03:53:21', '2024-12-06 03:53:21'),
(165, 243, 'dasdasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'adasd', 'Single', 0, 'Buddhism', 0, 'None', 'asdasd', NULL, 'asdasdas', 'dsadas', 'dasdas', 'dasdasd', NULL, NULL, NULL, NULL, '2024-12-06 04:00:11', '2024-12-06 04:00:11'),
(166, 244, 'fasddasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'sdfsdf', 'Single', 0, 'Buddhism', 0, 'None', 'asdasd', NULL, 'sad', 'asdasd', 'sadasd', 'asd', NULL, NULL, NULL, NULL, '2024-12-06 04:09:51', '2024-12-06 04:09:51'),
(167, 245, 'fasddasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'sdfsdf', 'Single', 0, 'Buddhism', 0, 'None', 'asdasd', NULL, 'sad', 'asdasd', 'sadasd', 'asd', NULL, NULL, NULL, NULL, '2024-12-06 04:10:56', '2024-12-06 04:10:56'),
(168, 246, 'fasddasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'sdfsdf', 'Single', 0, 'Buddhism', 0, 'None', 'asdasd', NULL, 'sad', 'asdasd', 'sadasd', 'asd', NULL, NULL, NULL, NULL, '2024-12-06 04:21:36', '2024-12-06 04:21:36'),
(169, 247, 'fasddasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'sdfsdf', 'Single', 0, 'Buddhism', 0, 'None', 'asdasd', NULL, 'sad', 'asdasd', 'sadasd', 'asd', NULL, NULL, NULL, NULL, '2024-12-06 04:22:01', '2024-12-06 04:22:01'),
(170, 248, 'fasddasdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'sdfsdf', 'Single', 0, 'Buddhism', 0, 'None', 'asdasd', NULL, 'sad', 'asdasd', 'sadasd', 'asd', NULL, NULL, NULL, NULL, '2024-12-06 04:24:43', '2024-12-06 04:24:43'),
(171, 249, 'afadasd', NULL, 'Cairo', 'ain shams', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'asdsa', 'Single', 1, 'Buddhism', 0, 'None', 'asd', NULL, 'sad', 'sad', 'asd', 'asd', NULL, NULL, NULL, NULL, '2024-12-06 06:53:58', '2024-12-06 06:53:58'),
(172, 250, 'asdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'sadasd', 'Separated', 1, 'Buddhism', 0, 'None', 'asd', NULL, 'sad', 'asd', 'asd', 'asd', NULL, NULL, NULL, NULL, '2024-12-06 07:16:25', '2024-12-06 07:16:25'),
(173, 251, 'Gabriel Souza', NULL, 'Brazil', 'Brazil', 'Brazil', 'brazil', 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, 'TEST', '/storage/profiles/251/cb189c96-e25a-40ad-b2d7-226b2e9f06aa.jpeg', '/storage/profiles/251/8f5f44ef-9641-4af4-a570-9da189408798.jpeg', '2024-12-08 05:34:17', '2024-12-08 05:34:17'),
(174, 252, 'Michelle Alas', 156, 'CAGAYAN DE ORO CITY', 'misamis oriental', 'Philippines', NULL, 23, NULL, 'Curvy', 5, 4, NULL, 'Single', 0, 'Catholic', 0, 'Often', 'Nursing', NULL, 'Virtual Assistant', 'Volleyball', 'Reading books', 'English', 'Proficient', NULL, 'clients/avatars/nvq6LwLi9zcvM4SkuGuRcZXnYsNOa80gZYs6McSC.jpg', NULL, '2024-12-09 00:07:26', '2024-12-09 00:07:26'),
(175, 253, 'Sameh Magdy Fathi', NULL, 'Ain-Shams', 'Cairo', 'Egypt', 'Cairo', 23, 'Male', 'Curvy', 5, 8, 'Black', 'Single', 0, 'Christian', 0, 'None', 'Faculty of law at sadat city university', NULL, 'Network planner', 'Chess, E-Sports', 'Video-games', 'Arabic, English', NULL, NULL, NULL, NULL, '2024-12-09 00:49:15', '2024-12-09 00:49:15'),
(176, 254, 'sadasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'asdasd', 'Single', 0, 'Buddhism', 0, 'None', 'addasd', NULL, 'asda', 'sdasd', 'sadasd', 'asdasd', NULL, NULL, NULL, NULL, '2024-12-09 02:46:48', '2024-12-09 02:46:48'),
(177, 255, 'AG', NULL, 'Digos City', 'Dava del Sur', 'Philippines', 'Digos City', 27, 'Male', 'Average', 5, 2, 'Black', 'Single', 0, 'Christian', 0, 'None', 'Bachelors of Science in Information Technology', NULL, 'Developer', 'Chess', 'Playing Games', 'English', NULL, 'test', NULL, NULL, '2024-12-09 12:16:36', '2024-12-11 04:27:47'),
(178, 256, 'Annie', NULL, 'Vancouver', 'British Columbia', 'Canada', 'Vancouver', 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 'I am passionate about nurturing and building genuine relationships and helping other people find their matches. As a psychology enthusiast and certified coach with professional experience in diverse industries spanning post-secondary/graduate education, entertainment, and online media, I am happy to leverage my communication skills, creative thinking, and strategic growth mindset to scout the right partners for my clients.', '/storage/profiles/256/7365a9de-f060-46b1-90ba-266afdba6d5a.JPG', NULL, '2024-12-09 13:00:32', '2024-12-09 13:00:32'),
(179, 257, 'Rahul gazi', NULL, 'Kolkata', 'West Bengal', 'India', 'Basirhat', 28, 'Male', 'Average', 5, 5, 'Black', 'Single', 0, 'Islam', 0, 'Often', 'Graduate', NULL, 'Office work', 'Cricket', 'Playing', 'Bengali, hindi, english', NULL, NULL, NULL, NULL, '2024-12-09 18:46:23', '2024-12-09 18:46:23'),
(180, 258, 'Carla Silva', NULL, 'Juiz de Fora', 'Minas Gerais', 'Brazil', 'Juiz de Fora', 46, 'Female', 'Curvy', 4, 2, 'preto', 'Single', 0, 'Catholic', 0, 'Occasionally', 'High school', NULL, 'Unemployed', 'Run in the park', 'go to the cinema', 'Portuguese', NULL, NULL, NULL, NULL, '2024-12-10 02:03:59', '2024-12-10 02:03:59'),
(181, 261, 'Alisson rivera', NULL, 'Perez Zeledon', 'San Isidro del general', 'Costa Rica', 'Perez zeledon', 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'I live in Costa Rica , I am trilingual, and I love to travel to different countries and places.', '/storage/profiles/261/c99eaa7b-39c0-41ac-a261-a0bd87ea4a7a.jpeg', NULL, '2024-12-10 04:15:56', '2024-12-10 04:15:56'),
(182, 262, 'Sasha', NULL, 'Hamilton', 'Hamilton', 'Canada', 'Hamilton', 42, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 'I am passionate about Love and about helping others find it. \r\nI love connecting with new people and finding out about their life and what makes them tick. I cannot wait to help you on your matchmaking journey.', '/storage/profiles/262/5843d6e6-49c3-4860-862a-21eb637c53eb.jpg', '/storage/profiles/262/810d1a99-7ea3-42ca-aca8-1d3c1fc538d3.jpg', '2024-12-10 05:03:17', '2024-12-10 05:03:17'),
(183, 263, 'Carla Silva', NULL, 'Juiz de Fora', 'Juiz de Fora', 'Brazil', 'Juiz de Fora', 46, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'Sou uma nova  matchmaking, mas tenho ótimas habilidades de comunicação, extrovertida, bem humorada e adoro conectar pessoas.', '/storage/profiles/263/c020b60f-4cc6-48ad-a5fd-25540d633b53.jpg', '/storage/profiles/263/c17c50bd-2511-48a5-8415-ab113b2fadb7.jpg', '2024-12-10 16:09:05', '2024-12-10 16:09:05'),
(184, 264, 'Gwyn', NULL, 'Cagayan de Oro', 'Mindanao', 'Philippines', 'Cagayan de Oro', 21, 'Female', 'Curvy', 5, 0, 'Black/dark brown', 'Single', 0, 'Christian', 0, 'Occasionally', 'College Student', NULL, 'n/a', 'n/a', 'n/a', 'Filipino, English', NULL, NULL, NULL, NULL, '2024-12-10 22:24:29', '2024-12-10 22:24:29'),
(185, 265, 'Gwyn', NULL, 'Cagayan de Oro', 'Mindanao', 'Philippines', 'Cagayan de Oro', 21, 'Female', 'Curvy', 5, 0, 'Balck/ dark brown', 'Single', 0, 'Catholic', 0, 'Occasionally', 'College student', NULL, 'n/a', 'n/a', 'n/a', 'Filipino, English', NULL, NULL, '/storage/upload/images/profiles/265/092d830b-785d-4f2c-8981-ddc45a8cbd3a.jpeg', NULL, '2024-12-10 22:29:02', '2024-12-10 23:19:45'),
(186, 266, 'Ry Bala', 156, 'Ozamiz City', 'Misamis Occidental', 'Philippines', NULL, 23, NULL, 'Average', 5, 5, NULL, 'Single', 0, 'Catholic', 0, 'Occasionally', 'Bachelor\'s Degree', NULL, 'Registered Nurse', 'Swimming', 'Playing video games', 'English, Tagalog', 'Proficient', NULL, 'clients/avatars/SqcKp80ZBD2Msv2uURzPHKQphidKeoNfIFYOFtvl.jpg', NULL, '2024-12-10 23:18:03', '2024-12-10 23:18:03'),
(187, 267, 'Becca', 156, 'Gusa', 'Misamis Oriental', 'Philippines', NULL, 22, NULL, 'Athletic', 5, 2, NULL, 'Single', 0, 'Christian', 0, 'Often', 'Bachelor\'s Degree', NULL, 'Engineer', 'Volleyball', 'Golf', 'English', 'Proficient', NULL, 'clients/avatars/vCAaUtCO3ubIL8Hb12FypyRXaImrYkcF5FQuFNl1.jpg', NULL, '2024-12-10 23:27:11', '2024-12-10 23:27:11'),
(188, 268, 'Mary Delos Reyes', 156, 'Bugo', 'Misamis Oriental', 'Philippines', NULL, 23, NULL, 'Athletic', 5, 0, NULL, 'Single', 0, 'Catholic', 0, 'Often', 'Bachelor\'s Degree', NULL, 'Psychology', 'Badminton', 'Playing video games', 'English', 'Proficient', NULL, 'clients/avatars/D4WHUBmjxQmzRNFRLdEewiiiXZUYTPEOvASSt7KW.jpg', NULL, '2024-12-10 23:36:06', '2024-12-10 23:36:06'),
(189, 269, 'Keyo Jimenez', 156, 'Ozamis City', 'Misamis Occidental', 'Philippines', NULL, 22, NULL, 'Average', 5, 0, NULL, 'Single', 0, 'Catholic', 0, 'Occasionally', 'Bachelor\'s Degree', NULL, 'Registered Nurse', 'Tennis, Table Tennis', 'Playing video games', 'English, Tagalog', 'Proficient', NULL, 'clients/avatars/sJk1OolEmm1rFbQ4xdLVR57CxB0WHmPlzTRNW5tK.jpg', NULL, '2024-12-10 23:50:41', '2024-12-10 23:50:41'),
(190, 270, 'Test Match Maker', NULL, 'Digos City', 'Digos City', 'Philippines', 'Digos City', 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 'test', '/storage/profiles/270/db236db9-76e2-4c6a-a6b8-a78f8813a436.png', '/storage/profiles/270/b4ad104e-7ac3-4daf-bac2-3fcd0a828cc9.png', '2024-12-12 03:54:21', '2024-12-12 03:54:21'),
(191, 271, 'Geovana da Silva Rodrigues', NULL, 'Volta Redonda', 'Rio de Janeiro', 'Brazil', 'Volta Redonda', 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'Although I’m new to the field of relationship matchmaking, I am genuinely excited to start learning and contributing. I believe in the power of meaningful connections and am eager to apply my skills in understanding people to help others find their perfect match. I\'m committed to growing in this field, and I look forward to gaining experience while helping clients build lasting relationships.', '/storage/profiles/271/784c375f-7256-431d-afbd-80d679468115.jpg', '/storage/profiles/271/5bd082f9-aa1f-4e8d-8d85-43477a06d6e1.jpg', '2024-12-12 04:07:35', '2024-12-12 04:07:35'),
(192, 272, 'asdasd', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'asdas', 'Single', 0, 'Buddhism', 0, 'None', 'dasd', NULL, 'asd', 'asda', 'dasd', 'asdas', NULL, NULL, NULL, NULL, '2024-12-12 09:25:47', '2024-12-12 09:25:47'),
(193, 273, 'J', NULL, 'Montreal', 'Quebec', 'Canada', 'Montreal', 36, 'Female', 'Average', 5, 2, 'Black', 'Single', 0, 'Sikhism', 0, 'None', 'MBA', NULL, 'Product Manager', 'N/A', 'Travelling ,Listening to Bollywood songs and watching YouTube', 'Punjabi and Hindi', NULL, NULL, NULL, NULL, '2024-12-12 09:47:58', '2024-12-12 09:47:58'),
(194, 274, 'Bianca M. Cordero', NULL, 'Valenzuela', 'Metro Manila', 'Philippines', 'Valenzuela City', 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'Hi, I\'m Bianca, a matchmaker dedicated to creating genuine connections. With Connectyed, I offer a personalized approach to dating, helping singles find their ideal partners through understanding their values, dreams, and what they\'re looking for in a partner. My goal is to make the dating process more enjoyable and successful. Let\'s connect and start your journey to lasting love.', '/storage/profiles/274/a7827a9d-e6c3-4149-9d6a-c091773b02c3.jfif', '/storage/profiles/274/51f1846a-15aa-4126-8a76-7a78fee564b7.jfif', '2024-12-12 12:28:11', '2024-12-12 12:28:11'),
(195, 275, 'Heloisa', NULL, 'Juiz de Fora', 'Minas Gerais', 'Brazil', 'Juiz de Fora', 46, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'Sou uma nova Matchmaker,mas amo conectar pessoas,tenho paixão em me comunicar bem', '/storage/profiles/275/7b604464-ca21-4299-8012-edcb68b6dae7.jpg', '/storage/profiles/275/6ccdcbb4-a25b-4a2f-8820-e44eeb9604fc.jpg', '2024-12-12 17:52:25', '2024-12-12 17:52:25'),
(196, 282, 'Beronica', NULL, 'Davie', 'Fl', 'United States', 'Davie', 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, 'I am open, optimistic, energetic, and love a happy ending. I love connecting people in my personal life, which has led me to my experiences. I love to have fun and live life to the fullest. I am an honest, inspirational, dependable person.', '/storage/profiles/282/8814fb05-0917-4ba3-afa3-6589c4deedf5.jpeg', NULL, '2024-12-12 22:36:17', '2024-12-12 22:36:17'),
(197, 283, 'allison', NULL, 'Perez zeledon', 'san isidro del general', 'Costa Rica', 'pz', 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'I am Costa Rican , I love to travel and learn about different cultures. I love animals and nature.', '/storage/profiles/283/34ffeaf0-bce6-4b25-8181-f77843cad944.jpeg', NULL, '2024-12-13 01:20:18', '2024-12-13 01:20:18'),
(198, 284, 'Ahmed Khaled', 154, 'Cairo', 'ain shams', 'Egypt', NULL, 25, NULL, 'Slender', 6, 1, NULL, 'Single', 1, 'Confucianism', 1, 'None', 'dasd', NULL, 'asdsa', 'asdasd', 'asdasd', 'adasd', 'Beginner', NULL, 'clients/avatars/L82BPieYRbpEuxSEWwIFwMyHJUrj9YmYXfYLeSrj.jpg', NULL, '2024-12-13 01:27:10', '2024-12-13 01:27:10'),
(199, 285, 'asdsadas', NULL, 'Cairo', 'Cairo', 'Egypt', 'Cairo', 25, 'Male', 'Slender', 6, 1, 'asdasd', 'Single', 0, 'Buddhism', 0, 'None', 'asdas', NULL, 'asd', 'asd', 'sadsa', 'das', NULL, NULL, NULL, NULL, '2024-12-13 01:28:37', '2024-12-13 01:28:37'),
(200, 286, 'Ahmed Khaled', 154, 'Cairo', 'ain shams', 'Egypt', NULL, 25, NULL, 'Slender', 6, 1, NULL, 'Single', 0, 'Buddhism', 1, 'None', 'asd', NULL, 'asd', 'asd', 'asdasd', 'asd', 'Beginner', NULL, 'clients/avatars/2VMg01OVzJmqOO06kyFPmARP8PtHZ0fmGGKBTWkm.jpg', NULL, '2024-12-13 01:45:05', '2024-12-13 01:45:05'),
(201, 287, 'Ahmed Khaled', 154, 'Cairo', 'ain shams', 'Egypt', NULL, 25, NULL, 'Slender', 6, 1, NULL, 'Single', 0, 'Buddhism', 1, 'None', 'asd', NULL, 'asdasd', 'asdas', 'sada', 'asd', 'Beginner', NULL, 'clients/avatars/tq3GqAwRJAlF2iPxXDRm2kACw274WItp1n7gspAi.jpg', NULL, '2024-12-13 01:52:38', '2024-12-13 01:52:38'),
(202, 288, 'Krista Stovall', NULL, 'Kansas City', 'Missouri/Kansas', 'United States', 'Richmond', 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'My passion is people, and I believe everyone deserves to find love and happiness. With a strong track record of successful networking and relationship management (and a personal network of over 10,000 individuals!), I\'m excited to bring my skills to the world of matchmaking.\r\n\r\nAfter 28 years of marriage and raising two wonderful children, I understand the complexities and nuances of relationships. My journey has given me invaluable insights into the dynamics of love, commitment, and the importance of finding a truly compatible partner.\r\nMore than anything, I\'m driven by empathy and intuition. I have a knack for understanding people\'s needs and desires, even those unspoken. My clients appreciate my genuine warmth, my dedication to their goals, and my ability to see their true potential.\r\n\r\nWhy Choose Me?\r\n\r\nExtensive Network: I have access to a vast pool of exceptional singles, increasing your chances of finding the perfect match.\r\nPersonalized Approach: I take the time to truly understand your unique personality, values, and relationship aspirations.\r\nProven Success: My background in management and networking has honed my skills in connecting people and fostering successful relationships.\r\nUnwavering Support: I\'m your dedicated advocate, providing guidance and encouragement throughout your journey to finding love.\r\n\r\nI believe that finding love should be an exciting and fulfilling experience. I\'m committed to providing a personalized, supportive, and results-oriented approach to help you find the lasting and meaningful relationship you deserve.\r\n\r\nLet\'s connect and start your love story today!', '/storage/profiles/288/501081f6-0516-4b8c-ab71-c5011916103c.jpg', '/storage/profiles/288/58b178bb-8465-4e64-9401-373b7045f629.jpg', '2024-12-13 09:33:45', '2024-12-13 09:33:45'),
(203, 289, 'Laura Williams', NULL, 'Tampa', 'Florida', 'United States', 'Tampa', 55, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, 'With over 20 years of experience as a certified master matchmaker, I have dedicated my career to guiding individuals on their journey to finding meaningful, lasting love. My passion lies and creating authentic connections and helping clients discover their forever person. I believe that love is a transformative journey, and I am honored to walk alongside each client offering guidance support and encouragement every step of the way. Whether you’re taking your first step or ready to embrace the next chapter in your love story, I’m excited to help you build the relationship of your dreams. Let’s embark on this beautiful journey together.', '/storage/profiles/289/3644ba5f-3461-4fa7-99a1-d237d77e2807.jpeg', NULL, '2024-12-14 06:36:53', '2024-12-14 06:36:53');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('14v7tdbgGP7ffjkR0hMIyNgzGYUvyjqz3LvMBeOx', NULL, '40.77.167.61', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibjl1b0JWS0NsWmFKZFRMd2Rmc0NJRGVRNEZNUkc5WHJ6Uko0Z1pmYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vY29ubmVjdHllZC5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1734198886),
('6c1orMIjBzNWLMAtR36vjGEaDqQoqDh5mqvenuU7', NULL, '42.236.101.254', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZDlSNkVDR1RzTzg3RzFIZ0pDNHVIckp3ZWlhNmhHSlhkenN3R3Q0UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9jb25uZWN0eWVkLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1734192755),
('6kqzsaGHDJqU4cmc23Hla3r0Iu7dYzUyt8dv5aYf', NULL, '135.180.60.237', 'Mozilla/5.0 (X11; CrOS x86_64 14092.77.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.107 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTkJlaW1xNWpVTEE2bFdyQnZzOG4yUXk0Q3NqVGdYRGxYQU9ES3hZbyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHBzOi8vd3d3LmNvbm5lY3R5ZWQuY29tL2FkbWluL2Fzc2V0cy9pbWFnZXMvZmF2aWNvbi5wbmciO319', 1734199150),
('6OxpORIoMR3B8VrOtVk1jcbhO6q3Bcx9rOV7srVC', NULL, '42.236.101.246', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiM0JiZ1BQeVZaTnlyaHRIYVpLSlk5OE96SVVIMG1NOGVKRkEwUmJTdiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1734192764),
('8I164EmG0pL2rPhetIeGexJziux1ADFKr2h8wLNf', NULL, '80.85.247.161', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekVZYzJEdTQ0eDZZV0pHZ2l0RUczcnBoZGxDdnZkVGdxeTlYdnlKOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vY29ubmVjdHllZC5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1734197865),
('aqqOn7ki1Y1opSdRsftL0ePeADHmRqiOeeSd4TLB', NULL, '107.77.109.94', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_8_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.6.6 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkQ4eEJiV0xQOWtwRGlHS005UEFXakdyY0NsdzRDQW5rNlppR0NJSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly93d3cuY29ubmVjdHllZC5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1734197461),
('CC5mNvY1FWmOVaIiHaFZY8W24THeFYijcAsNGrqi', NULL, '42.236.101.201', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSDh6RFJTbmhVcGZrc25HYkc1TGhIdjBldG9laE02TUVWTHVNSENqYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9jb25uZWN0eWVkLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1734192784),
('fGwTVSqU9bau12Rfcol6lLp7V1N23EFUGcdTG78d', NULL, '13.53.235.28', 'python-requests/2.32.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemR1aWtMc3BZVWZEMm5lUDU5d2U5ZjJUUHpGWHNTT2JHZmVjNnRLbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9jb25uZWN0eWVkLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1734207945),
('GTUV6WKPaijoUmrDf27I5ggwraep37sLfya7wE0P', NULL, '14.215.163.132', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZThMcVJpVVpiZ3dldXRTbzlPU3VSdzlvYXg4UTR5RlRXSWZBNGQ2eiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly93d3cuY29ubmVjdHllZC5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1734206250),
('H0n4sgz9LvFji87FLuNHs270SelOmUWcaJma9ruV', NULL, '172.226.164.25', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRE1DVzgyY3YzYVpuallIdURoMVd2bkVUeXQzYUhKdlNLNk5VdUxReiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9jb25uZWN0eWVkLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1734203710),
('kLvoC8qRNW8xpMpF8DdYUo3SZHwpVgsqZPWmN6o4', NULL, '42.236.101.201', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiOTR6ZjYwT0g1U2lWMWlBRkRqOHl0UUFpUDlkWEIzdFRWZG5XcXpYTyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1734192830),
('LKF24LZZJgsZ6lgagFX6gfYYRpqIAzQJ0XbFil5l', NULL, '42.236.17.200', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNDl5aTNlcUxnUURodXU2bGVZVDZwQXFZTmpXc2x0Nk5kMXdaRVFUVyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1734192774),
('m5FhPH57haSDtT03674GQooBYMJvbM6QS0NikzyP', NULL, '43.159.138.217', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoianJ2dFpOa0w4NFFoS01rUEttNlJpZG9JOVZpZzMwUW1oam54WmtkZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly93d3cuY29ubmVjdHllZC5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1734203192),
('QXuGzgYsro8vjGFQ4kFPq0HFznU9VrxGWpK1ao0C', NULL, '42.236.101.246', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibVpPTnllamNYWTVNUGVlTVA5dFphaUdQSHVUQmRhYVhmeHpXc0YyQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9jb25uZWN0eWVkLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1734192755),
('VwKKseZ9GCfTJXakt3m79ccoOAtufztQNINJYvs8', NULL, '42.236.17.87', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNUlIN3h1ckQzZlR1alBwenFBVzVlcFdiVVRKTEdHa2tQdUtVeDBOeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vY29ubmVjdHllZC5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1734192850),
('WEmd2jru95LKqC7QIIV1AG27U02XRRon1vBT8heq', NULL, '172.226.164.25', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Mobile/15E148 Safari/604.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoielloTHM2cEJpd2lqSDRPeXBQM2NZTnZodWJwTDl4QXgzMFU4dHMwVSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1734203711),
('XCI2rOhcwSmvZYFTsHOpwxaKDd60lCeuyulgp9bO', NULL, '42.236.17.200', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieHlKRXlJeWVWdzc5UmxzdTBGcnJ3VGQ1dGNlOUl3Wk5KeFkzcXB0aCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9jb25uZWN0eWVkLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1734192770),
('xNMU2dfleJF4HirtXLiupKUGxB0327avdQKjw6Sn', NULL, '42.236.101.254', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36; 360Spider', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSXRxWGZsR0VweDdhSDFJQlNudVpTNmJ6bkszWWNPckt3czJ5WnByYyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1734192764);

-- --------------------------------------------------------

--
-- Table structure for table `specialties`
--

CREATE TABLE `specialties` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `minage` int(11) DEFAULT NULL,
  `maxage` int(11) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `locations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`locations`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `specialties`
--

INSERT INTO `specialties` (`id`, `user_id`, `minage`, `maxage`, `gender`, `locations`, `created_at`, `updated_at`) VALUES
(1, 154, 18, 50, 'male', '[\"Albania\",\"Algeria\"]', '2024-11-13 08:01:35', '2024-11-13 08:05:51'),
(2, 283, 18, 55, 'male_female', '[\"United States\",\"Costa Rica\"]', '2024-12-14 00:28:59', '2024-12-14 00:28:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','matchmaker','candidate','client') NOT NULL DEFAULT 'client',
  `remember_token` varchar(100) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `google_access_token` varchar(255) DEFAULT NULL,
  `google_refresh_token` varchar(255) DEFAULT NULL,
  `google_token_expires_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `purchased_package` enum('silver','gold','platinum') DEFAULT NULL,
  `criteria_limit` int(11) DEFAULT 0,
  `package_purchased_at` timestamp NULL DEFAULT NULL,
  `criteria` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`criteria`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `avatar`, `google_access_token`, `google_refresh_token`, `google_token_expires_at`, `created_at`, `updated_at`, `purchased_package`, `criteria_limit`, `package_purchased_at`, `criteria`) VALUES
(1, 'Admin', 'admin', 'admin@mail.com', '2024-09-13 05:29:10', '$2y$12$wzFuOnQHlQ.Ut0WRCi1szeZ/rbe1aPE.G9CiqusrGejc/mCj.yCG.', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(41, 'George', 'GeorgeP', 'george-mail+1@30minuteadvice.com', '2024-09-13 05:29:10', '$2y$12$SHemBHJJafO.T1yQfCUoOOe6mw5yH0B458ftV1hQAeywoKUfntSry', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-13 03:45:03', '2024-09-13 03:45:03', NULL, 0, NULL, NULL),
(44, 'rebeca', 'souza', 'rebecasouzasilva345@gmail.com', '2024-09-13 07:06:05', '$2y$12$bVkitZneb8mwgcSeBABwYeB/6CLV83H4dJR6yQpZDF1YrjB.VAl8G', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-13 07:04:16', '2024-09-13 07:06:05', NULL, 0, NULL, NULL),
(45, 'Ana Paula', 'Ana Negreiro', 'ana.pn42@gmail.com', '2024-09-13 07:22:21', '$2y$12$.kzcXoLoofoqAxlpbPBPv.rtfo/1CMJ2/8Ia1O07GLLgeLJzqLEX2', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-13 07:20:41', '2024-09-13 07:22:21', NULL, 0, NULL, NULL),
(46, 'John Subsuban', 'Johnsubsuban24', 'johnsubsuban2.0@gmail.com', '2024-09-13 23:41:24', '$2y$12$hGKNMvthrVekBRyS2pnxGu9CpEId.h7waVK15FdkngA5R2iS7F4kK', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-13 23:34:26', '2024-09-13 23:41:24', NULL, 0, NULL, NULL),
(47, 'Andrea Loraine Gabo', 'Andrea_gabo', 'andrealorainegabo656@gmail.com', NULL, '$2y$12$lSYyZxHLanQ0ptuCBpU/d.w8A6sws7g2lh4EE1NQoxqMMYOatdZA.', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-13 23:39:56', '2024-09-13 23:39:56', NULL, 0, NULL, NULL),
(48, 'John Subsuban', 'John24', 'johnlloyd.subsuban@msunaawan.edu.ph', NULL, '$2y$12$CKjMGmSXErkccqJ3hb/ES.0RDcsBRLhawOZU2KyEluWt8P/KdT73q', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-13 23:40:20', '2024-09-13 23:40:20', NULL, 0, NULL, NULL),
(49, 'Juls Pansa', 'Juls30', 'kolzev0@gmail.com', NULL, '$2y$12$iZrOCTNj0nOzgFmAtyN4..40/k1pQsGEAd8HA9ablNk1kfopn48Wq', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-13 23:57:57', '2024-09-13 23:57:57', NULL, 0, NULL, NULL),
(50, 'Daisy Enot', 'Daisy14', 'daisyenot123@gmail.com', '2024-09-14 00:06:40', '$2y$12$GC7krIcltUh4cPjKydHOgeG6NlbnxJk2S.x7Sih/./29AtGoLxEHq', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-14 00:00:36', '2024-09-14 00:06:40', NULL, 0, NULL, NULL),
(51, 'Michelle Feun', 'sheeendipity', 'hingangmalalim17@gmail.com', '2024-09-14 00:15:45', '$2y$12$QB8Dfu1i10bFgSERNfNpQ.oorEhDZBh58PcsVRFWU4soVVgwzLuuO', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-14 00:13:52', '2024-09-14 00:15:45', NULL, 0, NULL, NULL),
(52, 'Joy', 'drew27', 'lsudrew94.5@gmail.com', '2024-09-15 00:54:32', '$2y$12$pCPgaYiU9FesBtRHuWPvZueGcI9teOIXoF4YmzB7gckllaAKMIiJe', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-15 00:52:42', '2024-09-15 00:54:32', NULL, 0, NULL, NULL),
(53, 'Crystal', 'Crysb', 'Crystal@3dbrightdesigns.com', '2024-09-15 02:44:39', '$2y$12$x/4J5ki00jPJvc836jkE5OYXl5C1VUV9/Uc8m9GXz1OxtZb5ICotS', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-15 02:43:11', '2024-09-15 02:44:39', NULL, 0, NULL, NULL),
(56, 'Carolina', 'Carolina Osorno', 'catmoon0927@gmail.com', '2024-09-17 04:08:29', '$2y$12$Bezxzjl99WwSGNy6Cu7Qc.RbN0p2/aa1NlEcC2CMjn6jyV9QzrgHm', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-17 04:06:23', '2024-09-17 04:08:29', NULL, 0, NULL, NULL),
(59, 'Sikandar', 'Sikandar', 'qasimnoman111@gmail.com', '2024-09-23 04:36:26', '$2y$12$A1oxdj1HRBCd85XtiOWxvOQnsZQENGUkhRd6jokGI6jXlL3MYqjZC', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-23 04:33:09', '2024-09-23 04:36:26', NULL, 0, NULL, NULL),
(61, 'Andre', 'andre', 'efriel.elyasa+1@gmail.com', '2024-09-24 11:18:05', '$2y$12$FAgjoEPY/t.hjdcsE/ZCF.h9h4HrcEX0txLDmqVWQ1o96IUKmHDFG', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-24 11:13:22', '2024-09-24 11:18:05', NULL, 0, NULL, NULL),
(64, 'Joy Marie', 'iamdrew', 'joymarie_engcoy@yahoo.com', NULL, '$2y$12$xZI32Duc48Qc2cGS7ySn/OMdxfubHnIZqB7mdq6CSRAQ/5QwJH1O6', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-24 23:54:46', '2024-09-24 23:54:46', NULL, 0, NULL, NULL),
(67, 'Babie Rose', 'Darling', 'darlingdelapena55@gmail.com', '2024-12-13 01:54:04', '$2y$12$AW3CaoCaPdZSt93pbGzuvuqthOJQLZ1bH8GCAusqJCwzCHdqcxjmy', 'client', NULL, NULL, NULL, NULL, NULL, '2024-09-27 19:23:17', '2024-09-27 19:23:17', NULL, 0, NULL, NULL),
(70, 'CF Test', 'cftest1', 'cftest1@mailinator.com', NULL, '$2y$12$esTs3xSvqEFxNl94E4EmAuz0N0mHNZytSDl/W//D1vfoGdIl9Mifi', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-13 04:16:32', '2024-10-13 04:16:32', NULL, 0, NULL, NULL),
(73, 'Client Mark', 'client105@', 'client105@yopmail.com', NULL, '$2y$12$v2jiawm8HZW1j6e9vJLz0O4HKnZiwJKo/YlB.lb0rpAa30w982umm', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-13 13:43:06', '2024-10-13 13:43:06', NULL, 0, NULL, NULL),
(76, 'ds', 'ds', 'modem31964@scarden.com', NULL, '$2y$12$PHBn5D4ZTmOQeuLkYtdoPeIQ2l7V2j1g87il8TmBQRVoX2y/HFszm', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-16 04:38:24', '2024-10-16 04:38:24', NULL, 0, NULL, NULL),
(77, 'MG R', 'mgr01', 'mgr01@yopmail.com', '2024-12-13 01:54:04', '$2y$12$zUNSHXSVUjQ5naBdXrByAu7AWB/zx3QV/YPD1m19t.iEwZWyc8EYC', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-17 00:01:58', '2024-10-17 00:01:58', NULL, 0, NULL, NULL),
(78, 'TEST One', 'palm11', 'palm11@yopmail.com', '2024-12-13 01:54:04', '$2y$12$Db2b5vzvBAGChb5/pu5GE.823ShltdQNGujlyEeuQAserCdCoy/Yi', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-17 18:43:23', '2024-10-17 18:43:23', NULL, 0, NULL, NULL),
(81, 'Test User', 'testuser', 'test@example.com', NULL, '$2y$12$9D980hamQHGcC2aXX/zLJezdr7J2Ia276e3qIuYbaWLXHBBJqJkHu', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-18 05:05:37', '2024-10-18 05:05:37', NULL, 0, NULL, NULL),
(82, 'Bilal Khalid', 'mbilal998', 'bilal.khalid@invozone.dev', '2024-12-13 01:54:04', '$2y$12$tNJYS9wylQ8cnTbjnhTV7OZ/uZg9FS1Lf2yes9CYEbBmXmBA2DPuy', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-18 20:13:23', '2024-10-18 20:13:23', NULL, 0, NULL, NULL),
(83, 'Sidharth', 'sidharth', 'sidharthahuja39@gmail.com', '2024-12-13 01:54:04', '$2y$12$iyOEiQZrT8rXUVLgApJgveqiCMwgES7JpEmNjwKu0ofVqSSVpxkUi', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-21 16:36:13', '2024-10-21 16:36:13', NULL, 0, NULL, NULL),
(86, 'Teal Bryze', 'Teal', 'teanillas400@gmail.com', NULL, '$2y$12$L9XlrdHvc.ZICOp037NJ7OIAklqLKijyR3T0GLiQB/Kde4MZgKoTW', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-30 13:04:49', '2024-10-30 13:04:49', NULL, 0, NULL, NULL),
(87, 'Red John', 'Red', 'rednillas400@gmail.com', '2024-12-13 01:54:04', '$2y$12$aWmue9p6jiruahYNlPbkb.6P/J7AkKySZu2zuIiIoLiUY75wNtdXi', 'client', NULL, NULL, NULL, NULL, NULL, '2024-10-30 13:11:50', '2024-10-30 13:11:50', NULL, 0, NULL, NULL),
(153, 'phoenix test client', 'testclient', 'wivihib739@operades.com', '2024-11-13 07:07:10', '$2y$12$5NfoZAEtW8qgZM/frpTup.S.jOjverQDJNIui259BPav4M5mckwEm', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-13 07:02:54', '2024-12-04 15:26:51', NULL, 9, '2024-11-14 02:21:59', '{\"income\":{\"min\":10000,\"max\":250000}}'),
(154, 'phoenix test matchmaker', 'testmatchmaker', 'bexise9604@opposir.com', '2024-11-13 07:11:22', '$2y$12$yZUOw3CySizvMnklcbCyKuyMrqFyoS0veJOZAaihnSILF37RP7tzy', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-11-13 07:09:51', '2024-12-11 02:46:33', NULL, 0, NULL, NULL),
(155, 'Yulia', 'Yulia777', 'ukrainematch777@gmail.com', '2024-11-13 16:12:29', '$2y$12$xXur5OMeTxTKcjPuK/vxTO79Vdxyi6rQ85Dlcp/LTF34B1eih.Tka', 'matchmaker', NULL, NULL, NULL, NULL, NULL, '2024-11-13 16:11:04', '2024-11-14 06:03:07', NULL, 0, NULL, NULL),
(156, 'Angelique Kauff Mancawan', 'kauff.dating', 'angeliquekauffmancawan@gmail.com', '2024-11-14 04:42:15', '$2y$12$utC2tN1lLWN7Adq9FAFwa.QtQzjuv/YzMT7HXt7VLQAcuaOTRjhnu', 'matchmaker', NULL, NULL, NULL, NULL, NULL, '2024-11-14 04:40:36', '2024-11-14 06:03:09', NULL, 0, NULL, NULL),
(157, 'Thuanne', 'Thuanne Oliveira', 'thuannemunizoliveira@gmail.com', '2024-11-14 04:49:47', '$2y$12$2laFHoK0kl9HVamV2oYPvebjAj2YzQvNgw9qkev42OZpHkE4n.7/O', 'matchmaker', NULL, NULL, NULL, NULL, NULL, '2024-11-14 04:48:23', '2024-11-14 06:03:11', NULL, 0, NULL, NULL),
(158, 'abi', 'abi90', 'lahcenabi90@gmail.com', '2024-12-12 04:09:26', '$2y$12$CpogR9CG5P6acstwEOVSUObbYeDXAJMG923mdcp6I57/ApIEgfc.a', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-11-15 01:19:53', '2024-11-15 01:19:53', NULL, 0, NULL, NULL),
(160, 'suraj', 'surajkumar199', 'er.surajkumar1999@gmail.com', '2024-11-16 16:36:03', '$2y$12$bB1Meyck8g1wrqzMNZJTjOlXuuuougVPgsfUzOxEstuegLG1RwMgq', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-16 16:33:01', '2024-11-16 16:36:03', NULL, 0, NULL, NULL),
(161, 'Robin Hughes', 'robinrhughes', 'robinrhughes1@aol.com', '2024-12-13 01:54:04', '$2y$12$Oc9Vh0hGY54Q45yNdljmfucF.Ux5Xb3yzfBumcL/um6DcN6xl14AO', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-17 01:55:08', '2024-11-17 01:55:08', NULL, 0, NULL, NULL),
(162, 'Aut maiores aut cons', 'Quam pariatur Volup', 'dapifi@mailinator.com', '2024-12-13 01:54:04', '$2y$12$F8qMyAcn35xKs9oa5pZ8fOBVG2Ary.KkT5DB3fR1Qq5r02oV/4G0u', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-18 16:41:11', '2024-11-18 16:41:11', NULL, 0, NULL, NULL),
(163, 'Michelle L. Alas', 'sheeenapelle', 'michellealas751@gmail.com', '2024-11-19 00:11:27', '$2y$12$BdDJqQuShHa7ijNXdGB5GO11QfAwxqvBaopsDE1f.HxYCh4eyFb9u', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-19 00:09:15', '2024-11-19 00:11:27', NULL, 0, NULL, NULL),
(164, 'Mary', 'Mira', 'miradelosr@gmail.com', '2024-11-21 21:36:40', '$2y$12$polJZRuGQjonVFQVE7/NKeL.Stq5ou4s5YCZe/NC2l8sZtpOjiho6', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-19 07:14:40', '2024-11-19 07:14:40', NULL, 0, NULL, NULL),
(165, 'Abi', 'Abi9050', 'aitbrahimhabiba50@gmail.com', '2024-11-20 01:11:57', '$2y$12$PX7tbke/qBx10qWfYdO0IOtgo4cnCCv7anFnkw5hgoFZrC/.R1cSS', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-11-20 01:10:04', '2024-11-20 01:11:57', NULL, 0, NULL, NULL),
(167, 'Yasmin', 'The Honeybee', 'yazzybee28@gmail.com', '2024-11-20 07:52:06', '$2y$12$vVlTfEmZE8mHluw1W1AJeerZsQwm8OCPjJ7Xzh/Cg.RQ0etNMRajq', 'matchmaker', NULL, NULL, NULL, NULL, NULL, '2024-11-20 07:50:35', '2024-11-24 02:39:23', NULL, 0, NULL, NULL),
(168, 'Ariel Francis Fernando Gacilo', 'funkz', 'gaciloarielfrancis@gmail.com', '2024-11-22 05:24:03', '$2y$12$zDWAy82rrWWshoP4a9qkp.bCQJnsZ0SJ66cuvHh8RClv4WFjPYtKC', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-20 13:24:27', '2024-11-25 14:08:37', 'platinum', 9, '2024-11-22 18:02:28', NULL),
(174, 'Becky', 'Becky914', '9ope1yemi4@gmail.com', '2024-11-20 15:36:48', '$2y$12$sgMmg0ReChj6JhVkH6gCo.eHR/UfzMmIjLWzvan9bxCKJGGa.IZxG', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-20 15:35:07', '2024-11-20 15:36:48', NULL, 0, NULL, NULL),
(176, 'Rose Aguiar', 'rose-aguiar', 'thu.oliveira13@gmail.com', '2024-11-21 21:36:40', '$2y$12$LfGcD.ksJ9uA3MBQ6dm/2ezsVr1PxkQqJB.FyBnLsNE6DBodSkw02', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-21 00:11:41', '2024-11-21 00:11:41', NULL, 0, NULL, NULL),
(177, 'Rebecca', 'rebecca02', 'lozadarebecca02@gmail.com', '2024-11-21 21:36:40', '$2y$12$rqitjPXQHW7v2DJHQGhaW.RETiix0Q6AFou0bT55sKSWT8abxvkwm', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-21 07:41:43', '2024-11-21 07:41:43', NULL, 0, NULL, NULL),
(178, 'Rebecca', 'rebecca08', 'kayelozada02@gmail.com', '2024-11-21 21:36:40', '$2y$12$K4Jz7Mjed4XCuLutkl9aX.R6vUFrfhd5oWMSA0FRGqItHirSay5zm', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-21 07:52:09', '2024-11-21 07:52:09', NULL, 0, NULL, NULL),
(179, 'test clients', 'testclients', 'cenebog711@nozamas.com', '2024-11-21 21:36:40', '$2y$12$71Zg5vtVDtq6oSa790mXWu5RVxe0aLQJT4rStWYu96fQmMF2cqDWO', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-21 21:34:13', '2024-11-21 21:36:40', NULL, 0, NULL, NULL),
(180, 'Eric', 'Benson', 'Ericbenson161@gmail.com', '2024-11-22 03:28:41', '$2y$12$6rSvcjwbY.RZ6floxelc6OWRCmwQ4dfKnVOBbiGSm7Qk.mD0urtby', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-22 03:16:22', '2024-11-22 03:28:41', NULL, 0, NULL, NULL),
(183, 'Bwambale praise', 'Praise21', 'bwambalepraise69@gmail.com', '2024-11-22 04:54:34', '$2y$12$EgXvM9U2aCXmvdpNRa1N..bkfJI8yyFucsClPKMRavxA00E/OY69.', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-22 04:52:53', '2024-11-22 04:54:34', NULL, 0, NULL, NULL),
(184, 'Mary De los reyes', 'Miradlsrys', 'janedlsrys01@gmail.com', '2024-11-22 07:42:22', '$2y$12$.g.8H3YQZwECNdj0bokb8efzpIA3rdvdKLABoi9/6wWi6vHaQlGC.', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-22 07:40:59', '2024-11-22 07:42:22', NULL, 0, NULL, NULL),
(185, 'Arhan', 'Arhan', 'aratwani1983@gmail.com', '2024-12-13 01:54:04', '$2y$12$9ZoJ.1EPtyczjE7yZPmqyeO3b35xv17BoNjHVRqY6TuIaDuH07u8S', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-22 09:36:50', '2024-11-22 09:36:50', NULL, 0, NULL, NULL),
(186, 'Prince Singh', 'Kyabhai', 'mrshivaverma3@gmail.com', '2024-12-13 01:54:04', '$2y$12$nP0.uR3CS/LiFEylCQOBDet.SAyvbNFCHAIAP/uTXjtVcn0z5Nsw.', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-22 11:43:50', '2024-11-22 11:43:50', NULL, 0, NULL, NULL),
(187, 'govind', 'rajput', 'govundrrajpjt259@gmail.com', '2024-12-12 04:09:26', '$2y$12$d4iteC6.nn3huKxa8YN9OOYMIGYhUyveHBMR.VU64ewBwC028GNOe', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-11-22 15:13:04', '2024-11-22 15:13:04', NULL, 0, NULL, NULL),
(189, 'rey', 'rey-', 'reysaray04@gmail.com', '2024-12-13 01:54:04', '$2y$12$LBKlmYt4rBSd3sYzEqCOAufF/fHhjpo/CUddMDlVaeF0brmjxB.TW', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-22 16:06:23', '2024-11-22 16:06:23', NULL, 0, NULL, NULL),
(190, 'Dipak', 'Deep', 'm20dipak.m@gmail.com', '2024-11-22 21:27:46', '$2y$12$9pCSWUD7z25Vn54Kan7TZOvwQSihYlhPBZOm6t.aTAs8pNS2jzPxS', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-22 21:26:06', '2024-11-22 21:27:46', NULL, 0, NULL, NULL),
(192, 'Brian', 'Trixx', 'brianmwape807@gmail.com', '2024-12-13 01:54:04', '$2y$12$gUIdrsWdKBhCqdB/16Z1UOzn6oqUMtT6cOAfTiO4BiswVIkiyTMU2', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-22 21:59:00', '2024-11-22 21:59:00', NULL, 0, NULL, NULL),
(193, 'Fareed', 'Play boy', 'fkubanda29@gmail.com', '2024-12-13 01:54:04', '$2y$12$DaQtV2t3CdM5fCOaYPwfieUcCSvyxb7Q8INWyUtAJlcqNiGuhNWBi', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-23 00:30:16', '2024-11-23 00:30:16', NULL, 0, NULL, NULL),
(200, 'Ella smith', 'Ellasmithh214', 'ellasmithhh214@gmail.com', '2024-12-12 04:09:26', '$2y$12$KLBMJtmxyiA.2yF.757V6uVBgV0q/mkwRSFD5JITsvcENBgKfxTQC', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-11-23 01:00:43', '2024-11-23 01:00:43', NULL, 0, NULL, NULL),
(206, 'Araf Sarker', 'araf', 'sarkeraraf33@gmail.com', '2024-12-13 01:54:04', '$2y$12$2rO1FjyIQINdQ8CA54Aen.G0AfFqTQinCmu3aa/tJe4XhD/56FKNK', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-23 03:38:57', '2024-11-23 03:38:57', NULL, 0, NULL, NULL),
(209, 'Ibrahim', 'Negeusu', 'ibrahimdream062@gmail.com', '2024-12-12 04:09:26', '$2y$12$h/WVF6kQZe0ljIA1LiKwR.n4nQ/IjW6awdO7IFH39C5TIa7L.Dxuu', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-11-23 03:44:22', '2024-11-23 03:44:22', NULL, 0, NULL, NULL),
(213, 'Ibrahim', 'Negusu', 'ibrahimnegusu77@gmail.com', '2024-12-13 01:54:04', '$2y$12$6ep3fp7Wh2NgYrgXzX.xa.xazQnJxreGA1gLH9texi/LMABuZ1l42', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-11-23 03:52:23', '2024-11-23 03:52:23', NULL, 0, NULL, NULL),
(219, 'Pela', 'Asong brown', 'heretaambo@gmail.com', '2024-12-12 04:09:26', '$2y$12$5fRtkl.ixYBCdmaJw9Q9ZuVJxqSj6nMl.GHEdd7yG6r8kofeovpc.', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-11-23 08:18:23', '2024-11-23 08:18:23', NULL, 0, NULL, NULL),
(220, 'Francey', 'Francey Travescort', 'Franceysavege5@gmail.com', '2024-12-13 01:54:04', '$2y$12$fR8jp/GPaQt2z6NiDmB1pOIK5OZTOyCNMMm6iyC8DxBoUSGRf.1VG', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-23 13:04:35', '2024-11-23 13:04:35', NULL, 0, NULL, NULL),
(221, 'Fritz Gerald', 'prets-devv', 'fritz.gerald.dev@gmail.com', '2024-11-28 11:26:05', '$2y$12$Li2JWkGjJHJDmONxnRjnMemHrJkU8B7/NO4nKR4qXLem8ZynRLP/K', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-28 10:55:57', '2024-11-28 11:26:05', NULL, 0, NULL, NULL),
(222, 'ruhan', 'ruh', 'ruhan@gmail.com', '2024-12-13 01:54:04', '$2y$12$7fd9DZ0MXbQzm26y8QFXhe1B5E6V6Zj3rADrnC7AKxpXVAyLl1qZC', 'client', NULL, NULL, NULL, NULL, NULL, '2024-11-28 13:07:10', '2024-11-28 13:07:10', NULL, 0, NULL, NULL),
(223, 'Andrea', 'Andreapmbo', 'pmboandrea@gmail.com', '2024-11-29 23:53:09', '$2y$12$2SHFT/3peRQe104bywYvEObQDv3dVaJJ6MNVZfP3oMNbUyTODlb82', 'matchmaker', NULL, NULL, NULL, NULL, NULL, '2024-11-29 23:50:42', '2024-11-30 06:10:26', NULL, 0, NULL, NULL),
(224, 'test', 'test', 'test@gmail.com', NULL, '$2y$12$LfCuxmHynolvNV98dgHtkue3ba9r6eF/gtG//KtrvyXGU0vPCv2zO', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-03 14:26:58', '2024-12-03 14:26:58', NULL, 0, NULL, NULL),
(226, 'test', 'rter', 'test1@gmail.com', NULL, '$2y$12$j/0A3vhTlxncNqjCSn109.ON3cgRZbitQqVZcKuKm28YivpXkJdzm', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-03 14:32:31', '2024-12-03 14:32:31', NULL, 0, NULL, NULL),
(227, 'Sophie', 'sophie', 'sophiegirl2003@gmail.com', '2024-12-13 01:54:04', '$2y$12$fbpWV9LIlB1HcMRHjXL4BOKPvSpVpv4PC4Xp.4ouDJp73qCpBsCr6', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-03 22:03:28', '2024-12-03 22:03:28', NULL, 0, NULL, NULL),
(228, 'Diana Wadie', 'Diana Wadie', 'dianawadie9@gmail.com', '2024-12-04 01:47:58', '$2y$12$Nl2iNETITWiKf25wIjf6zeqN7gk61JSs57z71NfRYgiWRFo2QdeMW', 'matchmaker', NULL, NULL, NULL, NULL, NULL, '2024-12-04 01:46:18', '2024-12-08 01:08:45', NULL, 0, NULL, NULL),
(236, 'Andrea Acuña', 'Cupidocaribe2024', 'acusa7372@gmail.com', '2024-12-04 13:45:12', '$2y$12$AmDh5Yzv36m0hKqt.8B6UefliIVekL.p42WCmzV.JLWmujmiSXB3y', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-04 13:43:35', '2024-12-04 13:45:12', NULL, 0, NULL, NULL),
(237, 'Antarjot Kaur', 'antarjot-kaur', 'arorajyot@yahoo.com', '2024-12-04 13:45:12', '$2y$12$H.12ETGvB.MYp6aq8F3.wuhaaLxu5PWR6tnx033eV2d2OgXKECI5O', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-05 00:31:16', '2024-12-05 00:31:16', NULL, 0, NULL, NULL),
(250, 'asdasd', 'asdasdasd', 'ciyoh86320@rustetic.com', '2024-12-13 01:54:04', '$2y$12$m0bZLEewsvufgclRSYFlV.YocsHSK6ch7Tv0dHq9E.HlEq9R2NfKC', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-06 07:16:25', '2024-12-06 07:16:25', NULL, 0, NULL, NULL),
(251, 'Gabriel Souza', 'Gabriel', 'gabriel.minuteadvice@gmail.com', '2024-12-12 04:09:26', '$2y$12$Gu8fG7DZH7TkTs1ES0yrseRfnALweqBBfjBZzp34RQHWx76KhsRqG', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-08 05:34:17', '2024-12-08 05:34:17', NULL, 0, NULL, NULL),
(252, 'Michelle Alas', 'michelle-alas', 'feeltheligh17@gmail.com', '2024-12-13 01:54:04', '$2y$12$yiiScbOvD2sR03ofYWnb8.CSTsgU0UrDmjAOgh2Mwh/Nt4h1/x7Ha', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-09 00:07:26', '2024-12-09 00:07:26', NULL, 0, NULL, NULL),
(253, 'Sameh Magdy Fathi', 'Sameh66', 'magdysameh945@gmail.com', '2024-12-09 02:48:48', '$2y$12$VEUcsiIqLL.B7jidfUXu9.cuxTuuuftSXM5bDWob4UnV8kncomZjq', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-09 00:49:15', '2024-12-09 00:49:15', NULL, 0, NULL, NULL),
(255, 'AG', 'agdev04', 'dev@agnieve.com', '2024-12-09 12:17:58', '$2y$12$fxdDdgcKztQYr/uBnx0KiOECmD67GTJ/9ws4QPK6dPiH31x35UCJW', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-09 12:16:36', '2024-12-09 12:17:58', NULL, 0, NULL, NULL),
(256, 'Annie', 'empoweringconnections', 'aednak@yahoo.ca', '2024-12-13 01:54:04', '$2y$12$/3bZJndKw7FQx45xbQMVdedPBdCi.PuUDE7ENZiYzAM8OeR92AmTK', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-09 13:00:32', '2024-12-09 13:00:32', NULL, 0, NULL, NULL),
(257, 'Rahul gazi', 'Rahul099', 'gazir9298@gmail.com', '2024-12-13 01:54:04', '$2y$12$jdTtughxEentMV.Om67jN.n.kwjwXmYdxU0qONXOwoVQvYeEeXrWe', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-09 18:46:23', '2024-12-09 18:46:23', NULL, 0, NULL, NULL),
(258, 'Carla Silva', 'CarlaSilva', 'carlaheloisa66@gmail.com', '2024-12-10 02:10:22', '$2y$12$EcJHLWDrxA36bmkEU8AJP.N.P4EPF3RH/zh5Q4aoBKRgZu17tzTVW', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-10 02:03:59', '2024-12-10 02:10:22', NULL, 0, NULL, NULL),
(261, 'Alisson rivera', 'Alir98', 'allisonr988@gmail.com', '2024-12-12 04:09:26', '$2y$12$QyFYVW7wrSP9ku6YdTg7TOh7luqRzGEg9VFP8SeuhXX42F2E2caYK', 'matchmaker', 'NSAVSK5YlrpzIfWaIJdXXgMj7PYdKA9jnR24kCsIz2efK8tJ7wCh90WX0UsY', NULL, NULL, NULL, NULL, '2024-12-10 04:15:56', '2024-12-12 02:30:11', NULL, 0, NULL, NULL),
(262, 'Sasha', 'Sash267', 'sash267@hotmail.com', '2024-12-10 05:04:45', '$2y$12$7d0Zr5n0/xLWdLQ58e9eeeamZMZVN0JCbhcby9oKULsY4ZK1PR1YG', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-10 05:03:17', '2024-12-10 05:04:45', NULL, 0, NULL, NULL),
(263, 'Carla Silva', 'CarlaHelo', 'arrow1579889carla@gmai.com', '2024-12-12 04:09:26', '$2y$12$.UIEe8FaOpp0ouYrvBqlSucztXN1fBBz1bmbW.SEQabL0..g6X1B.', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-10 16:09:05', '2024-12-10 16:09:05', NULL, 0, NULL, NULL),
(264, 'Gwyn', 'cgwyn_', 'cjimenez41634@liceo.edu.ph', '2024-12-13 01:54:04', '$2y$12$CO8tj93o9G0YHH3KLc7pm.pCtYFzjDPp7As/xfipe8O0GlFqNULiO', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-10 22:24:29', '2024-12-10 22:24:29', NULL, 0, NULL, NULL),
(265, 'Gwyn', 'gwyn23', 'cjimenez41633@liceo.edu.ph', '2024-12-10 22:32:45', '$2y$12$2pEWqkJO2clGF.9fJNLun.bampNHNdGYVZsah509O7pYqod7Jsc62', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-10 22:29:02', '2024-12-10 22:32:45', NULL, 0, NULL, NULL),
(266, 'Ry Bala', 'ry-bala', 'ryanngiftbala@gmail.com', '2024-12-13 01:54:04', '$2y$12$XDMUEbE3u8.X8t.2JQTA8OQVIWKewxiIwSEfUuowI6hXtpL4f00Fm', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-10 23:18:03', '2024-12-10 23:18:03', NULL, 0, NULL, NULL),
(267, 'Becca', 'becca', 'rkaye0501@gmail.com', '2024-12-13 01:54:04', '$2y$12$QunUbcijJGl4lpzOWM0U5OMxZafQ/OobuF8Y.jagh5igCdKgOJnPG', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-10 23:27:11', '2024-12-10 23:27:11', NULL, 0, NULL, NULL),
(268, 'Mary Delos Reyes', 'mary-delos-reyes', 'sunflowermira2324@gmail.com', '2024-12-13 01:54:04', '$2y$12$in6ZHXM4tAiwtSWMq/rf5uWh8m309RtCYjrSLyZ60kBrporh4ynPO', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-10 23:36:06', '2024-12-10 23:36:06', NULL, 0, NULL, NULL),
(269, 'Keyo Jimenez', 'keyo-jimenez', 'keyox0507@gmail.com', '2024-12-13 01:54:04', '$2y$12$vBROK8wpmWDlr/bLEFt23ePQKW/3l3qnYuBNHJqw0.LUQiGvqNntS', 'client', NULL, NULL, NULL, NULL, NULL, '2024-12-10 23:50:41', '2024-12-10 23:50:41', NULL, 0, NULL, NULL),
(270, 'Test Match Maker', 'test_matchmaker', 'agnieve70@gmail.com', '2024-12-12 03:56:29', '$2y$12$bpwFvIonwqQ.HQS1toDqqOtvwL4NWi6D2zSgVl04Ufwy3.sney34.', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-12 03:54:21', '2024-12-12 03:56:29', NULL, 0, NULL, NULL),
(271, 'Geovana da Silva Rodrigues', 'Geovana', 'rodriguesgeovana676@gmail.com', '2024-12-12 04:09:26', '$2y$12$Al/8LyC0HljZRZP4mV1mwudgvjozjc7E8ci/Z7mlN7x9Ih3fYgqaa', 'matchmaker', NULL, NULL, NULL, NULL, NULL, '2024-12-12 04:07:35', '2024-12-13 12:09:59', NULL, 0, NULL, NULL),
(273, 'J', 'K', 'antarjotkaur@yahoo.com', '2024-12-13 01:54:04', '$2y$12$Lkpx/ARnl1tkr5/0MwuqyecQip0la/JWMQsA.nB.p5.KSvVMDEZgm', 'client', 'VgFwlf0R17qsr9FtizCwsh1oo6BkUTK9cYHdWyyUNf637SqwEJZjZRQoeY2z', NULL, NULL, NULL, NULL, '2024-12-12 09:47:58', '2024-12-12 10:03:43', NULL, 0, NULL, NULL),
(274, 'Bianca M. Cordero', 'matchmakercamille77', 'matchmakercamille77@gmail.com', '2024-12-12 12:29:28', '$2y$12$GsuLxAQvBDD/FUNyuywInu4CCWUTc2gOAk79Qeb2kPOEN.oklv.42', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-12 12:28:11', '2024-12-12 12:29:28', NULL, 0, NULL, NULL),
(275, 'Heloisa', 'SilvaHelo', 'daieg04454@gmail.com', '2024-12-12 17:53:50', '$2y$12$3D98DKJTuR4p8SFj3RA7d.bz250PAL7.9HpD3GMSCSKN6SY7KXnZy', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-12 17:52:25', '2024-12-12 17:53:50', NULL, 0, NULL, NULL),
(282, 'Beronica', 'Nikki2024', 'beronicabaptiste@gmail.com', '2024-12-12 22:37:59', '$2y$12$9PBtvA3NevO/WGZkv5rm2.E3UEu3TisTZaI0knyTK.3AXcIGqTFli', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-12 22:36:17', '2024-12-12 22:37:59', NULL, 0, NULL, NULL),
(283, 'allison', 'alir988', 'riveraav98@gmail.com', '2024-12-13 01:21:41', '$2y$12$yTlkV3VCCN6yMDYCOU7HNuEfDxzx.7PoiYfs0c1OXlihEU5.xChta', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-13 01:20:18', '2024-12-13 01:21:41', NULL, 0, NULL, NULL),
(288, 'Krista Stovall', 'KStovall', 'kdbrim0000@gmail.com', '2024-12-13 09:35:45', '$2y$12$C138lhzE25zMvlgZIDrVN.4p4smtaggvAr4tMG9mUhNmPAWh5GmUW', 'matchmaker', NULL, NULL, NULL, NULL, NULL, '2024-12-13 09:33:45', '2024-12-13 12:09:12', NULL, 0, NULL, NULL),
(289, 'Laura Williams', 'Laura B', 'hotspotradio@gmail.com', NULL, '$2y$12$10mUdX2pvwYexPkoPZFOqesEl3kSm9jkz0XDFvGi/n4L.5XLRNp4W', 'candidate', NULL, NULL, NULL, NULL, NULL, '2024-12-14 06:36:53', '2024-12-14 06:36:53', NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_earnings`
--

CREATE TABLE `user_earnings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `meeting_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `type` enum('matchmaker_commission','client_bonus') NOT NULL,
  `status` enum('pending','available','withdrawn') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdrawal_requests`
--

CREATE TABLE `withdrawal_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `payment_email` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `processed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `availabilities`
--
ALTER TABLE `availabilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `availabilities_user_id_foreign` (`user_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `categories_category_id_IDX` (`category_id`,`category_slug`,`parent_id`,`lang`) USING BTREE;

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`userable_type`,`userable_id`,`likeable_type`,`likeable_id`),
  ADD KEY `likes_userable_type_userable_id_index` (`userable_type`,`userable_id`),
  ADD KEY `likes_likeable_type_likeable_id_index` (`likeable_type`,`likeable_id`),
  ADD KEY `likes_is_liked_index` (`is_liked`);

--
-- Indexes for table `matchmaker_clients`
--
ALTER TABLE `matchmaker_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_matchmaker_id` (`matchmaker_id`),
  ADD KEY `idx_location` (`city`,`state`,`country`),
  ADD KEY `fk_matchmaker_clients_user_id` (`user_id`);

--
-- Indexes for table `meetings`
--
ALTER TABLE `meetings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meetings_matchmaker_id_foreign` (`matchmaker_id`);

--
-- Indexes for table `meeting_client`
--
ALTER TABLE `meeting_client`
  ADD PRIMARY KEY (`meeting_id`,`client_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `meeting_reviews`
--
ALTER TABLE `meeting_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_reviews_meeting_id_foreign` (`meeting_id`),
  ADD KEY `meeting_reviews_client_id_foreign` (`client_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_messages_sender` (`sender_id`),
  ADD KEY `fk_messages_receiver` (`receiver_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pre_schedules`
--
ALTER TABLE `pre_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profiles_user_id_index` (`user_id`),
  ADD KEY `profiles_matchmaker_id_index` (`matchmaker_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_matchmaker_id` (`matchmaker_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `specialties`
--
ALTER TABLE `specialties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `specialties_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `idx_user_package` (`purchased_package`,`package_purchased_at`);

--
-- Indexes for table `user_earnings`
--
ALTER TABLE `user_earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_earnings_user_id_foreign` (`user_id`),
  ADD KEY `user_earnings_meeting_id_foreign` (`meeting_id`);

--
-- Indexes for table `withdrawal_requests`
--
ALTER TABLE `withdrawal_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `withdrawal_requests_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `availabilities`
--
ALTER TABLE `availabilities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `matchmaker_clients`
--
ALTER TABLE `matchmaker_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `meetings`
--
ALTER TABLE `meetings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `meeting_reviews`
--
ALTER TABLE `meeting_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `pre_schedules`
--
ALTER TABLE `pre_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT for table `specialties`
--
ALTER TABLE `specialties`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=290;

--
-- AUTO_INCREMENT for table `user_earnings`
--
ALTER TABLE `user_earnings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdrawal_requests`
--
ALTER TABLE `withdrawal_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `availabilities`
--
ALTER TABLE `availabilities`
  ADD CONSTRAINT `availabilities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `matchmaker_clients`
--
ALTER TABLE `matchmaker_clients`
  ADD CONSTRAINT `fk_matchmaker_clients_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_matchmaker_clients_users` FOREIGN KEY (`matchmaker_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `meetings`
--
ALTER TABLE `meetings`
  ADD CONSTRAINT `meetings_matchmaker_id_foreign` FOREIGN KEY (`matchmaker_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `meeting_client`
--
ALTER TABLE `meeting_client`
  ADD CONSTRAINT `meeting_client_ibfk_1` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `meeting_client_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `meeting_reviews`
--
ALTER TABLE `meeting_reviews`
  ADD CONSTRAINT `meeting_reviews_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `meeting_reviews_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_messages_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_messages_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `specialties`
--
ALTER TABLE `specialties`
  ADD CONSTRAINT `specialties_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_earnings`
--
ALTER TABLE `user_earnings`
  ADD CONSTRAINT `user_earnings_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_earnings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `withdrawal_requests`
--
ALTER TABLE `withdrawal_requests`
  ADD CONSTRAINT `withdrawal_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
