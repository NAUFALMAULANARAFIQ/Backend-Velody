-- --------------------------------------------------------
-- Host:                         TiDB Cloud / Remote
-- Server version:               MySQL Compatible
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Matikan cek foreign key sementara agar tidak error saat create table
SET FOREIGN_KEY_CHECKS=0;

-- HAPUS SEMUA TABEL LAMA (URUTAN GAK MASALAH KARENA CHECK MATI)
DROP TABLE IF EXISTS `playlists_song`;
DROP TABLE IF EXISTS `playlists`;
DROP TABLE IF EXISTS `histories`;
DROP TABLE IF EXISTS `favorites`;
DROP TABLE IF EXISTS `sessions`;
DROP TABLE IF EXISTS `personal_access_tokens`;
DROP TABLE IF EXISTS `password_reset_tokens`;
DROP TABLE IF EXISTS `migrations`;
DROP TABLE IF EXISTS `cache_locks`;
DROP TABLE IF EXISTS `cache`;
DROP TABLE IF EXISTS `songs`;
DROP TABLE IF EXISTS `albums`;
DROP TABLE IF EXISTS `artists`;
DROP TABLE IF EXISTS `users`;


-- 1. UTAMA: Buat Artists dulu (Induk)
CREATE TABLE IF NOT EXISTS `artists` (
  `id_artists` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bio` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_artists`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `artists` (`id_artists`, `name`, `bio`, `image`, `created_at`, `updated_at`) VALUES
    (1, 'LANY', 'This is the official artist profile of LANY.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (2, 'Rex Orange County', 'This is the official artist profile of Rex Orange County.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (3, 'Reality Club', 'This is the official artist profile of Reality Club.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (4, 'The 1975', 'This is the official artist profile of The 1975.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (5, 'Clairo', 'This is the official artist profile of Clairo.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (6, 'Lauv', 'This is the official artist profile of Lauv.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (7, 'Daniel Caesar', 'This is the official artist profile of Daniel Caesar.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (8, 'Keshi', 'This is the official artist profile of Keshi.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (9, 'Mazzy Star', 'This is the official artist profile of Mazzy Star.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (10, 'The Marias', 'This is the official artist profile of The Marias.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (11, 'wave to earth', 'This is the official artist profile of wave to earth.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (12, 'Frank Ocean', 'This is the official artist profile of Frank Ocean.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (13, 'Cigarettes After Sex', 'This is the official artist profile of Cigarettes After Sex.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (14, 'Joji', 'This is the official artist profile of Joji.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (15, 'Thomas Day', 'This is the official artist profile of Thomas Day.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (16, 'Phoebe Bridgers', 'This is the official artist profile of Phoebe Bridgers.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (17, 'Coldplay', 'This is the official artist profile of Coldplay.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (18, 'Lizzy McAlpine', 'This is the official artist profile of Lizzy McAlpine.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (19, 'Lord Huron', 'This is the official artist profile of Lord Huron.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (20, 'Paramore', 'This is the official artist profile of Paramore.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (21, 'NERIAH', 'This is the official artist profile of NERIAH.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19'),
    (22, 'The Neighbourhood', 'This is the official artist profile of The Neighbourhood.', 'artists/default.png', '2025-11-21 09:36:19', '2025-11-21 09:36:19');

-- 2. UTAMA: Buat Albums (Anak dari Artists)
CREATE TABLE IF NOT EXISTS `albums` (
  `id_albums` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_artists` bigint unsigned NOT NULL,
  `title` varchar(355) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `release_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_albums`),
  KEY `albums_id_artists_foreign` (`id_artists`),
  CONSTRAINT `albums_id_artists_foreign` FOREIGN KEY (`id_artists`) REFERENCES `artists` (`id_artists`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `albums` (`id_albums`, `id_artists`, `title`, `cover_image`, `release_date`, `created_at`, `updated_at`) VALUES
    (1, 1, 'mama\'s boy (deluxe)', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (2, 2, 'Apricot Princess', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (3, 3, 'What Do You Really Know?', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (4, 4, 'Being Funny In a Foreign Language', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (5, 6, '~how i\'m feeling~', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (6, 7, 'Son Of Spergy', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (7, 8, 'Requiem', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (8, 5, 'Immunity', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (9, 20, 'Paramore', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (10, 12, 'Blonde', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (11, 19, 'Strange Trails', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22'),
    (12, 9, 'So Tonight That I Might See', 'albums/default.png', '2020-01-01', '2025-11-21 09:36:22', '2025-11-21 09:36:22');

-- 3. UTAMA: Buat Songs (Link Updated ke GitHub Pages)
CREATE TABLE IF NOT EXISTS `songs` (
  `id_songs` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_artists` bigint unsigned NOT NULL,
  `id_albums` bigint unsigned NOT NULL,
  `duration` int NOT NULL,
  `file_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_songs`),
  KEY `songs_id_artists_foreign` (`id_artists`),
  KEY `songs_id_albums_foreign` (`id_albums`),
  CONSTRAINT `songs_id_albums_foreign` FOREIGN KEY (`id_albums`) REFERENCES `albums` (`id_albums`) ON DELETE CASCADE,
  CONSTRAINT `songs_id_artists_foreign` FOREIGN KEY (`id_artists`) REFERENCES `artists` (`id_artists`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `songs` (`id_songs`, `id_artists`, `id_albums`, `duration`, `file_url`, `genre`, `title`, `created_at`, `updated_at`) VALUES
    (1, 1, 1, 298, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/what%20i%20wish%20just%20one%20person%20would%20say%20to%20me.mp3', 'R&B', 'what i wish just one person would say to me', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (2, 2, 2, 219, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/4%20Seasons.mp3', 'Pop', '4 Seasons', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (3, 3, 3, 178, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/A%20Sorrowful%20Reunion.mp3', 'Alternative', 'A Sorrowful Reunion', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (4, 4, 4, 170, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/About%20You.mp3', 'Pop', 'About You', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (5, 1, 1, 170, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Act%20My%20Age.mp3', 'Soul', 'Act My Age', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (6, 2, 2, 136, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Always.mp3', 'Soul', 'Always', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (7, 5, 8, 178, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Bags.mp3', 'Soul', 'Bags', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (8, 6, 5, 152, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Canada.mp3', 'Rock', 'Canada', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (9, 7, 6, 243, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Emily%E2%80%99s%20Song.mp3', 'Soul', 'Emily’s Song', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (10, 8, 7, 198, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Euphoria.mp3', 'Rock', 'Euphoria', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (11, 9, 12, 231, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Fade%20Into%20You.mp3', 'Pop', 'Fade Into You', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (12, 1, 1, 186, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Hericane.mp3', 'R&B', 'Hericane', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (13, 4, 4, 215, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/I%20Couldn%27t%20Be%20More%20In%20Love.mp3', 'R&B', 'I Couldn\'t Be More In Love', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (14, 12, 10, 188, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Ivy.mp3', 'Pop', 'Ivy', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (15, 7, 6, 208, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Let%20Me%20Go.mp3', 'Alternative', 'Let Me Go', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (16, 1, 1, 246, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Let%20Me%20Know.mp3', 'Soul', 'Let Me Know', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (17, 7, 6, 221, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Loose.mp3', 'Alternative', 'Loose', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (18, 6, 5, 142, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Never%20Not.mp3', 'Indie Pop', 'Never Not', '2025-11-21 09:36:24', '2025-11-21 09:36:24'),
    (19, 2, 2, 255, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Pluto%20Projector.mp3', 'R&B', 'Pluto Projector', '2025-11-21 09:36:25', '2025-11-21 09:36:25'),
    (20, 7, 6, 283, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Streetcar.mp3', 'Pop', 'Streetcar', '2025-11-21 09:36:25', '2025-11-21 09:36:25'),
    (21, 1, 1, 146, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Tampa.mp3', 'Alternative', 'Tampa', '2025-11-21 09:36:25', '2025-11-21 09:36:25'),
    (22, 19, 11, 317, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/The%20Night%20We%20Met.mp3', 'Soul', 'The Night We Met', '2025-11-21 09:36:25', '2025-11-21 09:36:25'),
    (23, 20, 9, 282, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/The%20Only%20Exception.mp3', 'R&B', 'The Only Exception', '2025-11-21 09:36:25', '2025-11-21 09:36:25'),
    (24, 1, 1, 290, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Valentine%27s%20Day.mp3', 'Alternative', 'Valentine\'s Day', '2025-11-21 09:36:25', '2025-11-21 09:36:25'),
    (25, 12, 10, 195, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/White%20Ferrari.mp3', 'R&B', 'White Ferrari', '2025-11-21 09:36:25', '2025-11-21 09:36:25'),
    (26, 7, 6, 124, 'https://naufalmaulanarafiq.github.io/assets-velody/songs/Who%20Knows.mp3', 'Pop', 'Who Knows', '2025-11-21 09:36:25', '2025-11-21 09:36:25');

-- 4. UTAMA: Users (Induk dari Favorites, Histories, Playlists)
CREATE TABLE IF NOT EXISTS `users` (
  `id_users` bigint unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_users`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id_users`, `username`, `email`, `password`, `profile_image`, `created_at`, `updated_at`) VALUES
    (1, 'naufal', '123@gmail.com', '$2y$12$fGNgv77p/fxJA8rTu9OA/uT.3ejpMlHDmMbyP.7D0Mula1kFlyj8e', NULL, '2025-11-21 09:48:02', '2025-11-21 09:48:02');

-- 5. Tabel-tabel tanpa relasi krusial (Cache, Migrations, dll)
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
    (1, '0001_01_01_000000_create_users_table', 1),
    (2, '0001_01_01_000001_create_cache_table', 1),
    (3, '0001_01_01_000002_create_artists_table', 1),
    (4, '2025_10_29_035118_albums', 1),
    (5, '2025_10_29_043329_create_table_songs', 1),
    (6, '2025_10_29_044348_create_table_playlists', 1),
    (7, '2025_10_29_044932_create_table_playlists_song', 1),
    (8, '2025_10_29_045604_create_table_favorites', 1),
    (9, '2025_10_29_045853_create_histories', 1),
    (10, '2025_11_19_033710_create_personal_access_tokens_table', 1);

CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
    (54, 'App\\Models\\User', 1, 'auth_token', 'ab55e3fb3c4e1bed6b832c1ff51a907330625a237ab495ad73068a57ffe489d5', '["*"]', '2025-11-25 03:22:45', NULL, '2025-11-25 03:22:28', '2025-11-25 03:22:45'),
    (55, 'App\\Models\\User', 1, 'auth_token', '445a4ae7485cf7edb4ff73f3d212f00fd650de26a968b43911e4183ca087482c', '["*"]', '2025-11-25 03:23:55', NULL, '2025-11-25 03:22:59', '2025-11-25 03:23:55'),
    (56, 'App\\Models\\User', 1, 'auth_token', 'b13965a7e6540fbb5a9573b53f4a14d56188efd32d96907360c3fb18a7d0ac06', '["*"]', '2025-11-25 03:28:41', NULL, '2025-11-25 03:28:35', '2025-11-25 03:28:41');

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
    ('0f0NOPoPNPiaNlqfeZhoQ8078K25OWxVj3Rr5ml4', NULL, '127.0.0.1', 'Dart/3.9 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWG9KdFZabE5MMkxLU0F4VmVBOHZxa1lscHMyWnprY2RlcWdPME1PaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly8xMC4wLjIuMjo4MDAwL2NvdmVyL2xldF9tZV9nby53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1764065049),
    ('0GfhvXzjyDZCQfeYDMIeN1uXmcALPDGllc810raF', NULL, '127.0.0.1', 'Dart/3.9 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQUlUeUdYUlVCWVpRZmtmWUUzcXJtMnhyWFZsSVQ0cG9HMExsYzFnYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly8xMC4wLjIuMjo4MDAwL2NvdmVyL25ldmVyX25vdC53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1764066152);

-- 6. Dependent Tables (Favorites & Histories)
CREATE TABLE IF NOT EXISTS `favorites` (
  `id_favorites` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_users` bigint unsigned NOT NULL,
  `id_songs` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_favorites`),
  KEY `favorites_id_users_foreign` (`id_users`),
  KEY `favorites_id_songs_foreign` (`id_songs`),
  CONSTRAINT `favorites_id_songs_foreign` FOREIGN KEY (`id_songs`) REFERENCES `songs` (`id_songs`) ON DELETE CASCADE,
  CONSTRAINT `favorites_id_users_foreign` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `favorites` (`id_favorites`, `id_users`, `id_songs`, `created_at`, `updated_at`) VALUES
    (5, 1, 2, '2025-11-24 23:10:05', '2025-11-24 23:10:05'),
    (6, 1, 1, '2025-11-25 03:14:13', '2025-11-25 03:14:13'),
    (7, 1, 4, '2025-11-25 03:23:21', '2025-11-25 03:23:21');

CREATE TABLE IF NOT EXISTS `histories` (
  `id_histories` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_users` bigint unsigned NOT NULL,
  `id_songs` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_histories`),
  KEY `histories_id_users_foreign` (`id_users`),
  KEY `histories_id_songs_foreign` (`id_songs`),
  CONSTRAINT `histories_id_songs_foreign` FOREIGN KEY (`id_songs`) REFERENCES `songs` (`id_songs`) ON DELETE CASCADE,
  CONSTRAINT `histories_id_users_foreign` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `histories` (`id_histories`, `id_users`, `id_songs`, `created_at`, `updated_at`) VALUES
    (1, 1, 1, '2025-11-23 13:51:18', '2025-11-23 13:51:18'),
    (2, 1, 2, '2025-11-23 13:51:27', '2025-11-23 13:51:27'),
    (3, 1, 6, '2025-11-23 13:52:06', '2025-11-23 13:52:06'),
    (4, 1, 7, '2025-11-23 13:55:24', '2025-11-23 13:55:24');

-- 7. Dependent Tables (Playlists & Playlists_Song)
CREATE TABLE IF NOT EXISTS `playlists` (
  `id_playlists` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_users` bigint unsigned NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_playlists`),
  KEY `playlists_id_users_foreign` (`id_users`),
  CONSTRAINT `playlists_id_users_foreign` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `playlists` (`id_playlists`, `id_users`, `name`, `description`, `created_at`, `updated_at`) VALUES
    (1, 1, 'deep song', '', '2025-11-23 23:44:49', '2025-11-23 23:44:49');

CREATE TABLE IF NOT EXISTS `playlists_song` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_playlists` bigint unsigned NOT NULL,
  `id_songs` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `playlists` (`id_playlists`),
  CONSTRAINT `playlists` FOREIGN KEY (`id_playlists`) REFERENCES `playlists` (`id_playlists`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `playlists_song` (`id`, `id_playlists`, `id_songs`, `created_at`, `updated_at`) VALUES
    (1, 1, 3, NULL, NULL),
    (2, 1, 2, NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
SET FOREIGN_KEY_CHECKS=1;
