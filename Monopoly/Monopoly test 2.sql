DELIMITER /
CREATE PROCEDURE GamePlay
( #Declartion of variables
	input_name VARCHAR(45),
    dice_number INT, 
    input_round INT, 
    input_gamestep VARCHAR(20)
    )
Begin 
declare player_id int;
set player_id = (select player.id from player where player.name = input_name);

#Current Location update 
UPDATE Location_Player 
SET 
location = if (Location_Player.location + dice_number >16, Location_Player.location+dice_number-16, Location_Player.location + dice_number) ,
player = (select player.id from player where player.name = input_name)
where Location_Player.player = (select player.id from player where player.name = input_name);

#Property owned list insert 

INSERT INTO PropertyOwned
SELECT Location_property.location, (if (owner = null, player_id, 'pay 해야됨' ))) ##만약 owner 있으면 balance minus -> owner 는 plus
FROM DUAL 
	WHERE NOT EXISTS (select property FROM PropertyOwned WHERE property = Location_property.location);
);

End//
DELIMITER ;

/** #bankbalance update
UPDATE bankbalance 
SET bankbalance = CASE
				  when Location_Player.location = 1 
                  THEN bankbalance +200
                  when Location_Player.location = 2 
                  THEN if (propertyOwned.property = Location_Player.location, bankbalance-,if(bankbalance>property.cost,bankbalance-property.cost,bankbalance))
				  end;
**/
/**#Game_Record Insert 

**/

/** Current Location update 

데이터 없으면 insert, 있으면 업데이트 - 여기서는 플레이어 테이블에서 참조하는 키 때문에 구현이 안되네? 
INSERT INTO Location_Player(location, player) 
Values 
(location = if (Location_Player.location + dice_number >16, Location_Player.location+dice_number-16, Location_Player.location + dice_number) ,
player = player_id)
ON DUPLICATE KEY UPDATE location = if (Location_Player.location + dice_number >16, Location_Player.location+dice_number-16, Location_Player.location + dice_number) ;
**/


CREATE TRIGGER AFTER_Gameplay
    AFTER UPDATE ON GamePlay
    FOR EACH ROW 
	 INSERT INTO Audit_trail (step_trail, player_trail, round_trail, location_trail, bankbalance_trail, game_id)
		 select new.step, new.player, new.round, lp.location, b.bankbalance, new.id
		 from Location_player lp, bankbalance b
         Where new.player = lp.player 
         and new.player = b.player;
         

update Gameplay set step = 'G5' where player =3;
select * from audit_trail;
DROP TRIGGER AFTER_Gameplay;


DELIMITER /
CREATE TRIGGER PropertyOwned
	BEFORE UPDATE ON BankBalance 
    FOR EACH ROW
		Begin
        IF (select propertyowned.location from propertyowned where propertyowned.owner = (select player.id from player where player.name=input_name)=null)
			THEN if (select bankbalance from bankbalance where bankbalance.player=(select player.id from player where player.name=input_name)>
					(select property.cost from property where property.locid=current_location))
					THEN update propertyowned set propertyowned.owner = current_player where propertywoned.location=current_location;
                else
					select ('Game over, you are out of the game');
					DELETE FROM Player WHERE Player.id = current_player;
				END IF;
        ELSE
			IF  (select bankbalance from bankbalance where bankbalance.player=(select player.id from player where player.name=input_name)>
				(select property.cost from property where property.locid=current_location)) 
				THEN if (select count property.colour from property, propertyowned where property.locid = propertyowned.location)>2 THEN 
							update bankbalance set bankbalnce = property.cost*2 + bankbalance 
							where bankbalance.player = (select propertyowned.owner from propertyowned where propertyowned.location = current_location);
							update bankbalance set bankbalnce = bankabalance - property.cost*2 
							where bankbalance.player = current_player;
					ELSE 
							update bankbalance set bankbalnce = property.cost + bankbalance 
							where bankbalance.player = (select propertyowned.owner from propertyowned where propertyowned.location = current_location);
							update bankbalance set bankbalnce = bankabalance - property.cost
							where bankbalance.player = current_player;
					END IF;
			ELSE
				select ('Game over, you are out of the game');
				DELETE FROM Player WHERE Player.id = current_player;
			END IF;
        END IF;
End/
DELIMITER ;


