#After updating Gameplay, inserting in the audit trail(It is in every step in Proc.Dice_number_check to make sure all the records are stored after updating values.
DELIMITER /
CREATE TRIGGER AFTER_Gameplay
    AFTER UPDATE ON GamePlay
    FOR EACH ROW BEGIN
	 IF (NEW.step<>old.step) THEN
		 INSERT INTO Audit_trail (step_trail, player_trail, round_trail, location_trail, bankbalance_trail)
			 select new.step, new.player,new.round, lp.location, b.bankbalance
			 from Location_player lp, bankbalance b
			 Where new.player = lp.player 
			 and new.player = b.player;
	END IF;
	END//
DELIMITER ;
#After inserting new data in gameplay, inserting in the audit trail
DELIMITER /
CREATE TRIGGER AFTER_Gameplay_insert
    AFTER INSERT ON GamePlay
    FOR EACH ROW BEGIN
		 INSERT INTO Audit_trail (step_trail, player_trail, round_trail, location_trail, bankbalance_trail)
			 select new.step, new.player,new.round, lp.location, b.bankbalance
			 from Location_player lp, bankbalance b
			 Where new.player = lp.player 
			 and new.player = b.player;
	END//
DELIMITER ;
#bankbalance and player location is not updated beginning, thus if there are any changes, this will be updated. 
DELIMITER /
CREATE TRIGGER AFTER_bankbalance_update
    AFTER UPDATE ON bankbalance
    FOR EACH ROW BEGIN
    IF (old.bankbalance <> new.bankbalance) THEN 
		update Audit_trail set bankbalance_trail=new.bankbalance order by date DESC limit 1;
	END IF;
    END//
DELIMITER ;
DELIMITER /
CREATE TRIGGER AFTER_location_update
    AFTER UPDATE ON Location_player
    FOR EACH ROW BEGIN
    IF (old.location <> new.location) THEN 
		update Audit_trail set location_trail=new.location order by date DESC limit 1;
	END IF;
    END//
DELIMITER ;


drop trigger AFTER_bankbalance_update;
#NEW Player location set=1
DELIMITER /
CREATE TRIGGER AFTER_Player
    AFTER INSERT ON Player
    FOR EACH ROW BEGIN
	 INSERT INTO Location_Player VALUES (NEW.id,1);
	END//
DELIMITER ;

#NEW player added then 200 GBP is the starting bank balance
DELIMITER /
CREATE TRIGGER AFTER_Player_bank
    AFTER INSERT ON Player
    FOR EACH ROW BEGIN
	 INSERT INTO bankbalance(player, bankbalance) VALUES (NEW.id,200);
	END//
DELIMITER ;
drop trigger AFTER_Player_bank;



drop trigger AFTER_Location_player;
#After updating location_player check property or not 
DELIMITER //
CREATE TRIGGER AFTER_Location_player
	AFTER UPDATE ON Location_Player 
    FOR EACH ROW Begin
    
		DECLARE bankbalance_of_player INT;
		DECLARE cost_of_location INT;
        DECLARE location_id INT;
        DECLARE owner_of_location INT;
        DECLARE count_of_color_location INT;
        DECLARE bankbalance_of_owner INT;
        
		SET bankbalance_of_player = (SELECT b.bankbalance from bankbalance b where b.player = NEW.Player);
		SET cost_of_location = (SELECT property.cost from property where property.locid=NEW.location);
        SET owner_of_location = (SELECT po.owner from propertyowned po where po.property = NEW.location);
        SET count_of_color_location 
        = (SELECT COUNT(p.colour) from property as p, (select * from propertyowned where owner = owner_of_location)as pow where pow.property = p.locid);
		SET bankbalance_of_owner = (SELECT b.bankbalance from bankbalance b where b.player = owner_of_location);
                
		 IF (select type from location where id = NEW.location)='Property' THEN 
			call property_owned_proc(NEW.location, NEW.player,bankbalance_of_player,owner_of_location,count_of_color_location,cost_of_location, bankbalance_of_owner);
		ELSE 
			call bonususe(NEW.location, NEW.player, bankbalance_of_player);
		END IF; 
    END//
DELIMITER ;
