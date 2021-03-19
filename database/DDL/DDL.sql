CREATE SCHEMA IF NOT EXISTS `BIKES` ;

USE `BIKES` ;

CREATE TABLE IF NOT EXISTS `BIKES`.`PERSON` (
  `PERSON_ID` INT NOT NULL AUTO_INCREMENT,
  `PERSON_TYPE` ENUM('EM', 'GC', 'IN', 'SC', 'SP', 'VC') NOT NULL,
  `NAME_STYLE` SMALLINT NOT NULL,
  `TITLE` ENUM('Mr.', 'Mrs.', 'Ms.', 'Sr.', 'Sra.') NULL,
  `FIRST_NAME` VARCHAR(32) NOT NULL,
  `MIDDLE_NAME` VARCHAR(32),
  `LAST_NAME` VARCHAR(32),
  `SUFFIX` ENUM('II', 'III', 'IV', 'Jr.', 'Sr.', 'PhD') NULL,
  `EMAIL_PROMOTION` SMALLINT NOT NULL,
  `ADDITIONAL_CONTACT_INFO` TEXT NULL,
  `DEMOGRAPHICS` TEXT NOT NULL,
  `ROWGUID` CHAR(36) NOT NULL,
  `MODIFIED_DATE` DATETIME NOT NULL,
  PRIMARY KEY (`PERSON_ID`),
  UNIQUE INDEX `ID_PERSON_UNIQUE` (`PERSON_ID` ASC));

