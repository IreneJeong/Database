INSERT INTO Property (id, name, cost, colour, owner)
VALUES 
(10, 'Oak House', 100, 'Orange',4), 
(12, 'Owens Park', 30, 'Orange',4), 
(14, 'AMBS', 400, 'Blue'), 
(16, 'Co-Op', 30, 'Blue',3),
(2, 'Kilburn', 120, 'Yellow'),  
(4, 'Uni Place', 100, 'Yellow',1), 
(6,'Victoria', 75, 'Green',2),
(8,'Piccadilly', 35, 'Green');

INSERT INTO Bonus (id, name, description)
VALUES 
(3, 'Chance1', 'Pay each of the other players £50'),
(11, 'Chance2', 'Move forward 3 spaces'),
(7, 'Community chest1', 'For winning a Beauty Contest, you win £100'),
(15, 'Community chest2', 'Your library books are overdue. Play a find of £30'),
(9, 'Free Parking', 'No action'),
(13, 'Go to jail', 'Go to Jail, do not pass GO, do not collect £200'),
(1, 'Go', 'Collect £200');

INSERT INTO Player (id, name, token, location, bankbalance)
VALUES (1, 'Mary',3, 'Free Parking',190),
(2, 'Bill',1, 'Owens Park',500),
(3, 'Jane',2, 'AMBS',150),
(4, 'Norman',5, 'Kilburn',250);

