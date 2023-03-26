#How to see the result given from the coursework data. 
select p.name as Player, t.name as Token, l.name as Location, p.bankbalance as "Bank Balance(£)", po.property_name
FROM Player p, Token t, Location l, Location_player lp,
	(select l.name as property_name, p.id as owned_pid
	from location l, propertyowned po, property pp, player p
	where p.id = po.player and po.property = pp.id and pp.locid = l.id) as po
where p.token = t.id 
and p.id = lp.player
and l.id = lp.location
and p.id = po.owned_pid;

# stored procedure calling
call Dice_number_check('Norman', 5, 1,'G1');
SELECT PlayOneMore(6);
call Playeonemoretest('Mary',6);
select*from gameplay;
         
UPDATE GamePlay SET round = 2, step = 2 where player=3;


SELECT token = token + ISNULL(tokenid+',','') FROM (select * from (select t.id as tokenid, t.name as tokenname, p.id as player from Token t LEFT join player p on t.id = p.token) as tp where tp.player IS NULL);

select @s='"';
select (select group_concat(concat(tp.tokenname,',', tp.tokenid) separator ';')
	from (select * from(select t.id as tokenid, t.name as tokenname, p.id as player from Token t LEFT join player p on t.id = p.token) as tp0 where tp0.player IS NULL ) as tp) as tokenlist, 
    (select 'Please input the player information first. You need to choose token when you register. -> call NEWplayer_input(input_name, token);') as message;

select p.name, lp.location from player p , Location_player lp where p.id = lp.player;

update location_player set location = 9 where player = 2;
UPDATE Location_Player SET location = 9 + 3 where Location_player.player = 2;

#조건에 부합하는 값만 추가하기 
INSERT INTO Location_Player 
VALUES ((if (Location_Player.location + 3 >16, Location_Player.location+3-16, Location_Player.location + 3)),
(select player.id from player where player.name = 'Jane')
);

select * from (select t.id as tokenid, t.name as tokenname, p.id as player from Token t LEFT join player p on t.id = p.token) as tp where tp.player IS NULL;
select t.id as tokenid, t.name as tokenname, p.id as player from Token t LEFT join player p on t.id = p.token;
'#리스트에 없으면 추가,있으면 업데이트 
insert into propertyowned (player, owner)
values (2,1) 
on duplicate key update ;'

# 리스트에 없는 경우에만 추가 
insert INTO propertyowned (property,owner)
SELECT * FROM (SELECT 2,1) AS tmp
WHERE NOT EXISTS (
    SELECT property FROM propertyowned WHERE property = 2
) LIMIT 1;

# 중복값은 업데이트, 그 외에는 추가 -> 하나의 컬럼에만 적용려면 unique 키 지정해야 함. 이 경우 player 가 unique key 
insert into location_player 
values (4,1) 
on duplicate key update location = 1;

#
insert into game_trail

# owner의 장소 정보 추출 하기 
select player.name, location.name from player, property, propertyowned, location 
where player.id = propertyowned.owner 
and propertyowned.property = property.locid
and property.locid = location.id;

	SELECT a.round_trail AS round, p.name AS Player, a.bankbalance_trail AS bankbalance, l.name AS Location
    FROM audit_trail AS a, Player AS p, Location_Player AS lp, Location AS l
    WHERE a.player_trail= p.id
    AND lp.player=p.id
    AND lp.location=l.id; 

select*from property;
select * from propertyowned where owner = (SELECT po.owner from propertyowned po where po.property = 10);
SELECT po.property from propertyowned po where po.owner=4;

SELECT COUNT(p.colour) from property as p, (select * from propertyowned where owner = (SELECT po.owner from propertyowned po where po.property = 10))as pow 
where pow.property = p.locid;