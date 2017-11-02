-- Halls of Origination: Isiset, trash mobs
-- Script names, heroic entry (to-do)
UPDATE `creature_template` SET `ScriptName` = 'boss_isiset', `difficulty_entry_1` = 39586 WHERE `entry` = 39587;
UPDATE `creature_template` SET `ScriptName` = 'npc_celestial_familiar' WHERE `entry` = 39795;
UPDATE `creature_template` SET `ScriptName` = 'npc_astral_shift_explosion_visual' WHERE `entry` = 39787;
UPDATE `creature_template` SET `ScriptName` = 'npc_starry_sky' WHERE `entry` = 39681;
UPDATE `creature_template` SET `ScriptName` = 'npc_astral_rain' WHERE `entry` = 39720;
UPDATE `creature_template` SET `ScriptName` = 'npc_celestial_call' WHERE `entry` = 39721;
UPDATE `creature_template` SET `ScriptName` = 'npc_veil_of_sky' WHERE `entry` = 39722;
UPDATE `creature_template` SET `ScriptName` = 'npc_energy_flux' WHERE `entry` = 44015;

-- Brann Bronzebeard: Set menu id that is required to start the roleplay
UPDATE `creature_template` SET `gossip_menu_id` = 11339 WHERE `entry` = 39908;

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_isiset_veil_of_sky', 'spell_isiset_supernova_filter', 'spell_isiset_mirror_image_starry_sky_spawner', 'spell_isiset_mirror_image_spawner', 'spell_isiset_image_explosion', 'spell_isiset_astral_rain_controller', 'spell_isiset_mana_shield_controller', 'spell_isiset_astral_familiar_controller', 'spell_hoo_energy_flux', 'spell_hoo_arcane_energy_check');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(74133, 'spell_isiset_veil_of_sky'),
(74372, 'spell_isiset_veil_of_sky'),
(74373, 'spell_isiset_veil_of_sky'),
(74137, 'spell_isiset_supernova_filter'),
(76670, 'spell_isiset_supernova_filter'),
(69941, 'spell_isiset_mirror_image_starry_sky_spawner'),
(74264, 'spell_isiset_mirror_image_spawner'),
(74301, 'spell_isiset_image_explosion'),
(74381, 'spell_isiset_astral_rain_controller'),
(74382, 'spell_isiset_mana_shield_controller'),
(74383, 'spell_isiset_astral_familiar_controller'),
(82382, 'spell_hoo_energy_flux'),
(74880, 'spell_hoo_arcane_energy_check');

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

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (313971,313972,322519,322053,322210,320942,317604,317458);
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`) VALUES
-- Isiset trash right-side formation
(313971,313971,0,0,3),
(313971,317535,0,0,3),
(313971,313950,0,0,3),
(313971,313951,0,0,3),
(313971,313952,0,0,3),
-- Isiset trash left-side formation
(313972,313972,0,0,3),
(313972,320781,0,0,3),
(313972,320754,0,0,3),
(313972,313949,0,0,3),
(313972,313953,0,0,3),
-- First group, on the beginning
(322519,322519,0,0,3),
(322519,322579,0,0,3),
(322519,322520,0,0,3),
(322519,322578,0,0,3),
-- Second right-side group
(322053,322053,0,0,3),
(322053,322465,7,140,515),
(322053,322211,7,220,515),
(322053,322466,7,180,515),
-- Second left-side group
(322210,322210,0,0,3),
(322210,321936,7,140,515),
(322210,321868,7,220,515),
(322210,321867,7,180,515),
-- Third group (1 spawn missing in db)
(320942,320942,0,0,3),
(320942,321479,0,0,3),
-- Group before elevator
(317604,317604,0,0,3),
(317604,317603,0,0,3),
(317604,317601,0,0,3),
(317604,317570,0,0,3),
-- Group west from elevator
(317458,317458,0,0,3),
(317458,320150,8,150,515),
(317458,317381,8,210,515),
(317458,317382,8,270,515);


-- Spatial Flux SAI (root + disable gravity)
UPDATE `creature_template` SET `AIName` = "SmartAI", `InhabitType` = 12 WHERE `entry` = 39612;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 39612 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(39612, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 12000, 12000, '', 11, 82382, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spatial Flux - In Combat - Cast \'Energy Flux\'');

-- Spatial Anomaly SAI (cannot critically hit)
UPDATE `creature_template` SET `AIName` = "SmartAI", `flags_extra` = `flags_extra` | 131072 WHERE `entry` = 40170;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 40170 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(40170, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, '', 11, 72242, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spatial Anomaly - On Aggro - Cast \'Arcane Barrage\' on self'),
(40170, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, '', 11, 74869, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spatial Anomaly - Linked - Cast \'Arcane Form Dummy\' on self'),
(40170, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, '', 11, 74880, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spatial Anomaly - Linked - Cast \'Arcane Energy Periodic\' on self');

-- Flux Animator SAI
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 40033;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 40033 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(40033, 0, 0, 0, 0, 0, 100, 0, 0, 0, 7000, 11000, '', 11, 81013, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flux Animator - In Combat - Cast \'Arcane Barrage\'');

-- Star Shard SAI
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 40106;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 40106 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(40106, 0, 0, 0, 0, 0, 100, 0, 0, 0, 1200, 1200, '', 11, 74791, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Star Shard - In Combat - Cast \'Star Shock\'');

-- Temple Fireshaper SAI
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 48143;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (48143,-322519) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48143, 0, 0, 0, 0, 0, 100, 0, 0, 0, 500, 500, '', 11, 89538, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Temple Fireshaper - In Combat - Cast \'Fireball\''),
(48143, 0, 1, 0, 0, 0, 100, 0, 12000, 12000, 22000, 26000, '', 11, 84032, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Temple Fireshaper - In Combat - Cast \'Meteor\''),
(48143, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 30000, 30000, '', 11, 89542, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Temple Fireshaper - In Combat - Cast \'Molten Barrier\''),
(-322519, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, '', 11, 89547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Temple Fireshaper - On Aggro - Cast \'Blazing Eruption\''),
(-322519, 0, 1, 0, 0, 0, 100, 0, 0, 0, 500, 500, '', 11, 89538, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Temple Fireshaper - In Combat - Cast \'Fireball\''),
(-322519, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 22000, 26000, '', 11, 84032, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Temple Fireshaper - In Combat - Cast \'Meteor\''),
(-322519, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 30000, 30000, '', 11, 89542, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Temple Fireshaper - In Combat - Cast \'Molten Barrier\'');

-- Temple Swiftstalker SAI
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 48139;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 48139 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48139, 0, 0, 0, 0, 0, 100, 0, 0, 0, 1500, 1500, '', 11, 83877, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Temple Swiftstalker - In Combat - Cast \'Shoot\''),
(48139, 0, 1, 0, 0, 0, 100, 0, 12000, 12000, 22000, 26000, '', 11, 84836, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Temple Swiftstalker - In Combat - Cast \'Multi-Shot\''),
(48139, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 24000, 27000, '', 11, 89571, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Temple Swiftstalker - In Combat - Cast \'Charged Shot\'');

-- Temple Shadowlancer SAI
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 48141;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 48141 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48141, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 18000, 22000, '', 11, 89555, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Temple Shadowlancer - In Combat - Cast \'Shadowlance\''),
(48141, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 21000, 25000, '', 11, 89560, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Temple Shadowlancer - In Combat - Cast \'Pact of Darkness\'');

-- Temple Runecaster SAI
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 48140;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 48140 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48140, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 10000, 10000, '', 11, 89554, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Temple Runecaster - In Combat - Cast \'Runic Cleave\''),
(48140, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 32000, 36000, '', 11, 89551, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Temple Runecaster - In Combat - Cast \'Curse of the Runecaster\''),
(48140, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 33000, 35000, '', 11, 89549, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Temple Runecaster - In Combat - Cast \'Rune of Healing\'');

-- Rune of Healing SAI (root + disable gravity)
UPDATE `creature_template` SET `AIName` = "SmartAI", `InhabitType` = 12, `unit_flags` = 34080832 WHERE `entry` = 39258;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 39258 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(39258, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, '', 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rune of Healing - On Reset - Set react state to passive'),
(39258, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, '', 11, 89549, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rune of Healing - On Reset - Cast \'Rune of Healing\' on self');
