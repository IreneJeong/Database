DROP VIEW IF EXISTS gameView;

CREATE VIEW gameView AS 
	SELECT g.round, p.name, p.bankbalance, p.location
    FROM Game AS g, Player AS p
    WHERE p.name IS NOT NULL;
    
    
SELECT * FROM gameView;