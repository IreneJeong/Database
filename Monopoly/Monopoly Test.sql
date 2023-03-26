DELIMITER /
CREATE PROCEDURE CurrentLocation(
input_id int
)
BEGIN
select Location.id as cur_locid , Player.location, Player.name
from Location, Player 
where input_id=player.id 
and 
player.location=location.name; 
END//
DELIMITER ;
DROP PROCEDURE test;
call test(1);


