INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mcdonalds', 'McDonalds', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mcdonalds', 'McDonalds', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_mcdonalds', 'McDonalds', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mcdonalds', 'McDonalds')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mcdonalds',0,'recrue','Recrue',12,'{}','{}'),
	('mcdonalds',1,'novice','Novice',24,'{}','{}'),
	('mcdonalds',2,'experimente','Experimente',36,'{}','{}'),
	('mcdonalds',3,'chief',"Chef d\'équipe",48,'{}','{}'),
	('mcdonalds',4,'boss','Patron',0,'{}','{}')
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('steak', 'Steak haché', -1),
	('pouletdroifcongeler', 'Poulet Cru', -1),
	('ptwrap', 'Galette', -1),
	('potatoescru', 'Potatoes Surgélé', -1),
	('fritecru', 'Frites Surgélé', -1),
	('doublecheese', 'Double Cheese', -1),
	('vingtnuggets', 'Boite de 20 Nuggets', -1),
	('ptitwrap', 'Petit wrap', -1),
	('potatoes', 'Potatoes', -1),
	('frites', 'Frites', -1),
	('fritesfritecru', 'Frites surgelé', -1),
	('ketchup', 'Sachet de ketchup', -1)
;