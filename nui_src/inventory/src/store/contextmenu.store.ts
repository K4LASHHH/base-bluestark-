import { defineStore } from "pinia";
import { ref, watch } from "vue";
import { I_ContextMenu } from "../types/contextmenu";
import { useInventoryStore } from "./inventory.store";

export const useContextMenuStore = defineStore("ContextMenu", () => {
    const inventoryStore = useInventoryStore();

    const opened = ref(false);
    const coordX = ref(0);
    const coordY = ref(0);
    const disableClose = ref(false);
    const store = ref<I_ContextMenu | null>(null);

    function Open(data: I_ContextMenu) {
        store.value = data;
        opened.value = true;
        coordX.value = inventoryStore.store.cursorX;
        coordY.value = inventoryStore.store.cursorY;
    }

    function Close() {
        if (disableClose.value) return;

        opened.value = false;
        store.value = null;
    }

    watch(() => opened, (isOpened) => {
        disableClose.value = false;
    });

    /** Reset on interface close. */
    watch(() => inventoryStore.interfaceOpened, (isOpened) => {
        disableClose.value = false;
        Close();
    });

    return {
        opened,
        coordX,
        coordY,
        disableClose,
        store,
        Open,
        Close
    }
});