/* Database created by ArtemisDevelop */

START TRANSACTION;
DROP DATABASE IF EXISTS small_data_training_database;
CREATE DATABASE IF NOT EXISTS small_data_training_database
	DEFAULT CHARACTER SET = 'utf8mb4'
    COLLATE = 'utf8mb4_general_ci';

USE small_data_training_database;

-- CREATE MASTERDATA TABLE
CREATE TABLE tbl_operatingSystem(
	`systemName` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`systemName`)
);

CREATE TABLE tbl_currency(
	`currencyCode` CHAR(3) NOT NULL,
    `currencyName` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`currencyCode`)
);

CREATE TABLE tbl_country(
	`countryIsoAlpha3` CHAR(3) NOT NULL,
    `countryIsoAlpha2` CHAR(2) NOT NULL,
    `countryNameGerman` VARCHAR(45) NOT NULL,
    `countryNameEnglish` VARCHAR(45) NOT NULL,
    `countryNameOriginal` VARCHAR(45),
    PRIMARY KEY (`countryIsoAlpha3`)
);

CREATE TABLE tbl_webService(
	`webServiceId` INT NOT NULL AUTO_INCREMENT,
    `webServiceName` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`webServiceId`)
);

CREATE TABLE tbl_salary(
	`salaryId` INT NOT NULL AUTO_INCREMENT,
    `salaryAmount` DECIMAL(13,2) NOT NULL,
    `salaryName` VARCHAR(45),
    PRIMARY KEY (`salaryId`)
);

CREATE TABLE tbl_phonePrefix(
	`phonePrefix` VARCHAR(6) NOT NULL,
    PRIMARY KEY (`phonePrefix`)
);

CREATE TABLE tbl_department(
	`departmentId` INT NOT NULL AUTO_INCREMENT,
    `departmentName` VARCHAR(45),
    `departmentHead` INT,
    PRIMARY KEY (`departmentId`)
);

-- CREATE DATA TABLE
CREATE TABLE tbl_employee(
	`emplId` INT NOT NULL AUTO_INCREMENT,
    `emplDepartment` INT,
    `emplFirstName` VARCHAR(45) NOT NULL,
    `emplLastName` VARCHAR(45) NOT NULL,
	`emplStreet` VARCHAR(50) NOT NULL,
    `emplStreetNr` SMALLINT NOT NULL,
    `emplZip` MEDIUMINT NOT NULL,
    `emplTown` VARCHAR(50) NOT NULL,
    `emplCountry`CHAR(3) NOT NULL,
    PRIMARY KEY (`emplId`),
    CONSTRAINT fk_department_employee FOREIGN KEY (`emplDepartment`) REFERENCES tbl_department (`departmentId`),
    CONSTRAINT fk_country_employee FOREIGN KEY (`emplCountry`) REFERENCES tbl_country (`countryIsoAlpha3`)
);

ALTER TABLE tbl_department
	ADD CONSTRAINT fk_employee_departmentHead FOREIGN KEY (`departmentHead`) REFERENCES tbl_employee (`emplId`);

CREATE TABLE tbl_game(
	`gameId` INT NOT NULL AUTO_INCREMENT,
    `gameTitle` VARCHAR(45) NOT NULL,
    `gameDescription` TEXT,
    `gameCurrency` CHAR(3),
    `gameBasePrice` DECIMAL(6,2),
    `gameRelease` DATE,
    `gameStatus` ENUM('Planning',  'In Development',  'Beta Phase',  'Released',  'Deleted',  'Maintenance', 'Cancelled'),
    `gameReviewNumber` INT NOT NULL DEFAULT 0, 
    PRIMARY KEY (`gameId`),
    CONSTRAINT fk_currency_game FOREIGN KEY (`gameCurrency`) REFERENCES tbl_currency (`currencyCode`)
);

