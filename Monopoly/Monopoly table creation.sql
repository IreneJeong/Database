CREATE TABLE Player 
(id INT, name VARCHAR(45), token INT, ownedbonus INT, bankbalance INT,
PRIMARY KEY(id), 
FOREIGN KEY (token) REFERENCES Token(id),
FOREIGN KEY (ownedbonus) REFERENCES Bonus(id)
);
CREATE TABLE Token
(id INT, name VARCHAR(45),
PRIMARY KEY(id)
);
CREATE TABLE Location
(id INT, name VARCHAR(45),
PRIMARY KEY(name)
);
CREATE TABLE Bonus
(id INT, name VARCHAR(45), description VARCHAR(100),
PRIMARY KEY(id)
);
CREATE TABLE Property
(id INT, name VARCHAR(45), cost INT, colour VARCHAR(45), owner INT,
PRIMARY KEY(id),
FOREIGN KEY (owner) REFERENCES Player(id)
);
CREATE TABLE Game
(step INT, player INT, round INT, location VARCHAR(45), bankbalance INT,
PRIMARY KEY(step),
FOREIGN KEY (player) REFERENCES Player(id)
);

CREATE TABLE Location_Player
(id INT, player INT, location INT,
PRIMARY KEY(id));

CREATE TABLE IF NOT EXISTS `BankBalance` (
  `ID` INT NOT NULL,
  `BankBalance` INT NOT NULL,
  `player` INT NOT NULL,
  `gameid` INT NOT NULL,
  `Game_Record_id` INT NOT NULL,
  PRIMARY KEY (`ID`)
  );
    



