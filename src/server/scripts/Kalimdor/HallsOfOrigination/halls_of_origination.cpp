/*
 * Copyright (C) 2008-2017 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// To-do:
// - npc_spatial_anomaly: Spatial Anomaly has no energy bar. :-(

#include "ScriptMgr.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "TemporarySummon.h"
#include "halls_of_origination.h"

enum Spells
{
    // Isiset trash
    // 90735 use? 82383 muddy aura
    //SPELL_ENERGY_FLUX = 82382,
    SPELL_SUMMON_ENERGY_FLUX = 82385,
    SPELL_ENERGY_FLUX_SPAWN_TRIGGER = 82377, // Casts SPELL_ENERGY_FLUX_VISUAL on nearby entry (Spatial Flux)
    //SPELL_ENERGY_FLUX_VISUAL = 74043, // Beam visual
    SPELL_ENERGY_FLUX_PERIODIC = 74044,
    SPELL_ARCANE_FORM_DUMMY = 74869, // Visual
    SPELL_ARCANE_ENERGY_PERIODIC = 74880,
    SPELL_ARCANE_ENERGY_ENERGIZE = 74881,
    SPELL_ARCANE_BURST = 74888, // On retail not working? Should probably be cast at full energy.
};

enum Events
{
    // Isiset trash
    EVENT_ENERGY_FLUX,
};

// 44015 - Energy flux
class npc_energy_flux : public CreatureScript
{
public:
    npc_energy_flux() : CreatureScript("npc_energy_flux") { }

    struct npc_energy_fluxAI : public ScriptedAI
    {
        npc_energy_fluxAI(Creature* creature) : ScriptedAI(creature)
        {
            DoCast(me, SPELL_ENERGY_FLUX_SPAWN_TRIGGER);
            DoCast(me, SPELL_ENERGY_FLUX_PERIODIC);
            me->DespawnOrUnsummon(6400);
        }

        void IsSummonedBy(Unit* summoner) override
        {
            me->GetMotionMaster()->MoveFollow(summoner, 0.1f, 0.0f);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHallsOfOriginationAI<npc_energy_fluxAI>(creature);
    }
};

// 40170 - Spatial Anomaly
class npc_spatial_anomaly : public CreatureScript
{
public: npc_spatial_anomaly() : CreatureScript("npc_spatial_anomaly") { }

        struct npc_spatial_anomalyAI : public ScriptedAI
        {
            npc_spatial_anomalyAI(Creature* creature) : ScriptedAI(creature)
            {
                DoCast(me, SPELL_ZERO_ENERGY_NO_REGEN_AURA);
                DoCast(me, SPELL_ARCANE_FORM_DUMMY);
                DoCast(me, SPELL_ARCANE_ENERGY_PERIODIC);
            }

            void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
            {
                if (spell->Id == SPELL_ARCANE_ENERGY_ENERGIZE && me->GetPowerPct(POWER_ENERGY) == 100.0f)
                    DoCast(me, SPELL_ARCANE_BURST);
            }
        };        

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetHallsOfOriginationAI<npc_spatial_anomalyAI>(creature);
        }
};

// 82382 - Energy Flux
class spell_hoo_energy_flux : public SpellScriptLoader
{
public:
    spell_hoo_energy_flux() : SpellScriptLoader("spell_hoo_energy_flux") { }

    class spell_hoo_energy_flux_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hoo_energy_flux_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            if (targets.empty())
                return;
            
            WorldObject* target = Trinity::Containers::SelectRandomContainerElement(targets);
            targets.clear();
            targets.push_back(target);
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hoo_energy_flux_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_hoo_energy_flux_SpellScript();
    }
};

void AddSC_halls_of_origination()
{
    //new npc_spatial_flux();
    new npc_energy_flux();
    new npc_spatial_anomaly();
    new spell_hoo_energy_flux();
}
