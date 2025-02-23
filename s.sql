-- --------------------------------------------------------
-- Hôte:                         51.91.253.164
-- Version du serveur:           10.5.19-MariaDB-0+deb11u2 - Debian 11
-- SE du serveur:                debian-linux-gnu
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour bluestark_v2
CREATE DATABASE IF NOT EXISTS `bluestark_v2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `bluestark_v2`;

-- Listage de la structure de table bluestark_v2. basketball_rpg
CREATE TABLE IF NOT EXISTS `basketball_rpg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(64) NOT NULL,
  `score` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.basketball_rpg : ~0 rows (environ)
INSERT INTO `basketball_rpg` (`id`, `identifier`, `score`) VALUES
	(1, 'license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', 1);

-- Listage de la structure de table bluestark_v2. casino_cache
CREATE TABLE IF NOT EXISTS `casino_cache` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_slovak_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.casino_cache : ~0 rows (environ)
INSERT INTO `casino_cache` (`ID`, `Settings`) VALUES
	(1, '{"PodiumPriceProps":{"modOrnaments":-1,"neonColor":[255,0,255],"wheelColor":111,"modAirFilter":-1,"modHydrolic":-1,"tyreSmokeColor":[1,1,1],"modEngineBlock":-1,"modBackWheels":-1,"modDoorSpeaker":-1,"podiumName":"SHEAVA","modRightFender":-1,"modTransmission":2,"modHood":0,"pearlescentColor":111,"modAPlate":-1,"modDial":-1,"modBrakes":2,"engineHealth":1,"modAerials":-1,"modFrontBumper":1,"modHorns":57,"modTrimA":-1,"wheels":5,"modSmokeEnabled":1,"modPlateHolder":-1,"modFender":-1,"modSpeakers":-1,"modStruts":-1,"dirtLevel":1,"modExhaust":0,"neonEnabled":[false,false,false,false],"windowTint":6,"modRoof":2,"color2":111,"bodyHealth":1,"modEngine":3,"modShifterLeavers":-1,"modFrame":-1,"modRearBumper":0,"modXenon":1,"xenonColor":12,"modSuspension":-1,"tankHealth":1,"modTrunk":-1,"modSpoilers":3,"modGrille":-1,"model":819197656,"modArmor":4,"modLivery":1,"modVanityPlate":-1,"modWindows":-1,"fuelLevel":1,"plateIndex":0,"modArchCover":-1,"modTurbo":1,"modDashboard":-1,"modTank":-1,"extras":{"1":false},"modSideSkirt":-1,"modTrimB":-1,"modSteeringWheel":-1,"modSeats":-1,"color1":111,"modFrontWheels":-1},"bans":"[]"}');

-- Listage de la structure de table bluestark_v2. casino_players
CREATE TABLE IF NOT EXISTS `casino_players` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(128) NOT NULL,
  `properties` longtext NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.casino_players : ~0 rows (environ)
INSERT INTO `casino_players` (`ID`, `identifier`, `properties`) VALUES
	(35, 'license:b90704455b3efdd5907547511ac05e09eb931f67', '{"firstTime":false,"vipUntil":1686784878,"xmasCooldowns":"[1676738725,1676667574]","insideTrackCooldownUntil":1676652640,"lastSave":3916595,"activeTime":300474,"luckyWheelCooldownUntil":1686266401,"logins":34,"lastDailyBonus":"02/17/23"}');

