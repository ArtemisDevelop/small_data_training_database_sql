/* Database created by ArtemisDevelop */
USE small_data_training_database;
START TRANSACTION;
SET FOREIGN_KEY_CHECKS=0;

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/assignment.csv'
INTO TABLE tbl_assignment
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`assignmentId`,`assignmentName`,`projectId`, `assignmentPriority`, `assignmentStatus`)
SET `assignmentName` = REPLACE(`assignmentName`, '"', '');

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/country.csv'
INTO TABLE tbl_country
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`countryIsoAlpha3`, `countryIsoAlpha2`, `countryNameGerman`, `countryNameEnglish`, `countryNameOriginal`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/countryCurrency.csv'
INTO TABLE tbl_countryCurrency
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`countryIsoAlpha3`,`currencyCode`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/countryPhone.csv'
INTO TABLE tbl_countryPhone
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`countryIsoAlpha3`,`phonePrefix`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/currency.csv'
INTO TABLE tbl_currency
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`currencyCode`,`currencyName`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/department.csv'
INTO TABLE tbl_department
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`departmentId`, `departmentName`, `departmentHead`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/emplAssign.csv'
INTO TABLE tbl_emplAssign
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`emplId`,`assignmentId`,`dateStart`,`dateEnd`)
SET
	dateStart = STR_TO_DATE(`dateStart`, '%Y-%m-%d %H:%i:%s'),
	dateEnd = STR_TO_DATE(`dateEnd`, '%Y-%m-%d %H:%i:%s');

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/employee.csv'
INTO TABLE tbl_employee
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`emplId`, `emplDepartment`, `emplFirstName`, `emplLastName`, `emplStreet`, `emplStreetNr`, `emplZip`, `emplTown`, `emplCountry`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/emplSalary.csv'
INTO TABLE tbl_emplSalary
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`emplId`,`salaryId`,`emplPercentage`,`validDate`)
SET `validDate` = STR_TO_DATE(`validDate`, '%Y-%m-%d %H:%i:%s');

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/game.csv'
INTO TABLE tbl_game
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`gameId`,`gameTitle`,`gameDescription`,`gameCurrency`,`gameBasePrice`,`gameRelease`,`gameStatus`, `gameReviewNumber`)
SET `gameRelease` = IF(STR_TO_DATE(`gameRelease`, '%Y-%m-%d') = 0, NULL, STR_TO_DATE(`gameRelease`, '%Y-%m-%d'));

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/operatingSystem.csv'
INTO TABLE tbl_operatingSystem
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`systemName`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/opSysGame.csv'
INTO TABLE tbl_opSysGame
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`opSysGameId`, `gameId`, `systemName`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/phonePrefix.csv'
INTO TABLE tbl_phonePrefix
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`phonePrefix`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/project.csv'
INTO TABLE tbl_project
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`projectId`,`projectName`,`projectHead`, `gameId`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/salary.csv'
INTO TABLE tbl_salary
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`salaryName`,`salaryAmount`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/sale.csv'
INTO TABLE tbl_sale
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`saleId`, `webServiceId`, `opSysGameId`, `userId`, `currencyCode`, `salePrice`, `saleDate`)
SET saleDate = STR_TO_DATE(`saleDate`, '%Y-%m-%d %H:%i:%s');

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/user.csv'
INTO TABLE tbl_user
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`userId`,`userName`,`userPasswordHash`,`userCompany`,`userFirstName`,`userLastName`,`userStreet`,`userStreetNr`,`userZip`,`userTown`,`userCountry`,`userGender`,`userPhonePrefix`,`userPhone`,`userMail`)
SET `userCompany` = REPLACE(`userCompany`, '"', ''),
	`userStreet` = REPLACE(`userStreet`, '"', ''),
	`userTown` = REPLACE(`userTown`, '"', '');

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/webService.csv'
INTO TABLE tbl_webService
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`webServiceId`, `webServiceName`);

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/webServiceGame.csv'
INTO TABLE tbl_webServiceGame
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`webServiceId`,`opSysGameId`,`webServiceGameRelease`,`webServiceGameStatus`)
SET `webServiceGameRelease` = STR_TO_DATE(`webServiceGameRelease`, '%Y-%m-%d');

LOAD DATA LOCAL INFILE '/small_data_db_training/csv/5m_entry/review.csv'
INTO TABLE tbl_review
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`reviewId`,`gameId`,`userId`,`reviewScore`,`reviewFeedback`)
SET `reviewFeedback` = REPLACE(`reviewFeedback`, '"', '');

SET FOREIGN_KEY_CHECKS=1;
COMMIT;