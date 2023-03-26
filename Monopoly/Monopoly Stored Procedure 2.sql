CREATE DEFINER=`root`@`localhost` PROCEDURE `GamePlay`(	input_name VARCHAR(45),
    dice_number INT, 
    input_round INT, 
    input_gamestep VARCHAR(20)
    )
proc: Begin 

DECLARE current_player INT;
DECLARE currect_location INT;
DECLARE current_bank INT;
DECLARE current_loc_type VARCHAR(45);
SET current_player = (select player.id from player where player.name = input_name);
SET currect_location = (select lp.location from Location_player lp where current_player=lp.player);
SET current_bank = (select b.bankbalance from BankBalance b where current_player=b.player);
SET current_loc_type =(select l.type from location where current_location = location.id);

IF dice_number+current_location > 16 THEN 
	UPDATE BankBalance SET bankbalance = current_bank + 200 where BankBalance.player = current_player; 
	UPDATE Location_Player SET location = currect_location + dice_number where Location_player.player = current_player;

ELSEIF dice_number = 6 THEN 
	UPDATE Location_Player SET location = currect_location + 6 where Location_player.player = current_player;
	SELECT 'Lycky 6! Roll the DICE ONE MORE TIME';
    Leave proc;
    
ELSEIF dice_number+currect_location = 5 or dice_number+currect_location=13 THEN
	UPDATE Location_Player SET location = 5 where Location_player.player = current_player;
	SELECT 'You are in JAIL.  Roll the DICE ONE MORE TIME, If you get 6, you can leave or not.';
	Leave proc;    

ELSE 
	select current_loc_type from location where currect_location = location.id;

END IF;

END