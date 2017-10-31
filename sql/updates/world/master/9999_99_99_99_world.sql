-- Halls of Origination: Isiset, trash mobs
-- Script names, heroic entry (to-do)
UPDATE `creature_template` SET `ScriptName` = 'boss_isiset', `difficulty_entry_1` = 39586 WHERE `entry` = 39587;
UPDATE `creature_template` SET `ScriptName` = 'npc_celestial_familiar' WHERE `entry` = 39795;
UPDATE `creature_template` SET `ScriptName` = 'npc_astral_shift_explosion_visual' WHERE `entry` = 39787;
UPDATE `creature_template` SET `ScriptName` = 'npc_starry_sky' WHERE `entry` = 39681;
UPDATE `creature_template` SET `ScriptName` = 'npc_astral_rain' WHERE `entry` = 39720;
UPDATE `creature_template` SET `ScriptName` = 'npc_celestial_call' WHERE `entry` = 39721;
UPDATE `creature_template` SET `ScriptName` = 'npc_veil_of_sky' WHERE `entry` = 39722;
UPDATE `creature_template` SET `InhabitType` = 12 WHERE `entry` = 39612;
UPDATE `creature_template` SET `ScriptName` = 'npc_energy_flux' WHERE `entry` = 44015;
UPDATE `creature_template` SET `ScriptName` = 'npc_spatial_anomaly' WHERE `entry` = 40170;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (74133, 74372, 74373, 74137, 76670, 69941, 74264, 74301, 74381, 74382, 74383, 82382);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(74133, 'spell_isiset_veil_of_sky'),
(74372, 'spell_isiset_veil_of_sky'),
(74373, 'spell_isiset_veil_of_sky'),
(74137, 'spell_isiset_supernova_disorient'),
(76670, 'spell_isiset_supernova_damage'),
(69941, 'spell_isiset_mirror_image_starry_sky_spawner'),
(74264, 'spell_isiset_mirror_image_spawner'),
(74301, 'spell_isiset_image_explosion'),
(74381, 'spell_isiset_astral_rain_controller'),
(74382, 'spell_isiset_mana_shield_controller'),
(74383, 'spell_isiset_astral_familiar_controller'),
(82382, 'spell_hoo_energy_flux');

-- Spell condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (82377, 74043);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 82377, 0, 0, 31, 0, 3, 39612, 0, 0, 0, 0, '', 'Energy Flux Spawn Trigger targets NPC_SPATIAL_FLUX'),
(13, 1, 74043, 0, 0, 31, 0, 3, 44015, 0, 0, 0, 0, '', 'Energy Flux Visual targets NPC_ENERGY_FLUX');

-- Text
DELETE FROM `creature_text` WHERE `entry` IN (39587);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(39587, 0, 0, 'Gaze to the heavens! What do you see?', 14, 0, 100, 0, 0, 18843, 0, 0, 'Isiset - aggro'),
(39587, 1, 0, 'Bask in my radiance!', 14, 0, 100, 0, 0, 18845, 0, 0, 'Isiset - cast Supernova'),
(39587, 2, 0, '%s begins to channel a Supernova. Look away!', 41, 0, 100, 0, 0, 0, 0, 0, 'Isiset - cast Supernova'),
(39587, 3, 0, 'Insignificant!', 14, 0, 100, 0, 0, 18846, 0, 0, 'Isiset - player death'),
(39587, 3, 1, 'The glimmer of your life, extinguished.', 14, 0, 100, 0, 0, 18847, 0, 0, 'Isiset - player death'),
(39587, 4, 0, 'Eons of darkness... by your hand.', 14, 0, 100, 0, 0, 18842, 0, 0, 'Isiset - death'),
(39587, 4, 1, 'My luster... wanes.', 14, 0, 100, 0, 0, 18844, 0, 0, 'Isiset - death');

-- Loot
DELETE FROM `reference_loot_template` WHERE `Entry` IN (39587, 39586);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(39587, 55992, 0, 0, 0, 1, 1, 1, 1, NULL),
(39587, 55993, 0, 0, 0, 1, 1, 1, 1, NULL),
(39587, 55994, 0, 0, 0, 1, 1, 1, 1, NULL),
(39587, 55995, 0, 0, 0, 1, 1, 1, 1, NULL),
(39587, 55996, 0, 0, 0, 1, 1, 1, 1, NULL),
(39586, 56412, 0, 0, 0, 1, 1, 1, 1, NULL),
(39586, 56413, 0, 0, 0, 1, 1, 1, 1, NULL),
(39586, 56414, 0, 0, 0, 1, 1, 1, 1, NULL),
(39586, 56415, 0, 0, 0, 1, 1, 1, 1, NULL),
(39586, 56416, 0, 0, 0, 1, 1, 1, 1, NULL);

-- Isiset trash formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (313971,313972);
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`) VALUES
(313971,313971,0,0,3),
(313971,317535,0,0,3),
(313971,313950,0,0,3),
(313971,313951,0,0,3),
(313971,313952,0,0,3),
(313972,313972,0,0,3),
(313972,320781,0,0,3),
(313972,320754,0,0,3),
(313972,313949,0,0,3),
(313972,313953,0,0,3);

-- Spatial Flux SAI
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 39612;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 39612 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(39612, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 12000, 12000, '', 11, 82382, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spatial Flux - In Combat - Cast \'Energy Flux\'');

-- Flux Animator SAI
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 40033;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 40033 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(40033, 0, 0, 0, 0, 0, 100, 0, 0, 0, 7000, 11000, '', 11, 81013, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flux Animator - In Combat - Cast \'Arcane Barrage\'');

-- Star Shard SAI
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 40106;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 40106 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(40106, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 1200, '', 11, 74791, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Star Shard - In Combat - Cast \'Star Shock\'');
