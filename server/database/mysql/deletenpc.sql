#
# How to delete an NPC
# 
# 
# use this command to know which NPCs are currently loaded
# select name from players where alive_ind='Y';

SET collation_connection = 'latin1_swedish_ci';

# set here the name of the NPC you want to delete
set @npc_name='Naripel Denoole';
SET @npc_firstname=substring_index(@npc_name, ' ', 1);

# get ID of NPC
select @npc_id:=id from characters where name=@npc_firstname;

# set @npc_id=9674167;

# perform deletion
delete from npc_bad_text where npc=@npc_name;
delete from npc_knowledge_areas where player_id=@npc_id;

# responses and triggers
delete from npc_responses where trigger_id IN (select id from npc_triggers where area=@npc_name);
delete from npc_triggers where area=@npc_name;

delete from item_instances where char_id_owner=@npc_id;
delete from character_skills where character_id=@npc_id;
delete from merchant_item_categories where player_id=@npc_id;
delete from trainer_skills where player_id=@npc_id;

delete from character_factions where character_id=@npc_id;
delete from character_relationships where character_id=@npc_id;
delete from character_traits where character_id=@npc_id;
delete from character_variables where character_id=@npc_id;

delete from characters where id=@player_id;

#delete npcclient entries
delete from sc_npc_definitions WHERE char_id=@npc_id;
delete from sc_npctypes WHERE name=@npc_firstname;

delete from characters where id=@npc_id;
