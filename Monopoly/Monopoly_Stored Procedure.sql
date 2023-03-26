-- Define stored procedure 
DELIMITER /
CREATE PROCEDURE GamePlay
( #Declartion of variables
	input_name VARCHAR(45),
    dice_number INT, 
    input_round INT, 
    input_gamestep INT
    )
BEGIN #SQL 프로그래밍 부분 시작
DECLARE current_loc INT;
SET current_loc=0;

select id as input_id, bankbalance as input_bankbalance from Player where name=input_name; 
select owner input_owner, cost input_cost from Property; 
select Location.id as cur_locid from Location, Player where input_id=player.id and player.location=location.name; 




while current_loc = location.id + dice_number 
if current_loc >17 THEN current_loc = current_loc - 17 
else current_loc = current_loc

IF input.owner = null and input_bankbalance >= input_cost 
		THEN 
        UPDATE Property SET owner = input_id where property.name = input_location

END// 
DELIMITER ;


DELIMITER /
CREATE TRIGGER ownershipcheck
 BEFORE UPDATE on Property
 FOR EACH ROW
	BEGIN
		IF Property.ownwer = null and Player.bankbalance >= Property.cost 
        THEN 
        SET Property.owner = Player.id and Player.bankbalance=Player.bankbalance - Property.cost
        ElSE ;
	END IF;
 END/
DELIMITER ;