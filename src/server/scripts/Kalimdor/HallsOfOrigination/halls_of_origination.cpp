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
    //SPELL_ENERGY_FLUX                 = 82382,
    SPELL_SUMMON_ENERGY_FLUX            = 82385,
    SPELL_ENERGY_FLUX_SPAWN_TRIGGER     = 82377, // Casts SPELL_ENERGY_FLUX_VISUAL on nearby entry (Spatial Flux)
    //SPELL_ENERGY_FLUX_VISUAL          = 74043, // Beam visual
    SPELL_ENERGY_FLUX_PERIODIC          = 74044,
    SPELL_ARCANE_BURST                  = 74888, // On retail not working? Should probably be cast at full energy.
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
            DoCastSelf(SPELL_ENERGY_FLUX_SPAWN_TRIGGER);
            DoCastSelf(SPELL_ENERGY_FLUX_PERIODIC);
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

// 74880 - Arcane Energy
class spell_hoo_arcane_energy_check : public SpellScriptLoader
{
public:
    spell_hoo_arcane_energy_check() : SpellScriptLoader("spell_arcane_energy_check") { }

    class spell_hoo_arcane_energy_check_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hoo_arcane_energy_check_AuraScript);

        void AfterProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
        {
            if (GetTarget()->GetPowerPct(POWER_ENERGY) == 100.0f)
                GetTarget()->CastSpell(GetTarget(), SPELL_ARCANE_BURST, true);
        }

        void Register() override
        {
            AfterEffectProc += AuraEffectProcFn(spell_hoo_arcane_energy_check_AuraScript::AfterProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_hoo_arcane_energy_check_AuraScript();
    }
};

void AddSC_halls_of_origination()
{
    new npc_energy_flux();
    new spell_hoo_energy_flux();
    new spell_hoo_arcane_energy_check();
}
