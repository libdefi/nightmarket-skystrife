import { Entity, Has, Not, defineSystem, getComponentValue, runQuery, setComponent } from "@latticexyz/recs";
import { NetworkLayer } from "../../types";
import { DateTime } from "luxon";
import { decodeEntity } from "@latticexyz/store-sync/recs";

/**
 * Calculating the "liveness" of a match is an expensive operation that was
 * hindering UI performance. Doing it here on a slower cadence helps with that.
 */
export function createJoinableMatchSystem(layer: NetworkLayer) {
  const {
    world,
    components: { MatchJoinable, MatchConfig, MatchReady, MatchFinished, MatchAllowed, AllowList },
    utils: { matchIsLive },
  } = layer;

  const setMatchJoinable = (matchEntity: Entity) => {
    const currentTime = DateTime.utc().toSeconds();
    const matchIsNotLive = !matchIsLive(matchEntity);
    const matchConfig = getComponentValue(MatchConfig, matchEntity);
    if (!matchConfig) {
      setComponent(MatchJoinable, matchEntity, { value: false });
      return;
    }

    const registrationOpen = matchConfig.registrationTime <= BigInt(Math.floor(currentTime));

    if (matchIsNotLive && registrationOpen) {
      setComponent(MatchJoinable, matchEntity, { value: true });
    } else {
      setComponent(MatchJoinable, matchEntity, { value: false });
    }
  };

  const updateJoinableMatches = () => {
    const matchesToCheck = runQuery([Has(MatchConfig), Not(MatchFinished)]);

    for (const matchEntity of matchesToCheck) {
      setMatchJoinable(matchEntity);
    }
  };

  updateJoinableMatches();
  setInterval(updateJoinableMatches, 30_000);

  defineSystem(world, [Has(MatchConfig), Has(MatchReady), Not(MatchFinished)], ({ entity }) =>
    setMatchJoinable(entity),
  );
  defineSystem(world, [Has(MatchConfig), Not(MatchReady), Not(MatchFinished)], ({ entity }) =>
    setMatchJoinable(entity),
  );

  // unfuck the contract data model and build up the local AllowList
  defineSystem(world, [Has(MatchAllowed), Not(MatchFinished)], ({ entity }) => {
    const matchAllowed = getComponentValue(MatchAllowed, entity);
    if (!matchAllowed) return;

    const { matchEntity, account } = decodeEntity(MatchAllowed.metadata.keySchema, entity);
    const allowList = getComponentValue(AllowList, matchEntity as Entity)?.value ?? ([] as string[]);

    setComponent(AllowList, matchEntity as Entity, { value: [...allowList, account] });
  });
}
