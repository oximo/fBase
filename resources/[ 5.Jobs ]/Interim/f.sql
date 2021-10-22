INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_ferrailleur','Ferrailleur',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_ferrailleur','Ferrailleur',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_ferrailleur', 'Ferrailleur', 1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('ferrailleur', 'Ferrailleur');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('ferrailleur', 0, 'ferrailleur', 'Ferrailleur', 500, 'null', 'null');