CREATE TABLE IF NOT EXISTS `BIKES`.`CUSTOMER` (
  `CUSTOMER_ID` INT NOT NULL AUTO_INCREMENT,
  `PERSON_ID` INT,
  `STORE_ID` SMALLINT NULL,
  `TERRITORY_ID` SMALLINT NOT NULL,
  `ACCOUNT_NUMBER` CHAR(10) NOT NULL,
  `ROWGUID` CHAR(36) NOT NULL,
  `MODIFIED_DATE` DATETIME NOT NULL,
  PRIMARY KEY (`CUSTOMER_ID`),
  UNIQUE INDEX `ID_CUSTOMER_UNIQUE` (`CUSTOMER_ID` ASC),
  INDEX `fk_CUSTOMER_PERSON_ID1_idx` (`PERSON_ID` ASC),
  CONSTRAINT `fk_CUSTOMER_PERSON_ID1`
    FOREIGN KEY (`PERSON_ID`)
    REFERENCES `BIKES`.`PERSON` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `BIKES`.`SALES_ORDER_HEADER` (
  `SALES_ORDER_ID` INT NOT NULL AUTO_INCREMENT,
  `REVISION_NUMBER` SMALLINT NOT NULL,
  `ORDER_DATE` DATETIME NOT NULL,
  `SHIP_DATE` DATETIME NOT NULL,
  `STATUS` SMALLINT NOT NULL,
  `ONLINE_ORDER_FLAG` TINYINT(1) NOT NULL,
  `SALES_ORDER_NUMBER` CHAR(7) NOT NULL,
  `PURCHASE_ORDER_NUMBER` VARCHAR(13) NULL,
  `ACCOUNT_NUMBER` CHAR(14) NOT NULL,
  `CUSTOMER_ID` INT NOT NULL,
  `SALES_PERSON_ID` INT NULL,
  `TERRITORY_ID` SMALLINT NOT NULL,
  `BILL_TO_ADDRESS_ID` INT NOT NULL,
  `SHIP_TO_ADDRESS_ID` INT NOT NULL,
  `SHIP_METHOD_ID` SMALLINT NOT NULL,
  `CREDIT_CARD_ID` INT NULL,
  `CREDIT_CARD_APPROVAL_CODE` VARCHAR(14) NULL,
  `CURRENCY_RATE_ID` INT NULL,
  `SUB_TOTAL` FLOAT NOT NULL,
  `TAX_AMT` FLOAT NOT NULL,
  `FREIGHT` FLOAT NOT NULL,
  `TOTAL_DUE` FLOAT NULL,
  `COMMENT` VARCHAR(32) NULL,
  `ROWGUID` CHAR(36) NOT NULL,
  `MODIFIED_DATE` DATETIME NOT NULL,
  PRIMARY KEY (`SALES_ORDER_ID`),
  UNIQUE INDEX `ID_SALES_ORDER_UNIQUE` (`SALES_ORDER_ID` ASC),
  INDEX `fk_SALES_ORDER_HEADER_CUSTOMER_ID1_idx` (`CUSTOMER_ID` ASC),
  CONSTRAINT `fk_SALES_ORDER_HEADER_CUSTOMER_ID1`
    FOREIGN KEY (`CUSTOMER_ID`)
    REFERENCES `BIKES`.`CUSTOMER` (`CUSTOMER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `BIKES`.`PRODUCT` (
  `PRODUCT_ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(128) NOT NULL,
  `PRODUCT_NUMBER` VARCHAR(10) NOT NULL,
  `MAKE_FLAG` TINYINT(1) NOT NULL,
  `FINISHED_GOODS_FLAG` TINYINT(1) NOT NULL,
  `COLOR` VARCHAR(32) NULL,
  `SAFETY_STOCK_LEVEL` SMALLINT NOT NULL,
  `REORDER_POINT` SMALLINT NULL,
  `STANDARD_COST` FLOAT NOT NULL,
  `LIST_PRICE` FLOAT NOT NULL,
  `SIZE` ENUM('38', '40', '42', '44', '46', '48', '50', '52', '54', '56', '58', '60', '62', '64', '66', '68', '70', 'S', 'M', 'L', 'XL') NULL,
  `SIZE_UNIT_MEASURE_CODE` ENUM('MM', 'CM', 'M', 'KM') NULL,
  `WEIGHT_UNIT_MEASURE_CODE` ENUM('LB', 'G') NULL,
  `WEIGHT` FLOAT(2) NULL,
  `DAYS_OF_MANUFACTURE` TINYINT NULL,
  `PRODUCT_LINE` ENUM('R', 'M', 'T', 'S') NULL,
  `CLASS` ENUM('H', 'M', 'L') NULL,
  `PRODUCT_SUBCATEGORY_ID` SMALLINT NULL,
  `PRODUCT_MODEL_ID` SMALLINT NULL,
  `SELL_START_DATE` DATETIME NOT NULL,
  `SELL_END_DATE` DATETIME NULL,
  `DISCONTINUED_DATE` DATETIME NULL,
  `ROWGUID` CHAR(36) NOT NULL,
  `MODIFIED_DATE` DATETIME NOT NULL,
  PRIMARY KEY (`PRODUCT_ID`),
  UNIQUE INDEX `PRODUCT_ID_UNIQUE` (`PRODUCT_ID` ASC),
  UNIQUE INDEX `NAME_UNIQUE` (`NAME` ASC),
  UNIQUE INDEX `PRODUCT_NUMBER_UNIQUE` (`PRODUCT_NUMBER` ASC));

CREATE TABLE IF NOT EXISTS `BIKES`.`SPECIAL_ORFER_PRODUCT` (
  `SPECIAL_ORFER_PRODUCT_ID` INT NOT NULL AUTO_INCREMENT,
  `PRODUCT_ID` INT NOT NULL,
  `ROWGUID` CHAR(36) NOT NULL,
  `MODIFIED_DATE` DATETIME NOT NULL,
  PRIMARY KEY (`SPECIAL_ORFER_PRODUCT_ID`, `PRODUCT_ID`),
  UNIQUE INDEX `ID_SPECIAL_ORFER_PRODUCT_UNIQUE` (`SPECIAL_ORFER_PRODUCT_ID` ASC),
  INDEX `fk_SPECIAL_ORFER_PRODUCT_PRODUCT_ID1_idx` (`PRODUCT_ID` ASC),
  CONSTRAINT `fk_SPECIAL_ORFER_PRODUCT_PRODUCT_ID1`
    FOREIGN KEY (`PRODUCT_ID`)
    REFERENCES `BIKES`.`PRODUCT` (`PRODUCT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `BIKES`.`SALES_ORDER_DETAIL` (
  `SALES_ORDER_ID` INT NOT NULL,
  `SPECIAL_ORFER_PRODUCT_ID` INT NOT NULL,
  `PRODUCT_ID` INT NOT NULL,
  `CARRIER_TRACKING_NUMBER` CHAR(12) NULL,
  `ORDER_QTY` SMALLINT NOT NULL,
  `SPECIAL_ORFER_ID` SMALLINT NOT NULL,
  `UNIT_PRICE` FLOAT NOT NULL,
  `UNIT_PRICE_DISCOUNT` FLOAT NOT NULL,
  `LINE_TOTAL` INT NOT NULL,
  `ROWGUID` CHAR(36) NOT NULL,
  `MODIFIED_DATE` DATETIME NOT NULL,
  INDEX `fk_SALES_ORDER_DETAIL_SALES_ORDER_ID1_idx` (`SALES_ORDER_ID` ASC),
  PRIMARY KEY (`SALES_ORDER_ID`, `SPECIAL_ORFER_PRODUCT_ID`, `PRODUCT_ID`),
  INDEX `fk_SALES_ORDER_DETAIL_ID_SPECIAL_ORFER_PRODUCT1_idx` (`SPECIAL_ORFER_PRODUCT_ID` ASC, `PRODUCT_ID` ASC),
  CONSTRAINT `fk_SALES_ORDER_DETAIL_SALES_ORDER_ID1`
    FOREIGN KEY (`SALES_ORDER_ID`)
    REFERENCES `BIKES`.`SALES_ORDER_HEADER` (`SALES_ORDER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SALES_ORDER_DETAIL_ID_SPECIAL_ORFER_PRODUCT1`
    FOREIGN KEY (`SPECIAL_ORFER_PRODUCT_ID` , `PRODUCT_ID`)
    REFERENCES `BIKES`.`SPECIAL_ORFER_PRODUCT` (`SPECIAL_ORFER_PRODUCT_ID` , `PRODUCT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
