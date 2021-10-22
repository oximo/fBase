CREATE TABLE `vcoffre` (
  `vPlate` varchar(255) NOT NULL,
  `vInventory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `vLoadout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `vMoney` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `vcoffre`
  ADD PRIMARY KEY (`vPlate`);
COMMIT;