-- Listage de la structure de table bluestark_v2. garage
CREATE TABLE IF NOT EXISTS `garage` (
  `garageId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `menuPosition` longtext DEFAULT NULL,
  `spawnPosition` longtext DEFAULT NULL,
  `deletePosition` longtext DEFAULT NULL,
  PRIMARY KEY (`garageId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Garage of BlueStark';

-- Listage des données de la table bluestark_v2.garage : ~5 rows (environ)
INSERT INTO `garage` (`garageId`, `type`, `label`, `menuPosition`, `spawnPosition`, `deletePosition`) VALUES
	(1, 'garage', 'Parking central', '{"x":213.91969299316407,"y":-809.3533935546875,"z":31.01489067077636}', '{"x":229.15577697753907,"y":-801.2108154296875,"z":30.57264328002929,"w":161.5154266357422}', '{"x":223.6141357421875,"y":-763.7047729492188,"z":30.81742095947265}'),
	(3, 'garage', 'Parking central 2', '{"x":-349.354248046875,"y":-874.9198608398438,"z":31.31801414489746}', '{"x":-344.495361328125,"y":-881.9647827148438,"z":31.07145690917968,"w":257.5736999511719}', '{"x":-353.1818542480469,"y":-881.6094360351563,"z":31.07145500183105}'),
	(4, 'impound', 'Fourrière 2', '{"x":409.8092041015625,"y":-1623.3634033203126,"z":29.29194068908691}', '{"x":407.9316101074219,"y":-1644.55322265625,"z":29.29194259643554,"w":227.20333862304688}', '[]'),
	(5, 'garage', '~r~Non renseigné', '{"x":110.93782043457031,"y":-1082.406005859375,"z":29.15850257873535}', '{"x":102.34274291992188,"y":-1078.72216796875,"z":29.15850448608398,"w":248.1922607421875}', '{"x":105.78561401367188,"y":-1086.8466796875,"z":29.15853500366211}'),
	(6, 'impound', 'Yuuma', '{"x":108.09113311767578,"y":-1091.6116943359376,"z":29.15851974487304}', '{"x":107.6774673461914,"y":-1100.2437744140626,"z":29.15878295898437,"w":175.6389923095703}', '[]');

-- Listage de la structure de table bluestark_v2. hud_settings
CREATE TABLE IF NOT EXISTS `hud_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_license` varchar(50) NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`settings`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`user_license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Listage des données de la table bluestark_v2.hud_settings : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. inventory_items
CREATE TABLE IF NOT EXISTS `inventory_items` (
  `uniqueID` varchar(512) NOT NULL,
  `type` varchar(64) DEFAULT NULL,
  `items` longtext DEFAULT NULL,
  `originX` float DEFAULT NULL,
  `originY` float DEFAULT NULL,
  `originZ` float DEFAULT NULL,
  `expires` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`uniqueID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.inventory_items : ~60 rows (environ)
INSERT INTO `inventory_items` (`uniqueID`, `type`, `items`, `originX`, `originY`, `originZ`, `expires`) VALUES
	('admin_inventory_items', 'stash', '[{"name":"money","meta":[],"quantity":9999,"slot":1,"itemHash":"1686866846-787991"},{"name":"mask","meta":[],"quantity":9999,"slot":2,"itemHash":"1686866846-604498"},{"name":"arms","meta":[],"quantity":9999,"slot":3,"itemHash":"1686866846-890715"},{"name":"at_flashlight","meta":[],"quantity":9999,"slot":4,"itemHash":"1686866846-755822"},{"name":"9mm_rounds","meta":[],"quantity":9999,"slot":5,"itemHash":"1686866846-481782"},{"name":"apple","meta":[],"quantity":9999,"slot":6,"itemHash":"1686866846-823124"},{"name":"black_money","meta":[],"quantity":9999,"slot":7,"itemHash":"1686866846-521276"},{"name":"medikit","meta":[],"quantity":9999,"slot":8,"itemHash":"1686866846-563805"},{"name":"hood","meta":[],"quantity":9999,"slot":9,"itemHash":"1686866846-42725"},{"name":"chains","meta":[],"quantity":9999,"slot":10,"itemHash":"1686866846-73044"},{"name":"armor","meta":{"durability":100},"quantity":9999,"slot":11,"itemHash":"1686866846-895773"},{"name":"outfits","meta":[],"quantity":9999,"slot":12,"itemHash":"1686866846-709119"},{"name":"bproof","meta":[],"quantity":9999,"slot":13,"itemHash":"1686866846-552550"},{"name":"pants","meta":[],"quantity":9999,"slot":14,"itemHash":"1686866846-605435"},{"name":"bracelets","meta":[],"quantity":9999,"slot":15,"itemHash":"1686866846-272509"},{"name":"shoes","meta":[],"quantity":9999,"slot":16,"itemHash":"1686866846-448689"},{"name":"watches","meta":[],"quantity":9999,"slot":17,"itemHash":"1686866846-20687"},{"name":"glasses","meta":[],"quantity":9999,"slot":18,"itemHash":"1686866846-597073"},{"name":"bandage","meta":[],"quantity":9999,"slot":19,"itemHash":"1686866846-119764"},{"name":"bags","meta":[],"quantity":9999,"slot":20,"itemHash":"1686866846-49531"},{"name":"helmet","meta":[],"quantity":9999,"slot":21,"itemHash":"1686866846-821069"},{"name":"pistol","meta":{"durability":100,"serial":"5Z6S5Y5Z2F4Y8W2W"},"quantity":9999,"slot":22,"itemHash":"1686866846-881515"},{"name":"tshirt","meta":[],"quantity":9999,"slot":23,"itemHash":"1686866846-853620"},{"name":"handcuffs","meta":[],"quantity":9999,"slot":25,"itemHash":"1686866846-171389"},{"name":"torso","meta":[],"quantity":9999,"slot":26,"itemHash":"1686866846-80339"},{"name":"ears","meta":[],"quantity":9999,"slot":27,"itemHash":"1686866846-396864"},{"name":"at_suppressor_light","meta":[],"quantity":9999,"slot":24,"itemHash":"1686893079-65093"}]', NULL, NULL, NULL, NULL),
	('ambulance_locker_license:b754f5f908d5750f838dc62c60ed7904a6b609a3_1', 'stash', '[]', NULL, NULL, NULL, NULL),
	('ambulance_locker_license:b754f5f908d5750f838dc62c60ed7904a6b609a3_2', 'stash', '[]', NULL, NULL, NULL, NULL),
	('ambulance_locker_license:b90704455b3efdd5907547511ac05e09eb931f67_1', 'stash', '[{"itemHash":"1683665429-383911","meta":[],"quantity":1,"name":"9mm_rounds","slot":26},{"itemHash":"1683739288-949","meta":[],"quantity":1,"name":"9mm_rounds","slot":21}]', NULL, NULL, NULL, NULL),
	('ambulance_locker_license:b90704455b3efdd5907547511ac05e09eb931f67_2', 'stash', '[{"meta":[],"name":"9mm_rounds","itemHash":"1683665422-105682","quantity":1,"slot":1}]', NULL, NULL, NULL, NULL),
	('bennys_locker', 'stash', '[]', NULL, NULL, NULL, NULL),
	('cardealer_locker_1', 'stash', '[{"name":"pistol","itemHash":"1683049855-902548","meta":{"durability":100,"serial":"0R6H5V9S1E8C2D6U"},"slot":1,"quantity":1},{"name":"pistol","itemHash":"1683049856-264647","meta":{"durability":100,"serial":"0R6H5V9S1E8C2D6U"},"slot":2,"quantity":1}]', NULL, NULL, NULL, NULL),
	('cardealer_locker_license:b90704455b3efdd5907547511ac05e09eb931f67_1', 'stash', '[{"quantity":1,"slot":1,"name":"bandage","meta":{"job":{"ambulance":{"grade":0,"name":"ambulance"}}},"itemHash":"1683739404-803277"},{"quantity":1,"slot":2,"name":"bandage","meta":{"job":{"ambulance":{"grade":0,"name":"ambulance"}}},"itemHash":"1683739405-512491"}]', NULL, NULL, NULL, NULL),
	('glovebox-03ANX808', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-06GIU180', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-09NWL369', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-22FJH984', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-29KQA111', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-29LBW802', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-41RPG962', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-44JLA647', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-48UAV105', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-61KHZ437', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-65XCZ856', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-69LIT727', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-85NFG407', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('glovebox-TESTCAR ', 'BOITE A GANT', '[]', NULL, NULL, NULL, NULL),
	('license:1c5b46ea53fd2dc6e7dd781dbd74118140ab4b4f', 'player', '[]', NULL, NULL, NULL, NULL),
	('license:7896784edbc2f7f3b16c413601f85b334ca96543', 'player', '[{"quantity":-800,"itemHash":"1682631251-409577","name":"money","slot":14,"meta":{"customName":"aa"}}]', NULL, NULL, NULL, NULL),
	('license:b754f5f908d5750f838dc62c60ed7904a6b609a3', 'player', '[{"itemHash":"1683575443-876139","name":"money","meta":[],"slot":1,"quantity":580},{"itemHash":"1683575509-877800","name":"apple","meta":{"customName":"Ta gueule"},"slot":2,"quantity":7},{"itemHash":"1683749890-653351","name":"pistol","meta":{"serial":"7J1Q3D3G9S3M3X2Z","durability":100},"slot":6,"quantity":1},{"itemHash":"1683750072-500129","name":"pistol","meta":{"serial":"7G7T9F6H9B1C7T3P","durability":51.37999999999999},"slot":3,"quantity":1},{"itemHash":"1683750118-649241","name":"9mm_rounds","meta":[],"slot":4,"quantity":46}]', NULL, NULL, NULL, NULL),
	('license:b90704455b3efdd5907547511ac05e09eb931f67', 'player', '[{"name":"handcuffs","itemHash":"1682621498-505524","meta":{"customName":"Scott","note":"Salut"},"slot":3,"quantity":2},{"name":"black_money","itemHash":"1682954655-788878","meta":[],"slot":2,"quantity":150},{"name":"apple","itemHash":"1683672010-718449","meta":[],"slot":4,"quantity":2},{"name":"pistol","itemHash":"1683674744-32839","meta":{"durability":100,"serial":"6K3C1Y0R5V9F1N7B"},"slot":7,"quantity":1},{"name":"medikit","itemHash":"1684604323-584796","meta":{"job":"ambulance","grade":0},"slot":6,"quantity":2},{"name":"pistol","itemHash":"1686160147-612883","meta":{"serial":"8Q2E8L0M5X6E7S1W","durability":97.45,"customName":"Nouvelle arme","attachments":["at_suppressor_light","at_flashlight"],"note":"Just God"},"slot":5,"quantity":1},{"name":"hood","itemHash":"1686261248-98321","meta":[],"slot":8,"quantity":1},{"name":"bandage","itemHash":"1686866793-224240","meta":{"job":"ambulance","grade":0},"slot":9,"quantity":1},{"name":"money","itemHash":"1686866855-508312","meta":[],"slot":1,"quantity":2298261},{"name":"at_suppressor_light","itemHash":"1686893082-735253","meta":[],"slot":10,"quantity":1}]', NULL, NULL, NULL, NULL),
	('license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', 'player', '[{"itemHash":"1686160143-381453","meta":{"attachments":["at_flashlight","at_suppressor_light"],"durability":100,"serial":"4S8M5N6H8V9E1G4Y"},"slot":2,"quantity":1,"name":"pistol"},{"itemHash":"1686160165-941475","meta":{"customName":"Masque 51","value_2":1,"value_1":51},"slot":6,"quantity":1,"name":"mask"}]', NULL, NULL, NULL, NULL),
	('lscustom_locker', 'stash', '[{"meta":{"grade":0,"job":"ambulance"},"quantity":1,"name":"bandage","slot":1,"itemHash":"1686675638-204739"}]', NULL, NULL, NULL, NULL),
	('police_locker_license:7896784edbc2f7f3b16c413601f85b334ca96543_1', 'stash', '[]', NULL, NULL, NULL, NULL),
	('police_locker_license:b90704455b3efdd5907547511ac05e09eb931f67_1', 'stash', '[{"name":"handcuffs","meta":{"job":{"police":{"grade":0,"name":"police"}}},"itemHash":"1683747927-102568","quantity":1,"slot":1},{"name":"armor","meta":{"job":{"police":{"grade":0,"name":"police"}},"durability":100},"itemHash":"1683747928-208360","quantity":1,"slot":2}]', NULL, NULL, NULL, NULL),
	('police_locker_license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66_1', 'stash', '[]', NULL, NULL, NULL, NULL),
	('property_2', 'stash', '[{"itemHash":"1682981055-187576","quantity":1,"name":"9mm_rounds","slot":1,"meta":[]},{"itemHash":"1682981057-311351","quantity":1,"name":"pistol","slot":2,"meta":{"durability":100,"serial":"0R6H5V9S1E8C2D6U"}}]', NULL, NULL, NULL, NULL),
	('property_3', 'stash', '[{"itemHash":"1682981247-329391","quantity":1,"meta":[],"slot":1,"name":"9mm_rounds"}]', NULL, NULL, NULL, NULL),
	('property_4', 'stash', '[{"name":"outfits","itemHash":"1684604319-159776","slot":1,"quantity":1,"meta":{"customName":"Kadir","skin":{"mask_1":0,"eyebrows_6":0,"eyebrows_3":0,"sex":0,"cheeks_1":0,"blush_2":0,"watches_2":0,"eyebrows_5":0,"beard_1":8,"torso_2":0,"chain_1":0,"eyebrows_4":0,"eye_squint":10,"arms_2":0,"jaw_1":0,"hair_color_2":0,"beard_2":9.9,"dad":5,"arms_1":15,"makeup_1":0,"chest_1":0,"bproof_1":0,"chin_2":0,"nose_6":0,"glasses_1":0,"chest_2":0,"watches_1":-1,"moles_1":0,"mask_2":0,"age_1":0,"makeup_3":0,"eye_color":0,"lip_thickness":0,"sun_2":0,"lipstick_1":0,"chin_4":0,"lipstick_2":0,"decals_2":0,"makeup_4":0,"nose_4":0,"torso_1":390,"chin_3":0,"blemishes_2":0,"bproof_2":0,"bodyb_4":0,"lipstick_4":0,"glasses_2":0,"bag_1":0,"beard_3":0,"bag_2":0,"age_2":0,"hair_color_1":0,"helmet_1":160,"helmet_2":2,"nose_2":0,"cheeks_3":0,"bags_2":0,"decals_1":0,"moles_2":0,"bracelets_2":0,"ears_1":-1,"ears_2":0,"pants_2":2,"blush_1":0,"bodyb_1":-1,"pants_1":0,"bodyb_3":-1,"neck_thickness":0,"nose_5":0,"shoes_2":0,"mom":24,"chin_1":0,"hair_1":77,"makeup_2":0,"shoes_1":7,"complexion_1":0,"nose_1":0,"lipstick_3":0,"bodyb_2":0,"complexion_2":0,"bracelets_1":-1,"tshirt_2":0,"hair_2":0,"cheeks_2":0,"blemishes_1":0,"beard_4":0,"nose_3":0,"sun_1":0,"tshirt_1":15,"eyebrows_2":10.0,"bags_1":0,"eyebrows_1":2,"blush_3":0,"jaw_2":0,"chain_2":0,"skin_md_weight":0,"face_md_weight":99,"chest_3":0}}},{"name":"outfits","itemHash":"1684604320-237638","slot":2,"quantity":1,"meta":{"customName":"Sacs2","skin":{"mask_1":0,"eyebrows_6":0,"eyebrows_3":0,"sex":0,"cheeks_1":0,"chin_3":0,"watches_2":0,"eyebrows_5":0,"beard_1":8,"torso_2":9,"face_md_weight":99,"eyebrows_4":0,"eye_squint":10,"arms_2":0,"jaw_1":0,"nose_4":0,"beard_2":9.9,"dad":5,"arms_1":15,"makeup_1":0,"chest_1":0,"bproof_1":0,"chin_2":0,"nose_6":0,"glasses_1":0,"chest_2":0,"watches_1":-1,"moles_1":0,"mask_2":0,"age_1":0,"makeup_3":0,"eye_color":0,"lip_thickness":0,"sun_2":0,"beard_3":0,"chin_4":0,"lipstick_2":0,"nose_2":0,"makeup_4":0,"lipstick_1":0,"moles_2":0,"jaw_2":0,"blemishes_2":0,"torso_1":404,"bodyb_4":0,"lipstick_4":0,"complexion_1":0,"decals_2":0,"bags_1":0,"bag_2":0,"blush_2":0,"hair_color_1":0,"helmet_1":7,"helmet_2":5,"tshirt_1":15,"bproof_2":0,"bags_2":0,"decals_1":0,"chin_1":0,"bracelets_2":0,"ears_1":-1,"cheeks_3":0,"pants_2":2,"blush_1":0,"eyebrows_2":10.0,"pants_1":0,"bodyb_3":-1,"neck_thickness":0,"nose_5":0,"shoes_2":0,"mom":24,"hair_color_2":0,"bodyb_1":-1,"makeup_2":0,"shoes_1":7,"bag_1":0,"nose_1":0,"hair_1":77,"bodyb_2":0,"complexion_2":0,"lipstick_3":0,"tshirt_2":0,"glasses_2":0,"hair_2":0,"sun_1":0,"beard_4":0,"ears_2":0,"cheeks_2":0,"bracelets_1":-1,"blemishes_1":0,"nose_3":0,"eyebrows_1":2,"blush_3":0,"chain_1":0,"chain_2":0,"skin_md_weight":0,"age_2":0,"chest_3":0}}},{"name":"outfits","itemHash":"1684604321-915160","slot":3,"quantity":1,"meta":{"customName":"Sacs","skin":{"mask_1":0,"eyebrows_6":0,"eyebrows_3":0,"sex":0,"cheeks_1":0,"chin_3":0,"watches_2":0,"eyebrows_5":0,"beard_1":8,"torso_2":9,"face_md_weight":99,"eyebrows_4":0,"eye_squint":10,"arms_2":0,"jaw_1":0,"nose_4":0,"beard_2":9.9,"dad":5,"arms_1":15,"makeup_1":0,"chest_1":0,"bproof_1":0,"chin_2":0,"nose_6":0,"glasses_1":0,"chest_2":0,"watches_1":-1,"moles_1":0,"mask_2":0,"age_1":0,"makeup_3":0,"eye_color":0,"lip_thickness":0,"sun_2":0,"beard_3":0,"chin_4":0,"lipstick_2":0,"nose_2":0,"makeup_4":0,"lipstick_1":0,"moles_2":0,"jaw_2":0,"blemishes_2":0,"torso_1":404,"bodyb_4":0,"lipstick_4":0,"complexion_1":0,"decals_2":0,"bags_1":86,"bag_2":0,"blush_2":0,"hair_color_1":0,"helmet_1":7,"helmet_2":5,"tshirt_1":15,"bproof_2":0,"bags_2":0,"decals_1":0,"chin_1":0,"bracelets_2":0,"ears_1":-1,"cheeks_3":0,"pants_2":2,"blush_1":0,"eyebrows_2":10.0,"pants_1":0,"bodyb_3":-1,"neck_thickness":0,"nose_5":0,"shoes_2":0,"mom":24,"hair_color_2":0,"bodyb_1":-1,"makeup_2":0,"shoes_1":7,"bag_1":0,"nose_1":0,"hair_1":77,"bodyb_2":0,"complexion_2":0,"lipstick_3":0,"tshirt_2":0,"glasses_2":0,"hair_2":0,"sun_1":0,"beard_4":0,"ears_2":0,"cheeks_2":0,"bracelets_1":-1,"blemishes_1":0,"nose_3":0,"eyebrows_1":2,"blush_3":0,"chain_1":0,"chain_2":0,"skin_md_weight":0,"age_2":0,"chest_3":0}}},{"name":"outfits","itemHash":"1684618310-602679","slot":4,"quantity":1,"meta":{"customName":"Plage","skin":{"mask_1":0,"complexion_1":0,"eyebrows_3":0,"sex":0,"cheeks_1":0,"blush_2":0,"watches_2":0,"age_2":0,"beard_1":8,"torso_2":9,"face_md_weight":99,"eyebrows_4":0,"eye_squint":10,"arms_2":0,"jaw_1":0,"nose_4":0,"beard_2":9.9,"dad":5,"arms_1":15,"makeup_1":0,"chest_1":0,"bproof_1":0,"chin_2":0,"nose_6":0,"glasses_1":0,"chest_2":0,"watches_1":-1,"moles_1":0,"mask_2":0,"age_1":0,"makeup_3":0,"eye_color":0,"lip_thickness":0,"sun_2":0,"chin_4":0,"lipstick_2":0,"makeup_4":0,"cheeks_3":0,"lipstick_1":0,"moles_2":0,"blemishes_2":0,"hair_2":0,"bodyb_4":0,"lipstick_4":0,"torso_1":404,"nose_3":0,"beard_3":0,"glasses_2":0,"bproof_2":0,"hair_color_1":0,"helmet_1":7,"helmet_2":5,"nose_2":0,"eyebrows_6":0,"bags_2":0,"decals_1":0,"chin_1":0,"bracelets_2":0,"ears_1":-1,"hair_1":77,"pants_2":2,"blush_1":0,"decals_2":0,"pants_1":0,"bodyb_3":-1,"neck_thickness":0,"hair_color_2":0,"shoes_2":0,"mom":24,"bodyb_1":-1,"nose_5":0,"makeup_2":0,"shoes_1":7,"eyebrows_2":10.0,"nose_1":0,"lipstick_3":0,"bodyb_2":0,"complexion_2":0,"bags_1":0,"tshirt_2":0,"ears_2":0,"eyebrows_5":0,"sun_1":0,"beard_4":0,"tshirt_1":15,"bracelets_1":-1,"chain_1":0,"cheeks_2":0,"blemishes_1":0,"eyebrows_1":2,"blush_3":0,"jaw_2":0,"chain_2":0,"skin_md_weight":0,"chin_3":0,"chest_3":0}}},{"name":"outfits","itemHash":"1684689080-509231","slot":5,"quantity":1,"meta":{"customName":"Evan","skin":{"mask_1":0,"complexion_1":0,"eyebrows_3":0,"sex":0,"cheeks_1":0,"chin_3":0,"watches_2":0,"age_2":0,"beard_1":8,"torso_2":0,"chain_1":0,"eyebrows_4":0,"eye_squint":10,"arms_2":0,"bproof_2":0,"hair_color_2":0,"beard_2":9.9,"dad":5,"arms_1":15,"makeup_1":0,"chest_1":0,"bproof_1":0,"chin_2":0,"nose_6":0,"glasses_1":0,"sun_1":0,"watches_1":-1,"moles_1":0,"mask_2":0,"age_1":0,"cheeks_3":0,"eye_color":0,"lip_thickness":0,"sun_2":0,"glasses_2":0,"chin_4":0,"lipstick_2":0,"makeup_2":0,"makeup_4":0,"eyebrows_2":10.0,"bag_1":0,"makeup_3":0,"blemishes_2":0,"hair_1":77,"bodyb_4":0,"lipstick_4":0,"hair_2":0,"blush_2":0,"bags_1":0,"bag_2":0,"eyebrows_6":0,"hair_color_1":0,"nose_5":0,"helmet_2":5,"nose_2":0,"beard_3":0,"bags_2":0,"decals_1":0,"chin_1":0,"bracelets_2":0,"ears_1":-1,"helmet_1":7,"pants_2":0,"blush_1":0,"tshirt_1":15,"pants_1":122,"jaw_2":0,"neck_thickness":0,"jaw_1":0,"shoes_2":0,"mom":24,"moles_2":0,"nose_3":0,"blemishes_1":0,"shoes_1":7,"face_md_weight":99,"nose_1":0,"torso_1":388,"bodyb_2":0,"complexion_2":0,"decals_2":0,"tshirt_2":0,"cheeks_2":0,"ears_2":0,"bodyb_1":-1,"beard_4":0,"lipstick_1":0,"bodyb_3":-1,"chest_2":0,"nose_4":0,"bracelets_1":-1,"eyebrows_1":2,"blush_3":0,"lipstick_3":0,"chain_2":0,"skin_md_weight":0,"eyebrows_5":0,"chest_3":0}}}]', NULL, NULL, NULL, NULL),
	('property_5', 'stash', '[]', NULL, NULL, NULL, NULL),
	('realestateagent_locker_1', 'stash', '[{"name":"armor","itemHash":"1682870452-449536","quantity":1,"meta":{"durability":0},"slot":7}]', NULL, NULL, NULL, NULL),
	('steam:11000011a4c7762', 'player', '[{"name":"money","itemHash":"1686864077-792491","slot":1,"meta":[],"quantity":811979}]', NULL, NULL, NULL, NULL),
	('trunk- LIP309 ', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-01PIU930', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-01WHN499', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-03ANX808', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-06GIU180', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-20LXU507', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-22JJT063', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-23DMA766', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-23KIE978', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-27ZIA119', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-28HWQ093', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-28ISD880', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-29KQA111', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-40WQS876', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-40ZZV609', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-42TTF336', 'COFFRE', '[{"name":"armor","itemHash":"1682625971-984927","slot":1,"meta":{"durability":0},"quantity":1},{"name":"armor","itemHash":"1682626020-443163","slot":6,"meta":{"durability":0},"quantity":1}]', NULL, NULL, NULL, NULL),
	('trunk-46XKM396', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-48UAV105', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-62OOP980', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-64ESB715', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-64WZF837', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-65XCZ856', 'COFFRE', '[]', NULL, NULL, NULL, NULL),
	('trunk-89IRA928', 'COFFRE', '[]', NULL, NULL, NULL, NULL);

-- Listage de la structure de table bluestark_v2. items
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.items : ~64 rows (environ)
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('alive_chicken', 'Living chicken', 1, 0, 1),
	('apple', 'Pomme', 1, 0, 1),
	('bandage', 'Bandage', 2, 0, 1),
	('basketball', 'Basketball', 0, 0, 1),
	('basketball_hoop', 'Basketball Hoop', 0, 0, 1),
	('blowpipe', 'Blowtorch', 2, 0, 1),
	('bread', 'Bread', 1, 0, 1),
	('bunch_of_flowers', 'Bunch Of Flowers', 1, 0, 1),
	('cannabis', 'Cannabis', 3, 0, 1),
	('carnival_ticket', 'Carnival tickets', 0, 0, 1),
	('carokit', 'Body Kit', 3, 0, 1),
	('carotool', 'Tools', 2, 0, 1),
	('cartebancaire', 'Carte Bancaire', -1, 0, 1),
	('casino_beer', 'Casino Beer', 0, 0, 1),
	('casino_burger', 'Casino Burger', 0, 0, 1),
	('casino_chips', 'Casino Chips', 0, 0, 1),
	('casino_coffee', 'Casino Coffee', 0, 0, 1),
	('casino_coke', 'Casino Kofola', 0, 0, 1),
	('casino_donut', 'Casino Donut', 0, 0, 1),
	('casino_ego_chaser', 'Casino Ego Chaser', 0, 0, 1),
	('casino_luckypotion', 'Casino Lucky Potion', 0, 0, 1),
	('casino_psqs', 'Casino Ps & Qs', 0, 0, 1),
	('casino_sandwitch', 'Casino Sandwitch', 0, 0, 1),
	('casino_sprite', 'Casino Sprite', 0, 0, 1),
	('clothe', 'Cloth', 1, 0, 1),
	('copper', 'Copper', 1, 0, 1),
	('cutted_wood', 'Cut wood', 1, 0, 1),
	('diamond', 'Diamond', 1, 0, 1),
	('essence', 'Gas', 1, 0, 1),
	('fabric', 'Fabric', 1, 0, 1),
	('fish', 'Fish', 1, 0, 1),
	('fixkit', 'Repair Kit', 3, 0, 1),
	('fixtool', 'Repair Tools', 2, 0, 1),
	('gazbottle', 'Gas Bottle', 2, 0, 1),
	('gold', 'Gold', 1, 0, 1),
	('iron', 'Iron', 1, 0, 1),
	('marijuana', 'Marijuana', 2, 0, 1),
	('medikit', 'Medikit', 2, 0, 1),
	('packaged_chicken', 'Chicken fillet', 1, 0, 1),
	('packaged_plank', 'Packaged wood', 1, 0, 1),
	('petrol', 'Oil', 1, 0, 1),
	('petrol_raffin', 'Processed oil', 1, 0, 1),
	('phone', 'Phone', 1, 0, 1),
	('pistol_ammo', '9MM', 1, 0, 1),
	('plush_01', 'plush 1', 1, 0, 1),
	('plush_02', 'plush 2', 1, 0, 1),
	('plush_03', 'plush 3', 1, 0, 1),
	('plush_04', 'plush 4', 1, 0, 1),
	('plush_05', 'plush 5', 1, 0, 1),
	('plush_06', 'plush 6', 1, 0, 1),
	('plush_07', 'plush 7', 1, 0, 1),
	('plush_08', 'plush 8', 1, 0, 1),
	('plush_09', 'plush 9', 1, 0, 1),
	('radio', 'Radio', 1, 0, 1),
	('remote', 'remote', 1, 0, 1),
	('rose', 'rose', 1, 0, 1),
	('slaughtered_chicken', 'Slaughtered chicken', 1, 0, 1),
	('spray', 'Spray', 1, 1, 1),
	('spray_remover', 'Spray Remover', 1, 0, 1),
	('stone', 'Stone', 1, 0, 1),
	('teddy', 'teddy', 1, 0, 1),
	('top', 'Torses', 1, 0, 1),
	('washed_stone', 'Washed stone', 1, 0, 1),
	('water', 'Water', 1, 0, 1),
	('weapon_case', 'Caisse d\'arme', 1, 0, 1),
	('wood', 'Wood', 1, 0, 1),
	('wool', 'Wool', 1, 0, 1);

-- Listage de la structure de table bluestark_v2. jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `job_type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.jobs : ~4 rows (environ)
INSERT INTO `jobs` (`name`, `label`, `job_type`) VALUES
	('ambulance', 'EMS', 1),
	('bennys', 'Benny\'s', 1),
	('cardealer', 'CONCESSIONNAIRE', 1),
	('lscustom', 'LS CUSTOM', 1),
	('police', 'LSPD', 1),
	('unemployed', 'Unemployed', 0);

-- Listage de la structure de table bluestark_v2. job_grades
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.job_grades : ~10 rows (environ)
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`) VALUES
	(1, 'unemployed', 0, 'unemployed', 'Unemployed', 200),
	(2, 'police', 0, 'recruit', 'Recruit', 20),
	(3, 'police', 1, 'officer', 'Officer', 40),
	(4, 'police', 2, 'sergeant', 'Sergeant', 60),
	(5, 'police', 3, 'lieutenant', 'Lieutenant', 85),
	(6, 'police', 4, 'boss', 'Captain', 100),
	(22, 'ambulance', 0, 'ambulance', 'Jr. EMT', 20),
	(23, 'ambulance', 1, 'doctor', 'EMT', 40),
	(24, 'ambulance', 2, 'chief_doctor', 'Sr. EMT', 60),
	(25, 'ambulance', 3, 'boss', 'EMT Supervisor', 80),
	(27, 'cardealer', 0, 'recruit', 'Recruit', 200),
	(54, 'lscustom', 0, 'recruit', 'Recrue', 200),
	(55, 'lscustom', 1, 'boss', 'Patron', 200),
	(56, 'bennys', 0, 'recruit', 'Mécanicien', 600),
	(57, 'bennys', 1, 'sous_boss', 'Sous patron', 200),
	(58, 'bennys', 2, 'boss', 'Patron', 8000);

-- Listage de la structure de table bluestark_v2. mechanic
CREATE TABLE IF NOT EXISTS `mechanic` (
  `mechanicId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `cloakroomPosition` longtext DEFAULT NULL,
  `stashPosition` longtext DEFAULT NULL,
  `customPosition` longtext DEFAULT NULL,
  PRIMARY KEY (`mechanicId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Mechanic of BlueStark';

-- Listage des données de la table bluestark_v2.mechanic : ~2 rows (environ)
INSERT INTO `mechanic` (`mechanicId`, `name`, `label`, `cloakroomPosition`, `stashPosition`, `customPosition`) VALUES
	(1, 'lscustom', 'LS CUSTOM', '{"x":-345.1175537109375,"y":-123.24305725097656,"z":39.0096435546875}', '{"x":-344.09326171875,"y":-127.513427734375,"z":39.0096435546875}', '[{"x":-338.3681945800781,"y":-136.86471557617188,"z":39.00967788696289}]'),
	(2, 'bennys', 'Benny\'s', '{"x":-215.80677795410157,"y":-1317.822021484375,"z":30.89040184020996}', '{"x":-196.8661651611328,"y":-1318.9010009765626,"z":31.08934020996093}', '[{"x":-211.2228240966797,"y":-1323.5152587890626,"z":30.89039802551269}]');

-- Listage de la structure de table bluestark_v2. owned_vehicles
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(60) DEFAULT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `stored` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.owned_vehicles : ~2 rows (environ)
INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `type`, `stored`) VALUES
	('license:b90704455b3efdd5907547511ac05e09eb931f67', 'SEL397', '{"engineHealth":998.4,"modDoorSpeaker":3,"modTrimB":5,"modEngineBlock":-1,"modDoorR":-1,"modSuspension":3,"modArmor":-1,"modTransmission":2,"dirtLevel":4.4,"interiorColor":93,"id":"sel397_1726022652","pearlescentColor":73,"modSteeringWheel":15,"windowTint":-1,"bodyHealth":999.5,"plate":"SEL397","modFrontWheels":214,"wheelColor":0,"tyreSmokeColor":[255,255,255],"modPlateHolder":2,"modRightFender":2,"modVanityPlate":4,"modAPlate":-1,"modSpoilers":23,"modSideSkirt":9,"modExhaust":4,"neonEnabled":[false,false,false,false],"modRearBumper":9,"color1":2,"modXenon":1,"modDial":-1,"modTrimA":1,"modLivery":13,"xenonColor":7,"dashboardColor":134,"windowsBroken":{"0":false,"7":false,"2":false,"1":false,"4":true,"3":false,"6":false,"5":true},"neonColor":[255,0,255],"tankHealth":999.9,"modFrame":6,"plateIndex":0,"modHydrolic":-1,"customSecondaryColor":[255,0,0],"extras":[],"modTrunk":-1,"tyreBurst":{"0":false,"1":false,"4":false,"5":false},"fuelLevel":60.0,"modBackWheels":-1,"wheels":9,"color2":146,"modSmokeEnabled":1,"model":-1726022652,"modEngine":3,"modHood":13,"modFrontBumper":7,"modGrille":-1,"modArchCover":8,"modAirFilter":-1,"modLightbar":-1,"modTank":-1,"modDashboard":6,"modOrnaments":-1,"customPrimaryColor":[255,0,0],"modFender":3,"modAerials":6,"modBrakes":2,"doorsBroken":{"0":false,"2":false,"1":false,"4":false,"3":false},"modStruts":-1,"modSeats":13,"modShifterLeavers":-1,"modSpeakers":-1,"modHorns":57,"modTurbo":1,"modRoof":1}', 'car', 1),
	('license:b90704455b3efdd5907547511ac05e09eb931f67', 'RTT102', '{"modTrunk":-1,"modRightFender":-1,"modDashboard":-1,"modEngine":3,"windowTint":-1,"wheels":9,"modHydrolic":-1,"modTrimA":-1,"modGrille":-1,"modVanityPlate":-1,"color1":0,"tyreBurst":{"5":false,"0":false,"4":false,"1":false},"modSteeringWheel":-1,"wheelColor":0,"model":661493923,"modStruts":-1,"modBrakes":2,"modRearBumper":1,"id":"rtt102_661493923","dashboardColor":65,"modEngineBlock":-1,"modFrame":1,"dirtLevel":7.4,"modFrontBumper":2,"modDial":-1,"modArmor":-1,"modDoorSpeaker":-1,"engineHealth":999.5,"modHood":1,"neonColor":[255,0,0],"modSeats":-1,"modSmokeEnabled":1,"modTrimB":-1,"customSecondaryColor":[255,0,0],"modPlateHolder":-1,"modSpoilers":7,"plateIndex":0,"modTurbo":1,"modLightbar":-1,"modBackWheels":-1,"modXenon":1,"modExhaust":3,"modTransmission":2,"modHorns":57,"modAerials":-1,"color2":1,"modAPlate":-1,"modRoof":1,"modFender":0,"modOrnaments":-1,"modSuspension":2,"modArchCover":-1,"modDoorR":-1,"fuelLevel":60.0,"pearlescentColor":2,"extras":[],"modLivery":-1,"modFrontWheels":208,"modTank":-1,"plate":"RTT102","tyreSmokeColor":[255,255,255],"bodyHealth":999.5,"modAirFilter":-1,"xenonColor":3,"tankHealth":999.9,"modSpeakers":-1,"modSideSkirt":2,"interiorColor":93,"neonEnabled":[1,1,1,1],"modShifterLeavers":-1,"windowsBroken":{"5":true,"4":true,"3":false,"2":false,"1":false,"0":false,"7":false,"6":false},"doorsBroken":{"4":false,"3":false,"2":false,"1":false,"0":false}}', 'car', 1);

-- Listage de la structure de table bluestark_v2. phone_backups
CREATE TABLE IF NOT EXISTS `phone_backups` (
  `identifier` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_backups : ~0 rows (environ)
INSERT INTO `phone_backups` (`identifier`, `phone_number`) VALUES
	('license:b90704455b3efdd5907547511ac05e09eb931f67', '6028168179');

-- Listage de la structure de table bluestark_v2. phone_clock_alarms
CREATE TABLE IF NOT EXISTS `phone_clock_alarms` (
  `id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `hours` int(2) NOT NULL DEFAULT 0,
  `minutes` int(2) NOT NULL DEFAULT 0,
  `label` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`,`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_clock_alarms : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_crypto
CREATE TABLE IF NOT EXISTS `phone_crypto` (
  `identifier` varchar(100) NOT NULL,
  `coin` varchar(15) NOT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `invested` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`,`coin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_crypto : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_darkchat_accounts
CREATE TABLE IF NOT EXISTS `phone_darkchat_accounts` (
  `phone_number` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_darkchat_accounts : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_darkchat_channels
CREATE TABLE IF NOT EXISTS `phone_darkchat_channels` (
  `name` varchar(50) NOT NULL,
  `last_message` varchar(50) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_darkchat_channels : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_darkchat_members
CREATE TABLE IF NOT EXISTS `phone_darkchat_members` (
  `channel_name` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`channel_name`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_darkchat_members : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_darkchat_messages
CREATE TABLE IF NOT EXISTS `phone_darkchat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(50) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_darkchat_messages : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_instagram_accounts
CREATE TABLE IF NOT EXISTS `phone_instagram_accounts` (
  `display_name` varchar(30) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `profile_image` varchar(200) DEFAULT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) NOT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `date_joined` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_accounts : ~0 rows (environ)
INSERT INTO `phone_instagram_accounts` (`display_name`, `username`, `password`, `profile_image`, `bio`, `phone_number`, `verified`, `date_joined`) VALUES
	('Believer', 'believer', '$2a$11$nF4qd9N8UEocLtoNL5wuMO4W2Sq7IHTVJ4U7alAmzAs6sLFPZRPdu', NULL, NULL, '6028168179', 0, '2023-02-18 11:23:58');

-- Listage de la structure de table bluestark_v2. phone_instagram_comments
CREATE TABLE IF NOT EXISTS `phone_instagram_comments` (
  `id` varchar(50) NOT NULL,
  `post_id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `comment` varchar(500) NOT NULL DEFAULT '',
  `like_count` int(11) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_comments : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_instagram_follows
CREATE TABLE IF NOT EXISTS `phone_instagram_follows` (
  `followed` varchar(20) NOT NULL,
  `follower` varchar(20) NOT NULL,
  PRIMARY KEY (`followed`,`follower`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_follows : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_instagram_likes
CREATE TABLE IF NOT EXISTS `phone_instagram_likes` (
  `id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `is_comment` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_likes : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_instagram_loggedin
CREATE TABLE IF NOT EXISTS `phone_instagram_loggedin` (
  `phone_number` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_loggedin : ~0 rows (environ)
INSERT INTO `phone_instagram_loggedin` (`phone_number`, `username`) VALUES
	('6028168179', 'believer');

-- Listage de la structure de table bluestark_v2. phone_instagram_messages
CREATE TABLE IF NOT EXISTS `phone_instagram_messages` (
  `id` varchar(50) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `recipient` varchar(20) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_messages : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_instagram_notifications
CREATE TABLE IF NOT EXISTS `phone_instagram_notifications` (
  `id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `from` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `post_id` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_notifications : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_instagram_posts
CREATE TABLE IF NOT EXISTS `phone_instagram_posts` (
  `id` varchar(50) NOT NULL,
  `media` text DEFAULT NULL,
  `caption` varchar(500) NOT NULL DEFAULT '',
  `like_count` int(11) NOT NULL DEFAULT 0,
  `comment_count` int(11) NOT NULL DEFAULT 0,
  `username` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_posts : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_instagram_stories
CREATE TABLE IF NOT EXISTS `phone_instagram_stories` (
  `id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `image` varchar(200) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  CONSTRAINT `phone_instagram_stories_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_stories : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_instagram_stories_views
CREATE TABLE IF NOT EXISTS `phone_instagram_stories_views` (
  `story_id` varchar(50) NOT NULL,
  `viewer` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`story_id`,`viewer`),
  CONSTRAINT `phone_instagram_stories_views_ibfk_1` FOREIGN KEY (`story_id`) REFERENCES `phone_instagram_stories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_instagram_stories_views : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_last_phone
CREATE TABLE IF NOT EXISTS `phone_last_phone` (
  `identifier` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_last_phone : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_mail_accounts
CREATE TABLE IF NOT EXISTS `phone_mail_accounts` (
  `address` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_mail_accounts : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_mail_loggedin
CREATE TABLE IF NOT EXISTS `phone_mail_loggedin` (
  `address` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`address`,`phone_number`),
  CONSTRAINT `phone_mail_loggedin_ibfk_1` FOREIGN KEY (`address`) REFERENCES `phone_mail_accounts` (`address`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_mail_loggedin : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_mail_messages
CREATE TABLE IF NOT EXISTS `phone_mail_messages` (
  `id` varchar(50) NOT NULL,
  `recipient` varchar(100) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `attachments` longtext DEFAULT NULL,
  `actions` longtext DEFAULT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_mail_messages : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_maps_locations
CREATE TABLE IF NOT EXISTS `phone_maps_locations` (
  `id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `x_pos` float NOT NULL,
  `y_pos` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_maps_locations : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_marketplace_posts
CREATE TABLE IF NOT EXISTS `phone_marketplace_posts` (
  `id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `attachments` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_marketplace_posts : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_message_channels
CREATE TABLE IF NOT EXISTS `phone_message_channels` (
  `channel_id` varchar(50) NOT NULL,
  `is_group` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(50) DEFAULT NULL,
  `last_message` varchar(50) NOT NULL DEFAULT '',
  `last_message_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_message_channels : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_message_members
CREATE TABLE IF NOT EXISTS `phone_message_members` (
  `channel_id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `is_owner` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`channel_id`,`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_message_members : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_message_messages
CREATE TABLE IF NOT EXISTS `phone_message_messages` (
  `id` varchar(50) NOT NULL,
  `channel_id` varchar(50) NOT NULL,
  `sender` varchar(15) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_message_messages : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_message_unread
CREATE TABLE IF NOT EXISTS `phone_message_unread` (
  `channel_id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `unread` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`channel_id`,`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_message_unread : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_music_playlists
CREATE TABLE IF NOT EXISTS `phone_music_playlists` (
  `id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `cover` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_music_playlists : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_music_saved_playlists
CREATE TABLE IF NOT EXISTS `phone_music_saved_playlists` (
  `playlist_id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`playlist_id`,`phone_number`),
  CONSTRAINT `phone_music_saved_playlists_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_music_saved_playlists : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_music_songs
CREATE TABLE IF NOT EXISTS `phone_music_songs` (
  `song_id` varchar(100) NOT NULL,
  `playlist_id` varchar(50) NOT NULL,
  PRIMARY KEY (`song_id`,`playlist_id`),
  KEY `playlist_id` (`playlist_id`),
  CONSTRAINT `phone_music_songs_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_music_songs : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_notes
CREATE TABLE IF NOT EXISTS `phone_notes` (
  `id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` longtext DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_notes : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_notifications
CREATE TABLE IF NOT EXISTS `phone_notifications` (
  `id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `app` varchar(50) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `thumbnail` varchar(250) DEFAULT NULL,
  `avatar` varchar(250) DEFAULT NULL,
  `show_avatar` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_notifications : ~0 rows (environ)
INSERT INTO `phone_notifications` (`id`, `phone_number`, `app`, `title`, `content`, `thumbnail`, `avatar`, `show_avatar`, `timestamp`) VALUES
	('395456E2UXL65zt168pwO25C35x7v547PR4T185vmG1o66AuYW', '6028168179', 'Garage', 'Valet', 'Véhicule introuvable.', NULL, NULL, NULL, '2023-02-25 20:49:18');

-- Listage de la structure de table bluestark_v2. phone_phones
CREATE TABLE IF NOT EXISTS `phone_phones` (
  `id` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pin` varchar(4) DEFAULT NULL,
  `face_id` varchar(100) DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `is_setup` tinyint(1) DEFAULT 0,
  `assigned` tinyint(1) DEFAULT 0,
  `battery` int(11) NOT NULL DEFAULT 100,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_phones : ~0 rows (environ)
INSERT INTO `phone_phones` (`id`, `phone_number`, `name`, `pin`, `face_id`, `settings`, `is_setup`, `assigned`, `battery`) VALUES
	('license:b90704455b3efdd5907547511ac05e09eb931f67', '6028168179', 'Joshua\'s Phone', '0704', 'license:b90704455b3efdd5907547511ac05e09eb931f67', '{"phone":{"showCallerId":true},"locale":"fr","security":{"faceId":true,"pinCode":true},"doNotDisturb":false,"name":"Joshua\'s Phone","sound":{"silent":false,"volume":"0.6","ringtone":"default"},"apps":[["Phone","Messages","Camera","Photos"],["Settings","AppStore","Clock","Garage","Notes","Calculator","Weather","Maps","Wallet","Home","Music","Mail","Services","2048","YellowPages","DarkChat","Instagram","Tinder","Crypto","MarketPlace","Twitter"]],"time":{"twelveHourClock":false},"notifications":[],"display":{"brightness":1,"size":0.7,"theme":"light"},"weather":{"celcius":false},"wallpaper":{"background":"IOS16_2"},"airplaneMode":false,"storage":{"used":8576331,"total":128000000},"streamerMode":false}', 1, 0, 100);

-- Listage de la structure de table bluestark_v2. phone_phone_blocked_numbers
CREATE TABLE IF NOT EXISTS `phone_phone_blocked_numbers` (
  `phone_number` varchar(15) NOT NULL,
  `blocked_number` varchar(15) NOT NULL,
  PRIMARY KEY (`phone_number`,`blocked_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_phone_blocked_numbers : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_phone_calls
CREATE TABLE IF NOT EXISTS `phone_phone_calls` (
  `id` varchar(50) NOT NULL,
  `caller` varchar(15) NOT NULL,
  `callee` varchar(15) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `answered` tinyint(1) DEFAULT 0,
  `hide_caller_id` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_phone_calls : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_phone_contacts
CREATE TABLE IF NOT EXISTS `phone_phone_contacts` (
  `contact_phone_number` varchar(15) NOT NULL,
  `firstname` varchar(50) NOT NULL DEFAULT '',
  `lastname` varchar(50) NOT NULL DEFAULT '',
  `profile_image` varchar(200) DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT 0,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`contact_phone_number`,`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_phone_contacts : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_photos
CREATE TABLE IF NOT EXISTS `phone_photos` (
  `phone_number` varchar(15) NOT NULL,
  `link` varchar(200) NOT NULL,
  `is_video` tinyint(1) DEFAULT 0,
  `size` float NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`phone_number`,`link`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_photos : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_services_channels
CREATE TABLE IF NOT EXISTS `phone_services_channels` (
  `id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `company` varchar(50) NOT NULL,
  `last_message` varchar(100) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_services_channels : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_services_messages
CREATE TABLE IF NOT EXISTS `phone_services_messages` (
  `id` varchar(50) NOT NULL,
  `channel_id` varchar(50) NOT NULL,
  `sender` varchar(15) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `x_pos` int(11) DEFAULT NULL,
  `y_pos` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `phone_services_messages_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_services_channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_services_messages : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_tinder_accounts
CREATE TABLE IF NOT EXISTS `phone_tinder_accounts` (
  `name` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `photos` text DEFAULT NULL,
  `bio` varchar(500) DEFAULT NULL,
  `dob` date NOT NULL,
  `is_male` tinyint(1) NOT NULL,
  `interested_men` tinyint(1) NOT NULL,
  `interested_women` tinyint(1) NOT NULL,
  PRIMARY KEY (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_tinder_accounts : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_tinder_matches
CREATE TABLE IF NOT EXISTS `phone_tinder_matches` (
  `phone_number_1` varchar(15) NOT NULL,
  `phone_number_2` varchar(15) NOT NULL,
  `latest_message` varchar(1000) DEFAULT NULL,
  `latest_message_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`phone_number_1`,`phone_number_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_tinder_matches : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_tinder_messages
CREATE TABLE IF NOT EXISTS `phone_tinder_messages` (
  `id` varchar(50) NOT NULL,
  `sender` varchar(15) NOT NULL,
  `recipient` varchar(15) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_tinder_messages : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_tinder_swipes
CREATE TABLE IF NOT EXISTS `phone_tinder_swipes` (
  `swiper` varchar(15) NOT NULL,
  `swipee` varchar(15) NOT NULL,
  `liked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`swiper`,`swipee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_tinder_swipes : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_accounts
CREATE TABLE IF NOT EXISTS `phone_twitter_accounts` (
  `display_name` varchar(30) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `profile_image` varchar(200) DEFAULT NULL,
  `profile_header` varchar(200) DEFAULT NULL,
  `pinned_tweet` varchar(50) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `follower_count` int(11) NOT NULL DEFAULT 0,
  `following_count` int(11) NOT NULL DEFAULT 0,
  `date_joined` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_accounts : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_follows
CREATE TABLE IF NOT EXISTS `phone_twitter_follows` (
  `followed` varchar(20) NOT NULL,
  `follower` varchar(20) NOT NULL,
  `notifications` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`followed`,`follower`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_follows : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_hashtags
CREATE TABLE IF NOT EXISTS `phone_twitter_hashtags` (
  `hashtag` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `last_used` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`hashtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_hashtags : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_likes
CREATE TABLE IF NOT EXISTS `phone_twitter_likes` (
  `tweet_id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`tweet_id`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_likes : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_loggedin
CREATE TABLE IF NOT EXISTS `phone_twitter_loggedin` (
  `phone_number` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_loggedin : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_messages
CREATE TABLE IF NOT EXISTS `phone_twitter_messages` (
  `id` varchar(50) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `recipient` varchar(20) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_messages : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_notifications
CREATE TABLE IF NOT EXISTS `phone_twitter_notifications` (
  `id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `from` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `tweet_id` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_notifications : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_promoted
CREATE TABLE IF NOT EXISTS `phone_twitter_promoted` (
  `tweet_id` varchar(50) NOT NULL,
  `promotions` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tweet_id`),
  CONSTRAINT `phone_twitter_promoted_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `phone_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_promoted : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_retweets
CREATE TABLE IF NOT EXISTS `phone_twitter_retweets` (
  `tweet_id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`tweet_id`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_retweets : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_twitter_tweets
CREATE TABLE IF NOT EXISTS `phone_twitter_tweets` (
  `id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `content` varchar(280) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `reply_to` varchar(50) DEFAULT NULL,
  `like_count` int(11) DEFAULT 0,
  `reply_count` int(11) DEFAULT 0,
  `retweet_count` int(11) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_twitter_tweets : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_wallet_transactions
CREATE TABLE IF NOT EXISTS `phone_wallet_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `amount` int(11) NOT NULL,
  `company` varchar(50) NOT NULL,
  `logo` varchar(200) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_wallet_transactions : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. phone_yellow_pages_posts
CREATE TABLE IF NOT EXISTS `phone_yellow_pages_posts` (
  `id` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `attachment` varchar(500) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table bluestark_v2.phone_yellow_pages_posts : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. property
CREATE TABLE IF NOT EXISTS `property` (
  `propertyId` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(55) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `position` longtext DEFAULT NULL,
  `job` longtext DEFAULT NULL,
  `players` longtext DEFAULT NULL,
  PRIMARY KEY (`propertyId`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Property of BlueStark';

-- Listage des données de la table bluestark_v2.property : ~26 rows (environ)
INSERT INTO `property` (`propertyId`, `identifier`, `type`, `label`, `position`, `job`, `players`) VALUES
	(4, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 1, 'Zeit', '{"x":-773.97045898438,"y":311.88284301758,"z":85.698165893555}', '[]', '{}'),
	(5, 'sell', 1, NULL, '{"x":-780.74060058594,"y":270.52813720703,"z":85.793922424316}', NULL, NULL),
	(6, 'license:b90704455b3efdd5907547511ac05e09e', 1, NULL, '{"x":-753.54351806641,"y":275.89605712891,"z":85.758857727051}', NULL, NULL),
	(7, 'sell', 1, NULL, '{"x":-787.9346313476563,"y":286.2456970214844,"z":85.87276458740235}', NULL, NULL),
	(8, 'sell', 1, NULL, '{"x":-795.756591796875,"y":289.5910339355469,"z":85.86404418945313}', NULL, NULL),
	(9, 'sell', 1, NULL, '{"x":-802.1565551757813,"y":285.36944580078127,"z":86.1533203125}', NULL, NULL),
	(10, 'sell', 1, NULL, '{"x":-813.2376098632813,"y":285.074462890625,"z":86.29878997802735}', NULL, NULL),
	(11, 'sell', 1, NULL, '{"x":-828.7854614257813,"y":295.0243835449219,"z":86.31932830810547}', NULL, NULL),
	(12, 'sell', 1, NULL, '{"x":-828.7854614257813,"y":295.0243835449219,"z":86.31932830810547}', NULL, NULL),
	(13, 'sell', 1, NULL, '{"x":-857.1345825195313,"y":300.2007141113281,"z":85.95433807373047}', NULL, NULL),
	(14, 'sell', 1, NULL, '{"x":431.7903137207031,"y":-814.7837524414063,"z":28.77633476257324}', NULL, NULL),
	(15, 'sell', 1, NULL, '{"x":429.13043212890627,"y":-823.1741333007813,"z":28.92066192626953}', NULL, NULL),
	(16, 'sell', 1, NULL, '{"x":429.13043212890627,"y":-823.1741333007813,"z":28.92066192626953}', NULL, NULL),
	(17, 'sell', 1, NULL, '{"x":429.13043212890627,"y":-823.1741333007813,"z":28.92066192626953}', NULL, NULL),
	(18, 'sell', 1, NULL, '{"x":429.13043212890627,"y":-823.1741333007813,"z":28.92066192626953}', NULL, NULL),
	(19, 'sell', 1, NULL, '{"x":429.13043212890627,"y":-823.1741333007813,"z":28.92066192626953}', NULL, NULL),
	(20, 'sell', 1, NULL, '{"x":429.13043212890627,"y":-823.1741333007813,"z":28.92066192626953}', NULL, NULL),
	(21, 'sell', 1, NULL, '{"x":435.5792541503906,"y":-830.226806640625,"z":28.50296211242675}', NULL, NULL),
	(22, 'sell', 1, NULL, '{"x":449.7189636230469,"y":-820.2166748046875,"z":27.89688873291015}', NULL, NULL),
	(23, 'sell', 1, NULL, '{"x":772.3128662109375,"y":-2150.500732421875,"z":20.81883430480957}', NULL, NULL),
	(24, 'sell', 1, NULL, '{"x":767.3939819335938,"y":-2165.9736328125,"z":20.79963874816894}', NULL, NULL),
	(25, 'sell', 1, NULL, '{"x":765.1441650390625,"y":-2182.430419921875,"z":20.79903602600097}', NULL, NULL),
	(26, 'sell', 1, NULL, '{"x":-257.5541076660156,"y":-980.805908203125,"z":31.21999931335449}', NULL, NULL),
	(27, 'sell', 1, NULL, '{"x":-251.91357421875,"y":-973.923583984375,"z":31.21998977661132}', NULL, NULL),
	(28, 'sell', 1, NULL, '{"x":-247.4380645751953,"y":-962.9912719726563,"z":31.21999359130859}', NULL, NULL),
	(29, 'sell', 1, NULL, '{"x":-775.2017211914063,"y":273.1377868652344,"z":85.77735137939453}', NULL, NULL);

-- Listage de la structure de table bluestark_v2. races
CREATE TABLE IF NOT EXISTS `races` (
  `identifier` varchar(255) NOT NULL,
  `nickname` varchar(80) DEFAULT NULL,
  `elo` int(11) DEFAULT 1200,
  `unitsDriven` float DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.races : ~0 rows (environ)
INSERT INTO `races` (`identifier`, `nickname`, `elo`, `unitsDriven`) VALUES
	('license:b90704455b3efdd5907547511ac05e09eb931f67', 'Believer', 1200, 0);

-- Listage de la structure de table bluestark_v2. radiocar_music
CREATE TABLE IF NOT EXISTS `radiocar_music` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(64) NOT NULL,
  `url` varchar(256) NOT NULL,
  `plate` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.radiocar_music : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. radiocar_owned
CREATE TABLE IF NOT EXISTS `radiocar_owned` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spz` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.radiocar_owned : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. radiocar_playlist
CREATE TABLE IF NOT EXISTS `radiocar_playlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `playlist` text NOT NULL,
  `plate` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.radiocar_playlist : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. society
CREATE TABLE IF NOT EXISTS `society` (
  `societyId` int(11) NOT NULL AUTO_INCREMENT,
  `job_type` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `menuPosition` longtext DEFAULT NULL,
  `money` longtext DEFAULT NULL,
  `laudering` longtext DEFAULT NULL,
  PRIMARY KEY (`societyId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Society of BlueStark';

-- Listage des données de la table bluestark_v2.society : ~2 rows (environ)
INSERT INTO `society` (`societyId`, `job_type`, `name`, `label`, `menuPosition`, `money`, `laudering`) VALUES
	(1, 1, 'bennys', 'Benny\'s', '{"x":-227.1562957763672,"y":-1327.3016357421876,"z":30.89039421081543}', '{"black_money":2000,"money":10000}', '{"amount":2000,"time":1686896551,"active":true}'),
	(2, 1, 'police', 'Police', '{"x":-218.30311584472657,"y":-1329.8072509765626,"z":30.89041137695312}', '{"money":50000}', '[]');

-- Listage de la structure de table bluestark_v2. sprays
CREATE TABLE IF NOT EXISTS `sprays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(64) DEFAULT NULL,
  `x` float(8,4) NOT NULL,
  `y` float(8,4) NOT NULL,
  `z` float(8,4) NOT NULL,
  `origZ` float(8,4) NOT NULL,
  `origY` float(8,4) NOT NULL,
  `origX` float(8,4) NOT NULL,
  `rx` float(8,4) NOT NULL,
  `ry` float(8,4) NOT NULL,
  `rz` float(8,4) NOT NULL,
  `scale` float(8,4) NOT NULL,
  `text` varchar(32) DEFAULT NULL,
  `imageDict` varchar(64) DEFAULT NULL,
  `image` varchar(64) DEFAULT NULL,
  `font` varchar(32) DEFAULT NULL,
  `color` varchar(32) DEFAULT NULL,
  `interior` int(3) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Listage des données de la table bluestark_v2.sprays : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. users
CREATE TABLE IF NOT EXISTS `users` (
  `uniqueId` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(55) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job2` varchar(20) DEFAULT 'unemployed2',
  `job_grade` int(11) DEFAULT 0,
  `job2_grade` int(11) DEFAULT 0,
  `position` varchar(255) DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dateofbirth` varchar(50) DEFAULT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `first_connection` int(20) DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `tattoos` longtext DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `id` (`uniqueId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.users : ~6 rows (environ)
INSERT INTO `users` (`uniqueId`, `identifier`, `accounts`, `job`, `job2`, `job_grade`, `job2_grade`, `position`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `skin`, `status`, `is_dead`, `first_connection`, `metadata`, `tattoos`) VALUES
	(5, 'license:1c5b46ea53fd2dc6e7dd781dbd74118140ab4b4f', '{"bank":52000,"black_money":0,"money":0}', 'unemployed', 'unemployed', 0, 0, '{"x":217.96482849121095,"y":-810.6593627929688,"z":30.6783447265625}', 'Kadir', 'Lepd', NULL, NULL, NULL, NULL, '[{"name":"hunger","val":893125,"percent":89.3125},{"name":"thirst","val":836125,"percent":83.6125}]', 0, 1682077024, '[]', NULL),
	(4, 'license:7896784edbc2f7f3b16c413601f85b334ca96543', '{"money":-800,"bank":59580,"black_money":0}', 'unemployed', 'unemployed', 2, 0, '{"x":-1899.177978515625,"y":-337.9252624511719,"z":53.6951904296875}', 'Evan', 'Moula', NULL, NULL, NULL, NULL, '[{"percent":91.93,"val":919300,"name":"hunger"},{"percent":87.626,"val":876260,"name":"thirst"}]', 0, 1681849983, '[]', NULL),
	(6, 'license:b754f5f908d5750f838dc62c60ed7904a6b609a3', '{"money":580,"black_money":0,"bank":68485}', 'unemployed', 'unemployed', 4, 0, '{"x":285.9296569824219,"y":-961.7802124023438,"z":29.4146728515625}', 'Nana', 'Bouffone', NULL, NULL, NULL, NULL, '[{"val":0,"name":"hunger","percent":0.0},{"val":0,"name":"thirst","percent":0.0},{"val":0,"name":"hunger","percent":0.0},{"val":0,"name":"thirst","percent":0.0}]', 0, 1683552001, '[]', NULL),
	(1, 'license:b90704455b3efdd5907547511ac05e09eb931f67', '{"money":2298261,"black_money":150,"bank":2218440}', 'bennys', 'unemployed', 2, 0, '{"x":166.11428833007813,"y":-918.3692016601563,"z":30.6951904296875}', 'Joshua', 'Stark', '2003-04-07', '0', 190, '{"arms_1":15,"bags_1":0,"skin_md_weight":0,"ears_1":-1,"tshirt_1":15,"bproof_1":0,"nose_3":0,"eyebrows_1":2,"watches_2":0,"mask_2":0,"jaw_2":0,"sun_1":0,"jaw_1":0,"age_1":0,"helmet_2":5,"chain_1":0,"eyebrows_5":0,"makeup_3":0,"decals_2":0,"cheeks_2":0,"beard_3":0,"chin_2":0,"bproof_2":0,"pants_1":122,"hair_2":0,"age_2":0,"mask_1":0,"nose_2":0,"dad":5,"eye_squint":10,"makeup_2":0,"moles_1":0,"eyebrows_3":0,"makeup_4":0,"lipstick_2":0,"cheeks_1":0,"chest_1":0,"blemishes_1":0,"nose_1":0,"eyebrows_4":0,"blush_1":0,"lipstick_4":0,"complexion_2":0,"makeup_1":0,"shoes_2":0,"arms_2":0,"bodyb_4":0,"lipstick_1":0,"eyebrows_2":10.0,"nose_6":0,"beard_2":9.9,"eye_color":0,"sex":0,"bags_2":0,"cheeks_3":0,"beard_4":0,"eyebrows_6":0,"decals_1":0,"beard_1":8,"chest_2":0,"bodyb_3":-1,"bracelets_1":-1,"chin_3":0,"chain_2":0,"torso_2":0,"chin_1":0,"glasses_2":0,"hair_1":77,"lipstick_3":0,"nose_4":0,"mom":24,"blush_3":0,"bag_1":0,"nose_5":0,"tshirt_2":0,"bodyb_1":-1,"neck_thickness":0,"ears_2":0,"pants_2":0,"chin_4":0,"watches_1":-1,"blemishes_2":0,"sun_2":0,"face_md_weight":99,"blush_2":0,"chest_3":0,"bracelets_2":0,"hair_color_2":0,"bodyb_2":0,"shoes_1":7,"moles_2":0,"bag_2":0,"torso_1":388,"lip_thickness":0,"glasses_1":0,"helmet_1":7,"complexion_1":0,"hair_color_1":0}', '[{"val":0,"percent":0.0,"name":"hunger"},{"val":0,"percent":0.0,"name":"thirst"}]', 0, 1681667990, '[]', '[{"name":"MP_LUXE_TAT_023_M","collection":"mpluxe2_overlays"},{"name":"MP_MP_Biker_Tat_047_M","collection":"mpbiker_overlays"},{"name":"MP_Christmas2017_Tattoo_008_M","collection":"mpchristmas2017_overlays"},{"name":"MP_Xmas2_M_Tat_019","collection":"mpchristmas2_overlays"}]'),
	(2, 'license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', '{"bank":76800,"black_money":0,"money":0}', 'unemployed', 'unemployed', 1, 0, '{"x":269.69671630859377,"y":-68.82197570800781,"z":70.03955078125}', 'Fils', 'Depute', '2001-11-09', '0', 181, '{"cheeks_3":6,"blush_2":0,"bproof_1":0,"complexion_1":0,"beard_4":0,"shoes_1":105,"mask_1":0,"eye_squint":0,"ears_1":-1,"beard_1":19,"blush_3":0,"eyebrows_3":0,"makeup_4":0,"makeup_2":0,"shoes_2":0,"nose_6":0,"beard_3":0,"pants_2":5,"tshirt_2":0,"bodyb_2":0,"torso_2":0,"ears_2":0,"moles_1":0,"cheeks_1":5,"arms_1":0,"mask_2":0,"glasses_1":0,"neck_thickness":0,"watches_2":0,"glasses_2":0,"decals_2":0,"chest_2":0,"decals_1":0,"skin_md_weight":68,"chest_3":0,"hair_color_1":0,"lipstick_3":0,"chin_2":0,"pants_1":168,"sun_1":0,"mom":39,"cheeks_2":-10,"blemishes_1":0,"arms_2":0,"chin_1":0,"bracelets_1":-1,"watches_1":-1,"jaw_2":0,"lip_thickness":0,"nose_3":-8,"chain_1":0,"bracelets_2":0,"eyebrows_6":0,"bodyb_4":0,"bodyb_3":-1,"beard_2":0,"bags_2":0,"arms":1,"dad":19,"nose_1":-10,"chain_2":0,"nose_5":0,"bags_1":0,"moles_2":0,"hair_color_2":0,"complexion_2":0,"jaw_1":0,"eye_color":10,"chin_3":0,"age_1":0,"lipstick_4":0,"nose_4":0,"hair_2":0,"nose_2":8,"makeup_3":0,"sun_2":0,"eyebrows_2":0,"torso_1":499,"lipstick_2":0,"makeup_1":0,"helmet_2":0,"lipstick_1":0,"chest_1":0,"eyebrows_5":0,"age_2":0,"blemishes_2":0,"face_md_weight":26,"eyebrows_4":0,"blush_1":0,"tshirt_1":15,"bodyb_1":-1,"hair_1":66,"sex":0,"helmet_1":-1,"eyebrows_1":0,"bproof_2":0,"chin_4":0}', '[{"percent":98.59750000000001,"val":985975,"name":"hunger"},{"percent":97.8495,"val":978495,"name":"thirst"}]', 0, 1681675428, '[]', NULL),
	(3, 'steam:11000011a4c7762', '{"money":811979,"bank":54900,"black_money":0}', 'bennys', 'unemployed', 1, 0, '{"x":-215.2879180908203,"y":-1324.4835205078126,"z":30.880615234375}', 'Just', 'God', NULL, NULL, NULL, NULL, '[{"percent":46.135,"val":461350,"name":"hunger"},{"percent":17.407,"val":174070,"name":"thirst"}]', 0, 1681676531, '[]', NULL);

-- Listage de la structure de table bluestark_v2. user_admin
CREATE TABLE IF NOT EXISTS `user_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `players` longtext DEFAULT NULL,
  `commands` longtext DEFAULT NULL,
  `permissions` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.user_admin : ~9 rows (environ)
INSERT INTO `user_admin` (`id`, `name`, `label`, `players`, `commands`, `permissions`) VALUES
	(1, 'founder', 'Fondateur', '{"license:b90704455b3efdd5907547511ac05e09eb931f67":{"arrival_date":"08-02-2023 18:37:48","name":"Joshuaa","reports":8},"license:7896784edbc2f7f3b16c413601f85b334ca96543":{"arrival_date":"04-04-2023 14:08:06","name":"Scott","reports":0},"license:b754f5f908d5750f838dc62c60ed7904a6b609a3":{"arrival_date":"08-05-2023 16:20:36","name":"JustGod","reports":1},"license:66b377b7c0bfc397e2c7cd3707208d40981d8567":{"arrival_date":"05-04-2023 00:42:41","name":"Shadow","reports":0},"license:1c5b46ea53fd2dc6e7dd781dbd74118140ab4b4f":{"arrival_date":"10-06-2023 18:57:54","reports":0,"name":"Evan"},"steam:11000011a4c7762":{"arrival_date":"15-04-2023 22:50:23","name":"Joshuaa","reports":0},"license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66":{"arrival_date":"12-02-2023 05:58:18","name":"zk","reports":3}}', '{"bring":{"label":"Téléporter une personne à soi","name":"bring","description":"Permet de téléporter une personne à soi","permissions":true},"createMechanic":{"label":"Créer un mécano","name":"createMechanic","description":"Permet de créer un mécano","permissions":true},"clear":{"label":"Effacter le chat","name":"clear","description":"Permet d\'effacer son chat","permissions":true},"clearAll":{"label":"Effacter le chat de tous les joueurs","name":"clearAll","description":"Permet d\'effacer le chat de tous les joueurs","permissions":true},"creator":{"label":"Ouvrir le menu de création de personnage","name":"creator","description":"Permet d\'ouvrir le menu de création de personnage","permissions":true},"freeze":{"label":"Freeze un joueur","name":"freeze","description":"Permet de freeze un joueur","permissions":true},"ranks":{"label":"Rangs","name":"ranks","description":"Permet de gérer les rangs","permissions":true},"unfreeze":{"label":"UnFreeze un joueur","name":"unfreeze","description":"Permet de unfreeze un joueur","permissions":true},"msg":{"label":"Envoyer un message à un joueur","name":"msg","description":"Permet d\'envoyer un message à un joueur","permissions":true},"bringBack":{"label":"Téléporter une personne à sa dernière position","name":"bringBack","description":"Permet de téléporter une personne à sa dernière position","permissions":true},"players":{"label":"Liste des joueurs","name":"players","description":"Permet d\'afficher la liste des joueurs","permissions":true},"setArmour":{"label":"Donner de l\'armure","name":"setArmour","description":"Permet de donner de l\'armure à un joueur","permissions":true},"openPlayerInventory":{"description":"Permet d\'ouvrir l\'inventaire d\'un joueur","permissions":true,"name":"openPlayerInventory","label":"Ouvrir l\'inventaire d\'un joueur"},"openItemsInventory":{"description":"Permet d\'ouvrir l\'inventaire contenant les items","permissions":true,"name":"openItemsInventory","label":"Ouvrir l\'inventaire contenant les items"},"createEnterprise":{"label":"Créer une entreprise","name":"createEnterprise","description":"Permet de créer une entreprise","permissions":true},"animationCancel":{"value":true,"description":"Permet d\'annuler une animation","permissions":true,"label":"Annuler l\'animation","keys":["keyboard","X"],"name":"animationCancel"},"adminNoclip":{"value":true,"description":"Permet de passer en mode noclip","permissions":true,"label":"Noclip","keys":["keyboard","O"],"name":"adminNoclip"},"jobMenu":{"value":true,"description":"Permet d\'ouvrir le menu métier","permissions":true,"label":"Menu métier","name":"jobMenu"},"die":{"label":"Se suicider","name":"die","description":"Permet de se suicider","permissions":true},"car":{"label":"Faire apparaître un véhicule","name":"car","description":"Permet de faire apparaître un véhicule","permissions":true},"mechanic":{"label":"Mécanicien","name":"mechanic","description":"Permet de devenir mécanicien","permissions":true},"commands":{"label":"Ouvrir le menu des commandes","name":"commands","description":"Permet d\'ouvrir le menu des commandes","permissions":true},"info":{"label":"Information de son joueur","name":"info","description":"Permet d\'afficher les informations de son joueur","permissions":true},"kill":{"label":"Tuer un joueur","name":"kill","description":"Permet de tuer un joueur","permissions":true},"goto":{"label":"Se téléporter à une personne","name":"goto","description":"Permet de se téléporter à une personne","permissions":true},"createSociety":{"label":"Créer une société","name":"createSociety","description":"Permet de créer une société","permissions":true},"giveItem":{"label":"Donner un item","name":"giveItem","description":"Permet de donner un item à un joueur","permissions":true},"giveMoney":{"label":"Donner de l\'argent","name":"giveMoney","description":"Permet de donner de l\'argent à un joueur","permissions":true},"createGarage":{"label":"Créer un garage","name":"createGarage","description":"Permet de créer une propriété","permissions":true},"revive":{"label":"Réanimer","name":"revive","description":"Réanimer une personne","permissions":true},"setRank":{"label":"Changer le rank d\'un joueur","name":"setRank","description":"Permet de changer le rank d\'un joueur","permissions":true},"clearInventory":{"label":"Vider l\'inventaire","name":"clearInventory","description":"Permet de vider l\'inventaire d\'un joueur","permissions":true},"setCoords":{"label":"Se téléporter à une position","name":"setCoords","description":"Permet de se téléporter à une position","permissions":true},"personnalMenu":{"value":true,"description":"Permet d\'ouvrir son menu personnel","permissions":true,"label":"Menu personnel","keys":["keyboard","F5"],"name":"personnalMenu"},"unban":{"label":"Unban un joueur","name":"unban","description":"Permet de débannir une personne.","permissions":true},"saveAll":{"label":"Sauvegarder tous les joueurs","name":"saveAll","description":"Permet de sauvegarder tous les joueurs","permissions":true},"screenshot":{"label":"Prendre un screen du joueur","name":"screenshot","description":"Permet de prendre un screenshot de l\'écran du joueur","permissions":true},"ban":{"label":"Ban un joueur","name":"ban","description":"Permet de bannir temporairement ou définitivement une personne.","permissions":true},"kick":{"label":"Expulser une personne","name":"kick","description":"Permet d\'expulser une personne du serveur","permissions":true},"jail":{"label":"Envoyer un joueur dans l\'instance trolleur","name":"jail","description":"Permet d\'envoyer un joueur dans l\'instance trolleur","permissions":true},"heading":{"label":"Afficher sa position","name":"heading","description":"Permet d\'afficher sa position","permissions":true},"removeRank":{"label":"Retirer le rank d\'un joueur","name":"removeRank","description":"Permet de retirer le rank d\'un joueur","permissions":true},"heal":{"label":"Soigner","name":"heal","description":"Permet de soigner un joueur","permissions":true},"report":{"label":"Contacter l\'équipe de modération","name":"report","description":"Permet d\'envoyer un message à un joueur","permissions":true},"unjail":{"label":"Sortir un joueur de l\'instance trolleur","name":"unjail","description":"Permet de sortir un joueur de l\'instance trolleur","permissions":true},"createProperty":{"label":"Créer une propriété","name":"createProperty","description":"Permet de créer une propriété","permissions":true},"admin":{"value":true,"description":"Permet d\'ouvrir le menu d\'administration","label":"Ouvrir le menu d\'administration","keys":["keyboard","F10"],"name":"admin"},"closeReport":{"label":"Fermer son report actuel","name":"closeReport","description":"Permet de fermer son report actuel","permissions":true},"tpm":{"value":true,"description":"Permet de se téléporter à un marqueur","permissions":true,"label":"TP Marqueur","keys":["keyboard","F11"],"name":"tpm"},"openTebex":{"value":true,"description":"Permet d\'ouvrir la boutique","permissions":true,"label":"Ouvrir la boutique","keys":["keyboard","F1"],"name":"openTebex"},"setOrga":{"label":"Attribuer un gang/organisation","name":"setOrga","description":"Permet d\'attribuer un gang/organisation à un joueur","permissions":true},"setJob":{"label":"Attribuer un métier","name":"setJob","description":"Permet d\'attribuer un métier à un joueur","permissions":true},"animation":{"value":true,"description":"Permet d\'ouvrir le menu d\'animation","permissions":true,"label":"Menu animation","keys":["keyboard","K"],"name":"animation"},"tpVehicle":{"label":"Se téléporter à un véhicule","name":"tpVehicle","description":"Permet de se téléporter à un véhicule","permissions":true},"dv":{"label":"Supprimer le véhicule","name":"dv","description":"Permet de supprimer des véhicules","permissions":true}}', '{"CHANGE_ENTERPRISE_RANK_ID":{"label":"Changer la hiéarchie d\'un grade d\'entreprise","error":"~r~Vous n\'avez pas la permission de changer la hiéarchie d\'un grade d\'entreprise.","value":false,"description":"Permet de changer la hiéarchie d\'un grade d\'entreprise"},"CHANGE_MAZE_BANK_ARENA":{"label":"Changer l\'arène de Maze Bank","error":"~r~Vous n\'avez pas la permission de changer l\'arène de Maze Bank.","value":false,"description":"Permet de changer l\'arène de Maze Bank"},"CREATE_RANK":{"label":"Créer un rank","error":"~r~Vous n\'avez pas la permission de créer un nouveau rank.","value":true,"description":"Permet de créer un rank"},"MODIFY_DRUGS":{"label":"Modifié une drogue","error":"~r~Vous n\'avez pas la permission de modifié une drogue.","value":false,"description":"Permet de modifié une drogue"},"AROUND_ME_OBJECTS":{"label":"Supprimer des props","error":"~r~Vous n\'avez pas la permission de supprimer des props.","value":true,"description":"Permet de supprimer des props"},"MODIFY_ARENAWARS":{"label":"Modifier ArenaWars","error":"~r~Vous n\'avez pas la permission de modifier ArenaWars.","value":false,"description":"Permet de modifier ArenaWars"},"CREATE_ENTERPRISE":{"label":"Créer une entreprise","error":"~r~Vous n\'avez pas la permission de créer une entreprise.","value":true,"description":"Permet de créer une entreprise"},"CREATE_DRUGS":{"label":"Créer une drogue","error":"~r~Vous n\'avez pas la permission de créer une drogue.","value":false,"description":"Permet de créer une drogue"},"UPDATE_ENTERPRISE_PERMISSIONS":{"label":"Modifier les permissions d\'une entreprise","error":"~r~Vous n\'avez pas la permission de modifier les permissions d\'une entreprise.","value":false,"description":"Permet de modifier les permissions d\'une entreprise"},"MANAGE_RANK_PERMISSIONS":{"label":"Gérer les permissions d\'un rank","error":"~r~Vous n\'avez pas la permission de gérer les permissions d\'un rank.","value":false,"description":"Permet de gérer les permissions d\'un rank"},"PLAYER_WARNING":{"label":"Avertir un joueur","error":"~r~Vous n\'avez pas la permission d\'avertir un joueur.","value":true,"description":"Permet d\'avertir un joueur"},"CHANGE_ENTERPRISE_ZONE_POSITION":{"label":"Changer la position d\'une zone d\'entreprise","error":"~r~Vous n\'avez pas la permission de changer la position d\'une zone d\'entreprise.","value":false,"description":"Permet de changer la position d\'une zone d\'entreprise"},"BOUTIQUE_ADDVEHICLE":{"label":"Ajouter un véhicule à la boutique","error":"~r~Vous n\'avez pas la permission d\'ajouter un véhicule à la boutique.","value":false,"description":"Permet d\'ajouter un véhicule à la boutique"},"PLAYER_RESET_IDENTITY":{"label":"Réinitialiser l\'identité d\'un joueur","error":"~r~Vous n\'avez pas la permission de réinitialiser l\'identité d\'un joueur.","value":true,"description":"Permet de réinitialiser l\'identité d\'un joueur"},"MY_PLAYER_BLIPS":{"label":"Afficher les blips","error":"~r~Vous n\'avez pas la permission d\'afficher les blips.","value":true,"description":"Permet d\'afficher les blips"},"DELETE_DRUGS":{"label":"Supprimer une drogue","error":"~r~Vous n\'avez pas la permission de créer des drogues.","value":false,"description":"Permet de créer des drogues"},"RECRUIT_PLAYER_RANK":{"label":"Recruter un joueur","error":"~r~Vous n\'avez pas la permission de recruter un joueur dans un rank.","value":true,"description":"Permet de recruter un joueur dans un rank"},"AROUND_ME_MESSAGE":{"label":"Envoyer un message (zone)","error":"~r~Vous n\'avez pas la permission d\'envoyer un message (zone).","value":true,"description":"Permet d\'envoyer un message (zone)"},"AROUND_ME_HEAL":{"label":"Heal des joueurs (zone)","error":"~r~Vous n\'avez pas la permission de heal des joueurs (zone).","value":true,"description":"Permet de heal des joueurs (zone)"},"SEND_ALL_CHAT":{"label":"Envoyer des chat (ALL)","error":"~r~Vous n\'avez pas la permission d\'envoyer des chat (ALL).","value":false,"description":"Permet d\'envoyer des chat (ALL)"},"PLAYER_SANCTIONS":{"label":"Sanctions d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'obtenir les sanctions d\'un joueur.","value":true,"description":"Permet d\'obtenir les sanctions d\'un joueur"},"MANAGE_RANK_COMMANDS":{"label":"Gérer les commandes d\'un rank","error":"~r~Vous n\'avez pas la permission de gérer les commandes d\'un rank.","value":true,"description":"Permet de gérer les commandes d\'un rank"},"PLAYER_INVENTORY":{"label":"Ouvrir l\'inventaire d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'ouvrir l\'inventaire d\'un joueur.","value":true,"description":"Permet d\'ouvrir l\'inventaire d\'un joueur"},"PLAYER_VEHICLES":{"label":"Véhicules d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'obtenir les véhicules d\'un joueur.","value":true,"description":"Permet d\'obtenir les véhicules d\'un joueur"},"PLAYER_KILL":{"label":"Tuer un joueur","error":"~r~Vous n\'avez pas la permission de tuer un joueur.","value":true,"description":"Permet de tuer un joueur"},"MY_PLAYER_REMOVEALLWEAPONS":{"label":"Retirer toutes les armes","error":"~r~Vous n\'avez pas la permission de retirer toutes les armes.","value":false,"description":"Permet de retirer toutes les armes"},"VEHICLES_REPAIR":{"label":"Réparer un véhicule","error":"~r~Vous n\'avez pas la permission de réparer un véhicule.","value":true,"description":"Permet de réparer un véhicule"},"AROUND_ME_PNJS":{"label":"Supprimer des PNJs","error":"~r~Vous n\'avez pas la permission de supprimer des PNJs.","value":true,"description":"Permet de supprimer des PNJs"},"RECRUIT_ENTERPRISE_PLAYER":{"label":"Recruter un joueur dans l\'entreprise","error":"~r~Vous n\'avez pas la permission de recruter un joueur dans l\'entreprise.","value":false,"description":"Permet de recruter un joueur dans l\'entreprise"},"AROUND_ME_REVIVE":{"label":"Réanimer des joueurs (zone)","error":"~r~Vous n\'avez pas la permission de réanimer des joueurs (zone).","value":true,"description":"Permet de réanimer des joueurs (zone)"},"CREATE_ENTERPRISE_RANK":{"label":"Créer un grade d\'entreprise","error":"~r~Vous n\'avez pas la permission de créer un grade d\'entreprise.","value":false,"description":"Permet de créer un grade d\'entreprise"},"DELETE_ENTERPRISE_RANK":{"label":"Supprimer un rank d\'entreprise","error":"~r~Vous n\'avez pas la permission de supprimer un rank d\'entreprise.","value":false,"description":"Permet de supprimer un rank d\'entreprise"},"PLAYER_INFORMATIONS":{"label":"Informations d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'obtenir les informations d\'un joueur.","value":true,"description":"Permet d\'obtenir les informations d\'un joueur"},"KICK_ENTERPRISE_PLAYER":{"label":"Virer un joueur de l\'entreprise","error":"~r~Vous n\'avez pas la permission de virer un joueur de l\'entreprise.","value":false,"description":"Permet de virer un joueur de l\'entreprise"},"KICK_PLAYER_RANK":{"label":"Expulser un joueur d\'un rank","error":"~r~Vous n\'avez pas la permission d\'expulser un joueur d\'un rank.","value":true,"description":"Permet d\'expulser un joueur d\'un rank"},"AROUND_ME_VEHICLES":{"label":"Supprimer des véhicules","error":"~r~Vous n\'avez pas la permission de supprimer des véhicules.","value":true,"description":"Permet de supprimer des véhicules"},"PLAYER_VEHICLES_IMPOUND":{"label":"Mettre en fourrière un véhicule","error":"~r~Vous n\'avez pas la permission de mettre en fourrière un véhicule.","value":false,"description":"Permet de mettre en fourrière un véhicule"},"MY_PLAYER_INVISIBLESTAFF":{"label":"Invisible par les admins","error":"~r~Vous n\'avez pas la permission d\'être invisible par les admins.","value":false,"description":"Permet de ne pas être vu par les admins"},"MY_PLAYER_GAMERTAG":{"label":"Afficher les gamertags","error":"~r~Vous n\'avez pas la permission d\'afficher les gamertags.","value":true,"description":"Permet d\'afficher les gamertags"},"MY_PLAYER_GIVEALLWEAPONS":{"label":"Donner toutes les armes","error":"~r~Vous n\'avez pas la permission de donner toutes les armes.","value":false,"description":"Permet de donner toutes les armes"},"DELETE_ENTERPRISE":{"label":"Supprimer une entreprise","error":"~r~Vous n\'avez pas la permission de supprimer une entreprise.","value":false,"description":"Permet de supprimer une entreprise"}}'),
	(2, 'manager', 'Manager', '{}', '{"bring":{"label":"Téléporter une personne à soi","name":"bring","description":"Permet de téléporter une personne à soi","permissions":true},"createMechanic":{"label":"Créer un mécano","name":"createMechanic","description":"Permet de créer un mécano","permissions":true},"clear":{"label":"Effacter le chat","name":"clear","description":"Permet d\'effacer son chat","permissions":true},"clearAll":{"label":"Effacter le chat de tous les joueurs","name":"clearAll","description":"Permet d\'effacer le chat de tous les joueurs","permissions":true},"creator":{"label":"Ouvrir le menu de création de personnage","name":"creator","description":"Permet d\'ouvrir le menu de création de personnage","permissions":true},"freeze":{"label":"Freeze un joueur","name":"freeze","description":"Permet de freeze un joueur","permissions":true},"ranks":{"label":"Rangs","name":"ranks","description":"Permet de gérer les rangs","permissions":true},"unfreeze":{"label":"UnFreeze un joueur","name":"unfreeze","description":"Permet de unfreeze un joueur","permissions":true},"msg":{"label":"Envoyer un message à un joueur","name":"msg","description":"Permet d\'envoyer un message à un joueur","permissions":true},"goto":{"label":"Se téléporter à une personne","name":"goto","description":"Permet de se téléporter à une personne","permissions":true},"players":{"label":"Liste des joueurs","name":"players","description":"Permet d\'afficher la liste des joueurs","permissions":true},"setArmour":{"label":"Donner de l\'armure","name":"setArmour","description":"Permet de donner de l\'armure à un joueur","permissions":true},"openPlayerInventory":{"description":"Permet d\'ouvrir l\'inventaire d\'un joueur","permissions":true,"name":"openPlayerInventory","label":"Ouvrir l\'inventaire d\'un joueur"},"openItemsInventory":{"description":"Permet d\'ouvrir l\'inventaire contenant les items","permissions":true,"name":"openItemsInventory","label":"Ouvrir l\'inventaire contenant les items"},"screenshot":{"label":"Prendre un screen du joueur","name":"screenshot","description":"Permet de prendre un screenshot de l\'écran du joueur","permissions":true},"animationCancel":{"description":"Permet d\'annuler une animation","permissions":true,"label":"Annuler l\'animation","keys":["keyboard","X"],"name":"animationCancel"},"adminNoclip":{"description":"Permet de passer en mode noclip","permissions":true,"label":"Noclip","keys":["keyboard","O"],"name":"adminNoclip"},"jobMenu":{"description":"Permet d\'ouvrir le menu métier","permissions":true,"label":"Menu métier","keys":["keyboard","F6"],"name":"jobMenu"},"die":{"label":"Se suicider","name":"die","description":"Permet de se suicider","permissions":true},"personnalMenu":{"description":"Permet d\'ouvrir son menu personnel","permissions":true,"label":"Menu personnel","keys":["keyboard","F5"],"name":"personnalMenu"},"setJob":{"label":"Attribuer un métier","name":"setJob","description":"Permet d\'attribuer un métier à un joueur","permissions":true},"commands":{"label":"Ouvrir le menu des commandes","name":"commands","description":"Permet d\'ouvrir le menu des commandes","permissions":true},"clearInventory":{"label":"Vider l\'inventaire","name":"clearInventory","description":"Permet de vider l\'inventaire d\'un joueur","permissions":true},"kill":{"label":"Tuer un joueur","name":"kill","description":"Permet de tuer un joueur","permissions":true},"info":{"label":"Information de son joueur","name":"info","description":"Permet d\'afficher les informations de son joueur","permissions":true},"createSociety":{"label":"Créer une société","name":"createSociety","description":"Permet de créer une société","permissions":true},"giveItem":{"label":"Donner un item","name":"giveItem","description":"Permet de donner un item à un joueur","permissions":true},"giveMoney":{"label":"Donner de l\'argent","name":"giveMoney","description":"Permet de donner de l\'argent à un joueur","permissions":true},"revive":{"label":"Réanimer","name":"revive","description":"Réanimer une personne","permissions":true},"createGarage":{"label":"Créer un garage","name":"createGarage","description":"Permet de créer une propriété","permissions":true},"setRank":{"label":"Changer le rank d\'un joueur","name":"setRank","description":"Permet de changer le rank d\'un joueur","permissions":true},"car":{"label":"Faire apparaître un véhicule","name":"car","description":"Permet de faire apparaître un véhicule","permissions":true},"setCoords":{"label":"Se téléporter à une position","name":"setCoords","description":"Permet de se téléporter à une position","permissions":true},"mechanic":{"label":"Mécanicien","name":"mechanic","description":"Permet de devenir mécanicien","permissions":true},"unban":{"label":"Unban un joueur","name":"unban","description":"Permet de débannir une personne.","permissions":true},"saveAll":{"label":"Sauvegarder tous les joueurs","name":"saveAll","description":"Permet de sauvegarder tous les joueurs","permissions":true},"animation":{"description":"Permet d\'ouvrir le menu d\'animation","permissions":true,"label":"Menu animation","keys":["keyboard","K"],"name":"animation"},"bringBack":{"label":"Téléporter une personne à sa dernière position","name":"bringBack","description":"Permet de téléporter une personne à sa dernière position","permissions":true},"kick":{"label":"Expulser une personne","name":"kick","description":"Permet d\'expulser une personne du serveur","permissions":true},"jail":{"label":"Envoyer un joueur dans l\'instance trolleur","name":"jail","description":"Permet d\'envoyer un joueur dans l\'instance trolleur","permissions":true},"heading":{"label":"Afficher sa position","name":"heading","description":"Permet d\'afficher sa position","permissions":true},"removeRank":{"label":"Retirer le rank d\'un joueur","name":"removeRank","description":"Permet de retirer le rank d\'un joueur","permissions":true},"heal":{"label":"Soigner","name":"heal","description":"Permet de soigner un joueur","permissions":true},"report":{"label":"Contacter l\'équipe de modération","name":"report","description":"Permet d\'envoyer un message à un joueur","permissions":true},"unjail":{"label":"Sortir un joueur de l\'instance trolleur","name":"unjail","description":"Permet de sortir un joueur de l\'instance trolleur","permissions":true},"createProperty":{"label":"Créer une propriété","name":"createProperty","description":"Permet de créer une propriété","permissions":true},"admin":{"description":"Permet d\'ouvrir le menu d\'administration","permissions":true,"label":"Ouvrir le menu d\'administration","keys":["keyboard","F10"],"name":"admin"},"closeReport":{"label":"Fermer son report actuel","name":"closeReport","description":"Permet de fermer son report actuel","permissions":true},"createEnterprise":{"label":"Créer une entreprise","name":"createEnterprise","description":"Permet de créer une entreprise","permissions":true},"tpm":{"description":"Permet de se téléporter à un marqueur","permissions":true,"label":"TP Marqueur","keys":["keyboard","F11"],"name":"tpm"},"openTebex":{"description":"Permet d\'ouvrir la boutique","permissions":true,"label":"Ouvrir la boutique","keys":["keyboard","F1"],"name":"openTebex"},"setOrga":{"label":"Attribuer un gang/organisation","name":"setOrga","description":"Permet d\'attribuer un gang/organisation à un joueur","permissions":true},"ban":{"label":"Ban un joueur","name":"ban","description":"Permet de bannir temporairement ou définitivement une personne.","permissions":true},"tpVehicle":{"label":"Se téléporter à un véhicule","name":"tpVehicle","description":"Permet de se téléporter à un véhicule","permissions":true},"dv":{"label":"Supprimer le véhicule","name":"dv","description":"Permet de supprimer des véhicules","permissions":true}}', '{"CHANGE_ENTERPRISE_RANK_ID":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la hiéarchie d\'un grade d\'entreprise.","label":"Changer la hiéarchie d\'un grade d\'entreprise","description":"Permet de changer la hiéarchie d\'un grade d\'entreprise"},"CHANGE_MAZE_BANK_ARENA":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer l\'arène de Maze Bank.","label":"Changer l\'arène de Maze Bank","description":"Permet de changer l\'arène de Maze Bank"},"AROUND_ME_REVIVE":{"value":false,"error":"~r~Vous n\'avez pas la permission de réanimer des joueurs (zone).","label":"Réanimer des joueurs (zone)","description":"Permet de réanimer des joueurs (zone)"},"MODIFY_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifié une drogue.","label":"Modifié une drogue","description":"Permet de modifié une drogue"},"AROUND_ME_OBJECTS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des props.","label":"Supprimer des props","description":"Permet de supprimer des props"},"MODIFY_ARENAWARS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier ArenaWars.","label":"Modifier ArenaWars","description":"Permet de modifier ArenaWars"},"CREATE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une entreprise.","label":"Créer une entreprise","description":"Permet de créer une entreprise"},"AROUND_ME_PNJS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des PNJs.","label":"Supprimer des PNJs","description":"Permet de supprimer des PNJs"},"UPDATE_ENTERPRISE_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier les permissions d\'une entreprise.","label":"Modifier les permissions d\'une entreprise","description":"Permet de modifier les permissions d\'une entreprise"},"MANAGE_RANK_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les permissions d\'un rank.","label":"Gérer les permissions d\'un rank","description":"Permet de gérer les permissions d\'un rank"},"PLAYER_WARNING":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'avertir un joueur.","label":"Avertir un joueur","description":"Permet d\'avertir un joueur"},"CHANGE_ENTERPRISE_ZONE_POSITION":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la position d\'une zone d\'entreprise.","label":"Changer la position d\'une zone d\'entreprise","description":"Permet de changer la position d\'une zone d\'entreprise"},"BOUTIQUE_ADDVEHICLE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'ajouter un véhicule à la boutique.","label":"Ajouter un véhicule à la boutique","description":"Permet d\'ajouter un véhicule à la boutique"},"PLAYER_RESET_IDENTITY":{"value":false,"error":"~r~Vous n\'avez pas la permission de réinitialiser l\'identité d\'un joueur.","label":"Réinitialiser l\'identité d\'un joueur","description":"Permet de réinitialiser l\'identité d\'un joueur"},"MY_PLAYER_BLIPS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les blips.","label":"Afficher les blips","description":"Permet d\'afficher les blips"},"DELETE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer des drogues.","label":"Supprimer une drogue","description":"Permet de créer des drogues"},"RECRUIT_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans un rank.","label":"Recruter un joueur","description":"Permet de recruter un joueur dans un rank"},"AROUND_ME_MESSAGE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer un message (zone).","label":"Envoyer un message (zone)","description":"Permet d\'envoyer un message (zone)"},"AROUND_ME_HEAL":{"value":false,"error":"~r~Vous n\'avez pas la permission de heal des joueurs (zone).","label":"Heal des joueurs (zone)","description":"Permet de heal des joueurs (zone)"},"SEND_ALL_CHAT":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer des chat (ALL).","label":"Envoyer des chat (ALL)","description":"Permet d\'envoyer des chat (ALL)"},"MY_PLAYER_GAMERTAG":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les gamertags.","label":"Afficher les gamertags","description":"Permet d\'afficher les gamertags"},"MANAGE_RANK_COMMANDS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les commandes d\'un rank.","label":"Gérer les commandes d\'un rank","description":"Permet de gérer les commandes d\'un rank"},"PLAYER_INVENTORY":{"label":"Ouvrir l\'inventaire d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'ouvrir l\'inventaire d\'un joueur.","value":false,"description":"Permet d\'ouvrir l\'inventaire d\'un joueur"},"PLAYER_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les véhicules d\'un joueur.","label":"Véhicules d\'un joueur","description":"Permet d\'obtenir les véhicules d\'un joueur"},"PLAYER_KILL":{"value":false,"error":"~r~Vous n\'avez pas la permission de tuer un joueur.","label":"Tuer un joueur","description":"Permet de tuer un joueur"},"VEHICLES_REPAIR":{"value":false,"error":"~r~Vous n\'avez pas la permission de réparer un véhicule.","label":"Réparer un véhicule","description":"Permet de réparer un véhicule"},"CREATE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une drogue.","label":"Créer une drogue","description":"Permet de créer une drogue"},"MY_PLAYER_REMOVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de retirer toutes les armes.","label":"Retirer toutes les armes","description":"Permet de retirer toutes les armes"},"DELETE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer un rank d\'entreprise.","label":"Supprimer un rank d\'entreprise","description":"Permet de supprimer un rank d\'entreprise"},"CREATE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un nouveau rank.","label":"Créer un rank","description":"Permet de créer un rank"},"CREATE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un grade d\'entreprise.","label":"Créer un grade d\'entreprise","description":"Permet de créer un grade d\'entreprise"},"PLAYER_INFORMATIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les informations d\'un joueur.","label":"Informations d\'un joueur","description":"Permet d\'obtenir les informations d\'un joueur"},"MY_PLAYER_GIVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de donner toutes les armes.","label":"Donner toutes les armes","description":"Permet de donner toutes les armes"},"AROUND_ME_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des véhicules.","label":"Supprimer des véhicules","description":"Permet de supprimer des véhicules"},"KICK_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'expulser un joueur d\'un rank.","label":"Expulser un joueur d\'un rank","description":"Permet d\'expulser un joueur d\'un rank"},"KICK_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de virer un joueur de l\'entreprise.","label":"Virer un joueur de l\'entreprise","description":"Permet de virer un joueur de l\'entreprise"},"PLAYER_VEHICLES_IMPOUND":{"value":false,"error":"~r~Vous n\'avez pas la permission de mettre en fourrière un véhicule.","label":"Mettre en fourrière un véhicule","description":"Permet de mettre en fourrière un véhicule"},"MY_PLAYER_INVISIBLESTAFF":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'être invisible par les admins.","label":"Invisible par les admins","description":"Permet de ne pas être vu par les admins"},"RECRUIT_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans l\'entreprise.","label":"Recruter un joueur dans l\'entreprise","description":"Permet de recruter un joueur dans l\'entreprise"},"PLAYER_SANCTIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les sanctions d\'un joueur.","label":"Sanctions d\'un joueur","description":"Permet d\'obtenir les sanctions d\'un joueur"},"DELETE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer une entreprise.","label":"Supprimer une entreprise","description":"Permet de supprimer une entreprise"}}'),
	(3, 'staffmanager', 'Gérant Staff', '[]', '{"bring":{"label":"Téléporter une personne à soi","name":"bring","description":"Permet de téléporter une personne à soi","permissions":true},"createMechanic":{"label":"Créer un mécano","name":"createMechanic","description":"Permet de créer un mécano","permissions":true},"clear":{"label":"Effacter le chat","name":"clear","description":"Permet d\'effacer son chat","permissions":true},"clearAll":{"label":"Effacter le chat de tous les joueurs","name":"clearAll","description":"Permet d\'effacer le chat de tous les joueurs","permissions":true},"creator":{"label":"Ouvrir le menu de création de personnage","name":"creator","description":"Permet d\'ouvrir le menu de création de personnage","permissions":true},"freeze":{"label":"Freeze un joueur","name":"freeze","description":"Permet de freeze un joueur","permissions":true},"ranks":{"label":"Rangs","name":"ranks","description":"Permet de gérer les rangs","permissions":true},"unfreeze":{"label":"UnFreeze un joueur","name":"unfreeze","description":"Permet de unfreeze un joueur","permissions":true},"msg":{"label":"Envoyer un message à un joueur","name":"msg","description":"Permet d\'envoyer un message à un joueur","permissions":true},"bringBack":{"label":"Téléporter une personne à sa dernière position","name":"bringBack","description":"Permet de téléporter une personne à sa dernière position","permissions":true},"players":{"label":"Liste des joueurs","name":"players","description":"Permet d\'afficher la liste des joueurs","permissions":true},"setArmour":{"label":"Donner de l\'armure","name":"setArmour","description":"Permet de donner de l\'armure à un joueur","permissions":true},"openPlayerInventory":{"description":"Permet d\'ouvrir l\'inventaire d\'un joueur","permissions":true,"name":"openPlayerInventory","label":"Ouvrir l\'inventaire d\'un joueur"},"openItemsInventory":{"description":"Permet d\'ouvrir l\'inventaire contenant les items","permissions":true,"name":"openItemsInventory","label":"Ouvrir l\'inventaire contenant les items"},"createEnterprise":{"label":"Créer une entreprise","name":"createEnterprise","description":"Permet de créer une entreprise","permissions":true},"animationCancel":{"description":"Permet d\'annuler une animation","permissions":true,"label":"Annuler l\'animation","keys":["keyboard","X"],"name":"animationCancel"},"adminNoclip":{"description":"Permet de passer en mode noclip","permissions":true,"label":"Noclip","keys":["keyboard","O"],"name":"adminNoclip"},"jobMenu":{"label":"Menu métier","name":"jobMenu","description":"Permet d\'ouvrir le menu métier","permissions":true},"die":{"label":"Se suicider","name":"die","description":"Permet de se suicider","permissions":true},"car":{"label":"Faire apparaître un véhicule","name":"car","description":"Permet de faire apparaître un véhicule","permissions":true},"mechanic":{"label":"Mécanicien","name":"mechanic","description":"Permet de devenir mécanicien","permissions":true},"commands":{"label":"Ouvrir le menu des commandes","name":"commands","description":"Permet d\'ouvrir le menu des commandes","permissions":true},"info":{"label":"Information de son joueur","name":"info","description":"Permet d\'afficher les informations de son joueur","permissions":true},"kill":{"label":"Tuer un joueur","name":"kill","description":"Permet de tuer un joueur","permissions":true},"goto":{"label":"Se téléporter à une personne","name":"goto","description":"Permet de se téléporter à une personne","permissions":true},"createSociety":{"label":"Créer une société","name":"createSociety","description":"Permet de créer une société","permissions":true},"giveItem":{"label":"Donner un item","name":"giveItem","description":"Permet de donner un item à un joueur","permissions":true},"giveMoney":{"label":"Donner de l\'argent","name":"giveMoney","description":"Permet de donner de l\'argent à un joueur","permissions":true},"createGarage":{"label":"Créer un garage","name":"createGarage","description":"Permet de créer une propriété","permissions":true},"revive":{"label":"Réanimer","name":"revive","description":"Réanimer une personne","permissions":true},"setRank":{"label":"Changer le rank d\'un joueur","name":"setRank","description":"Permet de changer le rank d\'un joueur","permissions":true},"clearInventory":{"label":"Vider l\'inventaire","name":"clearInventory","description":"Permet de vider l\'inventaire d\'un joueur","permissions":true},"setCoords":{"label":"Se téléporter à une position","name":"setCoords","description":"Permet de se téléporter à une position","permissions":true},"personnalMenu":{"description":"Permet d\'ouvrir son menu personnel","permissions":true,"label":"Menu personnel","keys":["keyboard","F5"],"name":"personnalMenu"},"unban":{"label":"Unban un joueur","name":"unban","description":"Permet de débannir une personne.","permissions":true},"saveAll":{"label":"Sauvegarder tous les joueurs","name":"saveAll","description":"Permet de sauvegarder tous les joueurs","permissions":true},"screenshot":{"label":"Prendre un screen du joueur","name":"screenshot","description":"Permet de prendre un screenshot de l\'écran du joueur","permissions":true},"ban":{"label":"Ban un joueur","name":"ban","description":"Permet de bannir temporairement ou définitivement une personne.","permissions":true},"kick":{"label":"Expulser une personne","name":"kick","description":"Permet d\'expulser une personne du serveur","permissions":true},"jail":{"label":"Envoyer un joueur dans l\'instance trolleur","name":"jail","description":"Permet d\'envoyer un joueur dans l\'instance trolleur","permissions":true},"heading":{"label":"Afficher sa position","name":"heading","description":"Permet d\'afficher sa position","permissions":true},"removeRank":{"label":"Retirer le rank d\'un joueur","name":"removeRank","description":"Permet de retirer le rank d\'un joueur","permissions":true},"heal":{"label":"Soigner","name":"heal","description":"Permet de soigner un joueur","permissions":true},"report":{"label":"Contacter l\'équipe de modération","name":"report","description":"Permet d\'envoyer un message à un joueur","permissions":true},"unjail":{"label":"Sortir un joueur de l\'instance trolleur","name":"unjail","description":"Permet de sortir un joueur de l\'instance trolleur","permissions":true},"createProperty":{"label":"Créer une propriété","name":"createProperty","description":"Permet de créer une propriété","permissions":true},"admin":{"label":"Ouvrir le menu d\'administration","keys":["keyboard","F10"],"description":"Permet d\'ouvrir le menu d\'administration","name":"admin"},"closeReport":{"label":"Fermer son report actuel","name":"closeReport","description":"Permet de fermer son report actuel","permissions":true},"tpm":{"description":"Permet de se téléporter à un marqueur","permissions":true,"label":"TP Marqueur","keys":["keyboard","F11"],"name":"tpm"},"openTebex":{"description":"Permet d\'ouvrir la boutique","permissions":true,"label":"Ouvrir la boutique","keys":["keyboard","F1"],"name":"openTebex"},"setOrga":{"label":"Attribuer un gang/organisation","name":"setOrga","description":"Permet d\'attribuer un gang/organisation à un joueur","permissions":true},"setJob":{"label":"Attribuer un métier","name":"setJob","description":"Permet d\'attribuer un métier à un joueur","permissions":true},"animation":{"description":"Permet d\'ouvrir le menu d\'animation","permissions":true,"label":"Menu animation","keys":["keyboard","K"],"name":"animation"},"tpVehicle":{"label":"Se téléporter à un véhicule","name":"tpVehicle","description":"Permet de se téléporter à un véhicule","permissions":true},"dv":{"label":"Supprimer le véhicule","name":"dv","description":"Permet de supprimer des véhicules","permissions":true}}', '{"CHANGE_ENTERPRISE_RANK_ID":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la hiéarchie d\'un grade d\'entreprise.","label":"Changer la hiéarchie d\'un grade d\'entreprise","description":"Permet de changer la hiéarchie d\'un grade d\'entreprise"},"CHANGE_MAZE_BANK_ARENA":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer l\'arène de Maze Bank.","label":"Changer l\'arène de Maze Bank","description":"Permet de changer l\'arène de Maze Bank"},"AROUND_ME_REVIVE":{"value":false,"error":"~r~Vous n\'avez pas la permission de réanimer des joueurs (zone).","label":"Réanimer des joueurs (zone)","description":"Permet de réanimer des joueurs (zone)"},"MODIFY_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifié une drogue.","label":"Modifié une drogue","description":"Permet de modifié une drogue"},"AROUND_ME_OBJECTS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des props.","label":"Supprimer des props","description":"Permet de supprimer des props"},"MODIFY_ARENAWARS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier ArenaWars.","label":"Modifier ArenaWars","description":"Permet de modifier ArenaWars"},"CREATE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une entreprise.","label":"Créer une entreprise","description":"Permet de créer une entreprise"},"AROUND_ME_PNJS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des PNJs.","label":"Supprimer des PNJs","description":"Permet de supprimer des PNJs"},"UPDATE_ENTERPRISE_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier les permissions d\'une entreprise.","label":"Modifier les permissions d\'une entreprise","description":"Permet de modifier les permissions d\'une entreprise"},"MANAGE_RANK_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les permissions d\'un rank.","label":"Gérer les permissions d\'un rank","description":"Permet de gérer les permissions d\'un rank"},"PLAYER_WARNING":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'avertir un joueur.","label":"Avertir un joueur","description":"Permet d\'avertir un joueur"},"CHANGE_ENTERPRISE_ZONE_POSITION":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la position d\'une zone d\'entreprise.","label":"Changer la position d\'une zone d\'entreprise","description":"Permet de changer la position d\'une zone d\'entreprise"},"BOUTIQUE_ADDVEHICLE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'ajouter un véhicule à la boutique.","label":"Ajouter un véhicule à la boutique","description":"Permet d\'ajouter un véhicule à la boutique"},"PLAYER_RESET_IDENTITY":{"value":false,"error":"~r~Vous n\'avez pas la permission de réinitialiser l\'identité d\'un joueur.","label":"Réinitialiser l\'identité d\'un joueur","description":"Permet de réinitialiser l\'identité d\'un joueur"},"MY_PLAYER_BLIPS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les blips.","label":"Afficher les blips","description":"Permet d\'afficher les blips"},"DELETE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer des drogues.","label":"Supprimer une drogue","description":"Permet de créer des drogues"},"RECRUIT_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans un rank.","label":"Recruter un joueur","description":"Permet de recruter un joueur dans un rank"},"AROUND_ME_MESSAGE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer un message (zone).","label":"Envoyer un message (zone)","description":"Permet d\'envoyer un message (zone)"},"AROUND_ME_HEAL":{"value":false,"error":"~r~Vous n\'avez pas la permission de heal des joueurs (zone).","label":"Heal des joueurs (zone)","description":"Permet de heal des joueurs (zone)"},"SEND_ALL_CHAT":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer des chat (ALL).","label":"Envoyer des chat (ALL)","description":"Permet d\'envoyer des chat (ALL)"},"MY_PLAYER_GAMERTAG":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les gamertags.","label":"Afficher les gamertags","description":"Permet d\'afficher les gamertags"},"MANAGE_RANK_COMMANDS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les commandes d\'un rank.","label":"Gérer les commandes d\'un rank","description":"Permet de gérer les commandes d\'un rank"},"PLAYER_INVENTORY":{"label":"Ouvrir l\'inventaire d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'ouvrir l\'inventaire d\'un joueur.","value":false,"description":"Permet d\'ouvrir l\'inventaire d\'un joueur"},"PLAYER_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les véhicules d\'un joueur.","label":"Véhicules d\'un joueur","description":"Permet d\'obtenir les véhicules d\'un joueur"},"PLAYER_KILL":{"value":false,"error":"~r~Vous n\'avez pas la permission de tuer un joueur.","label":"Tuer un joueur","description":"Permet de tuer un joueur"},"MY_PLAYER_REMOVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de retirer toutes les armes.","label":"Retirer toutes les armes","description":"Permet de retirer toutes les armes"},"CREATE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une drogue.","label":"Créer une drogue","description":"Permet de créer une drogue"},"DELETE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer un rank d\'entreprise.","label":"Supprimer un rank d\'entreprise","description":"Permet de supprimer un rank d\'entreprise"},"CREATE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un nouveau rank.","label":"Créer un rank","description":"Permet de créer un rank"},"MY_PLAYER_GIVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de donner toutes les armes.","label":"Donner toutes les armes","description":"Permet de donner toutes les armes"},"CREATE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un grade d\'entreprise.","label":"Créer un grade d\'entreprise","description":"Permet de créer un grade d\'entreprise"},"PLAYER_INFORMATIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les informations d\'un joueur.","label":"Informations d\'un joueur","description":"Permet d\'obtenir les informations d\'un joueur"},"VEHICLES_REPAIR":{"value":false,"error":"~r~Vous n\'avez pas la permission de réparer un véhicule.","label":"Réparer un véhicule","description":"Permet de réparer un véhicule"},"AROUND_ME_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des véhicules.","label":"Supprimer des véhicules","description":"Permet de supprimer des véhicules"},"KICK_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'expulser un joueur d\'un rank.","label":"Expulser un joueur d\'un rank","description":"Permet d\'expulser un joueur d\'un rank"},"KICK_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de virer un joueur de l\'entreprise.","label":"Virer un joueur de l\'entreprise","description":"Permet de virer un joueur de l\'entreprise"},"PLAYER_VEHICLES_IMPOUND":{"value":false,"error":"~r~Vous n\'avez pas la permission de mettre en fourrière un véhicule.","label":"Mettre en fourrière un véhicule","description":"Permet de mettre en fourrière un véhicule"},"MY_PLAYER_INVISIBLESTAFF":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'être invisible par les admins.","label":"Invisible par les admins","description":"Permet de ne pas être vu par les admins"},"PLAYER_SANCTIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les sanctions d\'un joueur.","label":"Sanctions d\'un joueur","description":"Permet d\'obtenir les sanctions d\'un joueur"},"RECRUIT_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans l\'entreprise.","label":"Recruter un joueur dans l\'entreprise","description":"Permet de recruter un joueur dans l\'entreprise"},"DELETE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer une entreprise.","label":"Supprimer une entreprise","description":"Permet de supprimer une entreprise"}}'),
	(4, 'admin', 'Administrateur', '[]', '{"bring":{"label":"Téléporter une personne à soi","name":"bring","description":"Permet de téléporter une personne à soi","permissions":true},"createMechanic":{"label":"Créer un mécano","name":"createMechanic","description":"Permet de créer un mécano","permissions":true},"clear":{"label":"Effacter le chat","name":"clear","description":"Permet d\'effacer son chat","permissions":true},"clearAll":{"label":"Effacter le chat de tous les joueurs","name":"clearAll","description":"Permet d\'effacer le chat de tous les joueurs","permissions":true},"creator":{"label":"Ouvrir le menu de création de personnage","name":"creator","description":"Permet d\'ouvrir le menu de création de personnage","permissions":true},"freeze":{"label":"Freeze un joueur","name":"freeze","description":"Permet de freeze un joueur","permissions":true},"ranks":{"label":"Rangs","name":"ranks","description":"Permet de gérer les rangs","permissions":true},"unfreeze":{"label":"UnFreeze un joueur","name":"unfreeze","description":"Permet de unfreeze un joueur","permissions":true},"msg":{"label":"Envoyer un message à un joueur","name":"msg","description":"Permet d\'envoyer un message à un joueur","permissions":true},"goto":{"label":"Se téléporter à une personne","name":"goto","description":"Permet de se téléporter à une personne","permissions":true},"players":{"label":"Liste des joueurs","name":"players","description":"Permet d\'afficher la liste des joueurs","permissions":true},"setArmour":{"label":"Donner de l\'armure","name":"setArmour","description":"Permet de donner de l\'armure à un joueur","permissions":true},"openPlayerInventory":{"description":"Permet d\'ouvrir l\'inventaire d\'un joueur","permissions":true,"name":"openPlayerInventory","label":"Ouvrir l\'inventaire d\'un joueur"},"openItemsInventory":{"description":"Permet d\'ouvrir l\'inventaire contenant les items","permissions":true,"name":"openItemsInventory","label":"Ouvrir l\'inventaire contenant les items"},"screenshot":{"label":"Prendre un screen du joueur","name":"screenshot","description":"Permet de prendre un screenshot de l\'écran du joueur","permissions":true},"animationCancel":{"description":"Permet d\'annuler une animation","permissions":true,"label":"Annuler l\'animation","keys":["keyboard","X"],"name":"animationCancel"},"adminNoclip":{"description":"Permet de passer en mode noclip","permissions":true,"label":"Noclip","keys":["keyboard","O"],"name":"adminNoclip"},"jobMenu":{"label":"Menu métier","name":"jobMenu","description":"Permet d\'ouvrir le menu métier","permissions":true},"die":{"label":"Se suicider","name":"die","description":"Permet de se suicider","permissions":true},"personnalMenu":{"description":"Permet d\'ouvrir son menu personnel","permissions":true,"label":"Menu personnel","keys":["keyboard","F5"],"name":"personnalMenu"},"setJob":{"label":"Attribuer un métier","name":"setJob","description":"Permet d\'attribuer un métier à un joueur","permissions":true},"commands":{"label":"Ouvrir le menu des commandes","name":"commands","description":"Permet d\'ouvrir le menu des commandes","permissions":true},"clearInventory":{"label":"Vider l\'inventaire","name":"clearInventory","description":"Permet de vider l\'inventaire d\'un joueur","permissions":true},"kill":{"label":"Tuer un joueur","name":"kill","description":"Permet de tuer un joueur","permissions":true},"info":{"label":"Information de son joueur","name":"info","description":"Permet d\'afficher les informations de son joueur","permissions":true},"createSociety":{"label":"Créer une société","name":"createSociety","description":"Permet de créer une société","permissions":true},"giveItem":{"label":"Donner un item","name":"giveItem","description":"Permet de donner un item à un joueur","permissions":true},"giveMoney":{"label":"Donner de l\'argent","name":"giveMoney","description":"Permet de donner de l\'argent à un joueur","permissions":true},"revive":{"label":"Réanimer","name":"revive","description":"Réanimer une personne","permissions":true},"createGarage":{"label":"Créer un garage","name":"createGarage","description":"Permet de créer une propriété","permissions":true},"setRank":{"label":"Changer le rank d\'un joueur","name":"setRank","description":"Permet de changer le rank d\'un joueur","permissions":true},"car":{"label":"Faire apparaître un véhicule","name":"car","description":"Permet de faire apparaître un véhicule","permissions":true},"setCoords":{"label":"Se téléporter à une position","name":"setCoords","description":"Permet de se téléporter à une position","permissions":true},"mechanic":{"label":"Mécanicien","name":"mechanic","description":"Permet de devenir mécanicien","permissions":true},"unban":{"label":"Unban un joueur","name":"unban","description":"Permet de débannir une personne.","permissions":true},"saveAll":{"label":"Sauvegarder tous les joueurs","name":"saveAll","description":"Permet de sauvegarder tous les joueurs","permissions":true},"animation":{"description":"Permet d\'ouvrir le menu d\'animation","permissions":true,"label":"Menu animation","keys":["keyboard","K"],"name":"animation"},"bringBack":{"label":"Téléporter une personne à sa dernière position","name":"bringBack","description":"Permet de téléporter une personne à sa dernière position","permissions":true},"kick":{"label":"Expulser une personne","name":"kick","description":"Permet d\'expulser une personne du serveur","permissions":true},"jail":{"label":"Envoyer un joueur dans l\'instance trolleur","name":"jail","description":"Permet d\'envoyer un joueur dans l\'instance trolleur","permissions":true},"heading":{"label":"Afficher sa position","name":"heading","description":"Permet d\'afficher sa position","permissions":true},"removeRank":{"label":"Retirer le rank d\'un joueur","name":"removeRank","description":"Permet de retirer le rank d\'un joueur","permissions":true},"heal":{"label":"Soigner","name":"heal","description":"Permet de soigner un joueur","permissions":true},"report":{"label":"Contacter l\'équipe de modération","name":"report","description":"Permet d\'envoyer un message à un joueur","permissions":true},"unjail":{"label":"Sortir un joueur de l\'instance trolleur","name":"unjail","description":"Permet de sortir un joueur de l\'instance trolleur","permissions":true},"createProperty":{"label":"Créer une propriété","name":"createProperty","description":"Permet de créer une propriété","permissions":true},"admin":{"description":"Permet d\'ouvrir le menu d\'administration","permissions":true,"label":"Ouvrir le menu d\'administration","keys":["keyboard","F10"],"name":"admin"},"closeReport":{"label":"Fermer son report actuel","name":"closeReport","description":"Permet de fermer son report actuel","permissions":true},"createEnterprise":{"label":"Créer une entreprise","name":"createEnterprise","description":"Permet de créer une entreprise","permissions":true},"tpm":{"description":"Permet de se téléporter à un marqueur","permissions":true,"label":"TP Marqueur","keys":["keyboard","F11"],"name":"tpm"},"openTebex":{"description":"Permet d\'ouvrir la boutique","permissions":true,"label":"Ouvrir la boutique","keys":["keyboard","F1"],"name":"openTebex"},"setOrga":{"label":"Attribuer un gang/organisation","name":"setOrga","description":"Permet d\'attribuer un gang/organisation à un joueur","permissions":true},"ban":{"label":"Ban un joueur","name":"ban","description":"Permet de bannir temporairement ou définitivement une personne.","permissions":true},"tpVehicle":{"label":"Se téléporter à un véhicule","name":"tpVehicle","description":"Permet de se téléporter à un véhicule","permissions":true},"dv":{"label":"Supprimer le véhicule","name":"dv","description":"Permet de supprimer des véhicules","permissions":true}}', '{"CHANGE_ENTERPRISE_RANK_ID":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la hiéarchie d\'un grade d\'entreprise.","label":"Changer la hiéarchie d\'un grade d\'entreprise","description":"Permet de changer la hiéarchie d\'un grade d\'entreprise"},"CHANGE_MAZE_BANK_ARENA":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer l\'arène de Maze Bank.","label":"Changer l\'arène de Maze Bank","description":"Permet de changer l\'arène de Maze Bank"},"AROUND_ME_REVIVE":{"value":false,"error":"~r~Vous n\'avez pas la permission de réanimer des joueurs (zone).","label":"Réanimer des joueurs (zone)","description":"Permet de réanimer des joueurs (zone)"},"MODIFY_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifié une drogue.","label":"Modifié une drogue","description":"Permet de modifié une drogue"},"AROUND_ME_OBJECTS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des props.","label":"Supprimer des props","description":"Permet de supprimer des props"},"MODIFY_ARENAWARS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier ArenaWars.","label":"Modifier ArenaWars","description":"Permet de modifier ArenaWars"},"CREATE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une entreprise.","label":"Créer une entreprise","description":"Permet de créer une entreprise"},"AROUND_ME_PNJS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des PNJs.","label":"Supprimer des PNJs","description":"Permet de supprimer des PNJs"},"UPDATE_ENTERPRISE_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier les permissions d\'une entreprise.","label":"Modifier les permissions d\'une entreprise","description":"Permet de modifier les permissions d\'une entreprise"},"MANAGE_RANK_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les permissions d\'un rank.","label":"Gérer les permissions d\'un rank","description":"Permet de gérer les permissions d\'un rank"},"PLAYER_WARNING":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'avertir un joueur.","label":"Avertir un joueur","description":"Permet d\'avertir un joueur"},"CHANGE_ENTERPRISE_ZONE_POSITION":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la position d\'une zone d\'entreprise.","label":"Changer la position d\'une zone d\'entreprise","description":"Permet de changer la position d\'une zone d\'entreprise"},"BOUTIQUE_ADDVEHICLE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'ajouter un véhicule à la boutique.","label":"Ajouter un véhicule à la boutique","description":"Permet d\'ajouter un véhicule à la boutique"},"PLAYER_RESET_IDENTITY":{"value":false,"error":"~r~Vous n\'avez pas la permission de réinitialiser l\'identité d\'un joueur.","label":"Réinitialiser l\'identité d\'un joueur","description":"Permet de réinitialiser l\'identité d\'un joueur"},"MY_PLAYER_BLIPS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les blips.","label":"Afficher les blips","description":"Permet d\'afficher les blips"},"DELETE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer des drogues.","label":"Supprimer une drogue","description":"Permet de créer des drogues"},"RECRUIT_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans un rank.","label":"Recruter un joueur","description":"Permet de recruter un joueur dans un rank"},"AROUND_ME_MESSAGE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer un message (zone).","label":"Envoyer un message (zone)","description":"Permet d\'envoyer un message (zone)"},"AROUND_ME_HEAL":{"value":false,"error":"~r~Vous n\'avez pas la permission de heal des joueurs (zone).","label":"Heal des joueurs (zone)","description":"Permet de heal des joueurs (zone)"},"SEND_ALL_CHAT":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer des chat (ALL).","label":"Envoyer des chat (ALL)","description":"Permet d\'envoyer des chat (ALL)"},"PLAYER_SANCTIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les sanctions d\'un joueur.","label":"Sanctions d\'un joueur","description":"Permet d\'obtenir les sanctions d\'un joueur"},"MANAGE_RANK_COMMANDS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les commandes d\'un rank.","label":"Gérer les commandes d\'un rank","description":"Permet de gérer les commandes d\'un rank"},"PLAYER_INVENTORY":{"label":"Ouvrir l\'inventaire d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'ouvrir l\'inventaire d\'un joueur.","value":false,"description":"Permet d\'ouvrir l\'inventaire d\'un joueur"},"PLAYER_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les véhicules d\'un joueur.","label":"Véhicules d\'un joueur","description":"Permet d\'obtenir les véhicules d\'un joueur"},"PLAYER_KILL":{"value":false,"error":"~r~Vous n\'avez pas la permission de tuer un joueur.","label":"Tuer un joueur","description":"Permet de tuer un joueur"},"DELETE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer un rank d\'entreprise.","label":"Supprimer un rank d\'entreprise","description":"Permet de supprimer un rank d\'entreprise"},"CREATE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une drogue.","label":"Créer une drogue","description":"Permet de créer une drogue"},"MY_PLAYER_REMOVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de retirer toutes les armes.","label":"Retirer toutes les armes","description":"Permet de retirer toutes les armes"},"MY_PLAYER_GAMERTAG":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les gamertags.","label":"Afficher les gamertags","description":"Permet d\'afficher les gamertags"},"CREATE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un nouveau rank.","label":"Créer un rank","description":"Permet de créer un rank"},"CREATE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un grade d\'entreprise.","label":"Créer un grade d\'entreprise","description":"Permet de créer un grade d\'entreprise"},"PLAYER_INFORMATIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les informations d\'un joueur.","label":"Informations d\'un joueur","description":"Permet d\'obtenir les informations d\'un joueur"},"MY_PLAYER_GIVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de donner toutes les armes.","label":"Donner toutes les armes","description":"Permet de donner toutes les armes"},"KICK_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de virer un joueur de l\'entreprise.","label":"Virer un joueur de l\'entreprise","description":"Permet de virer un joueur de l\'entreprise"},"KICK_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'expulser un joueur d\'un rank.","label":"Expulser un joueur d\'un rank","description":"Permet d\'expulser un joueur d\'un rank"},"VEHICLES_REPAIR":{"value":false,"error":"~r~Vous n\'avez pas la permission de réparer un véhicule.","label":"Réparer un véhicule","description":"Permet de réparer un véhicule"},"PLAYER_VEHICLES_IMPOUND":{"value":false,"error":"~r~Vous n\'avez pas la permission de mettre en fourrière un véhicule.","label":"Mettre en fourrière un véhicule","description":"Permet de mettre en fourrière un véhicule"},"MY_PLAYER_INVISIBLESTAFF":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'être invisible par les admins.","label":"Invisible par les admins","description":"Permet de ne pas être vu par les admins"},"AROUND_ME_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des véhicules.","label":"Supprimer des véhicules","description":"Permet de supprimer des véhicules"},"RECRUIT_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans l\'entreprise.","label":"Recruter un joueur dans l\'entreprise","description":"Permet de recruter un joueur dans l\'entreprise"},"DELETE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer une entreprise.","label":"Supprimer une entreprise","description":"Permet de supprimer une entreprise"}}'),
	(5, 'moderator', 'Modérateur', '[]', '{"bring":{"label":"Téléporter une personne à soi","name":"bring","description":"Permet de téléporter une personne à soi","permissions":true},"createMechanic":{"label":"Créer un mécano","name":"createMechanic","description":"Permet de créer un mécano","permissions":true},"clear":{"label":"Effacter le chat","name":"clear","description":"Permet d\'effacer son chat","permissions":true},"clearAll":{"label":"Effacter le chat de tous les joueurs","name":"clearAll","description":"Permet d\'effacer le chat de tous les joueurs","permissions":true},"creator":{"label":"Ouvrir le menu de création de personnage","name":"creator","description":"Permet d\'ouvrir le menu de création de personnage","permissions":true},"freeze":{"label":"Freeze un joueur","name":"freeze","description":"Permet de freeze un joueur","permissions":true},"ranks":{"label":"Rangs","name":"ranks","description":"Permet de gérer les rangs","permissions":true},"unfreeze":{"label":"UnFreeze un joueur","name":"unfreeze","description":"Permet de unfreeze un joueur","permissions":true},"msg":{"label":"Envoyer un message à un joueur","name":"msg","description":"Permet d\'envoyer un message à un joueur","permissions":true},"goto":{"label":"Se téléporter à une personne","name":"goto","description":"Permet de se téléporter à une personne","permissions":true},"players":{"label":"Liste des joueurs","name":"players","description":"Permet d\'afficher la liste des joueurs","permissions":true},"setArmour":{"label":"Donner de l\'armure","name":"setArmour","description":"Permet de donner de l\'armure à un joueur","permissions":true},"openPlayerInventory":{"description":"Permet d\'ouvrir l\'inventaire d\'un joueur","permissions":true,"name":"openPlayerInventory","label":"Ouvrir l\'inventaire d\'un joueur"},"openItemsInventory":{"description":"Permet d\'ouvrir l\'inventaire contenant les items","permissions":true,"name":"openItemsInventory","label":"Ouvrir l\'inventaire contenant les items"},"screenshot":{"label":"Prendre un screen du joueur","name":"screenshot","description":"Permet de prendre un screenshot de l\'écran du joueur","permissions":true},"animationCancel":{"description":"Permet d\'annuler une animation","permissions":true,"label":"Annuler l\'animation","keys":["keyboard","X"],"name":"animationCancel"},"adminNoclip":{"description":"Permet de passer en mode noclip","permissions":true,"label":"Noclip","keys":["keyboard","O"],"name":"adminNoclip"},"jobMenu":{"label":"Menu métier","name":"jobMenu","description":"Permet d\'ouvrir le menu métier","permissions":true},"die":{"label":"Se suicider","name":"die","description":"Permet de se suicider","permissions":true},"personnalMenu":{"description":"Permet d\'ouvrir son menu personnel","permissions":true,"label":"Menu personnel","keys":["keyboard","F5"],"name":"personnalMenu"},"setJob":{"label":"Attribuer un métier","name":"setJob","description":"Permet d\'attribuer un métier à un joueur","permissions":true},"commands":{"label":"Ouvrir le menu des commandes","name":"commands","description":"Permet d\'ouvrir le menu des commandes","permissions":true},"clearInventory":{"label":"Vider l\'inventaire","name":"clearInventory","description":"Permet de vider l\'inventaire d\'un joueur","permissions":true},"kill":{"label":"Tuer un joueur","name":"kill","description":"Permet de tuer un joueur","permissions":true},"info":{"label":"Information de son joueur","name":"info","description":"Permet d\'afficher les informations de son joueur","permissions":true},"createSociety":{"label":"Créer une société","name":"createSociety","description":"Permet de créer une société","permissions":true},"giveItem":{"label":"Donner un item","name":"giveItem","description":"Permet de donner un item à un joueur","permissions":true},"giveMoney":{"label":"Donner de l\'argent","name":"giveMoney","description":"Permet de donner de l\'argent à un joueur","permissions":true},"revive":{"label":"Réanimer","name":"revive","description":"Réanimer une personne","permissions":true},"createGarage":{"label":"Créer un garage","name":"createGarage","description":"Permet de créer une propriété","permissions":true},"setRank":{"label":"Changer le rank d\'un joueur","name":"setRank","description":"Permet de changer le rank d\'un joueur","permissions":true},"car":{"label":"Faire apparaître un véhicule","name":"car","description":"Permet de faire apparaître un véhicule","permissions":true},"setCoords":{"label":"Se téléporter à une position","name":"setCoords","description":"Permet de se téléporter à une position","permissions":true},"mechanic":{"label":"Mécanicien","name":"mechanic","description":"Permet de devenir mécanicien","permissions":true},"unban":{"label":"Unban un joueur","name":"unban","description":"Permet de débannir une personne.","permissions":true},"saveAll":{"label":"Sauvegarder tous les joueurs","name":"saveAll","description":"Permet de sauvegarder tous les joueurs","permissions":true},"animation":{"description":"Permet d\'ouvrir le menu d\'animation","permissions":true,"label":"Menu animation","keys":["keyboard","K"],"name":"animation"},"bringBack":{"label":"Téléporter une personne à sa dernière position","name":"bringBack","description":"Permet de téléporter une personne à sa dernière position","permissions":true},"kick":{"label":"Expulser une personne","name":"kick","description":"Permet d\'expulser une personne du serveur","permissions":true},"jail":{"label":"Envoyer un joueur dans l\'instance trolleur","name":"jail","description":"Permet d\'envoyer un joueur dans l\'instance trolleur","permissions":true},"heading":{"label":"Afficher sa position","name":"heading","description":"Permet d\'afficher sa position","permissions":true},"removeRank":{"label":"Retirer le rank d\'un joueur","name":"removeRank","description":"Permet de retirer le rank d\'un joueur","permissions":true},"heal":{"label":"Soigner","name":"heal","description":"Permet de soigner un joueur","permissions":true},"report":{"label":"Contacter l\'équipe de modération","name":"report","description":"Permet d\'envoyer un message à un joueur","permissions":true},"unjail":{"label":"Sortir un joueur de l\'instance trolleur","name":"unjail","description":"Permet de sortir un joueur de l\'instance trolleur","permissions":true},"createProperty":{"label":"Créer une propriété","name":"createProperty","description":"Permet de créer une propriété","permissions":true},"admin":{"description":"Permet d\'ouvrir le menu d\'administration","permissions":true,"label":"Ouvrir le menu d\'administration","keys":["keyboard","F10"],"name":"admin"},"closeReport":{"label":"Fermer son report actuel","name":"closeReport","description":"Permet de fermer son report actuel","permissions":true},"createEnterprise":{"label":"Créer une entreprise","name":"createEnterprise","description":"Permet de créer une entreprise","permissions":true},"tpm":{"description":"Permet de se téléporter à un marqueur","permissions":true,"label":"TP Marqueur","keys":["keyboard","F11"],"name":"tpm"},"openTebex":{"description":"Permet d\'ouvrir la boutique","permissions":true,"label":"Ouvrir la boutique","keys":["keyboard","F1"],"name":"openTebex"},"setOrga":{"label":"Attribuer un gang/organisation","name":"setOrga","description":"Permet d\'attribuer un gang/organisation à un joueur","permissions":true},"ban":{"label":"Ban un joueur","name":"ban","description":"Permet de bannir temporairement ou définitivement une personne.","permissions":true},"tpVehicle":{"label":"Se téléporter à un véhicule","name":"tpVehicle","description":"Permet de se téléporter à un véhicule","permissions":true},"dv":{"label":"Supprimer le véhicule","name":"dv","description":"Permet de supprimer des véhicules","permissions":true}}', '{"CHANGE_ENTERPRISE_RANK_ID":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la hiéarchie d\'un grade d\'entreprise.","label":"Changer la hiéarchie d\'un grade d\'entreprise","description":"Permet de changer la hiéarchie d\'un grade d\'entreprise"},"CHANGE_MAZE_BANK_ARENA":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer l\'arène de Maze Bank.","label":"Changer l\'arène de Maze Bank","description":"Permet de changer l\'arène de Maze Bank"},"AROUND_ME_REVIVE":{"value":false,"error":"~r~Vous n\'avez pas la permission de réanimer des joueurs (zone).","label":"Réanimer des joueurs (zone)","description":"Permet de réanimer des joueurs (zone)"},"MODIFY_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifié une drogue.","label":"Modifié une drogue","description":"Permet de modifié une drogue"},"AROUND_ME_OBJECTS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des props.","label":"Supprimer des props","description":"Permet de supprimer des props"},"MODIFY_ARENAWARS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier ArenaWars.","label":"Modifier ArenaWars","description":"Permet de modifier ArenaWars"},"CREATE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une entreprise.","label":"Créer une entreprise","description":"Permet de créer une entreprise"},"AROUND_ME_PNJS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des PNJs.","label":"Supprimer des PNJs","description":"Permet de supprimer des PNJs"},"UPDATE_ENTERPRISE_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier les permissions d\'une entreprise.","label":"Modifier les permissions d\'une entreprise","description":"Permet de modifier les permissions d\'une entreprise"},"MANAGE_RANK_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les permissions d\'un rank.","label":"Gérer les permissions d\'un rank","description":"Permet de gérer les permissions d\'un rank"},"PLAYER_WARNING":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'avertir un joueur.","label":"Avertir un joueur","description":"Permet d\'avertir un joueur"},"CHANGE_ENTERPRISE_ZONE_POSITION":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la position d\'une zone d\'entreprise.","label":"Changer la position d\'une zone d\'entreprise","description":"Permet de changer la position d\'une zone d\'entreprise"},"BOUTIQUE_ADDVEHICLE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'ajouter un véhicule à la boutique.","label":"Ajouter un véhicule à la boutique","description":"Permet d\'ajouter un véhicule à la boutique"},"PLAYER_RESET_IDENTITY":{"value":false,"error":"~r~Vous n\'avez pas la permission de réinitialiser l\'identité d\'un joueur.","label":"Réinitialiser l\'identité d\'un joueur","description":"Permet de réinitialiser l\'identité d\'un joueur"},"MY_PLAYER_BLIPS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les blips.","label":"Afficher les blips","description":"Permet d\'afficher les blips"},"DELETE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer des drogues.","label":"Supprimer une drogue","description":"Permet de créer des drogues"},"RECRUIT_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans un rank.","label":"Recruter un joueur","description":"Permet de recruter un joueur dans un rank"},"AROUND_ME_MESSAGE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer un message (zone).","label":"Envoyer un message (zone)","description":"Permet d\'envoyer un message (zone)"},"AROUND_ME_HEAL":{"value":false,"error":"~r~Vous n\'avez pas la permission de heal des joueurs (zone).","label":"Heal des joueurs (zone)","description":"Permet de heal des joueurs (zone)"},"SEND_ALL_CHAT":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer des chat (ALL).","label":"Envoyer des chat (ALL)","description":"Permet d\'envoyer des chat (ALL)"},"PLAYER_SANCTIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les sanctions d\'un joueur.","label":"Sanctions d\'un joueur","description":"Permet d\'obtenir les sanctions d\'un joueur"},"MANAGE_RANK_COMMANDS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les commandes d\'un rank.","label":"Gérer les commandes d\'un rank","description":"Permet de gérer les commandes d\'un rank"},"PLAYER_INVENTORY":{"label":"Ouvrir l\'inventaire d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'ouvrir l\'inventaire d\'un joueur.","value":false,"description":"Permet d\'ouvrir l\'inventaire d\'un joueur"},"PLAYER_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les véhicules d\'un joueur.","label":"Véhicules d\'un joueur","description":"Permet d\'obtenir les véhicules d\'un joueur"},"PLAYER_KILL":{"value":false,"error":"~r~Vous n\'avez pas la permission de tuer un joueur.","label":"Tuer un joueur","description":"Permet de tuer un joueur"},"DELETE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer un rank d\'entreprise.","label":"Supprimer un rank d\'entreprise","description":"Permet de supprimer un rank d\'entreprise"},"CREATE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une drogue.","label":"Créer une drogue","description":"Permet de créer une drogue"},"MY_PLAYER_REMOVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de retirer toutes les armes.","label":"Retirer toutes les armes","description":"Permet de retirer toutes les armes"},"MY_PLAYER_GAMERTAG":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les gamertags.","label":"Afficher les gamertags","description":"Permet d\'afficher les gamertags"},"CREATE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un nouveau rank.","label":"Créer un rank","description":"Permet de créer un rank"},"CREATE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un grade d\'entreprise.","label":"Créer un grade d\'entreprise","description":"Permet de créer un grade d\'entreprise"},"PLAYER_INFORMATIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les informations d\'un joueur.","label":"Informations d\'un joueur","description":"Permet d\'obtenir les informations d\'un joueur"},"MY_PLAYER_GIVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de donner toutes les armes.","label":"Donner toutes les armes","description":"Permet de donner toutes les armes"},"KICK_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de virer un joueur de l\'entreprise.","label":"Virer un joueur de l\'entreprise","description":"Permet de virer un joueur de l\'entreprise"},"KICK_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'expulser un joueur d\'un rank.","label":"Expulser un joueur d\'un rank","description":"Permet d\'expulser un joueur d\'un rank"},"VEHICLES_REPAIR":{"value":false,"error":"~r~Vous n\'avez pas la permission de réparer un véhicule.","label":"Réparer un véhicule","description":"Permet de réparer un véhicule"},"PLAYER_VEHICLES_IMPOUND":{"value":false,"error":"~r~Vous n\'avez pas la permission de mettre en fourrière un véhicule.","label":"Mettre en fourrière un véhicule","description":"Permet de mettre en fourrière un véhicule"},"MY_PLAYER_INVISIBLESTAFF":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'être invisible par les admins.","label":"Invisible par les admins","description":"Permet de ne pas être vu par les admins"},"AROUND_ME_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des véhicules.","label":"Supprimer des véhicules","description":"Permet de supprimer des véhicules"},"RECRUIT_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans l\'entreprise.","label":"Recruter un joueur dans l\'entreprise","description":"Permet de recruter un joueur dans l\'entreprise"},"DELETE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer une entreprise.","label":"Supprimer une entreprise","description":"Permet de supprimer une entreprise"}}'),
	(6, 'helper', 'Helpeur', '[]', '{"bring":{"label":"Téléporter une personne à soi","name":"bring","description":"Permet de téléporter une personne à soi","permissions":true},"createMechanic":{"label":"Créer un mécano","name":"createMechanic","description":"Permet de créer un mécano","permissions":true},"clear":{"label":"Effacter le chat","name":"clear","description":"Permet d\'effacer son chat","permissions":true},"clearAll":{"label":"Effacter le chat de tous les joueurs","name":"clearAll","description":"Permet d\'effacer le chat de tous les joueurs","permissions":true},"creator":{"label":"Ouvrir le menu de création de personnage","name":"creator","description":"Permet d\'ouvrir le menu de création de personnage","permissions":true},"freeze":{"label":"Freeze un joueur","name":"freeze","description":"Permet de freeze un joueur","permissions":true},"ranks":{"label":"Rangs","name":"ranks","description":"Permet de gérer les rangs","permissions":true},"unfreeze":{"label":"UnFreeze un joueur","name":"unfreeze","description":"Permet de unfreeze un joueur","permissions":true},"msg":{"label":"Envoyer un message à un joueur","name":"msg","description":"Permet d\'envoyer un message à un joueur","permissions":true},"goto":{"label":"Se téléporter à une personne","name":"goto","description":"Permet de se téléporter à une personne","permissions":true},"players":{"label":"Liste des joueurs","name":"players","description":"Permet d\'afficher la liste des joueurs","permissions":true},"setArmour":{"label":"Donner de l\'armure","name":"setArmour","description":"Permet de donner de l\'armure à un joueur","permissions":true},"openPlayerInventory":{"description":"Permet d\'ouvrir l\'inventaire d\'un joueur","permissions":true,"name":"openPlayerInventory","label":"Ouvrir l\'inventaire d\'un joueur"},"openItemsInventory":{"description":"Permet d\'ouvrir l\'inventaire contenant les items","permissions":true,"name":"openItemsInventory","label":"Ouvrir l\'inventaire contenant les items"},"info":{"label":"Information de son joueur","name":"info","description":"Permet d\'afficher les informations de son joueur","permissions":true},"animationCancel":{"description":"Permet d\'annuler une animation","permissions":true,"label":"Annuler l\'animation","keys":["keyboard","X"],"name":"animationCancel"},"adminNoclip":{"description":"Permet de passer en mode noclip","permissions":true,"label":"Noclip","keys":["keyboard","O"],"name":"adminNoclip"},"jobMenu":{"description":"Permet d\'ouvrir le menu métier","permissions":true,"label":"Menu métier","keys":["keyboard","F6"],"name":"jobMenu"},"die":{"label":"Se suicider","name":"die","description":"Permet de se suicider","permissions":true},"personnalMenu":{"description":"Permet d\'ouvrir son menu personnel","permissions":true,"label":"Menu personnel","keys":["keyboard","F5"],"name":"personnalMenu"},"setJob":{"label":"Attribuer un métier","name":"setJob","description":"Permet d\'attribuer un métier à un joueur","permissions":true},"commands":{"label":"Ouvrir le menu des commandes","name":"commands","description":"Permet d\'ouvrir le menu des commandes","permissions":true},"clearInventory":{"label":"Vider l\'inventaire","name":"clearInventory","description":"Permet de vider l\'inventaire d\'un joueur","permissions":true},"kill":{"label":"Tuer un joueur","name":"kill","description":"Permet de tuer un joueur","permissions":true},"createGarage":{"label":"Créer un garage","name":"createGarage","description":"Permet de créer une propriété","permissions":true},"createSociety":{"label":"Créer une société","name":"createSociety","description":"Permet de créer une société","permissions":true},"giveItem":{"label":"Donner un item","name":"giveItem","description":"Permet de donner un item à un joueur","permissions":true},"giveMoney":{"label":"Donner de l\'argent","name":"giveMoney","description":"Permet de donner de l\'argent à un joueur","permissions":true},"revive":{"label":"Réanimer","name":"revive","description":"Réanimer une personne","permissions":true},"screenshot":{"label":"Prendre un screen du joueur","name":"screenshot","description":"Permet de prendre un screenshot de l\'écran du joueur","permissions":true},"setRank":{"label":"Changer le rank d\'un joueur","name":"setRank","description":"Permet de changer le rank d\'un joueur","permissions":true},"car":{"label":"Faire apparaître un véhicule","name":"car","description":"Permet de faire apparaître un véhicule","permissions":true},"setCoords":{"label":"Se téléporter à une position","name":"setCoords","description":"Permet de se téléporter à une position","permissions":true},"mechanic":{"label":"Mécanicien","name":"mechanic","description":"Permet de devenir mécanicien","permissions":true},"unban":{"label":"Unban un joueur","name":"unban","description":"Permet de débannir une personne.","permissions":true},"saveAll":{"label":"Sauvegarder tous les joueurs","name":"saveAll","description":"Permet de sauvegarder tous les joueurs","permissions":true},"animation":{"description":"Permet d\'ouvrir le menu d\'animation","permissions":true,"label":"Menu animation","keys":["keyboard","K"],"name":"animation"},"bringBack":{"label":"Téléporter une personne à sa dernière position","name":"bringBack","description":"Permet de téléporter une personne à sa dernière position","permissions":true},"kick":{"label":"Expulser une personne","name":"kick","description":"Permet d\'expulser une personne du serveur","permissions":true},"jail":{"label":"Envoyer un joueur dans l\'instance trolleur","name":"jail","description":"Permet d\'envoyer un joueur dans l\'instance trolleur","permissions":true},"heading":{"label":"Afficher sa position","name":"heading","description":"Permet d\'afficher sa position","permissions":true},"removeRank":{"label":"Retirer le rank d\'un joueur","name":"removeRank","description":"Permet de retirer le rank d\'un joueur","permissions":true},"heal":{"label":"Soigner","name":"heal","description":"Permet de soigner un joueur","permissions":true},"report":{"label":"Contacter l\'équipe de modération","name":"report","description":"Permet d\'envoyer un message à un joueur","permissions":true},"unjail":{"label":"Sortir un joueur de l\'instance trolleur","name":"unjail","description":"Permet de sortir un joueur de l\'instance trolleur","permissions":true},"createProperty":{"label":"Créer une propriété","name":"createProperty","description":"Permet de créer une propriété","permissions":true},"admin":{"description":"Permet d\'ouvrir le menu d\'administration","permissions":true,"label":"Ouvrir le menu d\'administration","keys":["keyboard","F10"],"name":"admin"},"closeReport":{"label":"Fermer son report actuel","name":"closeReport","description":"Permet de fermer son report actuel","permissions":true},"createEnterprise":{"label":"Créer une entreprise","name":"createEnterprise","description":"Permet de créer une entreprise","permissions":true},"tpm":{"description":"Permet de se téléporter à un marqueur","permissions":true,"label":"TP Marqueur","keys":["keyboard","F11"],"name":"tpm"},"openTebex":{"description":"Permet d\'ouvrir la boutique","permissions":true,"label":"Ouvrir la boutique","keys":["keyboard","F1"],"name":"openTebex"},"setOrga":{"label":"Attribuer un gang/organisation","name":"setOrga","description":"Permet d\'attribuer un gang/organisation à un joueur","permissions":true},"ban":{"label":"Ban un joueur","name":"ban","description":"Permet de bannir temporairement ou définitivement une personne.","permissions":true},"tpVehicle":{"label":"Se téléporter à un véhicule","name":"tpVehicle","description":"Permet de se téléporter à un véhicule","permissions":true},"dv":{"label":"Supprimer le véhicule","name":"dv","description":"Permet de supprimer des véhicules","permissions":true}}', '{"CHANGE_ENTERPRISE_RANK_ID":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la hiéarchie d\'un grade d\'entreprise.","label":"Changer la hiéarchie d\'un grade d\'entreprise","description":"Permet de changer la hiéarchie d\'un grade d\'entreprise"},"CHANGE_MAZE_BANK_ARENA":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer l\'arène de Maze Bank.","label":"Changer l\'arène de Maze Bank","description":"Permet de changer l\'arène de Maze Bank"},"RECRUIT_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans l\'entreprise.","label":"Recruter un joueur dans l\'entreprise","description":"Permet de recruter un joueur dans l\'entreprise"},"MODIFY_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifié une drogue.","label":"Modifié une drogue","description":"Permet de modifié une drogue"},"AROUND_ME_OBJECTS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des props.","label":"Supprimer des props","description":"Permet de supprimer des props"},"MODIFY_ARENAWARS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier ArenaWars.","label":"Modifier ArenaWars","description":"Permet de modifier ArenaWars"},"CREATE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une entreprise.","label":"Créer une entreprise","description":"Permet de créer une entreprise"},"AROUND_ME_PNJS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des PNJs.","label":"Supprimer des PNJs","description":"Permet de supprimer des PNJs"},"UPDATE_ENTERPRISE_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier les permissions d\'une entreprise.","label":"Modifier les permissions d\'une entreprise","description":"Permet de modifier les permissions d\'une entreprise"},"MANAGE_RANK_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les permissions d\'un rank.","label":"Gérer les permissions d\'un rank","description":"Permet de gérer les permissions d\'un rank"},"PLAYER_WARNING":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'avertir un joueur.","label":"Avertir un joueur","description":"Permet d\'avertir un joueur"},"CHANGE_ENTERPRISE_ZONE_POSITION":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la position d\'une zone d\'entreprise.","label":"Changer la position d\'une zone d\'entreprise","description":"Permet de changer la position d\'une zone d\'entreprise"},"BOUTIQUE_ADDVEHICLE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'ajouter un véhicule à la boutique.","label":"Ajouter un véhicule à la boutique","description":"Permet d\'ajouter un véhicule à la boutique"},"PLAYER_RESET_IDENTITY":{"value":false,"error":"~r~Vous n\'avez pas la permission de réinitialiser l\'identité d\'un joueur.","label":"Réinitialiser l\'identité d\'un joueur","description":"Permet de réinitialiser l\'identité d\'un joueur"},"MY_PLAYER_BLIPS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les blips.","label":"Afficher les blips","description":"Permet d\'afficher les blips"},"DELETE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer des drogues.","label":"Supprimer une drogue","description":"Permet de créer des drogues"},"RECRUIT_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans un rank.","label":"Recruter un joueur","description":"Permet de recruter un joueur dans un rank"},"AROUND_ME_MESSAGE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer un message (zone).","label":"Envoyer un message (zone)","description":"Permet d\'envoyer un message (zone)"},"AROUND_ME_HEAL":{"value":false,"error":"~r~Vous n\'avez pas la permission de heal des joueurs (zone).","label":"Heal des joueurs (zone)","description":"Permet de heal des joueurs (zone)"},"SEND_ALL_CHAT":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer des chat (ALL).","label":"Envoyer des chat (ALL)","description":"Permet d\'envoyer des chat (ALL)"},"PLAYER_SANCTIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les sanctions d\'un joueur.","label":"Sanctions d\'un joueur","description":"Permet d\'obtenir les sanctions d\'un joueur"},"MANAGE_RANK_COMMANDS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les commandes d\'un rank.","label":"Gérer les commandes d\'un rank","description":"Permet de gérer les commandes d\'un rank"},"PLAYER_INVENTORY":{"label":"Ouvrir l\'inventaire d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'ouvrir l\'inventaire d\'un joueur.","value":false,"description":"Permet d\'ouvrir l\'inventaire d\'un joueur"},"PLAYER_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les véhicules d\'un joueur.","label":"Véhicules d\'un joueur","description":"Permet d\'obtenir les véhicules d\'un joueur"},"PLAYER_KILL":{"value":false,"error":"~r~Vous n\'avez pas la permission de tuer un joueur.","label":"Tuer un joueur","description":"Permet de tuer un joueur"},"DELETE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer un rank d\'entreprise.","label":"Supprimer un rank d\'entreprise","description":"Permet de supprimer un rank d\'entreprise"},"CREATE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une drogue.","label":"Créer une drogue","description":"Permet de créer une drogue"},"MY_PLAYER_REMOVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de retirer toutes les armes.","label":"Retirer toutes les armes","description":"Permet de retirer toutes les armes"},"CREATE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un nouveau rank.","label":"Créer un rank","description":"Permet de créer un rank"},"MY_PLAYER_GIVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de donner toutes les armes.","label":"Donner toutes les armes","description":"Permet de donner toutes les armes"},"CREATE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un grade d\'entreprise.","label":"Créer un grade d\'entreprise","description":"Permet de créer un grade d\'entreprise"},"PLAYER_INFORMATIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les informations d\'un joueur.","label":"Informations d\'un joueur","description":"Permet d\'obtenir les informations d\'un joueur"},"VEHICLES_REPAIR":{"value":false,"error":"~r~Vous n\'avez pas la permission de réparer un véhicule.","label":"Réparer un véhicule","description":"Permet de réparer un véhicule"},"AROUND_ME_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des véhicules.","label":"Supprimer des véhicules","description":"Permet de supprimer des véhicules"},"KICK_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'expulser un joueur d\'un rank.","label":"Expulser un joueur d\'un rank","description":"Permet d\'expulser un joueur d\'un rank"},"KICK_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de virer un joueur de l\'entreprise.","label":"Virer un joueur de l\'entreprise","description":"Permet de virer un joueur de l\'entreprise"},"PLAYER_VEHICLES_IMPOUND":{"value":false,"error":"~r~Vous n\'avez pas la permission de mettre en fourrière un véhicule.","label":"Mettre en fourrière un véhicule","description":"Permet de mettre en fourrière un véhicule"},"MY_PLAYER_INVISIBLESTAFF":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'être invisible par les admins.","label":"Invisible par les admins","description":"Permet de ne pas être vu par les admins"},"MY_PLAYER_GAMERTAG":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les gamertags.","label":"Afficher les gamertags","description":"Permet d\'afficher les gamertags"},"AROUND_ME_REVIVE":{"value":false,"error":"~r~Vous n\'avez pas la permission de réanimer des joueurs (zone).","label":"Réanimer des joueurs (zone)","description":"Permet de réanimer des joueurs (zone)"},"DELETE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer une entreprise.","label":"Supprimer une entreprise","description":"Permet de supprimer une entreprise"}}'),
	(7, 'friend', 'Ami', '[]', '{"bring":{"label":"Téléporter une personne à soi","name":"bring","description":"Permet de téléporter une personne à soi","permissions":true},"createMechanic":{"label":"Créer un mécano","name":"createMechanic","description":"Permet de créer un mécano","permissions":true},"clear":{"label":"Effacter le chat","name":"clear","description":"Permet d\'effacer son chat","permissions":true},"clearAll":{"label":"Effacter le chat de tous les joueurs","name":"clearAll","description":"Permet d\'effacer le chat de tous les joueurs","permissions":true},"creator":{"label":"Ouvrir le menu de création de personnage","name":"creator","description":"Permet d\'ouvrir le menu de création de personnage","permissions":true},"freeze":{"label":"Freeze un joueur","name":"freeze","description":"Permet de freeze un joueur","permissions":true},"ranks":{"label":"Rangs","name":"ranks","description":"Permet de gérer les rangs","permissions":true},"unfreeze":{"label":"UnFreeze un joueur","name":"unfreeze","description":"Permet de unfreeze un joueur","permissions":true},"msg":{"label":"Envoyer un message à un joueur","name":"msg","description":"Permet d\'envoyer un message à un joueur","permissions":true},"goto":{"label":"Se téléporter à une personne","name":"goto","description":"Permet de se téléporter à une personne","permissions":true},"players":{"label":"Liste des joueurs","name":"players","description":"Permet d\'afficher la liste des joueurs","permissions":true},"setArmour":{"label":"Donner de l\'armure","name":"setArmour","description":"Permet de donner de l\'armure à un joueur","permissions":true},"openPlayerInventory":{"description":"Permet d\'ouvrir l\'inventaire d\'un joueur","permissions":true,"name":"openPlayerInventory","label":"Ouvrir l\'inventaire d\'un joueur"},"openItemsInventory":{"description":"Permet d\'ouvrir l\'inventaire contenant les items","permissions":true,"name":"openItemsInventory","label":"Ouvrir l\'inventaire contenant les items"},"info":{"label":"Information de son joueur","name":"info","description":"Permet d\'afficher les informations de son joueur","permissions":true},"animationCancel":{"description":"Permet d\'annuler une animation","permissions":true,"label":"Annuler l\'animation","keys":["keyboard","X"],"name":"animationCancel"},"adminNoclip":{"description":"Permet de passer en mode noclip","permissions":true,"label":"Noclip","keys":["keyboard","O"],"name":"adminNoclip"},"jobMenu":{"description":"Permet d\'ouvrir le menu métier","permissions":true,"label":"Menu métier","keys":["keyboard","F6"],"name":"jobMenu"},"die":{"label":"Se suicider","name":"die","description":"Permet de se suicider","permissions":true},"personnalMenu":{"description":"Permet d\'ouvrir son menu personnel","permissions":true,"label":"Menu personnel","keys":["keyboard","F5"],"name":"personnalMenu"},"setJob":{"label":"Attribuer un métier","name":"setJob","description":"Permet d\'attribuer un métier à un joueur","permissions":true},"commands":{"label":"Ouvrir le menu des commandes","name":"commands","description":"Permet d\'ouvrir le menu des commandes","permissions":true},"clearInventory":{"label":"Vider l\'inventaire","name":"clearInventory","description":"Permet de vider l\'inventaire d\'un joueur","permissions":true},"kill":{"label":"Tuer un joueur","name":"kill","description":"Permet de tuer un joueur","permissions":true},"createGarage":{"label":"Créer un garage","name":"createGarage","description":"Permet de créer une propriété","permissions":true},"createSociety":{"label":"Créer une société","name":"createSociety","description":"Permet de créer une société","permissions":true},"giveItem":{"label":"Donner un item","name":"giveItem","description":"Permet de donner un item à un joueur","permissions":true},"giveMoney":{"label":"Donner de l\'argent","name":"giveMoney","description":"Permet de donner de l\'argent à un joueur","permissions":true},"revive":{"label":"Réanimer","name":"revive","description":"Réanimer une personne","permissions":true},"screenshot":{"label":"Prendre un screen du joueur","name":"screenshot","description":"Permet de prendre un screenshot de l\'écran du joueur","permissions":true},"setRank":{"label":"Changer le rank d\'un joueur","name":"setRank","description":"Permet de changer le rank d\'un joueur","permissions":true},"car":{"label":"Faire apparaître un véhicule","name":"car","description":"Permet de faire apparaître un véhicule","permissions":true},"setCoords":{"label":"Se téléporter à une position","name":"setCoords","description":"Permet de se téléporter à une position","permissions":true},"mechanic":{"label":"Mécanicien","name":"mechanic","description":"Permet de devenir mécanicien","permissions":true},"unban":{"label":"Unban un joueur","name":"unban","description":"Permet de débannir une personne.","permissions":true},"saveAll":{"label":"Sauvegarder tous les joueurs","name":"saveAll","description":"Permet de sauvegarder tous les joueurs","permissions":true},"animation":{"description":"Permet d\'ouvrir le menu d\'animation","permissions":true,"label":"Menu animation","keys":["keyboard","K"],"name":"animation"},"bringBack":{"label":"Téléporter une personne à sa dernière position","name":"bringBack","description":"Permet de téléporter une personne à sa dernière position","permissions":true},"kick":{"label":"Expulser une personne","name":"kick","description":"Permet d\'expulser une personne du serveur","permissions":true},"jail":{"label":"Envoyer un joueur dans l\'instance trolleur","name":"jail","description":"Permet d\'envoyer un joueur dans l\'instance trolleur","permissions":true},"heading":{"label":"Afficher sa position","name":"heading","description":"Permet d\'afficher sa position","permissions":true},"removeRank":{"label":"Retirer le rank d\'un joueur","name":"removeRank","description":"Permet de retirer le rank d\'un joueur","permissions":true},"heal":{"label":"Soigner","name":"heal","description":"Permet de soigner un joueur","permissions":true},"report":{"label":"Contacter l\'équipe de modération","name":"report","description":"Permet d\'envoyer un message à un joueur","permissions":true},"unjail":{"label":"Sortir un joueur de l\'instance trolleur","name":"unjail","description":"Permet de sortir un joueur de l\'instance trolleur","permissions":true},"createProperty":{"label":"Créer une propriété","name":"createProperty","description":"Permet de créer une propriété","permissions":true},"admin":{"description":"Permet d\'ouvrir le menu d\'administration","permissions":true,"label":"Ouvrir le menu d\'administration","keys":["keyboard","F10"],"name":"admin"},"closeReport":{"label":"Fermer son report actuel","name":"closeReport","description":"Permet de fermer son report actuel","permissions":true},"createEnterprise":{"label":"Créer une entreprise","name":"createEnterprise","description":"Permet de créer une entreprise","permissions":true},"tpm":{"description":"Permet de se téléporter à un marqueur","permissions":true,"label":"TP Marqueur","keys":["keyboard","F11"],"name":"tpm"},"openTebex":{"description":"Permet d\'ouvrir la boutique","permissions":true,"label":"Ouvrir la boutique","keys":["keyboard","F1"],"name":"openTebex"},"setOrga":{"label":"Attribuer un gang/organisation","name":"setOrga","description":"Permet d\'attribuer un gang/organisation à un joueur","permissions":true},"ban":{"label":"Ban un joueur","name":"ban","description":"Permet de bannir temporairement ou définitivement une personne.","permissions":true},"tpVehicle":{"label":"Se téléporter à un véhicule","name":"tpVehicle","description":"Permet de se téléporter à un véhicule","permissions":true},"dv":{"label":"Supprimer le véhicule","name":"dv","description":"Permet de supprimer des véhicules","permissions":true}}', '{"CHANGE_ENTERPRISE_RANK_ID":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la hiéarchie d\'un grade d\'entreprise.","label":"Changer la hiéarchie d\'un grade d\'entreprise","description":"Permet de changer la hiéarchie d\'un grade d\'entreprise"},"CHANGE_MAZE_BANK_ARENA":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer l\'arène de Maze Bank.","label":"Changer l\'arène de Maze Bank","description":"Permet de changer l\'arène de Maze Bank"},"AROUND_ME_REVIVE":{"value":false,"error":"~r~Vous n\'avez pas la permission de réanimer des joueurs (zone).","label":"Réanimer des joueurs (zone)","description":"Permet de réanimer des joueurs (zone)"},"MODIFY_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifié une drogue.","label":"Modifié une drogue","description":"Permet de modifié une drogue"},"AROUND_ME_OBJECTS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des props.","label":"Supprimer des props","description":"Permet de supprimer des props"},"MODIFY_ARENAWARS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier ArenaWars.","label":"Modifier ArenaWars","description":"Permet de modifier ArenaWars"},"CREATE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une entreprise.","label":"Créer une entreprise","description":"Permet de créer une entreprise"},"AROUND_ME_PNJS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des PNJs.","label":"Supprimer des PNJs","description":"Permet de supprimer des PNJs"},"UPDATE_ENTERPRISE_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier les permissions d\'une entreprise.","label":"Modifier les permissions d\'une entreprise","description":"Permet de modifier les permissions d\'une entreprise"},"MANAGE_RANK_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les permissions d\'un rank.","label":"Gérer les permissions d\'un rank","description":"Permet de gérer les permissions d\'un rank"},"PLAYER_WARNING":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'avertir un joueur.","label":"Avertir un joueur","description":"Permet d\'avertir un joueur"},"CHANGE_ENTERPRISE_ZONE_POSITION":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la position d\'une zone d\'entreprise.","label":"Changer la position d\'une zone d\'entreprise","description":"Permet de changer la position d\'une zone d\'entreprise"},"BOUTIQUE_ADDVEHICLE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'ajouter un véhicule à la boutique.","label":"Ajouter un véhicule à la boutique","description":"Permet d\'ajouter un véhicule à la boutique"},"PLAYER_RESET_IDENTITY":{"value":false,"error":"~r~Vous n\'avez pas la permission de réinitialiser l\'identité d\'un joueur.","label":"Réinitialiser l\'identité d\'un joueur","description":"Permet de réinitialiser l\'identité d\'un joueur"},"MY_PLAYER_BLIPS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les blips.","label":"Afficher les blips","description":"Permet d\'afficher les blips"},"DELETE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer des drogues.","label":"Supprimer une drogue","description":"Permet de créer des drogues"},"RECRUIT_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans un rank.","label":"Recruter un joueur","description":"Permet de recruter un joueur dans un rank"},"AROUND_ME_MESSAGE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer un message (zone).","label":"Envoyer un message (zone)","description":"Permet d\'envoyer un message (zone)"},"AROUND_ME_HEAL":{"value":false,"error":"~r~Vous n\'avez pas la permission de heal des joueurs (zone).","label":"Heal des joueurs (zone)","description":"Permet de heal des joueurs (zone)"},"SEND_ALL_CHAT":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer des chat (ALL).","label":"Envoyer des chat (ALL)","description":"Permet d\'envoyer des chat (ALL)"},"MY_PLAYER_GAMERTAG":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les gamertags.","label":"Afficher les gamertags","description":"Permet d\'afficher les gamertags"},"MANAGE_RANK_COMMANDS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les commandes d\'un rank.","label":"Gérer les commandes d\'un rank","description":"Permet de gérer les commandes d\'un rank"},"PLAYER_INVENTORY":{"label":"Ouvrir l\'inventaire d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'ouvrir l\'inventaire d\'un joueur.","value":false,"description":"Permet d\'ouvrir l\'inventaire d\'un joueur"},"PLAYER_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les véhicules d\'un joueur.","label":"Véhicules d\'un joueur","description":"Permet d\'obtenir les véhicules d\'un joueur"},"PLAYER_KILL":{"value":false,"error":"~r~Vous n\'avez pas la permission de tuer un joueur.","label":"Tuer un joueur","description":"Permet de tuer un joueur"},"MY_PLAYER_REMOVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de retirer toutes les armes.","label":"Retirer toutes les armes","description":"Permet de retirer toutes les armes"},"CREATE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une drogue.","label":"Créer une drogue","description":"Permet de créer une drogue"},"DELETE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer un rank d\'entreprise.","label":"Supprimer un rank d\'entreprise","description":"Permet de supprimer un rank d\'entreprise"},"CREATE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un nouveau rank.","label":"Créer un rank","description":"Permet de créer un rank"},"MY_PLAYER_GIVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de donner toutes les armes.","label":"Donner toutes les armes","description":"Permet de donner toutes les armes"},"CREATE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un grade d\'entreprise.","label":"Créer un grade d\'entreprise","description":"Permet de créer un grade d\'entreprise"},"PLAYER_INFORMATIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les informations d\'un joueur.","label":"Informations d\'un joueur","description":"Permet d\'obtenir les informations d\'un joueur"},"VEHICLES_REPAIR":{"value":false,"error":"~r~Vous n\'avez pas la permission de réparer un véhicule.","label":"Réparer un véhicule","description":"Permet de réparer un véhicule"},"AROUND_ME_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des véhicules.","label":"Supprimer des véhicules","description":"Permet de supprimer des véhicules"},"KICK_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'expulser un joueur d\'un rank.","label":"Expulser un joueur d\'un rank","description":"Permet d\'expulser un joueur d\'un rank"},"KICK_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de virer un joueur de l\'entreprise.","label":"Virer un joueur de l\'entreprise","description":"Permet de virer un joueur de l\'entreprise"},"PLAYER_VEHICLES_IMPOUND":{"value":false,"error":"~r~Vous n\'avez pas la permission de mettre en fourrière un véhicule.","label":"Mettre en fourrière un véhicule","description":"Permet de mettre en fourrière un véhicule"},"MY_PLAYER_INVISIBLESTAFF":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'être invisible par les admins.","label":"Invisible par les admins","description":"Permet de ne pas être vu par les admins"},"PLAYER_SANCTIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les sanctions d\'un joueur.","label":"Sanctions d\'un joueur","description":"Permet d\'obtenir les sanctions d\'un joueur"},"RECRUIT_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans l\'entreprise.","label":"Recruter un joueur dans l\'entreprise","description":"Permet de recruter un joueur dans l\'entreprise"},"DELETE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer une entreprise.","label":"Supprimer une entreprise","description":"Permet de supprimer une entreprise"}}'),
	(8, 'user', 'Joueur', '[]', '{"bring":{"label":"Téléporter une personne à soi","name":"bring","description":"Permet de téléporter une personne à soi","permissions":true},"createMechanic":{"label":"Créer un mécano","name":"createMechanic","description":"Permet de créer un mécano","permissions":true},"clear":{"label":"Effacter le chat","name":"clear","description":"Permet d\'effacer son chat","permissions":true},"clearAll":{"label":"Effacter le chat de tous les joueurs","name":"clearAll","description":"Permet d\'effacer le chat de tous les joueurs","permissions":true},"creator":{"label":"Ouvrir le menu de création de personnage","name":"creator","description":"Permet d\'ouvrir le menu de création de personnage","permissions":true},"freeze":{"label":"Freeze un joueur","name":"freeze","description":"Permet de freeze un joueur","permissions":true},"ranks":{"label":"Rangs","name":"ranks","description":"Permet de gérer les rangs","permissions":true},"unfreeze":{"label":"UnFreeze un joueur","name":"unfreeze","description":"Permet de unfreeze un joueur","permissions":true},"msg":{"label":"Envoyer un message à un joueur","name":"msg","description":"Permet d\'envoyer un message à un joueur","permissions":true},"bringBack":{"label":"Téléporter une personne à sa dernière position","name":"bringBack","description":"Permet de téléporter une personne à sa dernière position","permissions":true},"players":{"label":"Liste des joueurs","name":"players","description":"Permet d\'afficher la liste des joueurs","permissions":true},"setArmour":{"label":"Donner de l\'armure","name":"setArmour","description":"Permet de donner de l\'armure à un joueur","permissions":true},"openPlayerInventory":{"description":"Permet d\'ouvrir l\'inventaire d\'un joueur","permissions":true,"name":"openPlayerInventory","label":"Ouvrir l\'inventaire d\'un joueur"},"openItemsInventory":{"description":"Permet d\'ouvrir l\'inventaire contenant les items","permissions":true,"name":"openItemsInventory","label":"Ouvrir l\'inventaire contenant les items"},"createEnterprise":{"label":"Créer une entreprise","name":"createEnterprise","description":"Permet de créer une entreprise","permissions":true},"animationCancel":{"description":"Permet d\'annuler une animation","permissions":true,"label":"Annuler l\'animation","keys":["keyboard","X"],"name":"animationCancel"},"adminNoclip":{"description":"Permet de passer en mode noclip","permissions":true,"label":"Noclip","keys":["keyboard","O"],"name":"adminNoclip"},"jobMenu":{"label":"Menu métier","name":"jobMenu","description":"Permet d\'ouvrir le menu métier","permissions":true},"die":{"label":"Se suicider","name":"die","description":"Permet de se suicider","permissions":true},"car":{"label":"Faire apparaître un véhicule","name":"car","description":"Permet de faire apparaître un véhicule","permissions":true},"mechanic":{"label":"Mécanicien","name":"mechanic","description":"Permet de devenir mécanicien","permissions":true},"commands":{"label":"Ouvrir le menu des commandes","name":"commands","description":"Permet d\'ouvrir le menu des commandes","permissions":true},"info":{"label":"Information de son joueur","name":"info","description":"Permet d\'afficher les informations de son joueur","permissions":true},"kill":{"label":"Tuer un joueur","name":"kill","description":"Permet de tuer un joueur","permissions":true},"goto":{"label":"Se téléporter à une personne","name":"goto","description":"Permet de se téléporter à une personne","permissions":true},"createSociety":{"label":"Créer une société","name":"createSociety","description":"Permet de créer une société","permissions":true},"giveItem":{"label":"Donner un item","name":"giveItem","description":"Permet de donner un item à un joueur","permissions":true},"giveMoney":{"label":"Donner de l\'argent","name":"giveMoney","description":"Permet de donner de l\'argent à un joueur","permissions":true},"createGarage":{"label":"Créer un garage","name":"createGarage","description":"Permet de créer une propriété","permissions":true},"revive":{"label":"Réanimer","name":"revive","description":"Réanimer une personne","permissions":true},"setRank":{"label":"Changer le rank d\'un joueur","name":"setRank","description":"Permet de changer le rank d\'un joueur","permissions":true},"clearInventory":{"label":"Vider l\'inventaire","name":"clearInventory","description":"Permet de vider l\'inventaire d\'un joueur","permissions":true},"setCoords":{"label":"Se téléporter à une position","name":"setCoords","description":"Permet de se téléporter à une position","permissions":true},"personnalMenu":{"description":"Permet d\'ouvrir son menu personnel","permissions":true,"label":"Menu personnel","keys":["keyboard","F5"],"name":"personnalMenu"},"unban":{"label":"Unban un joueur","name":"unban","description":"Permet de débannir une personne.","permissions":true},"saveAll":{"label":"Sauvegarder tous les joueurs","name":"saveAll","description":"Permet de sauvegarder tous les joueurs","permissions":true},"screenshot":{"label":"Prendre un screen du joueur","name":"screenshot","description":"Permet de prendre un screenshot de l\'écran du joueur","permissions":true},"ban":{"label":"Ban un joueur","name":"ban","description":"Permet de bannir temporairement ou définitivement une personne.","permissions":true},"kick":{"label":"Expulser une personne","name":"kick","description":"Permet d\'expulser une personne du serveur","permissions":true},"jail":{"label":"Envoyer un joueur dans l\'instance trolleur","name":"jail","description":"Permet d\'envoyer un joueur dans l\'instance trolleur","permissions":true},"heading":{"label":"Afficher sa position","name":"heading","description":"Permet d\'afficher sa position","permissions":true},"removeRank":{"label":"Retirer le rank d\'un joueur","name":"removeRank","description":"Permet de retirer le rank d\'un joueur","permissions":true},"heal":{"label":"Soigner","name":"heal","description":"Permet de soigner un joueur","permissions":true},"report":{"label":"Contacter l\'équipe de modération","name":"report","description":"Permet d\'envoyer un message à un joueur","permissions":true},"unjail":{"label":"Sortir un joueur de l\'instance trolleur","name":"unjail","description":"Permet de sortir un joueur de l\'instance trolleur","permissions":true},"createProperty":{"label":"Créer une propriété","name":"createProperty","description":"Permet de créer une propriété","permissions":true},"admin":{"label":"Ouvrir le menu d\'administration","keys":["keyboard","F10"],"description":"Permet d\'ouvrir le menu d\'administration","name":"admin"},"closeReport":{"label":"Fermer son report actuel","name":"closeReport","description":"Permet de fermer son report actuel","permissions":true},"tpm":{"description":"Permet de se téléporter à un marqueur","permissions":true,"label":"TP Marqueur","keys":["keyboard","F11"],"name":"tpm"},"openTebex":{"description":"Permet d\'ouvrir la boutique","permissions":true,"label":"Ouvrir la boutique","keys":["keyboard","F1"],"name":"openTebex"},"setOrga":{"label":"Attribuer un gang/organisation","name":"setOrga","description":"Permet d\'attribuer un gang/organisation à un joueur","permissions":true},"setJob":{"label":"Attribuer un métier","name":"setJob","description":"Permet d\'attribuer un métier à un joueur","permissions":true},"animation":{"description":"Permet d\'ouvrir le menu d\'animation","permissions":true,"label":"Menu animation","keys":["keyboard","K"],"name":"animation"},"tpVehicle":{"label":"Se téléporter à un véhicule","name":"tpVehicle","description":"Permet de se téléporter à un véhicule","permissions":true},"dv":{"label":"Supprimer le véhicule","name":"dv","description":"Permet de supprimer des véhicules","permissions":true}}', '{"CHANGE_ENTERPRISE_RANK_ID":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la hiéarchie d\'un grade d\'entreprise.","label":"Changer la hiéarchie d\'un grade d\'entreprise","description":"Permet de changer la hiéarchie d\'un grade d\'entreprise"},"CHANGE_MAZE_BANK_ARENA":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer l\'arène de Maze Bank.","label":"Changer l\'arène de Maze Bank","description":"Permet de changer l\'arène de Maze Bank"},"RECRUIT_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans l\'entreprise.","label":"Recruter un joueur dans l\'entreprise","description":"Permet de recruter un joueur dans l\'entreprise"},"MODIFY_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifié une drogue.","label":"Modifié une drogue","description":"Permet de modifié une drogue"},"AROUND_ME_OBJECTS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des props.","label":"Supprimer des props","description":"Permet de supprimer des props"},"MODIFY_ARENAWARS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier ArenaWars.","label":"Modifier ArenaWars","description":"Permet de modifier ArenaWars"},"CREATE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une entreprise.","label":"Créer une entreprise","description":"Permet de créer une entreprise"},"AROUND_ME_PNJS":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des PNJs.","label":"Supprimer des PNJs","description":"Permet de supprimer des PNJs"},"UPDATE_ENTERPRISE_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de modifier les permissions d\'une entreprise.","label":"Modifier les permissions d\'une entreprise","description":"Permet de modifier les permissions d\'une entreprise"},"MANAGE_RANK_PERMISSIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les permissions d\'un rank.","label":"Gérer les permissions d\'un rank","description":"Permet de gérer les permissions d\'un rank"},"PLAYER_WARNING":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'avertir un joueur.","label":"Avertir un joueur","description":"Permet d\'avertir un joueur"},"CHANGE_ENTERPRISE_ZONE_POSITION":{"value":false,"error":"~r~Vous n\'avez pas la permission de changer la position d\'une zone d\'entreprise.","label":"Changer la position d\'une zone d\'entreprise","description":"Permet de changer la position d\'une zone d\'entreprise"},"BOUTIQUE_ADDVEHICLE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'ajouter un véhicule à la boutique.","label":"Ajouter un véhicule à la boutique","description":"Permet d\'ajouter un véhicule à la boutique"},"PLAYER_RESET_IDENTITY":{"value":false,"error":"~r~Vous n\'avez pas la permission de réinitialiser l\'identité d\'un joueur.","label":"Réinitialiser l\'identité d\'un joueur","description":"Permet de réinitialiser l\'identité d\'un joueur"},"MY_PLAYER_BLIPS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les blips.","label":"Afficher les blips","description":"Permet d\'afficher les blips"},"DELETE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer des drogues.","label":"Supprimer une drogue","description":"Permet de créer des drogues"},"RECRUIT_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de recruter un joueur dans un rank.","label":"Recruter un joueur","description":"Permet de recruter un joueur dans un rank"},"AROUND_ME_MESSAGE":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer un message (zone).","label":"Envoyer un message (zone)","description":"Permet d\'envoyer un message (zone)"},"AROUND_ME_HEAL":{"value":false,"error":"~r~Vous n\'avez pas la permission de heal des joueurs (zone).","label":"Heal des joueurs (zone)","description":"Permet de heal des joueurs (zone)"},"SEND_ALL_CHAT":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'envoyer des chat (ALL).","label":"Envoyer des chat (ALL)","description":"Permet d\'envoyer des chat (ALL)"},"PLAYER_SANCTIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les sanctions d\'un joueur.","label":"Sanctions d\'un joueur","description":"Permet d\'obtenir les sanctions d\'un joueur"},"MANAGE_RANK_COMMANDS":{"value":false,"error":"~r~Vous n\'avez pas la permission de gérer les commandes d\'un rank.","label":"Gérer les commandes d\'un rank","description":"Permet de gérer les commandes d\'un rank"},"PLAYER_INVENTORY":{"label":"Ouvrir l\'inventaire d\'un joueur","error":"~r~Vous n\'avez pas la permission d\'ouvrir l\'inventaire d\'un joueur.","value":false,"description":"Permet d\'ouvrir l\'inventaire d\'un joueur"},"PLAYER_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les véhicules d\'un joueur.","label":"Véhicules d\'un joueur","description":"Permet d\'obtenir les véhicules d\'un joueur"},"PLAYER_KILL":{"value":false,"error":"~r~Vous n\'avez pas la permission de tuer un joueur.","label":"Tuer un joueur","description":"Permet de tuer un joueur"},"DELETE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer un rank d\'entreprise.","label":"Supprimer un rank d\'entreprise","description":"Permet de supprimer un rank d\'entreprise"},"CREATE_DRUGS":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer une drogue.","label":"Créer une drogue","description":"Permet de créer une drogue"},"MY_PLAYER_REMOVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de retirer toutes les armes.","label":"Retirer toutes les armes","description":"Permet de retirer toutes les armes"},"CREATE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un nouveau rank.","label":"Créer un rank","description":"Permet de créer un rank"},"MY_PLAYER_GIVEALLWEAPONS":{"value":false,"error":"~r~Vous n\'avez pas la permission de donner toutes les armes.","label":"Donner toutes les armes","description":"Permet de donner toutes les armes"},"CREATE_ENTERPRISE_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission de créer un grade d\'entreprise.","label":"Créer un grade d\'entreprise","description":"Permet de créer un grade d\'entreprise"},"PLAYER_INFORMATIONS":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'obtenir les informations d\'un joueur.","label":"Informations d\'un joueur","description":"Permet d\'obtenir les informations d\'un joueur"},"VEHICLES_REPAIR":{"value":false,"error":"~r~Vous n\'avez pas la permission de réparer un véhicule.","label":"Réparer un véhicule","description":"Permet de réparer un véhicule"},"AROUND_ME_VEHICLES":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer des véhicules.","label":"Supprimer des véhicules","description":"Permet de supprimer des véhicules"},"KICK_PLAYER_RANK":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'expulser un joueur d\'un rank.","label":"Expulser un joueur d\'un rank","description":"Permet d\'expulser un joueur d\'un rank"},"KICK_ENTERPRISE_PLAYER":{"value":false,"error":"~r~Vous n\'avez pas la permission de virer un joueur de l\'entreprise.","label":"Virer un joueur de l\'entreprise","description":"Permet de virer un joueur de l\'entreprise"},"PLAYER_VEHICLES_IMPOUND":{"value":false,"error":"~r~Vous n\'avez pas la permission de mettre en fourrière un véhicule.","label":"Mettre en fourrière un véhicule","description":"Permet de mettre en fourrière un véhicule"},"MY_PLAYER_INVISIBLESTAFF":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'être invisible par les admins.","label":"Invisible par les admins","description":"Permet de ne pas être vu par les admins"},"MY_PLAYER_GAMERTAG":{"value":false,"error":"~r~Vous n\'avez pas la permission d\'afficher les gamertags.","label":"Afficher les gamertags","description":"Permet d\'afficher les gamertags"},"AROUND_ME_REVIVE":{"value":false,"error":"~r~Vous n\'avez pas la permission de réanimer des joueurs (zone).","label":"Réanimer des joueurs (zone)","description":"Permet de réanimer des joueurs (zone)"},"DELETE_ENTERPRISE":{"value":false,"error":"~r~Vous n\'avez pas la permission de supprimer une entreprise.","label":"Supprimer une entreprise","description":"Permet de supprimer une entreprise"}}');

-- Listage de la structure de table bluestark_v2. user_animation
CREATE TABLE IF NOT EXISTS `user_animation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `licence` varchar(80) NOT NULL,
  `dict` text NOT NULL,
  `anim` text NOT NULL,
  `name` text NOT NULL,
  `param` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Listage des données de la table bluestark_v2.user_animation : ~5 rows (environ)
INSERT INTO `user_animation` (`id`, `licence`, `dict`, `anim`, `name`, `param`) VALUES
	(12, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'custom@gylphic', 'gylphic', 'Glyphic(Fortnite)', '{"EmoteLoop":true,"EmoteMoving":false}'),
	(13, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'misschinese2_crystalmazemcs1_cs', 'dance_loop_tao', 'Dance 6', '{"EmoteLoop":true}'),
	(14, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'rcmbarry', 'm_cower_01', 'Ce rendre', '{"EmoteDuration":-1,"EmoteLoop":true,"EmoteMoving":false}'),
	(15, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'custom@dont_start', 'dont_start', 'Dont Start(Fortnite)', '{"EmoteMoving":false,"EmoteDuration":-1,"EmoteLoop":true}'),
	(16, 'license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', 'oddjobs@assassinate@multi@yachttarget@lapdance', 'yacht_ld_f', 'Lapdance 6', '{"EmoteLoop":true}');

-- Listage de la structure de table bluestark_v2. user_axeoffury
CREATE TABLE IF NOT EXISTS `user_axeoffury` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Axe of Fury';

-- Listage des données de la table bluestark_v2.user_axeoffury : ~0 rows (environ)
INSERT INTO `user_axeoffury` (`id`, `score`) VALUES
	(1, 707);

-- Listage de la structure de table bluestark_v2. user_billing
CREATE TABLE IF NOT EXISTS `user_billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Billing of players';

-- Listage des données de la table bluestark_v2.user_billing : ~3 rows (environ)
INSERT INTO `user_billing` (`id`, `identifier`, `data`) VALUES
	(1, 'license:7896784edbc2f7f3b16c413601f85b334ca96543', '[]'),
	(2, 'license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', '[]'),
	(3, 'license:b754f5f908d5750f838dc62c60ed7904a6b609a3', '[]');

-- Listage de la structure de table bluestark_v2. user_clothes
CREATE TABLE IF NOT EXISTS `user_clothes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `outfit` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Clothes of Users';

-- Listage des données de la table bluestark_v2.user_clothes : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. user_drugs
CREATE TABLE IF NOT EXISTS `user_drugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `position` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Drugs of BlueStark';

-- Listage des données de la table bluestark_v2.user_drugs : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. user_enterprise
CREATE TABLE IF NOT EXISTS `user_enterprise` (
  `enterpriseId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `employees` longtext DEFAULT NULL,
  `grades` longtext DEFAULT NULL,
  `permissions` longtext DEFAULT NULL,
  `money` int(11) DEFAULT 0,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`enterpriseId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Enterprise of Players';

-- Listage des données de la table bluestark_v2.user_enterprise : ~1 rows (environ)
INSERT INTO `user_enterprise` (`enterpriseId`, `type`, `name`, `label`, `employees`, `grades`, `permissions`, `money`, `data`) VALUES
	(1, 'mechanic', 'bennys', 'Bennys', '[]', '[{"name":"owner","label":"Patron"},{"name":"recruit","label":"Recrue"}]', '{"RECRUIT_PLAYER":{"label":"Recruter un joueur","value":false,"description":"Permet de recruter un joueur","error":"~r~Vous n\'avez pas la permission de recruter un joueur."}}', 0, '{"position_marker_management":{"x":-194.37704467773438,"y":-1315.26025390625,"z":31.30045127868652},"position_marker_custom_3":{"x":-214.2673797607422,"y":-1335.667724609375,"z":31.30048942565918},"position_marker_custom_2":{"x":-207.87350463867188,"y":-1336.7996826171876,"z":31.30048561096191},"position_marker_stash":{"x":-223.7645263671875,"y":-1338.65673828125,"z":31.30117607116699},"position_marker_custom_1":{"x":-194.14874267578126,"y":-1326.6375732421876,"z":31.30048751831054},"position_marker_wardrobe":{"x":-194.22689819335938,"y":-1336.900146484375,"z":31.30049133300781}}');

-- Listage de la structure de table bluestark_v2. user_garage
CREATE TABLE IF NOT EXISTS `user_garage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `menuPosition` longtext DEFAULT NULL,
  `spawnPosition` longtext DEFAULT NULL,
  `spawnHeading` int(11) DEFAULT NULL,
  `deletePosition` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Garage of Players';

-- Listage des données de la table bluestark_v2.user_garage : ~0 rows (environ)
INSERT INTO `user_garage` (`id`, `type`, `name`, `label`, `menuPosition`, `spawnPosition`, `spawnHeading`, `deletePosition`) VALUES
	(3, 'car', 'parking_public_1', 'Parking central', '{"x":215.48825073242188,"y":-809.558837890625,"z":30.74308967590332}', '{"x":230.66590881347657,"y":-798.4365844726563,"z":30.57079124450683}', 157, '{"x":214.04603576660157,"y":-793.7001953125,"z":30.85089683532715}');

-- Listage de la structure de table bluestark_v2. user_identifiers
CREATE TABLE IF NOT EXISTS `user_identifiers` (
  `owner` varchar(50) DEFAULT NULL,
  `currentBan` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `uniqueId` int(11) DEFAULT NULL,
  UNIQUE KEY `identifier` (`owner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='All identifiers of players';

-- Listage des données de la table bluestark_v2.user_identifiers : ~8 rows (environ)
INSERT INTO `user_identifiers` (`owner`, `currentBan`, `data`, `uniqueId`) VALUES
	('license:b90704455b3efdd5907547511ac05e09eb931f67', NULL, '["ip:192.168.1.15","ip:92.184.116.249","fivem:8610708","ip:92.184.119.128","4:c9ccba4bf708fffa3ec3dc1692e7e041f14b5064adb0fd3aac0d49fded1d3c51","4:5f04799b29825197b2ebf37376a3ef950c0c8f35383964015ea8f870b84174bd","4:7d15f59657d9d65a04f57e9358da5c4ed19c34e7ed0f84bee123b95e1be408cc","5:f96b121648509890a509cf8296cb205e48e2cd9ef0be50e096f0e74d43419376","3:b9b66e1e748a99e2bce28b9d0ac54c2762d27feead2cebdc455273abae52ac28","4:ed1528313285ab225f72e8f6dc22e2923d04e176aa2c7f4d6343edae5606504c","live:985155083766413","4:48fec63dc0f7fbb368fab9f5ea4a6d4f0eb578a9f3f6555fbd10427420618ef7","discord:1010355242296168528","license2:4ca203824e2bf7fda4a3acebfe703e8e5b55beb9","2:43ee01c5994cf6ba8fc8e2dd09591c05952e687ff26c00e0db63ebfd6353841e","steam:11000011a4c7762","ip:127.0.0.1","ip:172.20.10.4","4:94c19a4ad013261c61b31bdf7a85a5650b1cebfbde93b9b01264c1f5bebfe17c","ip:172.20.10.6","ip:92.184.117.186","ip:90.46.70.69","license:b90704455b3efdd5907547511ac05e09eb931f67"]', 1),
	('license:b43afe87dd1281d72407ae605e3cb1d47b2bb96b', NULL, '["6:549cec084c158f2f3bb11da47d126fae3e7f1d371465893c774a1b0898885e46","4:3be870742ac78b776ec95abdc9b30c149774a5a7d113218b77757e072fb48587","4:c5cd6f30de1cb4d79f9f8c848f8397e4e9eda79a31c700643dde9bf12a877f42","ip:10.0.4.10","discord:858832110591803402","ip:10.0.1.10","4:986fcc202a8f6775c96d2dd95e2064039033465628bf201ae28a0438612aac5e","6:82f12ae956d29e8837357b5a16556625393569e82a4237e05b7979a0d8805064","ip:10.0.2.10","steam:1100001588189e8","4:ff29e136620a123b6c170f45b6ba0ef0a92de54d46832ea3c0256cd7d5cf02ee","4:d535cc7ac079381713b4109745635b199549cf7763ffc2884e9627bbbfd1eb89","4:c62ec817d3928284c72857dcae1c0d0388ac03d5dd37c2eb70d9178b0ca9eae4","4:92f76f1fcb2d4fe89d38bab67cabb98be35993809a2ba9d973fb41370d5e7d44","license2:b43afe87dd1281d72407ae605e3cb1d47b2bb96b","license:b43afe87dd1281d72407ae605e3cb1d47b2bb96b"]', 2),
	('license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', NULL, '["ip:92.167.159.191","live:914801736677033","3:c831b866acd6a62f4009df65bd0777641163dacfcf3295ee46b1963ea01ca1bd","5:09517d8d14e2222d0f5a37838022fa3ffa6c6ba1a352f34c7d84852dfa1ea76a","4:ca07a4d3f2ab4a1e54eb5cd7e96002378b0ba74e5c50ed38b67456466d7d54a1","xbl:2535431921942615","license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66","license2:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66","4:e6643664872460d15afa48fe6bba8cab5306fcd620509c83e0e3c4aa3b56df64","4:775bc207b2bd63b6043f0a9a23265f5c5d0c8c33a514b4da43e235534c425c78","discord:1053443723108831262","4:592689627ec107e3fd843d40f68892afc3aef6507cefee5159295db960bb8989","fivem:757768","4:bb7c09237647599138e2112000986b22bdbebaa51188f7ea0f866f3da732a592","4:661d7fd877bc0f38ae859b64218000e4b9a39bc1fa90e646c289e3a4f0c67398","3:150451812c4ffd5240e33a8cbd6b36d50863c77dd7ed2ee8475257e17c884db7","4:4ab9f1fccceb7bee05edfd36302252e7992701cfaec2fbc4bb3b268e1298822b","2:15f0215c892e21754563de28ab935c85b3aa6496691065de12ee21c36d0b38e4","4:d46458d129bfcd05f015b696a0db760cf5fe5ef99a0176184218d0307b211e95","4:8cecc8b3357236519cadcf0c26c3e8bf0b67017270c08fcd0ef49c11390e1a47","discord:294933586774196234","steam:11000013690d3c4","5:7abd27393b1b638f9bafa484f21693a4900023a2ebedddf0d53fa4f6509f2ede","2:c242990636fef11556a1011d527aa676d664c9437f24d1f97e614104c075769f"]', 3),
	('license:7896784edbc2f7f3b16c413601f85b334ca96543', NULL, '["2:af46b9dc08bbb6bd91fb590cf4fb59d0f49522e097c943009d3e8cb0d8aed238","4:d840cb0b41a6cfa2d2dca68b03dcffb4bbead81dfd0c4512a6d3c7c527d6881d","4:013a8b41c16614597fda9b210d4e072cdb827496e705a7868e5d58bd583117fc","4:3d435ac545ae7a3d3157526aaac767894bc2ef68801692aa961b1fe818913326","license:7896784edbc2f7f3b16c413601f85b334ca96543","license2:7896784edbc2f7f3b16c413601f85b334ca96543","3:af8509b6a6b2123c189371ba5b607a43f21184fea7038e923aba8f4b76e1f6d7","ip:86.238.81.20","xbl:2535407836271266","discord:519613963617697792","live:844425118595517","steam:11000013aca8850"]', 4),
	('license:66b377b7c0bfc397e2c7cd3707208d40981d8567', NULL, '["ip:185.161.168.118","4:ad2b438815eed6cfc602363936d570a598675f6cd63534b9a58ae3c864813d3c","license2:66b377b7c0bfc397e2c7cd3707208d40981d8567","license:66b377b7c0bfc397e2c7cd3707208d40981d8567","6:ecf6fe528204c8c78721a60733ce9d3528670a2792f5b091b799b989b947f9d3","4:f1f5b5ca74626f219eb38e4cff10a3a541f56ee69f30b9a8fdf0369570bbc8f0","4:f19e93d24b32fc141f2f78da6ec98a693c27a1355db39d8c4e2e40f7449b7f7d","ip:185.161.168.165"]', 5),
	('license:4befc1af7c19e7642fb727b6586f25977dfc143a', NULL, '["discord:807969721660080138","4:3a030ede4ffd59877554b99a958efe78b6d25b369eafa9106363ad25bae4d064","steam:1100001358dbb4b","5:eac557691190c39e9ef056e15158569a6c0e48cc9878654c034b387393716078","ip:192.168.1.120","license2:4befc1af7c19e7642fb727b6586f25977dfc143a","3:9acbd3f851e6319c0da831b81e039c1b5483c836f22db745486029fcb32c576b","license:4befc1af7c19e7642fb727b6586f25977dfc143a","4:234365615b5da916ff4e984b396902d74e67f3fdb2b2b905e9ddb1f9ec627ca1","4:9737baa7114500820ba3fd22a100618138c8e47cdc6493c1dbd88abe8c268a20"]', 6),
	('license:1c5b46ea53fd2dc6e7dd781dbd74118140ab4b4f', NULL, '["fivem:8400586","4:a84ea68266bf5f507ee86b9e2b8669803124cf9cddcc329acac3f5efae7065f7","ip:109.9.186.167","license:1c5b46ea53fd2dc6e7dd781dbd74118140ab4b4f","3:439d7e0b585b80d31aacd6943e27f462a16d7c33e4b352426511534134028687","ip:109.9.186.250","ip:109.9.186.135","5:fc2aff6d5055067154767dbb789c43c27280da4e431dd49c26344e6b88f539c9","license2:1c5b46ea53fd2dc6e7dd781dbd74118140ab4b4f","xbl:2535469031557827","steam:11000010dfa58b6","discord:1068983660755300382","live:985154988767860","2:c091f4ae608f564ba877edb8597a0c8cdf4db6770c19d174b3ef97f9c97c6c70","4:95ad6873cd9fa8f48c7b9ffa5c98e49537a653a4f460a40db7b22dfafd9515a1","4:3c2ed474f4b2123ca9de5ec00a48a57c764d2ab723a94d998319b0e2f775019e"]', 0),
	('license:b754f5f908d5750f838dc62c60ed7904a6b609a3', NULL, '["4:e6cd9e94b841993b915dc560c453a60f484b0ff5e60f710818f1f6fe1458831b","4:4f42d859377347272ee781a18bcfcdc042eda610f0e19162d1c712e02c5ffc92","ip:172.16.0.2","5:7a7853f024aaea21c429da4ed4719a53b0982784236c29d8ab155c358130e2a4","ip:169.254.171.41","xbl:2535450378906410","3:5e2a83861ddeb8d716f853bf357071376f097410b8dbbb1a643d15073ecf51d1","live:914798718017546","fivem:2972599","license2:b754f5f908d5750f838dc62c60ed7904a6b609a3","license:b754f5f908d5750f838dc62c60ed7904a6b609a3","4:5573767e8e25cc5318fc2b0b2463a87076da77abe8afc04e69810661842a21a2","2:34dd1f19f1dbd79d252f3db6ae976273b84869e932faad32c04d987d100d2d30"]', 6);

-- Listage de la structure de table bluestark_v2. user_jail
CREATE TABLE IF NOT EXISTS `user_jail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `time` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Jail Players of BlueStark';

-- Listage des données de la table bluestark_v2.user_jail : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. user_licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `identifier` varchar(50) NOT NULL,
  `licenses` longtext DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='License of Players';

-- Listage des données de la table bluestark_v2.user_licenses : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. user_playtime
CREATE TABLE IF NOT EXISTS `user_playtime` (
  `identifier` varchar(50) NOT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='PlayTime of Players';

-- Listage des données de la table bluestark_v2.user_playtime : ~9 rows (environ)
INSERT INTO `user_playtime` (`identifier`, `time`) VALUES
	('license:1c5b46ea53fd2dc6e7dd781dbd74118140ab4b4f', 4073),
	('license:4befc1af7c19e7642fb727b6586f25977dfc143a', 575),
	('license:66b377b7c0bfc397e2c7cd3707208d40981d8567', 787),
	('license:7896784edbc2f7f3b16c413601f85b334ca96543', 54560),
	('license:b43afe87dd1281d72407ae605e3cb1d47b2bb96b', 2090),
	('license:b754f5f908d5750f838dc62c60ed7904a6b609a3', 18742),
	('license:b90704455b3efdd5907547511ac05e09eb931f67', 339504),
	('license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', 119098),
	('steam:11000011a4c7762', 9216);

-- Listage de la structure de table bluestark_v2. user_sanctions
CREATE TABLE IF NOT EXISTS `user_sanctions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Sanctions of Players';

-- Listage des données de la table bluestark_v2.user_sanctions : ~27 rows (environ)
INSERT INTO `user_sanctions` (`id`, `identifier`, `type`, `data`) VALUES
	(2, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Avertissement', '{"date":"12/02/2023 15:43:35","admin":"Joshuaa","reason":"Yuuma t\'es beau"}'),
	(4, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Kick', '{"date":"12/02/2023 16:30:34","reason":"merci de ne plus faire de HRP","admin":"Joshuaa"}'),
	(5, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Jail', '{"reason":"Ne roule plus aussi vite !","date":"12/02/2023 22:16:10","admin":"Believer Shark"}'),
	(6, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Jail', '{"reason":"Test","date":"17/02/2023 23:06:05","admin":"Believer Shark"}'),
	(7, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Jail', '{"reason":"Test","date":"17/02/2023 23:06:34","admin":"Believer Shark"}'),
	(8, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Jail', '{"reason":"Salut","date":"17/02/2023 23:10:41","admin":"Believer Shark"}'),
	(9, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Avertissement', '{"reason":"Stark","date":"17/02/2023 23:10:48","admin":"Believer Shark"}'),
	(10, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Kick', '{"date":"18/02/2023 01:18:42","reason":"Déconnexion du serveur"}'),
	(11, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Jail', '{"admin":"Joshua Pigmi","reason":"Salut","date":"25/02/2023 20:29:46"}'),
	(12, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Jail', '{"reason":"Test","date":"27/02/2023 21:25:31","admin":"Joshua Pigmi"}'),
	(13, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Jail', '{"admin":"Joshua Pigmi","reason":"Test","date":"02/04/2023 19:04:47"}'),
	(14, 'license:7896784edbc2f7f3b16c413601f85b334ca96543', 'Jail', '{"reason":"tu troll c\'est pas bien","date":"04/04/2023 14:17:20","admin":"Scott Scott"}'),
	(15, 'license:7896784edbc2f7f3b16c413601f85b334ca96543', 'Avertissement', '{"reason":"Étranger","date":"04/04/2023 14:21:26","admin":"Scott Scott"}'),
	(16, 'license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', 'Avertissement', '{"reason":"CACAPIPI","date":"04/04/2023 14:21:27","admin":"zeit"}'),
	(17, 'license:7896784edbc2f7f3b16c413601f85b334ca96543', 'Avertissement', '{"reason":"Non français","date":"04/04/2023 14:21:33","admin":"Scott Scott"}'),
	(18, 'license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', 'Avertissement', '{"reason":"cacapipi","date":"04/04/2023 14:21:50","admin":"zeit"}'),
	(19, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Avertissement', '{"date":"04/04/2023 14:23:04","admin":"Joshua Pigmi","reason":"test scott"}'),
	(20, 'license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', 'Avertissement', '{"admin":"Scott Scott","reason":"immigré","date":"04/04/2023 14:24:44"}'),
	(21, 'license:ed7a81b2b525f9c98eb3a3a607ab3aa9f6255f66', 'Kick', '{"admin":"Scott Scott","reason":"Ceci est un kick exécuté par le satellite de la NASA","date":"04/04/2023 14:28:50"}'),
	(22, 'license:7896784edbc2f7f3b16c413601f85b334ca96543', 'Jail', '{"admin":"Scott Scott","reason":"1","date":"04/04/2023 14:29:19"}'),
	(23, 'license:66b377b7c0bfc397e2c7cd3707208d40981d8567', 'Avertissement', '{"reason":"Dorian test","date":"05/04/2023 00:43:03","admin":"Shadow"}'),
	(24, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Jail', '{"date":"10/04/2023 20:23:50","reason":"Nique ta mère yuuma","admin":"Joshua Pigmi"}'),
	(25, 'license:b90704455b3efdd5907547511ac05e09eb931f67', 'Jail', '{"admin":"Believer","reason":"Test","date":"20/04/2023 18:19:52"}'),
	(26, 'license:b754f5f908d5750f838dc62c60ed7904a6b609a3', 'Jail', '{"reason":"A pas dit bonjour","date":"08/05/2023 16:22:02","admin":"JustGod"}'),
	(27, 'license:b754f5f908d5750f838dc62c60ed7904a6b609a3', 'Jail', '{"reason":"A pas dit bonjour","date":"08/05/2023 18:02:29","admin":"JustGod"}'),
	(28, 'license:b754f5f908d5750f838dc62c60ed7904a6b609a3', 'Jail', '{"admin":"JustGod","date":"09/05/2023 00:20:52","reason":"Tooooooooooooz"}'),
	(29, 'license:1c5b46ea53fd2dc6e7dd781dbd74118140ab4b4f', 'Avertissement', '{"reason":"Attention !","date":"13/06/2023 16:04:06","admin":"Evan"}');

-- Listage de la structure de table bluestark_v2. user_territories
CREATE TABLE IF NOT EXISTS `user_territories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namecontrol` varchar(50) DEFAULT NULL,
  `influence` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Territories of BlueStark';

-- Listage des données de la table bluestark_v2.user_territories : ~26 rows (environ)
INSERT INTO `user_territories` (`id`, `namecontrol`, `influence`) VALUES
	(1, NULL, NULL),
	(2, NULL, NULL),
	(3, NULL, NULL),
	(4, NULL, NULL),
	(5, NULL, NULL),
	(6, NULL, NULL),
	(7, NULL, NULL),
	(8, NULL, NULL),
	(9, NULL, NULL),
	(10, NULL, NULL),
	(11, NULL, NULL),
	(12, NULL, NULL),
	(13, NULL, NULL),
	(14, NULL, NULL),
	(15, NULL, NULL),
	(16, NULL, NULL),
	(17, NULL, NULL),
	(18, NULL, NULL),
	(19, NULL, NULL),
	(20, NULL, NULL),
	(21, NULL, NULL),
	(22, NULL, NULL),
	(23, NULL, NULL),
	(24, NULL, NULL),
	(25, NULL, NULL),
	(26, NULL, NULL),
	(27, NULL, NULL),
	(28, NULL, NULL);

-- Listage de la structure de table bluestark_v2. user_whitelist
CREATE TABLE IF NOT EXISTS `user_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Whitelist of BlueStark';

-- Listage des données de la table bluestark_v2.user_whitelist : ~0 rows (environ)

-- Listage de la structure de table bluestark_v2. vip_purchased
CREATE TABLE IF NOT EXISTS `vip_purchased` (
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Purchased of VIP System';

-- Listage des données de la table bluestark_v2.vip_purchased : ~23 rows (environ)
INSERT INTO `vip_purchased` (`product_id`, `user_id`) VALUES
	(3, 1),
	(3, 1),
	(1, 1),
	(1, 1),
	(1, 1),
	(3, 1),
	(1, 1),
	(3, 1),
	(1, 1),
	(1, 1),
	(3, 1),
	(3, 1),
	(3, 1),
	(3, 1),
	(1, 1),
	(1, 1),
	(1, 1),
	(1, 1),
	(1, 1),
	(1, 1),
	(1, 1),
	(1, 1),
	(1, 1);

-- Listage de la structure de table bluestark_v2. vip_redeem
CREATE TABLE IF NOT EXISTS `vip_redeem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `coin_count` int(11) NOT NULL DEFAULT 0,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `from` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Listage des données de la table bluestark_v2.vip_redeem : ~1 rows (environ)
INSERT INTO `vip_redeem` (`id`, `code`, `coin_count`, `used`, `from`) VALUES
	(1, 'tbx-300000', 50000, 1, 'b90704455b3efdd5907547511ac05e09eb931f67');

-- Listage de la structure de table bluestark_v2. vip_stocks
CREATE TABLE IF NOT EXISTS `vip_stocks` (
  `product_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Stocks of VIP Product';

-- Listage des données de la table bluestark_v2.vip_stocks : ~2 rows (environ)
INSERT INTO `vip_stocks` (`product_id`, `name`, `stock`) VALUES
	(1, 'bg700w', 5),
	(3, 'weapon_hell', 0);

-- Listage de la structure de table bluestark_v2. vip_users
CREATE TABLE IF NOT EXISTS `vip_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) NOT NULL,
  `coin` int(11) NOT NULL DEFAULT 0,
  `purchased` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`purchased`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `Unique` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Listage des données de la table bluestark_v2.vip_users : ~1 rows (environ)
INSERT INTO `vip_users` (`id`, `license`, `coin`, `purchased`) VALUES
	(1, 'b90704455b3efdd5907547511ac05e09eb931f67', 788, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
