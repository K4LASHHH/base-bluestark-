<template>
    <div :ref="drop" class="inventory-slot" :style="{
        background: `radial-gradient(circle, ${settingsStore.Settings.slot_colour_1} 0%, ${settingsStore.Settings.slot_colour_2} 100%)`
    }">
        <div v-if="slotIndex <= 5" class="slot-id">{{ slotIndex }}</div>
    </div>
</template>

<script lang="ts" setup>
import { useDrop } from 'vue3-dnd';
import { useSettingsStore } from '../store/settings.store';
import { DragSourceTypes, I_DragSource } from '../types/dragSource';
import { useInventoryStore } from '../store/inventory.store';
import { playAudio } from '../plugins/audio.plugin';
import eventPlugin from '../plugins/event.plugin';

const settingsStore = useSettingsStore();
const inventoryStore = useInventoryStore();

const props = defineProps({
    uniqueId: {
        type: String,
        required: true
    },
    slotIndex: {
        type: Number,
        required: true
    }
})

const [dropCollect, drop] = useDrop<I_DragSource, void, { isOver: boolean }>(() => {
    return {
        accept: [
            DragSourceTypes.INVENTORY_ITEM,
            DragSourceTypes.WEAPON_ATTACHMENT,
            DragSourceTypes.SHOP_ITEM
        ],
        drop: (item, monitor) => {
            const { attachmentItem, inventoryItem, shopItem } = item;

            playAudio("sfx/inv_pop.wav");

            if (inventoryItem) {
                eventPlugin.post("ITEM_MOVE_TO_SLOT", {
                    fromUniqueID: inventoryItem.uniqueID,
                    fromSlot: inventoryItem.item.slot,
                    quantity: inventoryStore.quantityInput,

                    toSlot: props.slotIndex,
                    toUniqueID: props.uniqueId
                });
            }
            else if (attachmentItem) {
                eventPlugin.post("ITEM_REMOVE_ATTACHMENT_WEAPON", {
                    fromUniqueID: attachmentItem.fromUniqueID,
                    fromItemHash: attachmentItem.fromItemHash,
                    fromAttIndex: attachmentItem.attachmentIndex,

                    toUniqueID: props.uniqueId,
                    toSlot: props.slotIndex
                });
            }
            else if (shopItem) {
                eventPlugin.post("BUY_FROM_SHOP", {
                    shopId: shopItem.shopId,
                    fromSlot: shopItem.fromSlot,
                    quantity: inventoryStore.quantityInput,

                    toSlot: props.slotIndex
                });
            }
        }
    }
})
</script>