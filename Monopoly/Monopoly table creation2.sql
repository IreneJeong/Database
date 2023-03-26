CREATE TABLE IF NOT EXISTS Player 
(id INT, name VARCHAR(45), token INT, 
PRIMARY KEY(id), 
FOREIGN KEY (token) REFERENCES Token(id) 
);

CREATE TABLE IF NOT EXISTS Token
(id INT, name VARCHAR(45),
PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS BankBalance (
player INT NOT NULL, bankbalance INT NOT NULL,
PRIMARY KEY (player),
FOREIGN KEY (player) REFERENCES Player(id),
UNIQUE KEY(player)
);

#Bridge tables - Composite key is a Primary key. 
CREATE TABLE IF NOT EXISTS Location_Player
(player INT, location INT,
PRIMARY KEY(player, location),
FOREIGN KEY (location) REFERENCES location(locid),
FOREIGN KEY (player) REFERENCES player(id),
UNIQUE KEY(player)
);

CREATE TABLE IF NOT EXISTS Location
(id INT, name VARCHAR(45), type VARCHAR(45),
PRIMARY KEY(name)
);
CREATE TABLE IF NOT EXISTS Bonus
(locid INT, description VARCHAR(100),
PRIMARY KEY(locid),
FOREIGN KEY (locid) REFERENCES Location(id)
);
CREATE TABLE IF NOT EXISTS Property
(locid INT, cost INT, colour VARCHAR(45),
PRIMARY KEY(locid),
FOREIGN KEY (locid) REFERENCES Location(id)
);

#Bridge Table : Composite key is Primary key 
CREATE TABLE IF NOT EXISTS Bonususe
(bonus INT, player INT,
PRIMARY KEY(bonus,user),
FOREIGN KEY (bonus) REFERENCES Bonus(locid),
FOREIGN KEY (player) REFERENCES Player(id), 
UNIQUE INDEX (player)
);

#Bridge Table : Composite key is Primary key   
CREATE TABLE IF NOT EXISTS propertyowend
(property INT, owner INT,
PRIMARY KEY(property,owner),
FOREIGN KEY (property) REFERENCES Bonus(locid),
FOREIGN KEY (owner) REFERENCES Player(id), 
UNIQUE INDEX (property)
);

CREATE TABLE IF NOT EXISTS GamePlay
(step VARCHAR(20), round INT, player INT, TimesStamp DATETIME DEFAULT(CURRENT_TIMESTAMP),
PRIMARY KEY(step), 
FOREIGN KEY (player) REFERENCES Player(id),
UNIQUE INDEX(step)
); 

CREATE TABLE IF NOT EXISTS Audit_trail
(id INT AUTO_INCREMENT, step_trail VARCHAR(20), player_trail INT, round_trail INT, 
location_trail VARCHAR(45), bankbalance_trail INT, date DATETIME DEFAULT(CURRENT_TIMESTAMP),
PRIMARY KEY(id),
FOREIGN KEY (date) REFERENCES GamePlay(TimesStamp),
FOREIGN KEY (step_trail) REFERENCES GamePlay(step),
FOREIGN KEY (round_trail) REFERENCES GamePlay(round),
UNIQUE KEY(id)
);


    



