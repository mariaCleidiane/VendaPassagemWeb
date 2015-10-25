SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `tam` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `tam` ;

-- -----------------------------------------------------
-- Table `tam`.`Passageiro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Passageiro` (
  `codPassageiro` INT NOT NULL AUTO_INCREMENT ,
  `nomePassageiro` VARCHAR(70) NOT NULL ,
  `sobrenomePassageiro` VARCHAR(70) NOT NULL ,
  `generoPassageiro` VARCHAR(1) NOT NULL ,
  `rgPassageiro` VARCHAR(15) NOT NULL ,
  `cpfPassageiro` VARCHAR(11) NULL ,
  `tratamentoPassageiro` VARCHAR(20) NOT NULL ,
  `diaNascimento` INT NOT NULL ,
  `mesNascimento` INT NOT NULL ,
  `anoNascimento` INT NOT NULL ,
  `celularPassageiro` VARCHAR(15) NULL ,
  `emailPassageiro` VARCHAR(45) NULL ,
  PRIMARY KEY (`codPassageiro`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Aeronave`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Aeronave` (
  `codAeronave` INT NOT NULL AUTO_INCREMENT ,
  `nomeAeronave` VARCHAR(45) NOT NULL ,
  `modeloAeronave` VARCHAR(45) NOT NULL COMMENT '			' ,
  `qtdAssento` INT NOT NULL ,
  `qtdFileiras` INT NOT NULL ,
  PRIMARY KEY (`codAeronave`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Aeroporto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Aeroporto` (
  `codAeroporto` INT NOT NULL ,
  `nomeAeroporto` VARCHAR(100) NOT NULL ,
  `siglaAeroporto` VARCHAR(3) NULL ,
  `icao` VARCHAR(4) NULL ,
  `estadoAeroporto` VARCHAR(100) NULL ,
  `cidadeAeroporto` VARCHAR(100) NULL ,
  PRIMARY KEY (`codAeroporto`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Voo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Voo` (
  `codVoo` INT NOT NULL AUTO_INCREMENT ,
  `precoVoo` DOUBLE NOT NULL ,
  `statusVoo` VARCHAR(45) NOT NULL ,
  `horaPartida` INT NOT NULL ,
  `minutoPartida` INT NOT NULL ,
  `diaPartida` INT NOT NULL ,
  `mesPartida` INT NOT NULL ,
  `anoPartida` INT NOT NULL ,
  `codAeronave` INT NOT NULL ,
  `codOrigem` INT NOT NULL ,
  `codDestino` INT NOT NULL ,
  PRIMARY KEY (`codVoo`) ,
  INDEX `codAeronave_idx` (`codAeronave` ASC) ,
  INDEX `codAeroporto_idx` (`codOrigem` ASC) ,
  INDEX `codDestino_idx` (`codDestino` ASC) ,
  CONSTRAINT `cod_Aeronave`
    FOREIGN KEY (`codAeronave` )
    REFERENCES `tam`.`Aeronave` (`codAeronave` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_Aeroporto`
    FOREIGN KEY (`codOrigem` )
    REFERENCES `tam`.`Aeroporto` (`codAeroporto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_Destino`
    FOREIGN KEY (`codDestino` )
    REFERENCES `tam`.`Aeroporto` (`codAeroporto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Assento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Assento` (
  `codAssento` INT NOT NULL AUTO_INCREMENT ,
  `colunaAssento` INT NOT NULL ,
  `fileiraAssento` INT NOT NULL ,
  `colunaSigla` CHAR NOT NULL ,
  `codAeronave` INT NOT NULL ,
  `disponibilidade` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`codAssento`) ,
  INDEX `codAeronave_idx` (`codAeronave` ASC) ,
  CONSTRAINT `codAeronave`
    FOREIGN KEY (`codAeronave` )
    REFERENCES `tam`.`Aeronave` (`codAeronave` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Passagem`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Passagem` (
  `numeroPassagem` INT NOT NULL AUTO_INCREMENT ,
  `valorPassagem` DECIMAL(10,2) NOT NULL ,
  `taxaEmbarque` DECIMAL(5,2) NOT NULL ,
  `tipoPassagem` VARCHAR(45) NOT NULL ,
  `assentoPassagem` INT NULL ,
  `checkIn` TINYINT(1) NOT NULL ,
  `ticketBagagem` VARCHAR(20) NOT NULL ,
  `cod_Passageiro` INT NOT NULL ,
  `codVoo` INT NOT NULL ,
  PRIMARY KEY (`numeroPassagem`) ,
  INDEX `codPassageiro_idx` (`cod_Passageiro` ASC) ,
  INDEX `codVoo_idx` (`codVoo` ASC) ,
  INDEX `assentoPassagem_idx` (`assentoPassagem` ASC) ,
  CONSTRAINT `codPassageiro`
    FOREIGN KEY (`cod_Passageiro` )
    REFERENCES `tam`.`Passageiro` (`codPassageiro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `codVoo`
    FOREIGN KEY (`codVoo` )
    REFERENCES `tam`.`Voo` (`codVoo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `assentoPassagem`
    FOREIGN KEY (`assentoPassagem` )
    REFERENCES `tam`.`Assento` (`codAssento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Pagamento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Pagamento` (
  `codPagamento` INT NOT NULL AUTO_INCREMENT ,
  `codPassageiroTitular` INT NOT NULL ,
  `diaPagamento` INT NOT NULL ,
  `mesPagamento` INT NOT NULL ,
  `anoPagamento` INT NOT NULL ,
  `tipoPagamento` VARCHAR(8) NOT NULL ,
  `numeroPassagem` INT NOT NULL ,
  PRIMARY KEY (`codPagamento`) ,
  INDEX `numeroPassagem_idx` (`numeroPassagem` ASC) ,
  INDEX `codPassageiroTitular_idx` (`codPassageiroTitular` ASC) ,
  CONSTRAINT `numeroPassagem`
    FOREIGN KEY (`numeroPassagem` )
    REFERENCES `tam`.`Passagem` (`numeroPassagem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `codPassageiroTitular`
    FOREIGN KEY (`codPassageiroTitular` )
    REFERENCES `tam`.`Passageiro` (`codPassageiro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Reembolso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Reembolso` (
  `codReembolso` INT NOT NULL AUTO_INCREMENT ,
  `bancoReembolso` VARCHAR(45) NOT NULL ,
  `agenciaReembolso` VARCHAR(45) NOT NULL ,
  `contaReembolso` VARCHAR(45) NOT NULL ,
  `codPassagem` INT NOT NULL ,
  `cod_PassageiroTitular` INT NOT NULL ,
  PRIMARY KEY (`codReembolso`) ,
  INDEX `codPassagem_idx` (`codPassagem` ASC) ,
  INDEX `codPassageiroTitular_idx` (`cod_PassageiroTitular` ASC) ,
  CONSTRAINT `codPassagem`
    FOREIGN KEY (`codPassagem` )
    REFERENCES `tam`.`Passagem` (`numeroPassagem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_PassageiroTitular`
    FOREIGN KEY (`cod_PassageiroTitular` )
    REFERENCES `tam`.`Passageiro` (`codPassageiro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Dinheiro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Dinheiro` (
  `codDinheiro` INT NOT NULL AUTO_INCREMENT ,
  `troco` DECIMAL(10,2) NULL ,
  `valorPago` DECIMAL(10,2) NOT NULL ,
  `codPagamento` INT NOT NULL ,
  PRIMARY KEY (`codDinheiro`) ,
  INDEX `codPagamento_idx` (`codPagamento` ASC) ,
  CONSTRAINT `cod_Pagamento`
    FOREIGN KEY (`codPagamento` )
    REFERENCES `tam`.`Pagamento` (`codPagamento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Cartao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Cartao` (
  `codCartao` INT NOT NULL AUTO_INCREMENT ,
  `numeroCartao` VARCHAR(16) NOT NULL ,
  `mesValidade` INT NOT NULL ,
  `anoValidade` INT NOT NULL ,
  `bandeiraCartao` VARCHAR(15) NOT NULL ,
  `agenciaCartao` VARCHAR(4) NOT NULL ,
  `codSeguranca` SMALLINT NOT NULL ,
  `cod_pagamento` INT NOT NULL ,
  PRIMARY KEY (`codCartao`) ,
  INDEX `codPagamento_idx` (`cod_pagamento` ASC) ,
  CONSTRAINT `codPagto`
    FOREIGN KEY (`cod_pagamento` )
    REFERENCES `tam`.`Pagamento` (`codPagamento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Cheque`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Cheque` (
  `codCheque` INT NOT NULL AUTO_INCREMENT ,
  `numeroCheque` VARCHAR(45) NOT NULL ,
  `banco` VARCHAR(45) NOT NULL ,
  `agencia` VARCHAR(5) NOT NULL ,
  `conta` VARCHAR(16) NOT NULL ,
  `cod_Pagamento` INT NOT NULL ,
  PRIMARY KEY (`codCheque`) ,
  INDEX `codPagamento_idx` (`cod_Pagamento` ASC) ,
  CONSTRAINT `cod_Pagto`
    FOREIGN KEY (`cod_Pagamento` )
    REFERENCES `tam`.`Pagamento` (`codPagamento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tam`.`Escalas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tam`.`Escalas` (
  `codEscala` INT NOT NULL AUTO_INCREMENT ,
  `cod_Voo` INT NOT NULL ,
  `cod_Aeroporto` INT NOT NULL ,
  PRIMARY KEY (`codEscala`) ,
  INDEX `cod_Voo_idx` (`cod_Voo` ASC) ,
  INDEX `cod_Aeroporto_idx` (`cod_Aeroporto` ASC) ,
  CONSTRAINT `cod_Voo`
    FOREIGN KEY (`cod_Voo` )
    REFERENCES `tam`.`Voo` (`codVoo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `codAeroporto`
    FOREIGN KEY (`cod_Aeroporto` )
    REFERENCES `tam`.`Aeroporto` (`codAeroporto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (1, 'Aeroporto Internacional de Cruzeiro do Sul', 'Acre', 'Cruzeiro do Sul', 'CZS', 'SBCZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (2, 'Aeroporto Internacional de Rio Branco - Plácido de Castro', 'Acre', 'Rio Branco', 'RBR', 'SBRB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (3, 'Aeroporto de Brasileia', 'Acre', 'Brasileia', NULL, 'SWBS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (4, 'Aeroporto de Feijó', 'Acre', 'Feijó', 'FEJ', 'SWFJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (5, 'Aeroporto de Santa Rosa do Purus', 'Acre', 'Santa Rosa do Purus', NULL, 'SDOE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (6, 'Aeroporto de Sena Madureira', 'Acre', 'Sena Madureira', NULL, 'SBRB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (7, 'Aeroporto de Tarauacá', 'Acre', 'Tarauacá', 'TRQ', 'SBTK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (8, 'Aeroporto de Xapuri', 'Acre', 'Xapuri', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (9, 'Aeroporto Internacional Zumbi dos Palmares', 'Alagoas', 'Maceió', 'MCZ', 'SBMO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (10, 'Aeroporto de Arapiraca', 'Alagoas', 'Arapiraca', 'APQ', 'SNAL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (11, 'Aeroporto de Penedo', 'Alagoas', 'Penedo', NULL, 'SNPE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (12, 'Aeroporto Manduca Leão', 'Alagoas', 'Rio Largo', NULL, 'SNML');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (13, 'Aeroporto Internacional de Macapá', 'Amapá', 'Macapá', 'MCP', 'SBMQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (14, 'Aeroporto de Amapá', 'Amapá', 'Amapá', NULL, 'SBAM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (15, 'Aeroporto de Calçoene', 'Amapá', 'Calçoene', NULL, 'SNCC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (16, 'Aeroporto de Oiapoque', 'Amapá', 'Oiapoque', NULL, 'SBOI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (17, 'Aeroporto de Porto Grande', 'Amapá', 'Porto Grande', NULL, 'SNPG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (18, 'Aeroporto das Flores', 'Amazonas', 'Manaus', NULL, 'SWFN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (19, 'Aeroporto de Apuí', 'Amazonas', 'Apuí', NULL, 'SWYN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (20, 'Aeroporto Palmeiras do Javali', 'Amazonas', 'Atalaia do Norte', NULL, 'SWJV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (21, 'Aeroporto de Barcelos', 'Amazonas', 'Barcelos', 'BAZ', 'SWBC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (22, 'Aeroporto de Barreirinha', 'Amazonas', 'Barreirinha', NULL, 'SWBI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (23, 'Aeroporto Novo Campo', 'Amazonas', 'Boca do Acre', NULL, 'SWNK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (24, 'Aeroporto de Borba', 'Amazonas', 'Borba', NULL, 'SWBR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (25, 'Aeroporto de Coari', 'Amazonas', 'Coari', 'CIZ', 'SWKO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (26, 'Aeroporto de Carauari', 'Amazonas', 'Carauari', 'CAF', 'SWCA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (27, 'Aeroporto de Eirunepé', 'Amazonas', 'Eirunepé', 'ERN', 'SWEI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (28, 'Aeroporto de Fonte Boa', 'Amazonas', 'Fonte Boa', NULL, 'SWOB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (29, 'Aeroporto de Humaitá', 'Amazonas', 'Humaitá', 'HIA', 'SWHT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (30, 'Aeroporto de Itacoatiara', 'Amazonas', 'Itacoatiara', NULL, 'SBIC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (31, 'Aeroporto Bittencourt', 'Amazonas', 'Japurá', NULL, 'SWJP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (32, 'Aeroporto de Lábrea', 'Amazonas', 'Lábrea', 'LBR', 'SWLB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (33, 'Aeroporto de Manicoré', 'Amazonas', 'Manicoré', 'MNX', 'SWMY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (34, 'Aeroporto de Maués', 'Amazonas', 'Maués', 'MBZ', 'SWMW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (35, 'Aeroporto de Moura', 'Amazonas', 'Moura', NULL, 'SWOW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (36, 'Aeroporto de Nova Olinda do Norte', 'Amazonas', 'Nova Olinda do Norte', NULL, 'SWNO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (37, 'Aeroporto de Novo Aripuanã', 'Amazonas', 'Novo Aripuanã', NULL, 'SWNA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (38, 'Aeroporto Julio Belem', 'Amazonas', 'Parintins', 'PIN', 'SWPI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (39, 'Aeroporto de Pauini', 'Amazonas', 'Pauini', NULL, 'SWUI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (40, 'Aeroporto de Porto Urucu', 'Amazonas', 'Coari', NULL, 'SWUY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (41, 'Aeroporto Ipiranga', 'Amazonas', 'Santo Antônio do Içá', 'IPG', 'SWII');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (42, 'Aeroporto de São Gabriel da Cachoeira', 'Amazonas', 'São Gabriel da Cachoeira', 'SJL', 'SBUA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (43, 'Aeroporto de Tefé', 'Amazonas', 'Tefé', 'TFF', 'SBTF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (44, 'Aeroporto de Tapuruquara', 'Amazonas', 'Santa Isabel do Rio Negro', 'IRZ', 'SWTP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (45, 'Aeroporto de Urucará', 'Amazonas', 'Urucará', NULL, 'SWKK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (46, 'Aeroporto Internacional de Tabatinga', 'Amazonas', 'Tabatinga', 'TBT', 'SBTT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (47, 'Aeroporto Internacional Eduardo Gomes', 'Amazonas', 'Manaus', 'MAO', 'SBEG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (48, 'Aeroporto Senadora Eunice Michiles', 'Amazonas', 'São Paulo de Olivença', NULL, 'SDCG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (49, 'Aeroporto de Bom Jesus da Lapa', 'Bahia', 'Bom Jesus da Lapa', 'LAZ', 'SBLP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (50, 'Aeroporto Jorge Amado', 'Bahia', 'Ilhéus', 'IOS', 'SBIL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (51, 'Aeroporto de Paulo Afonso', 'Bahia', 'Paulo Afonso', 'PAV', 'SBUF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (52, 'Aeroporto Coronel Horácio de Matos', 'Bahia', 'Lençóis', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (53, 'Aeroporto Internacional Dep. Luís Eduardo Magalhães', 'Bahia', 'Salvador', 'SSA', 'SBSV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (54, 'Aeroporto Estadual João Durval Carneiro', 'Bahia', 'Feira de Santana', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (55, 'Aeroporto Internacional Pinto Martins', 'Ceará', 'Fortaleza', 'FOR', 'SBFZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (56, 'Aeroporto Regional do Cariri', 'Ceará', 'Juazeiro do Norte', 'JDO', 'SBJU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (57, 'Aeroporto de Aracati', 'Ceará', 'Aracati', NULL, 'SNAT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (58, 'Aeroporto Coronel Virgílio Távora', 'Ceará', 'Boa Viagem', NULL, 'SNMB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (59, 'Aeroporto Pinto Martins', 'Ceará', 'Camocim', 'CMC', 'SNWC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (60, 'Aeroporto de Campos Sales', 'Ceará', 'Campos Sales', NULL, 'SNCS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (61, 'Aeroporto de Crateús', 'Ceará', 'Crateús', NULL, 'SNWS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (62, 'Aeroporto de Iguatu', 'Ceará', 'Iguatu', 'IGT', 'SNIG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (63, 'Aeroporto de Mombaça', 'Ceará', 'Mombaça', NULL, 'SNMB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (64, 'Aeroporto de Morada Nova', 'Ceará', 'Morada Nova', NULL, 'SNMO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (65, 'Aeroporto de Limoeiro do Norte', 'Ceará', 'Limoeiro do Norte', NULL, 'SNLM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (66, 'Aeroporto de Quixadá', 'Ceará', 'Quixadá', NULL, 'SNQX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (67, 'Aeroporto de Sobral', 'Ceará', 'Sobral', 'QBX', 'SNOB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (68, 'Aeroporto de Tamboril', 'Ceará', 'Tamboril', NULL, 'SNTL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (69, 'Aeroporto Internacional Juscelino Kubitschek', 'Distrito Federal', 'Brasília', 'BSB', 'SBBR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (70, 'Aeroporto Eurico de Aguiar Salles', 'Espírito Santo', 'Vitória', 'VIX', 'SBVT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (71, 'Aeroporto de Baixo Guandu/Aimorés', 'Espírito Santo', 'Baixo Guandu', NULL, 'SNBG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (72, 'Aeroporto de Cachoeiro de Itapemirim', 'Espírito Santo', 'Cachoeiro de Itapemirim', 'CDI', 'SNKI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (73, 'Aeroporto de Guarapari', 'Espírito Santo', 'Guarapari', 'GUZ', 'SNGA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (74, 'Aeroporto de Linhares', 'Espírito Santo', 'Linhares', NULL, 'SNLN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (75, 'Aeroporto Tancredo de Almeida Neves', 'Espírito Santo', 'São Mateus', 'SBJ', 'SNMX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (76, 'Aeroporto Santa Genoveva', 'Goiás', 'Goiânia', 'GYN', 'SBGO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (77, 'Aeródromo Nacional de Aviação', 'Goiás', 'Goiânia', NULL, 'SBGO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (78, 'Aeroporto de Anápolis', 'Goiás', 'Anápolis', 'APS', 'SWNS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (79, 'Aeroporto de Buriti Alegre', 'Goiás', 'Buriti Alegre', NULL, 'SWBA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (80, 'Aeroporto de Caldas Novas', 'Goiás', 'Caldas Novas', 'CLV', 'SBCN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (81, 'Aeroporto de Campos Belos', 'Goiás', 'Campos Belos', NULL, 'SWCB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (82, 'Aeroporto de Catalão', 'Goiás', 'Catalão', NULL, 'SWKT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (83, 'Aeroporto de Cavalcante', 'Goiás', 'Cavalcante', NULL, 'SWCW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (84, 'Aeroporto de Ceres', 'Goiás', 'Ceres', NULL, 'SWCZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (85, 'Aeroporto de Formosa', 'Goiás', 'Formosa', NULL, 'SWFR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (86, 'Aeroporto de Iaciara', 'Goiás', 'Iaciara', NULL, 'SWIA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (87, 'Aeroporto de Ipameri', 'Goiás', 'Ipameri', NULL, 'SWIP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (88, 'Aeroporto de Jataí', 'Goiás', 'Jataí', NULL, 'SWJW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (89, 'Aeroporto Brigadeiro Araripe Macedo', 'Goiás', 'Luziânia', NULL, 'SWUZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (90, 'Aeroporto de Minaçu', 'Goiás', 'Minaçu', 'MQH', 'SBMC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (91, 'Aeroporto de Mineiros', 'Goiás', 'Mineiros', NULL, 'SWME');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (92, 'Aeroporto de Monte Alegre de Goiás', 'Goiás', 'Monte Alegre de Goiás', NULL, 'SWML');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (93, 'Aeroporto de Morrinhos', 'Goiás', 'Morrinhos', NULL, 'SWMX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (94, 'Aeroporto de Niquelândia', 'Goiás', 'Niquelândia', 'NQL', 'SWNQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (95, 'Aeroporto de Pires do Rio', 'Goiás', 'Pires do Rio', NULL, 'SWPR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (96, 'Aeroporto de Posse', 'Goiás', 'Posse', NULL, 'SWPZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (97, 'Aeroporto de Rio Verde', 'Goiás', 'Rio Verde', 'RVD', 'SWLC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (98, 'Aeroporto de Santa Helena de Goiás', 'Goiás', 'Santa Helena de Goiás', NULL, 'SWHG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (99, 'Aeroporto de Imperatriz', 'Maranhão', 'Imperatriz', 'IMP', 'SBIZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (100, 'Aeroporto Internacional Marechal Cunha Machado', 'Maranhão', 'São Luís', 'SLZ', 'SBSL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (101, 'Aeroporto de Alcântara', 'Maranhão', 'Alcantara', 'QAH', 'SNCW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (102, 'Aeroporto de Alto Parnaíba', 'Maranhão', 'Alto Parnaíba', 'APY', 'SNAI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (103, 'Aeroporto de Bacabal', 'Maranhão', 'Bacabal', NULL, 'SNBI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (104, 'Aeroporto de Balsas', 'Maranhão', 'Balsas', 'BSS', 'SNBS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (105, 'Aeroporto de Barra do Corda', 'Maranhão', 'Barra do Corda', 'BDC', 'SNBC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (106, 'Aeroporto de Barreirinhas', 'Maranhão', 'Barreirinhas', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (107, 'Aeroporto de Benedito Leite', 'Maranhão', 'Benedito Leite', NULL, 'SNBT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (108, 'Aeroporto de Brejo', 'Maranhão', 'Brejo', NULL, 'SNRJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (109, 'Aeroporto de Carolina', 'Maranhão', 'Carolina', 'CLN', 'SBCI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (110, 'Aeroporto de Carutapera', 'Maranhão', 'Carutapera', 'CTP', 'SNCP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (111, 'Aeroporto de Codó', 'Maranhão', 'Codó', NULL, 'SNXH');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (112, 'Aeroporto de Coelho Neto', 'Maranhão', 'Coelho Neto', NULL, 'SIDB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (113, 'Aeroporto de Colinas', 'Maranhão', 'Colinas', NULL, 'SNKL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (114, 'Aeroporto de Coroatá', 'Maranhão', 'Coroatá', NULL, 'SNOA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (115, 'Aeroporto de Cururupu', 'Maranhão', 'Cururupu', 'CPU', 'SNCU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (116, 'Aeroporto de Grajaú', 'Maranhão', 'Grajaú', NULL, 'SNGJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (117, 'Aeroporto de Guimarães', 'Maranhão', 'Guimarães', NULL, 'SNYW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (118, 'Aeroporto de Pastos Bons', 'Maranhão', 'Pastos Bons', NULL, 'SNPB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (119, 'Aeroporto de Paço do Lumiar', 'Maranhão', 'Paço do Lumiar', NULL, 'SNOZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (120, 'Aeroporto de Pinheiro', 'Maranhão', 'Pinheiro', 'PHI', 'SNYE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (121, 'Aeroporto de Raposa', 'Maranhão', 'Raposa', NULL, 'SIPB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (122, 'Aeroporto de Riachão', 'Maranhão', 'Riachão', NULL, 'SNRX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (123, 'Aeroporto Regional João Silva', 'Maranhão', 'Santa Inês', NULL, 'SJBY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (124, 'Aeroporto de São Bento', 'Maranhão', 'São Bento', NULL, 'SNSB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (125, 'Aeroporto de São Domingos do Maranhão', 'Maranhão', 'São Domingos do Maranhão', NULL, 'SNDG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (126, 'Aeroporto de Timon', 'Maranhão', 'Timon', NULL, 'SNDR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (127, 'Aeroporto de Turiaçu', 'Maranhão', 'Turiaçu', NULL, 'SNTU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (128, 'Aeroporto de Tutóia', 'Maranhão', 'Tutóia', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (129, 'Aeroporto de Urbano Santos', 'Maranhão', 'Urbano Santos', NULL, 'SNUD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (130, 'Aeroporto Internacional Marechal Rondon', 'Mato Grosso', 'Várzea Grande/Cuiabá', 'CGB', 'SBCY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (131, 'Aeroporto de Alta Floresta', 'Mato Grosso', 'Alta Floresta', 'AFL', 'SBAT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (132, 'Aeroporto de Alto Garças', 'Mato Grosso', 'Alto Garças', NULL, 'SWGR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (133, 'Aeroporto de Araguaiana', 'Mato Grosso', 'Araguaiana', NULL, 'SWAY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (134, 'Aeroporto de Aripuanã', 'Mato Grosso', 'Aripuanã', 'AIR', 'SWRP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (135, 'Aeroporto de Barra do Bugres', 'Mato Grosso', 'Barra do Bugres', NULL, 'SWBB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (136, 'Aeroporto de Barra do Garças', 'Mato Grosso', 'Barra do Garças', 'BPG', 'SBBW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (137, 'Aeroporto de Cáceres', 'Mato Grosso', 'Cáceres', 'CCX', 'SWKC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (138, 'Aeroporto de Canarana', 'Mato Grosso', 'Canarana', NULL, 'SWEK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (139, 'Aeroporto de Chapada dos Guimarães', 'Mato Grosso', 'Chapada dos Guimarães', NULL, 'SWPL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (140, 'Aeroporto de Confresa', 'Mato Grosso', 'Confresa', 'CFO', 'SWKF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (141, 'Aeroporto de Diamantino', 'Mato Grosso', 'Diamantino', NULL, 'SWDM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (142, 'Aeroporto de Jaciara', 'Mato Grosso', 'Jaciara', NULL, 'SWJC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (143, 'Aeroporto Inácio Luís do Nascimento', 'Mato Grosso', 'Juara', 'JUA', 'SWJH');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (144, 'Aeroporto de Juína', 'Mato Grosso', 'Juína', 'JIA', 'SWJN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (145, 'Aeroporto de Juruena', 'Mato Grosso', 'Juruena', 'JRN', 'SWJU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (146, 'Aeroporto de Lucas do Rio Verde', 'Mato Grosso', 'Lucas do Rio Verde', NULL, 'SWFE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (147, 'Aeroporto de Luciara', 'Mato Grosso', 'Luciára', NULL, 'SWUC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (148, 'Aeroporto de Matupá', 'Mato Grosso', 'Matupá', 'MBK', NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (149, 'Aeroporto de Nortelândia', 'Mato Grosso', 'Nortelândia', NULL, 'SWNR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (150, 'Aeroporto de Nova Mutum', 'Mato Grosso', 'Nova Mutum', NULL, 'SWNU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (151, 'Aeroporto de Nova Xavantina', 'Mato Grosso', 'Nova Xavantina', NULL, 'SWXN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (152, 'Aeroporto de Poconé', 'Mato Grosso', 'Poconé', NULL, 'SWPK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (153, 'Aeroporto de Porto dos Gaúchos', 'Mato Grosso', 'Porto dos Gaúchos', NULL, 'SWPG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (154, 'Aeroporto de Pontes e Lacerda', 'Mato Grosso', 'Pontes e Lacerda', NULL, 'SWLE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (155, 'Aeroporto de Primavera do Leste', 'Mato Grosso', 'Primavera do Leste', NULL, 'SWPY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (156, 'Aeroporto de Rondonópolis', 'Mato Grosso', 'Rondonópolis', 'ROO', 'SWRD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (157, 'Aeroporto de São Félix do Araguaia', 'Mato Grosso', 'São Félix do Araguaia', 'SXO', 'SWFX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (158, 'Aeroporto de Sinop', 'Mato Grosso', 'Sinop', 'OPS', 'SWSI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (159, 'Aeroporto de Tangará da Serra', 'Mato Grosso', 'Tangará da Serra', NULL, 'SWTS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (160, 'Aeroporto de Vila Bela da Santíssima Trindade', 'Mato Grosso', 'Vila Bela da Santíssima Trindade', NULL, 'SWVB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (161, 'Aeroporto de Vila Rica', 'Mato Grosso', 'Vila Rica', 'VLP', 'SWVC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (162, 'Aeroporto Governador Júlio Campos', 'Mato Grosso', 'Santo Antônio de Leverger', NULL, 'SWJC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (163, 'Aeroporto Umberto Bosaipo', 'Mato Grosso', 'Tesouro', NULL, 'SWRU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (164, 'Aeroporto Internacional de Campo Grande', 'Mato Grosso do Sul', 'Campo Grande', 'CGR', 'SBCG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (165, 'Aeroporto Internacional de Corumbá', 'Mato Grosso do Sul', 'Corumbá', 'CMG', 'SBCR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (166, 'Aeroporto Internacional de Ponta Porã', 'Mato Grosso do Sul', 'Ponta Porã', 'PMG', 'SBPP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (167, 'Aeroporto de Amambai', 'Mato Grosso do Sul', 'Amambai', NULL, 'SSAM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (168, 'Aeroporto de Aquidauana', 'Mato Grosso do Sul', 'Aquidauana', NULL, 'SBGC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (169, 'Aeroporto Ariosto da Riva', 'Mato Grosso do Sul', 'Naviraí', NULL, 'SSNB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (170, 'Aeroporto de Bela Vista', 'Mato Grosso do Sul', 'Bela Vista', NULL, 'SSBV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (171, 'Aeroporto de Bodoquena', 'Mato Grosso do Sul', 'Bodoquena', NULL, 'SSBB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (172, 'Aeroporto de Caracol', 'Mato Grosso do Sul', 'Caracol', NULL, 'SSZK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (173, 'Aeroporto de Cassilândia', 'Mato Grosso do Sul', 'Cassilândia', NULL, 'SSCL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (174, 'Aeroporto de Coxim', 'Mato Grosso do Sul', 'Coxim', NULL, 'SSXM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (175, 'Aeroporto de Iguatemi', 'Mato Grosso do Sul', 'Iguatemi', NULL, 'SSBI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (176, 'Aeroporto de Jardim', 'Mato Grosso do Sul', 'Jardim', NULL, 'SSJI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (177, 'Aeroporto de Maracaju', 'Mato Grosso do Sul', 'Maracaju', NULL, 'SSMJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (178, 'Aeroporto de Nioaque', 'Mato Grosso do Sul', 'Nioaque', NULL, 'SSNQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (179, 'Aeroporto de Nova Andradina', 'Mato Grosso do Sul', 'Nova Andradina *Sigla errada* Necessita de checagem', NULL, 'SSNE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (180, 'Aeroporto de Paranaíba', 'Mato Grosso do Sul', 'Paranaíba', NULL, 'SSPN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (181, 'Aeroporto Plínio Alarcom', 'Mato Grosso do Sul', 'Três Lagoas', NULL, 'SSTL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (182, 'Aeroporto de Porto Murtinho', 'Mato Grosso do Sul', 'Porto Murtinho', NULL, 'SSPM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (183, 'Aeroporto Regional de Dourados', 'Mato Grosso do Sul', 'Dourados', 'DOU', 'SBDO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (184, 'Aeroporto Regional de Bonito', 'Mato Grosso do Sul', 'Bonito', 'BYO', 'SJDB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (185, 'Aeroporto de Rio Brilhante', 'Mato Grosso do Sul', 'Rio Brilhante', NULL, 'SSRB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (186, 'Aeroporto de São Gabriel do Oeste', 'Mato Grosso do Sul', 'São Gabriel do Oeste', NULL, 'SSGO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (187, 'Aeroporto Ten.-Cel. Av. César Bombonato', 'Minas Gerais', 'Uberlândia', 'UDI', 'SBUL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (188, 'Aeroporto Internacional Tancredo Neves', 'Minas Gerais', 'Confins', 'CNF', 'SBCF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (189, 'Aeroporto da Pampulha - Carlos Drummond de Andrade', 'Minas Gerais', 'Belo Horizonte', 'PLU', 'SBBH');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (190, 'Aeroporto Carlos Prates', 'Minas Gerais', 'Belo Horizonte', NULL, 'SBPR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (191, 'Aeroporto de Montes Claros', 'Minas Gerais', 'Montes Claros', 'MOC', 'SBMK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (192, 'Aeroporto Embaixador Walther Moreira Salles', 'Minas Gerais', 'Poços de Caldas', 'POO', 'SBPC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (193, 'Aeroporto Mário de Almeida Franco', 'Minas Gerais', 'Uberaba', 'UBA', 'SBUR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (194, 'Aeroporto de Araxá', 'Minas Gerais', 'Araxá', 'AAX', 'SBAX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (195, 'Aeroporto de Barbacena', 'Minas Gerais', 'Barbacena', 'QAK', 'SBBQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (196, 'Aeroporto de Alfenas', 'Minas Gerais', 'Alfenas', NULL, 'SNFE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (197, 'Aeroporto de Caxambu', 'Minas Gerais', 'Caxambu', NULL, 'SNXB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (198, 'Aeroporto das Bandeirinhas/Conselheiro Lafaiete', 'Minas Gerais', 'Conselheiro Lafaiete', NULL, 'SNKF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (199, 'Aeroporto de Diamantina', 'Minas Gerais', 'Diamantina', 'DTI', 'SNDT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (200, 'Aeroporto de Divinópolis', 'Minas Gerais', 'Divinópolis', 'DIQ', 'SNDV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (201, 'Aeroporto de Espinosa', 'Minas Gerais', 'Espinosa', NULL, 'SBEP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (202, 'Aeroporto Coronel Altino Machado', 'Minas Gerais', 'SBGV', NULL, 'GVR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (203, 'Aeroporto de Ipatinga', 'Minas Gerais', 'Ipatinga', 'IPN', 'SBIP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (204, 'Aeroporto de Ituiutaba', 'Minas Gerais', 'Ituiutaba', NULL, 'SNYB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (205, 'Aeroporto de Jaíba', 'Minas Gerais', 'Jaíba', NULL, 'SNMK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (206, 'Aeroporto de Janaúba', 'Minas Gerais', 'Janaúba', NULL, 'SNAP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (207, 'Aeroporto Francisco Álvares de Assis', 'Minas Gerais', 'Juiz de Fora', 'JDF', 'SBJF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (208, 'Aeroporto de Mato Verde', 'Minas Gerais', 'Mato Verde', NULL, 'SBMV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (209, 'Aeroporto de Mocambinho', 'Minas Gerais', 'Mocambinho (Jaíba)', NULL, 'SBMM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (210, 'Aeroporto de Monte Verde', 'Minas Gerais', 'Camanducaia/Monte Verde', NULL, 'SNEJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (211, 'Aeroporto Cristiano F. Varella', 'Minas Gerais', 'Muriaé', NULL, 'SNBM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (212, 'Aeroporto de Oliveira/Aeroporto Deputado José Aldo dos Santos', 'Minas Gerais', 'Oliveira', NULL, 'SNRZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (213, 'Aeroporto de Pouso Alegre', 'Minas Gerais', 'Pouso Alegre', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (214, 'Aeroporto de Frutal', 'Minas Gerais', 'Frutal', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (215, 'Aeroporto de Patos de Minas', 'Minas Gerais', 'Patos de Minas', 'POJ', 'SNPD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (216, 'Aeroporto Juscelino Kubitschek', 'Minas Gerais', 'Teófilo Otoni', 'TFL', 'SNTO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (217, 'Aeroporto de Varginha', 'Minas Gerais', 'Varginha', 'VAG', 'SBVG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (218, 'Aeroporto de Viçosa', 'Minas Gerais', 'Viçosa', NULL, 'SNVC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (219, 'Aeroporto de São João del-Rei', 'Minas Gerais', 'São João del-Rei', NULL, 'SNJR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (220, 'Aeroporto de São Lourenço', 'Minas Gerais', 'São Lourenço', 'SSO', 'SNLO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (221, 'Aeroporto de São Sebastião do Paraíso', 'Minas Gerais', 'São Sebastião do Paraíso', NULL, 'SNPY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (222, 'Aeroporto de Ubá', 'Minas Gerais', 'Ubá', NULL, 'SNUB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (223, 'Aeroporto Regional da Zona da Mata - Presidente Itamar Franco', 'Minas Gerais', 'Rio Novo / Goianá', 'IZA', 'SBZM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (224, 'Aeroporto de Altamira', 'Pará', 'Altamira', 'ATM', 'SBHT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (225, 'Aeroporto Internacional de Belém/Val de Cans', 'Pará', 'Belém', 'BEL', 'SBBE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (226, 'Aeroporto Júlio Cesar', 'Pará', 'Belém', NULL, 'SBJC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (227, 'Aeroporto de Marabá', 'Pará', 'Marabá', 'MAB', 'SBMA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (228, 'Aeroporto de Carajás', 'Pará', 'Parauapebas', 'CKS', 'SBCJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (229, 'Aeroporto Internacional de Santarém', 'Pará', 'Santarém', 'STM', 'SBSN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (230, 'Aeroporto de Conceição do Araguaia', 'Pará', 'Conceição do Araguaia', 'CDJ', 'SBAA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (231, 'Aeroporto de Itaituba', 'Pará', 'Itaituba', 'ITB', 'SNQW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (232, 'Aeroporto de Monte Dourado', 'Pará', 'Almerim', 'MEU', 'SBMD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (233, 'Aeroporto de Novo Progresso', 'Pará', 'Novo Progresso', 'NPR', 'SJNP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (234, 'Aeroporto de Oriximiná', 'Pará', 'Oriximiná', 'ORX', 'SNOX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (235, 'Aeroporto de Ourilândia do Norte', 'Pará', 'Ourilândia do Norte', 'OIA', 'SDOW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (236, 'Aeroporto de Porto Trombetas', 'Pará', 'Porto Trombetas', 'TMT', 'SBTB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (237, 'Aeroporto de Redenção', 'Pará', 'Redenção', 'RDC', 'SNDC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (238, 'Aeroporto de Santana do Araguaia', 'Pará', 'Santana do Araguaia', 'CMP', 'SNKE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (239, 'Aeroporto de São Félix do Xingu', 'Pará', 'São Félix do Xingu', 'SXX', 'SNFX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (240, 'Aeroporto de Tucuruí', 'Pará', 'Tucuruí', 'TUR', 'SBTU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (241, 'Aeroporto Internacional Presidente Castro Pinto', 'Paraíba', 'Bayeux/João Pessoa', 'JPA', 'SBJP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (242, 'Aeroporto Presidente João Suassuna', 'Paraíba', 'Campina Grande', 'CPV', 'SBKG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (243, 'Aeroporto de Cajazeiras', 'Paraíba', 'Cajazeiras', 'CJZ', 'SBCZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (244, 'Aeroclube de Campina Grande', 'Paraíba', 'Campina Grande', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (245, 'Aeroporto de Catolé do Rocha', 'Paraíba', 'Catolé do Rocha', NULL, 'SIBU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (246, 'Aeroporto de Conceição', 'Paraíba', 'Conceição', NULL, 'SIBW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (247, 'Aeroporto de Itaporanga', 'Paraíba', 'Itaporanga', NULL, 'SIBZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (248, 'Aeroporto de Monteiro', 'Paraíba', 'Monteiro', NULL, 'SIBY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (249, 'Aeroclube da Paraíba', 'Paraíba', 'João Pessoa', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (250, 'Aeroporto de Patos', 'Paraíba', 'Patos', NULL, 'SNTS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (251, 'Aeroporto de Rio Tinto', 'Paraíba', 'Rio Tinto', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (252, 'Aeroporto de Sousa', 'Paraíba', 'Sousa', NULL, 'SNQD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (253, 'Aeroporto de Fagundes', 'Paraíba', 'Fagundes', NULL, 'SFGS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (254, 'Aeroporto Governador José Richa', 'Paraná', 'Londrina', 'LDB', 'SBLO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (255, 'Aeroporto Internacional Afonso Pena', 'Paraná', 'São José dos Pinhais/Curitiba', 'CWB', 'SBCT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (256, 'Aeroporto do Bacacheri', 'Paraná', 'Curitiba', 'BFH', 'SBBI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (257, 'Aeroporto Internacional Cataratas', 'Paraná', 'Foz do Iguaçu', 'IGU', 'SBFI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (258, 'Aeroporto de Andirá', 'Paraná', 'Andirá', NULL, 'SSAN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (259, 'Aeroporto de Apucarana', 'Paraná', 'Apucarana', NULL, 'SSAP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (260, 'Aeroporto de Arapongas', 'Paraná', 'Arapongas', NULL, 'SSOG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (261, 'Aeroporto de Arapoti', 'Paraná', 'Arapoti', NULL, 'SSYA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (262, 'Aeroporto de Bandeirantes', 'Paraná', 'Bandeirantes', NULL, 'SSBR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (263, 'Aeroporto de Campo Mourão', 'Paraná', 'Campo Mourão', 'CBW', 'SSKM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (264, 'Aeroporto de Cascavel', 'Paraná', 'Cascavel', 'CAC', 'SBCA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (265, 'Aeroporto de Castro', 'Paraná', 'Castro', NULL, 'SSQT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (266, 'Aeroporto de Centenário do Sul', 'Paraná', 'Centenário do Sul', NULL, 'SSZS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (267, 'Aeroporto de Cianorte', 'Paraná', 'Cianorte', NULL, 'SSCT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (268, 'Aeroporto de Cornélio Procópio', 'Paraná', 'Cornélio Procópio', NULL, 'SSCP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (269, 'Aeroporto de Goioerê', 'Paraná', 'Goioerê', NULL, 'SSGW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (270, 'Aeroporto de Guaíra', 'Paraná', 'Guaíra', NULL, 'SSGY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (271, 'Aeroporto de Guarapuava', 'Paraná', 'Guarapuava', NULL, 'SBGU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (272, 'Aeroporto de Guaratuba', 'Paraná', 'Guaratuba', NULL, 'SSGB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (273, 'Aeroporto de Ibaiti', 'Paraná', 'Ibaiti', NULL, 'SSAB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (274, 'Aeroporto de Jacarezinho', 'Paraná', 'Jacarezinho', NULL, 'SSJE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (275, 'Aeroporto de Loanda', 'Paraná', 'Loanda', NULL, 'SSLO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (276, 'Aeroporto de Manoel Ribas', 'Paraná', 'Manoel Ribas', NULL, 'SSMY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (277, 'Aeroporto de Marechal Cândido Rondon', 'Paraná', 'Marechal Cândido Rondon', NULL, 'SSCR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (278, 'Aeroporto de Maringá', 'Paraná', 'Maringá', 'MGF', 'SBMG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (279, 'Aeroporto de Medianeira', 'Paraná', 'Medianeira', NULL, 'SSMD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (280, 'Aeroporto de Palmas', 'Paraná', 'Palmas', NULL, 'SSPS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (281, 'Aeroporto de Palotina', 'Paraná', 'Palotina', NULL, 'SSPT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (282, 'Aeroporto de Paranaguá', 'Paraná', 'Paranaguá', NULL, 'SSPG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (283, 'Aeroporto de Paranavaí', 'Paraná', 'Paranavaí', NULL, 'SSPI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (284, 'Aeroporto de Pato Branco', 'Paraná', 'Pato Branco', 'PTO', 'SSPB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (285, 'Aeroporto de Ponta Grossa', 'Paraná', 'Ponta Grossa', 'PGZ', 'SSZW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (286, 'Aeroporto de Porecatu', 'Paraná', 'Porecatu', NULL, 'SSPK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (287, 'Aeroporto de Realeza', 'Paraná', 'Realeza', NULL, 'SSRE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (288, 'Aeroporto de São Miguel do Iguaçu', 'Paraná', 'São Miguel do Iguaçu', NULL, 'SSMY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (289, 'Aeroporto de Sertanópolis', 'Paraná', 'Sertanópolis', NULL, 'SSSZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (290, 'Aeroporto de Siqueira Campos', 'Paraná', 'Siqueira Campos', NULL, 'SSQC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (291, 'Aeroporto de Telêmaco Borba', 'Paraná', 'Telêmaco Borba', NULL, 'SBTL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (292, 'Aeroporto de Toledo', 'Paraná', 'Toledo', NULL, 'SBTD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (293, 'Aeroporto de Umuarama', 'Paraná', 'Umuarama', 'UMU', 'SSUM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (294, 'Aeroporto de União da Vitória', 'Paraná', 'União da Vitória', NULL, 'SSUV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (295, 'Aeroporto Paulo Abdala', 'Paraná', 'Francisco Beltrão', NULL, 'SSFB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (296, 'Aeroporto Regional Silvio Name Junior', 'Paraná', 'Maringá', 'MGF', 'SBMG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (297, 'Aeroporto de Afogados da Ingazeira', 'Pernambuco', 'Afogados da Ingazeira', NULL, 'SNTB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (298, 'Aeroporto de Araripina', 'Pernambuco', 'Araripina', NULL, 'SNAB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (299, 'Aeroporto de Arcoverde', 'Pernambuco', 'Arcoverde', NULL, 'SNAE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (300, 'Aeroporto de Belém de São Francisco', 'Pernambuco', 'Belém de São Francisco', NULL, 'SNFR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (301, 'Aeroporto de Belo Jardim', 'Pernambuco', 'Belo Jardim', NULL, 'SNBJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (302, 'Aeroporto de Caruaru', 'Pernambuco', 'Caruaru', 'CAU', 'SNRU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (303, 'Aeroporto de Fernando de Noronha', 'Pernambuco', 'Fernando de Noronha', 'FEN', 'SBFN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (304, 'Aeroporto de Floresta', 'Pernambuco', 'Floresta', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (305, 'Aeroporto de Garanhuns', 'Pernambuco', 'Garanhuns', NULL, 'SNGN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (306, 'Aeroporto Internacional dos Guararapes Gilberto Freyre', 'Pernambuco', 'Recife', 'REC', 'SBRF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (307, 'Aeroporto de Ouricuri', 'Pernambuco', 'Ouricuri', NULL, 'SNOY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (308, 'Aeroclube de Pernambuco', 'Pernambuco', 'Recife', NULL, 'SNEM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (309, 'Aeroporto de Pesqueira', 'Pernambuco', 'Pesqueira', NULL, 'SNPQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (310, 'Aeroporto de Petrolina', 'Pernambuco', 'Petrolina', 'PNZ', 'SBPL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (311, 'Aeroporto de Salgueiro', 'Pernambuco', 'Salgueiro', NULL, 'SNSG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (312, 'Aeroporto de Santa Maria da Boa Vista', 'Pernambuco', 'Santa Maria de Boa Vista', NULL, 'SNUJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (313, 'Aeroporto de Serra Talhada', 'Pernambuco', 'Serra Talhada', NULL, 'SNHS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (314, 'Aeroporto de Sertânia', 'Pernambuco', 'Sertânia', NULL, 'SNUW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (315, 'Aeroporto Internacional Prefeito Dr.João Silva Filho', 'Piauí', 'Parnaíba', 'PHB', 'SBPB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (316, 'Aeroporto Senador Petrônio Portella', 'Piauí', 'Teresina', 'THE', 'SBTE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (317, 'Aeroporto de Bom Jesus', 'Piauí', 'Bom Jesus', NULL, 'SNGG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (318, 'Aeroporto de Corrente', 'Piauí', 'Corrente', NULL, 'SNKR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (319, 'Aeroporto de Floriano', 'Piauí', 'Floriano', 'FLB', 'SNQG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (320, 'Aeroporto de Gilbués', 'Piauí', 'Gilbués', NULL, 'SNGB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (321, 'Aeroporto de Guadalupe', 'Piauí', 'Guadalupe', NULL, 'SMGD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (322, 'Aeroporto de Oeiras', 'Piauí', 'Oeiras', NULL, 'SNOE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (323, 'Aeroporto de Picos', 'Piauí', 'Picos', 'PCS', 'SNPC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (324, 'Aeroporto de São Raimundo Nonato', 'Piauí', 'São Raimundo Nonato', 'SRN', 'SWKQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (325, 'Aeroporto de Campos dos Goytacazes', 'Rio de Janeiro', 'Campos dos Goytacazes', 'CAW', 'SBCP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (326, 'Aeroporto de Macaé', 'Rio de Janeiro', 'Macaé', 'MEA', 'SBME');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (327, 'Aeroporto Internacional do Rio de Janeiro - Antônio Carlos Jobim', 'Rio de Janeiro', 'Rio de Janeiro', 'GIG', 'SBGL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (328, 'Aeroporto Santos Dumont', 'Rio de Janeiro', 'Rio de Janeiro', 'SDU', 'SBRJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (329, 'Aeroporto de Jacarepaguá', 'Rio de Janeiro', 'Rio de Janeiro', NULL, 'SBJR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (330, 'Aeroporto de Cabo Frio', 'Rio de Janeiro', 'Cabo Frio', 'CFB', 'SBCB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (331, 'Aeroporto das Agulhas Negras', 'Rio de Janeiro', 'Resende', NULL, 'SDRS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (332, 'Aeroporto de Angra dos Reis', 'Rio de Janeiro', 'Angra dos Reis', NULL, 'SDAG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (333, 'Aeroporto de Búzios', 'Rio de Janeiro', 'Armação dos Búzios', 'BZC', 'SBBZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (334, 'Aeroporto de Itaperuna', 'Rio de Janeiro', 'Itaperuna', 'ITP', 'SDUN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (335, 'Aeroporto de Maricá', 'Rio de Janeiro', 'Maricá', NULL, 'SDMC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (336, 'Aeroporto de Nova Iguaçu', 'Rio de Janeiro', 'Nova Iguaçu', 'QNV', 'SDNY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (337, 'Aeroporto de Paraty', 'Rio de Janeiro', 'Paraty', NULL, 'SDTK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (338, 'Aeroporto de Saquarema', 'Rio de Janeiro', 'Saquarema', NULL, 'SDSK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (339, 'Aeroporto de Itaperuna', 'Rio de Janeiro', 'Itaperuna', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (340, 'Aeroporto Internacional Augusto Severo', 'Rio Grande do Norte', 'Parnamirim/Natal', 'NAT', 'SBNT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (341, 'Aeroporto Internacional da Grande Natal', 'Rio Grande do Norte', 'São Gonçalo do Amarante/Natal', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (342, 'Aeroporto de Açu', 'Rio Grande do Norte', 'Assu', NULL, 'SNUC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (343, 'Aeroporto de Caicó', 'Rio Grande do Norte', 'Caicó', NULL, 'SNKK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (344, 'Aeroporto de Currais Novos', 'Rio Grande do Norte', 'Currais Novos', NULL, 'SNKN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (345, 'Aeroporto de Jardim de Angicos', 'Rio Grande do Norte', 'Jardim de Angicos', NULL, 'SNJA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (346, 'Aeroporto de Jardim do Seridó', 'Rio Grande do Norte', 'Jardim do Seridó', NULL, 'SNJS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (347, 'Aeroporto de Pau dos Ferros', 'Rio Grande do Norte', 'Pau dos Ferros', NULL, 'SNPF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (348, 'Aeroporto de Macau', 'Rio Grande do Norte', 'Macau', NULL, 'SNMC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (349, 'Aeroporto Dix-Sept Rosado', 'Rio Grande do Norte', 'Mossoró', 'MVF', 'SBMS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (350, 'Aeroporto Internacional Comandante Gustavo Kraemer', 'Rio Grande do Sul', 'Bagé', 'BGX', 'SBBG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (351, 'Aeroporto Internacional de Pelotas', 'Rio Grande do Sul', 'Pelotas', 'PET', 'SBPK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (352, 'Aeroporto Internacional Salgado Filho', 'Rio Grande do Sul', 'Porto Alegre', 'POA', 'SBPA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (353, 'Aeroporto Internacional Rubem Berta', 'Rio Grande do Sul', 'Uruguaiana', 'URG', 'SBUG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (354, 'Aeroporto Internacional Cei', 'Rio Grande do Sul', 'Campo Bom', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (355, 'Aeroporto Alegrete Novo', 'Rio Grande do Sul', 'Alegrete', 'ALQ', 'SSLT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (356, 'Aeroporto de Arroio Grande', 'Rio Grande do Sul', 'Arroio Grande', NULL, 'SSAE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (357, 'Aeroclube de Bagé', 'Rio Grande do Sul', 'Bagé', 'BGX', 'SSCE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (358, 'Aeroporto de Belém Novo', 'Rio Grande do Sul', 'Porto Alegre', NULL, 'SSBN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (359, 'Aeroporto de Bom Jesus', 'Rio Grande do Sul', 'Bom Jesus', NULL, 'SSBJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (360, 'Aeroporto de Caçapava do Sul', 'Rio Grande do Sul', 'Caçapava do Sul', NULL, 'SSWS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (361, 'Aeroporto de Saicã', 'Rio Grande do Sul', 'Cacequi', NULL, 'SSCQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (362, 'Aeroporto de Cachoeira do Sul', 'Rio Grande do Sul', 'Cachoeira do Sul', 'QDB', 'SSKS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (363, 'Aeroporto de Campo Novo', 'Rio Grande do Sul', 'Campo Novo', NULL, 'SSKN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (364, 'Aeroporto de Canela', 'Rio Grande do Sul', 'Canela', 'QCN', 'SSCN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (365, 'Aeroporto de Canoas', 'Rio Grande do Sul', 'Canoas', NULL, 'SBCO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (366, 'Aeroporto de Capão da Canoa', 'Rio Grande do Sul', 'Capão da Canoa', NULL, 'SSKK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (367, 'Aeroporto de Carazinho', 'Rio Grande do Sul', 'Carazinho', 'QRE', 'SSKZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (368, 'Aeroporto Regional de Caxias do Sul Hugo Cantergiani', 'Rio Grande do Sul', 'Caxias do Sul', 'CXJ', 'SBCX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (369, 'Aeroclube de Cruz Alta', 'Rio Grande do Sul', 'Cruz Alta', NULL, 'SSAK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (370, 'Aeroporto de Encruzilhada do Sul', 'Rio Grande do Sul', 'Encruzilhada do Sul', NULL, 'SSES');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (371, 'Aeroporto de Erechim', 'Rio Grande do Sul', 'Erechim', 'ERM', 'SSER');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (372, 'Aeroporto de Espumoso', 'Rio Grande do Sul', 'Espumoso', NULL, 'SSEZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (373, 'Aeroporto de Estrela', 'Rio Grande do Sul', 'Estrela', NULL, 'SSEE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (374, 'Aeroporto de Frederico Westphalen', 'Rio Grande do Sul', 'Frederico Westphalen', NULL, 'SSWF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (375, 'Aeroporto de Garibaldi', 'Rio Grande do Sul', 'Garibaldi', NULL, 'SSGA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (376, 'Aeroporto de Guaporé', 'Rio Grande do Sul', 'Guaporé', NULL, 'SSGR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (377, 'Aeroporto de Horizontina', 'Rio Grande do Sul', 'Horizontina', NULL, 'SSHZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (378, 'Aeroporto de Ibirubá', 'Rio Grande do Sul', 'Ibirubá', NULL, 'SSIR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (379, 'Aeroporto de Ijuí', 'Rio Grande do Sul', 'Ijuí', NULL, 'SSIJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (380, 'Aeroporto de Itaqui', 'Rio Grande do Sul', 'Itaqui', NULL, 'SSIQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (381, 'Aeroporto de Jaguarão', 'Rio Grande do Sul', 'Jaguarão', NULL, 'SSJR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (382, 'Aeroporto de Júlio de Castilhos', 'Rio Grande do Sul', 'Júlio de Castilhos', NULL, 'SSJK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (383, 'Aeroporto de Montenegro', 'Rio Grande do Sul', 'Montenegro', 'QGF', 'SSNG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (384, 'Aeroporto de Mostardas', 'Rio Grande do Sul', 'Mostardas', NULL, 'SSMT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (385, 'Aeroporto de Nonoai', 'Rio Grande do Sul', 'Nonoai', NULL, 'SSNO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (386, 'Aeroporto de Nova Prata', 'Rio Grande do Sul', 'Nova Prata', NULL, 'SSNP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (387, 'Aeroporto de Novo Hamburgo', 'Rio Grande do Sul', 'Novo Hamburgo', NULL, 'SSNH');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (388, 'Aeroporto de Osório', 'Rio Grande do Sul', 'Osório', NULL, 'SSOS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (389, 'Aeroporto de Palmeira das Missões', 'Rio Grande do Sul', 'Palmeira das Missões', NULL, 'SSPL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (390, 'Aeroclube de Passo Fundo', 'Rio Grande do Sul', 'Passo Fundo', NULL, 'SSAQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (391, 'Aeroporto Lauro Kurtz', 'Rio Grande do Sul', 'Passo Fundo', 'PFB', 'SBPF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (392, 'Aeroporto de Pelotas', 'Rio Grande do Sul', 'Pelotas', NULL, 'SBPK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (393, 'Aeroporto de Rio Grande', 'Rio Grande do Sul', 'Rio Grande', 'RIG', 'SBRG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (394, 'Aeroporto de Rio Pardo', 'Rio Grande do Sul', 'Rio Pardo', NULL, 'SSRY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (395, 'Aeroporto de Rosário do Sul', 'Rio Grande do Sul', 'Rosário do Sul', NULL, 'SSRZ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (396, 'Aeroporto Nova Jacuí', 'Rio Grande do Sul', 'Salto do Jacuí', NULL, 'SSNJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (397, 'Aeroporto de Santa Cruz do Sul', 'Rio Grande do Sul', 'Santa Cruz do Sul', 'CSU', 'SSSC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (398, 'Aeroporto de Santa Maria', 'Rio Grande do Sul', 'Santa Maria', 'RIA', 'SBSM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (399, 'Aeroporto de Santa Rosa', 'Rio Grande do Sul', 'Santa Rosa', 'SRA', 'SSZR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (400, 'Aeroporto de Santa Vitória do Palmar', 'Rio Grande do Sul', 'Santa Vitória do Palmar', NULL, 'SSVP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (401, 'Aeroporto de Santana do Livramento', 'Rio Grande do Sul', 'Santana do Livramento', 'LVB', 'SSDM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (402, 'Aeroporto de Santiago', 'Rio Grande do Sul', 'Santiago', NULL, 'SSST');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (403, 'Aeroporto de Santo Ângelo', 'Rio Grande do Sul', 'Santo Ângelo', 'GEL', 'SBNM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (404, 'Aeroporto de São Borja', 'Rio Grande do Sul', 'São Borja', NULL, 'SSSB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (405, 'Aeroporto de São Gabriel', 'Rio Grande do Sul', 'São Gabriel', NULL, 'SSSG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (406, 'Aeroporto de São Lourenço do Sul', 'Rio Grande do Sul', 'São Lourenço do Sul', NULL, 'SSRU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (407, 'Aeroporto de São Luiz Gonzaga', 'Rio Grande do Sul', 'São Luiz Gonzaga', NULL, 'SSLG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (408, 'Aeroporto de São Sepé', 'Rio Grande do Sul', 'São Sepé', NULL, 'SSEP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (409, 'Aeroporto de Sarandi', 'Rio Grande do Sul', 'Sarandi', NULL, 'SSXD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (410, 'Aeroporto de Sobradinho', 'Rio Grande do Sul', 'Sobradinho', NULL, 'SSBD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (411, 'Aeroporto de Soledade', 'Rio Grande do Sul', 'Soledade', NULL, 'SSSD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (412, 'Aeroporto de Torres', 'Rio Grande do Sul', 'Torres', 'TSQ', 'SBTR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (413, 'Aeroporto de Três Passos', 'Rio Grande do Sul', 'Três Passos', NULL, 'SSTO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (414, 'Aeroporto de Vacaria', 'Rio Grande do Sul', 'Vacaria', NULL, 'SSVC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (415, 'Aeroporto de Venâncio Aires', 'Rio Grande do Sul', 'Venâncio Aires', NULL, 'SSWA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (416, 'Aeroporto de Veranópolis', 'Rio Grande do Sul', 'Veranópolis', NULL, 'SSVN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (417, 'Aeroporto Internacional Governador Jorge Teixeira', 'Rondônia', 'Porto Velho', 'PVH', 'SBPV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (418, 'Aeroporto José Coleto', 'Rondônia', 'Ji-Paraná', 'JPR', 'SWJI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (419, 'Aeroporto Nova Vida', 'Rondônia', 'Ariquemes', NULL, 'SWNI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (420, 'Aeroporto Tabajara', 'Rondônia', 'Ariquemes', NULL, 'SWTB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (421, 'Aeroporto Brigadeiro Camarão', 'Rondônia', 'Vilhena', 'BVH', 'SBVH');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (422, 'Aeroporto de Cacoal', 'Rondônia', 'Cacoal', 'OAL', 'SWKK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (423, 'Aeroporto de Costa Marques', 'Rondônia', 'Costa Marques', NULL, 'SWCQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (424, 'Aeroporto de Guajará-Mirim', 'Rondônia', 'Guajará-Mirim', 'GJM', 'SBGM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (425, 'Aeroporto de Pimenta Bueno', 'Rondônia', 'Pimenta Bueno', NULL, 'SWPM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (426, 'Aeroporto Internacional de Boa Vista - Atlas Brasil', 'Roraima', 'Boa Vista', 'BVB', 'SBBV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (427, 'Aeroporto de Caracaraí', 'Roraima', 'Caracaraí', NULL, 'SBQI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (428, 'Aeroporto Surucucu', 'Roraima', 'Alto Alegre', NULL, 'SWUQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (429, 'Aeroporto Uaicas', 'Roraima', 'Alto Alegre', NULL, 'SWAE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (430, 'Aeroporto Auaris', 'Roraima', 'Amajari', NULL, 'SWBV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (431, 'Aeroporto de Mucajaí', 'Roraima', 'Mucajaí', NULL, 'SWMV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (432, 'Aeroporto de Pacaraima', 'Roraima', 'Pacaraima', NULL, 'SWMU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (433, 'Aeroporto Internacional Hercílio Luz', 'Santa Catarina', 'Florianópolis', 'FLN', 'SBFL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (434, 'Aeroporto Internacional Ministro Victor Konder', 'Santa Catarina', 'Navegantes', 'NVT', 'SBNF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (435, 'Aeroporto Lauro Carneiro de Loyola', 'Santa Catarina', 'Joinville', 'JOI', 'SBJV');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (436, 'Aeroporto de Forquilhinha', 'Santa Catarina', 'Forquilhinha/Criciúma', 'CCM', 'SBCM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (437, 'Aeroporto de Blumenau', 'Santa Catarina', 'Blumenau', 'BNU', 'SSBL');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (438, 'Aeroporto de Caçador', 'Santa Catarina', 'Caçador', NULL, 'SBCD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (439, 'Aeroporto de Chapecó', 'Santa Catarina', 'Chapecó', 'XAP', 'SBCH');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (440, 'Aeroporto de Concórdia', 'Santa Catarina', 'Concórdia', NULL, 'SSCK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (441, 'Aeroporto de Curitibanos', 'Santa Catarina', 'Curitibanos', NULL, 'SSKU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (442, 'Aeroporto de Dionísio Cerqueira', 'Santa Catarina', 'Dionísio Cerqueira', NULL, 'SSDC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (443, 'Aeroporto de Itapiranga', 'Santa Catarina', 'Itapiranga', NULL, 'SSYT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (444, 'Aeroporto de Joaçaba', 'Santa Catarina', 'Joaçaba', NULL, 'SSJA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (445, 'Aeroporto de Lages', 'Santa Catarina', 'Lages', NULL, 'SBLJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (446, 'Aeroporto de Laguna', 'Santa Catarina', 'Laguna', NULL, 'SSLA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (447, 'Aeroporto de Lontras', 'Santa Catarina', 'Lontras', NULL, 'SSLN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (448, 'Aeroporto de Mafra', 'Santa Catarina', 'Mafra', NULL, 'SSMF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (449, 'Aeroporto de São Francisco do Sul', 'Santa Catarina', 'São Francisco do Sul', NULL, 'SSSS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (450, 'Aeroporto de São Joaquim', 'Santa Catarina', 'São Joaquim', NULL, 'SSSQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (451, 'Aeroporto de São Miguel do Oeste', 'Santa Catarina', 'São Miguel do Oeste', NULL, 'SSOE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (452, 'Aeroporto de Três Barras', 'Santa Catarina', 'Três Barras', NULL, 'SSTB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (453, 'Aeroporto de Videira', 'Santa Catarina', 'Videira', NULL, 'SSVI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (454, 'Aeroporto de Xanxerê', 'Santa Catarina', 'Xanxerê', NULL, 'SSXX');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (455, 'Aeródromo de Gavião Peixoto - EMBRAER Ensaios em Voo', 'São Paulo', 'Gavião Peixoto', NULL, 'SBGP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (456, 'Aeroporto Campo de Marte', 'São Paulo', 'São Paulo', 'MAE', 'SBMT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (457, 'Aeroporto de Congonhas/São Paulo', 'São Paulo', 'São Paulo', 'CGH', 'SBSP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (458, 'Aeroporto Internacional de São Paulo-Guarulhos', 'São Paulo', 'Guarulhos / São Paulo', 'GRU', 'SBGR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (459, 'Aeroporto Internacional de Viracopos-Campinas', 'São Paulo', 'Campinas', 'VCP', 'SBKP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (460, 'Aeroporto de São José dos Campos', 'São Paulo', 'São José dos Campos', 'SJK', 'SBSJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (461, 'Aeroporto dos Amarais', 'São Paulo', 'Campinas', 'CPQ', 'SDAM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (462, 'Aeroporto de Andradina', 'São Paulo', 'Andradina', NULL, 'SDDN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (463, 'Aeroporto de Araçatuba', 'São Paulo', 'Araçatuba', 'ARU', 'SBAU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (464, 'Aeroporto de Araraquara', 'São Paulo', 'Araraquara', 'AQA', 'SBAQ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (465, 'Aeroporto de Assis', 'São Paulo', 'Assis', 'AIF', 'SBAS');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (466, 'Aeroporto de Avaré-Arandu', 'São Paulo', 'Avaré / Arandu', 'QVP', 'SDRR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (467, 'Aeroporto de Barretos', 'São Paulo', 'Barretos', 'BAT', 'SBBT');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (468, 'Aeroporto de Bauru', 'São Paulo', 'Bauru', 'BAU', 'SBBU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (469, 'Aeroporto de Bauru-Arealva', 'São Paulo', 'Bauru / Arealva', 'JTC', 'SBAE');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (470, 'Aeroporto de Botucatu', 'São Paulo', 'Botucatu', 'QCP', 'SDBK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (471, 'Aeroporto de Bragança Paulista', 'São Paulo', 'Bragança Paulista', 'BJP', 'SBBP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (472, 'Aeroporto de Dracena', 'São Paulo', 'Dracena', NULL, 'SDDR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (473, 'Aeroporto de Franca', 'São Paulo', 'Franca', 'FRC', 'SIMK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (474, 'Aeroporto de Itanhaém', 'São Paulo', 'Itanhaém', NULL, 'SDIM');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (475, 'Aeroporto de Jundiaí', 'São Paulo', 'Jundiaí', 'QDV', 'SBJD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (476, 'Aeroporto de Lins', 'São Paulo', 'Lins', 'LIP', 'SBLN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (477, 'Aeroporto de Marília', 'São Paulo', 'Marília', 'MII', 'SBML');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (478, 'Aeroporto de Ourinhos', 'São Paulo', 'Ourinhos', 'OUS', 'SDOU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (479, 'Aeroporto de Penápolis', 'São Paulo', 'Penápolis', NULL, 'SDPN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (480, 'Aeroporto de Piracicaba', 'São Paulo', 'Piracicaba', 'QHB', 'SDPW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (481, 'Aeroporto de Presidente Epitácio', 'São Paulo', 'Presidente Epitácio', NULL, 'SDEP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (482, 'Aeroporto de Presidente Prudente', 'São Paulo', 'Presidente Prudente', 'PPB', 'SBDN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (483, 'Aeroporto Leite Lopes', 'São Paulo', 'Ribeirão Preto', 'RAO', 'SBRP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (484, 'Aeroporto de São Carlos', 'São Paulo', 'São Carlos', 'QSC', 'SDSC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (485, 'Aeroporto de São José do Rio Preto', 'São Paulo', 'São José do Rio Preto', 'SJP', 'SBSR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (486, 'Aeroporto de São Manuel', 'São Paulo', 'São Manuel', NULL, 'SDNO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (487, 'Aeroporto de Sorocaba', 'São Paulo', 'Sorocaba', 'SOD', 'SDCO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (488, 'Aeroporto de Tupã', 'São Paulo', 'Tupã', NULL, 'SDTP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (489, 'Aeroporto de Ubatuba', 'São Paulo', 'Ubatuba', 'UBT', 'SDUB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (490, 'Aeroporto de Votuporanga', 'São Paulo', 'Votuporanga', NULL, 'SDVG');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (491, 'Aeroporto de Americana', 'São Paulo', 'Americana', NULL, 'SDAI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (492, 'Aeroporto de Atibaia', 'São Paulo', 'Atibaia', NULL, 'SDTB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (493, 'Aeroporto de Bebedouro', 'São Paulo', 'Bebedouro', NULL, 'SDBB');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (494, 'Aeroporto de Capão Bonito', 'São Paulo', 'Capão Bonito', NULL, 'SDCA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (495, 'Aeroporto de Catanduva', 'São Paulo', 'Catanduva', NULL, 'SDCD');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (496, 'Aeroporto de Guaratinguetá', 'São Paulo', 'Guaratinguetá', 'GUJ', 'SBGW');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (497, 'Aeroporto de Rio Claro', 'São Paulo', 'Rio Claro', NULL, 'SDRK');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (498, 'Aeroporto de Sertãozinho', 'São Paulo', 'Sertãozinho', NULL, NULL);
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (499, 'Aeroporto de Tatuí', 'São Paulo', 'Tatuí / Itapetininga', NULL, 'SDTF');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (500, 'Aeródromo Dr. José Augusto de Arruda Botelho', 'São Paulo', 'Itirapina / São Carlo', NULL, 'SDJA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (501, 'Aeroporto Internacional de Aracaju', 'Sergipe', 'Aracaju', 'AJU', 'SBAR');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (502, 'Aeroporto de Propriá', 'Sergipe', 'Propriá', NULL, 'SNOP');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (503, 'Aeroporto de Palmas', 'Tocantins', 'Palmas', 'PMW', 'SBPJ');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (504, 'Aeroporto de Araguacema', 'Tocantins', 'Araguacema', NULL, 'SJGC');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (505, 'Aeroporto de Araguaína', 'Tocantins', 'Araguaína', 'AUX', 'SWGN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (506, 'Aeroporto de Araguatins', 'Tocantins', 'Araguatins', NULL, 'SJCU');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (507, 'Aeroporto de Arraias', 'Tocantins', 'Arraias', NULL, 'SWRA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (508, 'Aeroporto de Brejinho de Nazaré', 'Tocantins', 'Brejinho de Nazaré', NULL, 'SWBH');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (509, 'Aeroporto de Santa Isabel do Morro', 'Tocantins', 'Cristalândia', NULL, 'SWIY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (510, 'Aeroporto de Dianópolis', 'Tocantins', 'Dianópolis', NULL, 'SWDN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (511, 'Aeroporto de Gurupi', 'Tocantins', 'Gurupi', 'GRP', 'SWGI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (512, 'Aeroporto de Paraíso do Tocantins', 'Tocantins', 'Paraíso do Tocantins', NULL, 'SWTO');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (513, 'Aeroporto de Paranã', 'Tocantins', 'Paranã', NULL, 'SWPN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (514, 'Aeroporto de Pedro Afonso', 'Tocantins', 'Pedro Afonso', NULL, 'SWPA');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (515, 'Aeroporto Dois Irmãos', 'Tocantins', 'Peixe', NULL, 'SWDI');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (516, 'Aeroporto de Porto Nacional', 'Tocantins', 'Porto Nacional', 'PNB', 'SBPN');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (517, 'Aeroporto de Taguatinga', 'Tocantins', 'Taguatinga', NULL, 'SWTY');
INSERT INTO `tam`.`Aeroporto` (`codAeroporto`, `nomeAeroporto`, `estadoAeroporto`, `cidadeAeroporto`, `siglaAeroporto`, `icao`) VALUES (518, 'Aeroporto de Tocantínia', 'Tocantins', 'Tocantínia', NULL, 'SWTC');


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
