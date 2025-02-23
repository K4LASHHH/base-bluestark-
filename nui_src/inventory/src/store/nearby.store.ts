import { defineStore } from "pinia";
import { ref, watch } from "vue";
import { useInventoryStore } from "./inventory.store";
import eventPlugin from "../plugins/event.plugin";

export const useNearbyStore = defineStore("NearbyStore", () => {

    const inventoryStore = useInventoryStore();

    const isOpened = ref(false);
    const nearPlayers = ref<{ serverId: number; name: string; }[]>([]);

    const itemHash = ref<string | null>(null);

    function open(iHash: string) {
        itemHash.value = iHash;

        eventPlugin.post("NEARBY_GET_PLAYERS").then(response => {
            const players = response.data;
            if (Array.isArray(players) && players.length > 0) {
                nearPlayers.value = players;
                isOpened.value = true;
            }
            else {
                isOpened.value = false;
            }
        });
    }

    function give(serverId: number) {
        eventPlugin.post("GIVE_ITEM_TO_TARGET", {
            itemHash: itemHash.value,
            serverId: serverId,
            quantity: inventoryStore.quantityInput
        });

        isOpened.value = false;
        itemHash.value = null;
    }

    watch(() => inventoryStore.interfaceOpened, (newState) => {
        if (!newState) isOpened.value = false;
    });

    return {
        isOpened,
        nearPlayers,
        open,
        give
    }
});