CREATE TABLE tbl_opSysGame(
	`opSysGameId` INT NOT NULL AUTO_INCREMENT,
    `systemName` VARCHAR(45) NOT NULL,
    `gameId` INT NOT NULL,
    PRIMARY KEY (`opSysGameId`),
    CONSTRAINT fk_system_opSysName FOREIGN KEY (`systemName`) REFERENCES tbl_operatingSystem (`systemName`),
    CONSTRAINT fk_game_opSysName FOREIGN KEY (`gameId`) REFERENCES tbl_game (`gameId`),
    CONSTRAINT uk_sysName_game UNIQUE KEY (`systemName`, `gameId`)
);

CREATE TABLE tbl_project(
	`projectId` INT NOT NULL AUTO_INCREMENT,
    `projectName` VARCHAR(125) NOT NULL,
    `projectHead` INT,
    `gameId` INT,
    PRIMARY KEY (`projectId`),
    CONSTRAINT fk_employee_projectHead FOREIGN KEY (`projectHead`) REFERENCES tbl_employee (`emplId`),
	CONSTRAINT fk_game_project FOREIGN KEY (`gameId`) REFERENCES tbl_game (`gameId`)
);

CREATE TABLE tbl_assignment(
	`assignmentId` INT NOT NULL AUTO_INCREMENT,
    `assignmentName`VARCHAR(150) NOT NULL,
    `projectId` INT NOT NULL,
    `assignmentPriority` ENUM('urgent', 'high', 'moderate', 'low') NOT NULL DEFAULT 'moderate',
    `assignmentStatus` ENUM('InProgress', 'Pending', 'Completed') NOT NULL, 
    PRIMARY KEY (`assignmentId`),
    CONSTRAINT fk_project_assignment FOREIGN KEY (`projectId`) REFERENCES tbl_project (`projectId`)
);

CREATE TABLE tbl_user(
	`userId` INT NOT NULL AUTO_INCREMENT,
    `userName` VARCHAR(45) NOT NULL,
    `userPasswordHash` CHAR(64) NOT NULL,
    `userCompany` VARCHAR(45),
    `userFirstName` VARCHAR(45) NOT NULL,
    `userLastName` VARCHAR(45) NOT NULL,
    `userStreet` VARCHAR(45),
    `userStreetNr` SMALLINT,
    `userZip` MEDIUMINT,
    `userTown` VARCHAR(45),
    `userCountry` CHAR(3) NOT NULL,
    `userGender` ENUM('male', 'female', 'divers'),
    `userPhonePrefix` VARCHAR(6),
    `userPhone` BIGINT,
    `userMail` VARCHAR(100),
    PRIMARY KEY (`userId`),
    CONSTRAINT fk_country_user FOREIGN KEY (`userCountry`) REFERENCES tbl_country (`countryIsoAlpha3`),
    CONSTRAINT fk_phonePrefix_user FOREIGN KEY (`userPhonePrefix`) REFERENCES tbl_phonePrefix (`phonePrefix`),
    CHECK (`userMail` LIKE '%@%.%')
);

CREATE TABLE tbl_review(
	`reviewId` INT NOT NULL AUTO_INCREMENT,
    `userId` INT,
    `gameId` INT,
    `reviewScore` TINYINT NOT NULL,
    `reviewFeedback` TEXT,
    PRIMARY KEY (`reviewId`)
);

CREATE TABLE tbl_sale(
	`saleId` INT NOT NULL AUTO_INCREMENT,
    `webServiceId` INT NOT NULL,
    `opSysGameId` INT NOT NULL,
    `userId` INT NOT NULL,
    `currencyCode` CHAR(3) NOT NULL,
    `salePrice` DECIMAL(6,2) NOT NULL,
    `saleDate` TIMESTAMP NOT NULL,
    PRIMARY KEY (`saleId`),
    CONSTRAINT fk_webService_sale FOREIGN KEY (`webServiceId`) REFERENCES tbl_webService (`webServiceId`),
    CONSTRAINT fk_opSysGame_sale FOREIGN KEY (`opSysGameId`) REFERENCES tbl_opSysGame (`opSysGameId`),
    CONSTRAINT fk_user_sale FOREIGN KEY (`userId`) REFERENCES tbl_user (`userId`),
    CONSTRAINT fk_currency_sale FOREIGN KEY (`currencyCode`) REFERENCES tbl_currency (`currencyCode`)
);

