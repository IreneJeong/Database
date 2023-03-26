#Fixed Values for GAME RULES
INSERT INTO Location ()
VALUES (1, 'GO', 'Bonus'),
(2, 'Kilburn', 'Property'),
(3, 'CHANCE1', 'Bonus'),
(4, 'Uni Place', 'Property'),
(5, 'Jail', 'Bonus'),
(6, 'Victoria', 'Property'),
(7, 'COMMUNITY CHEST1', 'Bonus'),
(8, 'Piccadilly', 'Property'),
(9, 'FREE PARKING', 'Bonus'),
(10, 'Oak House', 'Property'),
(11, 'CHANCE2', 'Bonus'),
(12, 'Owens Park', 'Property'),
(13, 'GO TO JAIL', 'Bonus'),
(14, 'AMBS', 'Property'),
(15, 'COMMUNITY CHEST2', 'Bonus'),
(16, 'Co-Op', 'Property');

INSERT INTO Token()
VALUES (1, 'dog'),
(2, 'car'),
(3,'battleship'),
(4,'top hat'),
(5, 'thimble'),
(6,'boot');

INSERT INTO Property ()
VALUES 
(10, 100, 'Orange'), 
(12, 30,'Orange'), 
(14, 400, 'Blue'), 
(16, 30, 'Blue'),
(2, 120, 'Yellow'),  
(4, 100, 'Yellow'), 
(6, 75, 'Green'),
(8, 35, 'Green');

INSERT INTO Bonus ()
VALUES 
(3, 'Pay each of the other players £50'),
(11, 'Move forward 3 spaces'),
(7, 'For winning a Beauty Contest, you win £100'),
(15, 'Your library books are overdue. Play a find of £30'),
(9, 'No action'),
(13,  'Go to Jail, do not pass GO, do not collect £200'),
(1, 'Collect £200');


######################
DELETE FROM Audit_trail;
DELETE FROM GamePlay;

DELETE FROM Player;
INSERT INTO Player ()
VALUES 
(1, 'Mary',3),
(2, 'Bill',1),
(3, 'Jane',2),
(4, 'Norman',5);

DELETE FROM PropertyOwned;
INSERT INTO PropertyOwned ()
VALUES 
(4,1), 
(6,2), 
(16,3), 
(10,4),
(12,4);

#Because of NEWPlayer Procedure and trigger, the data will be automatically set up as the default value. 
#To update the data as per the provided information, I have used "update" instead of "insert"
Update BankBalance SET bankbalance=5000; 

update Location_Player set location =9 where player=1;
update Location_Player set location =12 where player=2;
update Location_Player set location =14 where player=3;
update Location_Player set location =2 where player=4;

update BankBalance set bankbalance =190 where player=1;
update BankBalance set bankbalance =500 where player=2;
update BankBalance set bankbalance =150 where player=3;
update BankBalance set bankbalance =250 where player=4;

