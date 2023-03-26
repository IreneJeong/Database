DELIMITER /
CREATE PROCEDURE Dice_number_check
(	input_name VARCHAR(45),
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

END//
DELIMITER ;

DELIMITER /
CREATE PROCEDURE PlayOnemoreTime
(	input_name VARCHAR(45),
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

IF current_location = 5 and dice_number = 6 THEN 
	select 'Next Step ';

ELSEIF current_location = 5 and dice_number != 6  THEN 
	SELECT 'Sorry, You still need to be in the JAIL. BYE! ';
    Leave proc;

ELSE 
	select 'Next Step ';
    
END IF;

END//
DELIMITER ;

DELIMITER /

CREATE PROCEDURE GamePlay
(	input_name VARCHAR(45),
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

IF current_location = 5 and dice_number = 6 THEN 
	call Dice_number_check (input_name, 6, input_round, input_gamestep);

ELSEIF current_location = 5 and dice_number != 6  THEN 
	SELECT 'Sorry, You still need to be in the JAIL. BYE! Next turn!';
    Leave proc;

ELSE 
	call Dice_number_check (input_name, 6, input_round, input_gamestep);
    
END IF;

END//
DELIMITER ;

DELIMITER /
CREATE PROCEDURE Playeonemoretest
(	dice_number1 INT
    )
Begin 

SELECT PlayOneMore(dice_number1);

END//
DELIMITER ;


DELIMITER $$
CREATE FUNCTION PlayOneMore(dice_number1 INT) RETURNS BOOLEAN
READS SQL DATA
BEGIN
DECLARE dice_number2 INT;

IF currect_location = 5 and dice_number1 = 6 THEN 
	select 6  into dice_number2;
    return dice_number2;

ELSEIF currect_location = 5 and dice_number1 != 6  THEN 
	RETURN 'Sorry, You still need to be in the JAIL. BYE! ';
    
ELSE 
	select dice_number1 into dice_number2;
    return dice_number2;
    
END IF;

END $$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `PlayOneMorelucky`(dice_number1 INT) RETURNS int
    READS SQL DATA
BEGIN
DECLARE dice_number2 INT;

IF dice_number1 = 6 THEN 
RETURN 'You are out of JAIL!';

ELSE 
RETURN 'Please try again next time';

END IF;

END
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `GameOver`(dice_number1 INT) RETURNS int
    READS SQL DATA
BEGIN
DECLARE dice_number2 INT;

IF dice_number1 = 6 THEN 
RETURN 'You are out of JAIL!';

ELSE 
RETURN 'Please try again next time';

END IF;

END
DELIMITER ;