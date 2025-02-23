CREATE TABLE IF NOT EXISTS `kibra-mechanics` (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `employees` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `money` float NOT NULL,
  `wage` float NOT NULL,
  `discountrate` float NOT NULL,
  `customers` text NOT NULL DEFAULT '[]',
  `repairfee` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;