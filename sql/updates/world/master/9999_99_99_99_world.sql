-- To-do:
--  - Stormwind 1 spawn (gameobject id 205268?/Portal to the Maelstrom)
SET @CGUID := 999999; -- 8 creatures
SET @OGUID := 999999; -- 1 gameobject

-- Origrammar spawn (MAP: 1, ZONE: 1637, AREA: 5429)
-- Portal to the Maelstrom object (Orgrimmar)
DELETE FROM `gameobject` WHERE `guid` = @OGUID+0;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `PhaseId`, `PhaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@OGUID+0, 205268, 1, 1637, 5429, 1, 0, 0, 2048.063, -4377.163, 98.9305, 0, 0, 0, 0, 1, 120, 255, 1, '', 15595);

DELETE FROM `gameobject_addon` WHERE `guid` = @OGUID+0;
INSERT INTO `gameobject_addon` (`guid`, `parent_rotation0`, `parent_rotation1`, `parent_rotation2`, `parent_rotation3`, `invisibilityType`, `invisibilityValue`, `WorldEffectID`) VALUES
(@OGUID+0, 0, 0, 0, 1, 18, 1000, 0);

-- Maelstrom spawns (MAP: 730, ZONE: 5416)
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+1 AND @CGUID+8;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@CGUID+1, 43718, 730, 5416, 0, 3, 0, 0, 0, 0, 898.788, 784.769, -255.762, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595),
(@CGUID+2, 32520, 730, 5416, 0, 3, 0, 0, 0, 0, 533.118, 844.262, 36.2403, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595),
(@CGUID+3, 45042, 730, 5416, 0, 3, 0, 0, 0, 0, 852.306, 1038.92, -5.3136, 4.88692, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595),
(@CGUID+4, 45005, 730, 5416, 0, 3, 0, 0, 0, 0, 833.59, 1052.81, -7.74965, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595),
(@CGUID+5, 51065, 730, 5416, 0, 3, 0, 0, 0, 0, 801.481, 537.939, 81.3254, 1.20428, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595),
(@CGUID+6, 45006, 730, 5416, 0, 3, 0, 0, 0, 0, 836.573, 1054.9, -8.0286, 0.523599, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595),
(@CGUID+7, 43718, 730, 5416, 0, 3, 0, 0, 0, 0, 896.398, 787.035, 6.13353, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595),
(@CGUID+8, 51060, 730, 5416, 0, 3, 0, 0, 0, 0, 822.448, 653.031, -8.58495, 1.39626, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595);

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+1 AND @CGUID+3;
DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+5 AND @CGUID+8;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(@CGUID+1, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 43718
(@CGUID+2, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 32520
(@CGUID+3, 0, 0, 0, 1, 0, 0, 0, 0, '28892'), -- 45042 - 28892 - 28892
(@CGUID+5, 0, 0, 0, 1, 0, 0, 0, 0, '28892'), -- 51065 - 28892 - 28892
(@CGUID+6, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 45006
(@CGUID+7, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 43718
(@CGUID+8, 0, 0, 0, 1, 0, 0, 0, 0, '28892'); -- 51060 - 28892 - 28892

DELETE FROM `creature_template_addon` WHERE `entry` = 45005;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(45005, 0, 0, 50331648, 1, 0, 0, 0, 0, ''); -- 45005 (it should respawn after spell-click, so it needs template addon)
