import {
  defineEnterSystem,
  defineSystem,
  getComponentValue,
  getComponentValueStrict,
  Has,
  removeComponent,
  runQuery,
  setComponent,
  UpdateType,
} from "@latticexyz/recs";
import { calculateCombatResult, getModiferAtPosition } from "../../../../Headless/utils";
import { PhaserLayer } from "../../types";
import { decodeMatchEntity } from "../../../../../decodeMatchEntity";
import { encodeMatchEntity } from "../../../../../encodeMatchEntity";

export function createCalculateCombatResultSystem(layer: PhaserLayer) {
  const {
    world,
    parentLayers: {
      network: networkLayer,
      network: {
        components: { Combat, ArmorModifier, Position, CombatOutcome },
        utils: { isOwnedByCurrentPlayer },
      },
      headless: {
        components: { NextPosition },
      },
      local: {
        components: { IncomingDamage },
      },
    },
    components: { WillBeDestroyed, TerrainArmorBonus },
  } = layer;

  defineEnterSystem(world, [Has(CombatOutcome)], ({ entity }) => {
    const {
      attacker: _a,
      defender: _d,
      attackerDamageReceived,
      defenderDamageReceived,
    } = getComponentValueStrict(CombatOutcome, entity);

    const { matchEntity } = decodeMatchEntity(entity);
    const attacker = encodeMatchEntity(matchEntity, _a);
    const defender = encodeMatchEntity(matchEntity, _d);

    if (isOwnedByCurrentPlayer(attacker)) return;

    const attackerIncomingDamage = getComponentValue(IncomingDamage, attacker);
    if (!attackerIncomingDamage) return;
    attackerIncomingDamage.sources.push(defender);
    attackerIncomingDamage.values.push(attackerDamageReceived);
    attackerIncomingDamage.commitments.push(1);
    setComponent(IncomingDamage, attacker, attackerIncomingDamage);

    const defenderIncomingDamage = getComponentValue(IncomingDamage, defender);
    if (!defenderIncomingDamage) return;
    defenderIncomingDamage.sources.push(attacker);
    defenderIncomingDamage.values.push(defenderDamageReceived);
    defenderIncomingDamage.commitments.push(1);
    setComponent(IncomingDamage, defender, defenderIncomingDamage);
  });

  defineEnterSystem(
    world,
    [Has(Combat)],
    ({ entity }) => {
      setComponent(IncomingDamage, entity, {
        sources: [],
        values: [],
        commitments: [],
      });
    },
    { runOnInit: true },
  );

  defineSystem(world, [Has(NextPosition)], ({ entity, type }) => {
    const entitiesWithIncomingDamage = [...runQuery([Has(IncomingDamage)])];

    for (const entity of entitiesWithIncomingDamage) {
      const incomingDamage = getComponentValue(IncomingDamage, entity);
      if (!incomingDamage) continue;

      const sources = incomingDamage.sources;
      const values = incomingDamage.values;
      const commitments = incomingDamage.commitments;

      let changed = false;
      for (let i = 0; i < incomingDamage.sources.length; i++) {
        const commitment = incomingDamage.commitments[i];

        if (commitment === 0) {
          changed = true;
          sources.splice(i, 1);
          values.splice(i, 1);
          commitments.splice(i, 1);
          continue;
        }
      }

      if (changed) {
        setComponent(IncomingDamage, entity, {
          sources,
          values,
          commitments,
        });
      }
      setComponent(WillBeDestroyed, entity, { value: false });
      removeComponent(TerrainArmorBonus, entity);
    }

    if (type === UpdateType.Exit) {
      return;
    }

    const nextPosition = getComponentValueStrict(NextPosition, entity);
    if (nextPosition.intendedTarget) {
      const defender = nextPosition.intendedTarget;
      const attacker = entity;

      const combatResult = calculateCombatResult(layer.parentLayers.network, attacker, defender, {
        x: nextPosition.x,
        y: nextPosition.y,
      });

      const attackerIncomingDamage = getComponentValueStrict(IncomingDamage, attacker);
      attackerIncomingDamage.sources.push(defender);
      attackerIncomingDamage.values.push(combatResult.defenderDamage * 1000);
      attackerIncomingDamage.commitments.push(0);
      setComponent(IncomingDamage, attacker, attackerIncomingDamage);

      const defenderIncomingDamage = getComponentValueStrict(IncomingDamage, defender);
      defenderIncomingDamage.sources.push(attacker);
      defenderIncomingDamage.values.push(combatResult.attackerDamage * 1000);
      defenderIncomingDamage.commitments.push(0);
      setComponent(IncomingDamage, defender, defenderIncomingDamage);

      const attackerHealth = (getComponentValue(Combat, attacker)?.health ?? 0) / 1000;
      const defenderHealth = (getComponentValue(Combat, defender)?.health ?? 0) / 1000;

      const attackerTotalIncomingDamage = attackerIncomingDamage.values.reduce((acc, val) => acc + val / 1000, 0);
      if (attackerHealth - attackerTotalIncomingDamage <= 0) {
        setComponent(WillBeDestroyed, attacker, { value: true });
      }

      const defenderTotalIncomingDamage = defenderIncomingDamage.values.reduce((acc, val) => acc + val / 1000, 0);
      if (defenderHealth - defenderTotalIncomingDamage <= 0) {
        setComponent(WillBeDestroyed, defender, { value: true });
      }

      const attackerTerrainModifier = getModiferAtPosition(
        networkLayer,
        ArmorModifier,
        {
          x: nextPosition.x,
          y: nextPosition.y,
        } || { x: 0, y: 0 },
      );
      setComponent(TerrainArmorBonus, attacker, { value: attackerTerrainModifier });

      const defenderTerrainModifier = getModiferAtPosition(
        networkLayer,
        ArmorModifier,
        getComponentValue(Position, defender) || { x: 0, y: 0 },
      );
      setComponent(TerrainArmorBonus, defender, { value: defenderTerrainModifier });
    }
  });
}
