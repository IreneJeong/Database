DROP VIEW IF EXISTS gameView;

CREATE VIEW gameView AS 
	SELECT a.round_trail AS round, p.name AS Player, a.bankbalance_trail AS bankbalance, l.name AS Location
    FROM audit_trail AS a, Player AS p, Location_Player AS lp, Location AS l
    WHERE a.round_trail = 1
    AND a.player_trail= p.id
    AND lp.player=p.id
    AND lp.location=l.id; 
        
SELECT * FROM gameView;