CREATE TABLE tbl_countryCurrency(
	`countryIsoAlpha3` CHAR(3) NOT NULL,
    `currencyCode` CHAR(3) NOT NULL,
    PRIMARY KEY (`countryIsoAlpha3`,`currencyCode`),
    CONSTRAINT fk_country_countryCurrency FOREIGN KEY (`countryIsoAlpha3`) REFERENCES tbl_country (`countryIsoAlpha3`),
	CONSTRAINT fk_currency_countryCurrency FOREIGN KEY (`currencyCode`) REFERENCES tbl_currency (`currencyCode`)
);

CREATE TABLE tbl_countryPhone(
	`countryIsoAlpha3` CHAR(3) NOT NULL,
    `phonePrefix` VARCHAR(6) NOT NULL,
    PRIMARY KEY (`countryIsoAlpha3`,`phonePrefix`),
    CONSTRAINT fk_country_countryPhone FOREIGN KEY (`countryIsoAlpha3`) REFERENCES tbl_country (`countryIsoAlpha3`),
    CONSTRAINT fk_phonePrefix_countryPhone FOREIGN KEY (`phonePrefix`) REFERENCES tbl_phonePrefix (`phonePrefix`)
);

CREATE TABLE tbl_emplSalary(
	`emplId` INT NOT NULL,
    `salaryId` INT,
    `emplPercentage` TINYINT NOT NULL,
    `validDate` DATETIME NOT NULL,
    PRIMARY KEY (`emplId`,`salaryId`),
    CONSTRAINT fk_employee_emplSalary FOREIGN KEY (`emplId`) REFERENCES tbl_employee (`emplId`),
    CONSTRAINT fk_salary_emplSalary FOREIGN KEY (`salaryId`) REFERENCES tbl_salary (`salaryId`)
);

CREATE TABLE tbl_emplAssign(
	`emplId` INT NOT NULL,
    `assignmentId` INT NOT NULL,
    `dateStart` TIMESTAMP NOT NULL,
    `dateEnd` DATETIME,
    PRIMARY KEY (`emplId`,`assignmentId`),
    CONSTRAINT fk_employee_emplAssign FOREIGN KEY (`emplId`) REFERENCES tbl_employee (`emplId`),
    CONSTRAINT fk_assignment_emplAssign FOREIGN KEY (`assignmentId`) REFERENCES tbl_assignment (`assignmentId`)
);

CREATE TABLE tbl_webServiceGame(
	`webServiceId` INT NOT NULL,
    `opSysGameId` INT NOT NULL,
    `webServiceGameRelease` DATE,
    `webServiceGameStatus` ENUM('Planning', 'Beta Phase',  'Released',  'Deleted',  'Maintenance', 'Cancelled') DEFAULT 'Released',
    PRIMARY KEY (`webServiceId`, `opSysGameId`),
    CONSTRAINT fk_webService_webServiceGame FOREIGN KEY (`webServiceId`) REFERENCES tbl_webService (`webServiceId`),
    CONSTRAINT fk_game_webServiceGame FOREIGN KEY (`opSysGameId`) REFERENCES tbl_opSysGame (`opSysGameId`)
);


-- CREATE TRIGGERS
DELIMITER //
CREATE TRIGGER tg_insert_review
AFTER INSERT ON tbl_review FOR EACH ROW
BEGIN
	UPDATE tbl_game
    SET `gameReviewNumber` = `gameReviewNumber` + 1
    WHERE `gameId` = NEW.gameId;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER tg_delete_review AFTER DELETE ON tbl_review FOR EACH ROW
BEGIN
	UPDATE tbl_game
    SET `gameReviewNumber` = `gameReviewNumber` - 1
    WHERE `gameId` = OLD.gameId;
END//
DELIMITER ; 
COMMIT;

