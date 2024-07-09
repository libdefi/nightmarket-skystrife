import { Hex, stringToHex } from "viem";
import { NetworkLayer } from "../../../layers/Network";
import { chunk } from "@latticexyz/common/utils";
import { LEVEL_UPLOAD_SYSTEM_ID } from "../../../constants";
import { encodeSystemCallFrom } from "@latticexyz/world/internal";
import IWorldAbi from "contracts/out/IWorld.sol/IWorld.abi.json";
import { skystrifeDebug } from "../../../debug";

const debug = skystrifeDebug.extend("map-upload");

export type Level = Array<{
  templateId: string;
  values: object;
}>;

const STATE_UPDATES_PER_TX = 50;

export async function bulkUploadMap(layer: NetworkLayer, from: Hex, level: Level, name: string) {
  debug(`Uploading ${name} level`);

  const chunkedState = Array.from(chunk(level, STATE_UPDATES_PER_TX));

  for (let i = 0; i < chunkedState.length; i++) {
    const stateChunk = chunkedState[i];
    debug(`Level: ${name}, Uploading chunk ${i + 1} of ${chunkedState.length}`);

    const levelId = stringToHex(name, { size: 32 });
    const templateIds = stateChunk.map((s) => stringToHex(s.templateId, { size: 32 }));
    const xs = stateChunk.map((s) => s.values.Position.x);
    const ys = stateChunk.map((s) => s.values.Position.y);

    let success = false;
    let retryCount = 0;

    while (!success && retryCount < 3) {
      try {
        const tx = await layer.network.worldContract.write.callFrom(
          encodeSystemCallFrom({
            abi: IWorldAbi,
            from,
            systemId: LEVEL_UPLOAD_SYSTEM_ID,
            functionName: "uploadLevel",
            args: [levelId, templateIds, xs, ys],
          }),
        );
        await layer.network.waitForTransaction(tx);
        success = true;
      } catch (e) {
        debug(`Error uploading chunk ${i + 1}:`, e);
        retryCount++;
        debug(`Retrying chunk ${i + 1}, attempt ${retryCount}`);
      }
    }

    if (!success) {
      throw new Error(`Failed to upload ${name} level at chunk ${i + 1}`);
    }
  }

  debug(`Uploaded ${name} level!`);
}
