<template>
    <div :ref="node => drag(drop(node as Element))" :key="slotIndex" class="inventory-slot"
        @contextmenu.prevent.right="onContextMenu" @mouseenter="mouseEnter" :style="{
            background: `radial-gradient(circle, ${settingsStore.Settings.slot_colour_1} 0%, ${settingsStore.Settings.slot_colour_2} 100%)`,
            opacity: isDragging ? 0.7 : 1.0
        }">

        <div class="item-image" :style="{
            backgroundImage: `url(items/${item.name}.png)`
        }"></div>

        <div class="item-weight" v-if="typeof item.data.weight == 'number' && settingsStore.Settings.itemweight" :style="{
            color: settingsStore.Settings.item_weight_color
        }">
            {{ (item.data.weight * item.quantity).toFixed(2) }} kg
        </div>

        <div class="item-name" v-if="settingsStore.Settings.itemname" :style="{
            color: settingsStore.Settings.item_name_color,
            background: settingsStore.Settings.item_name_background
        }">
            {{ item.meta?.customName ?? item.data.label }}
        </div>
        <div class="item-quantity" v-if="item.data.stackable && settingsStore.Settings.itemquantity" :style="{
            color: settingsStore.Settings.item_quantity_color
        }">
            x{{ item.quantity }}
        </div>
    </div>
</template>

<script lang="ts" setup>
import { computed, PropType, unref } from 'vue';
import { DragSourceMonitor, DropTargetMonitor, useDrag, useDrop } from 'vue3-dnd';
import { useContextMenuStore } from '../store/contextmenu.store';
import { useSettingsStore } from '../store/settings.store';
import { DragSourceTypes, I_DragSource } from '../types/dragSource';
import { I_Item } from '../types/item';
import { useInventoryStore } from '../store/inventory.store';
import { playAudio } from '../plugins/audio.plugin';
import eventPlugin from '../plugins/event.plugin';

const settingsStore = useSettingsStore();
const contextMenuStore = useContextMenuStore();
const inventoryStore = useInventoryStore();

const props = defineProps({
    uniqueId: {
        type: String,
        required: true
    },
    item: {
        type: Object as PropType<I_Item>,
        required: true
    },
    slotIndex: {
        type: Number,
        required: true
    }
})

const [dragCollect, drag] = useDrag<I_DragSource, unknown, { isDragging: boolean }>(() => {
    return {
        type: DragSourceTypes.INVENTORY_ITEM,
        item: {
            image: props.item.name,
            inventoryItem: {
                uniqueID: props.uniqueId,
                item: props.item
            }
        },
        collect: (monitor) => {
            return {
                isDragging: monitor.isDragging()
            }
        }
    }
})

const isDragging = computed(() => unref(dragCollect).isDragging);

const [dropCollect, drop] = useDrop<I_DragSource, void, { isOver: boolean }>(() => {
    return {
        accept: [
            DragSourceTypes.INVENTORY_ITEM,
            DragSourceTypes.SHOP_ITEM
        ],
        canDrop: (item, monitor) => {
            const { inventoryItem } = item;
            if (inventoryItem) {
                /** If its the same slot in the same inventory. */
                if (props.slotIndex == inventoryItem.item.slot && props.uniqueId == inventoryItem.uniqueID) return false;
                /** If its the same item. */
                if (props.item.itemHash == inventoryItem.item.itemHash) return false;
                /** If the current prop item is not stackable. */
                if (props.item.data.stackable == false) return false;
                /** If the items are not the same. */
                if (props.item.name != inventoryItem.item.name) return false;
            }

            return true;
        },
        drop: (item, monitor) => {
            const { inventoryItem, shopItem } = item;

            playAudio("sfx/inv_pop.wav");

            if (inventoryItem) {
                eventPlugin.post("ITEM_MOVE_TO_SLOT", {
                    fromUniqueID: inventoryItem.uniqueID,
                    fromSlot: inventoryItem.item.slot,
                    toSlot: props.slotIndex,
                    toUniqueID: props.uniqueId,
                    quantity: inventoryStore.quantityInput
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

function mouseEnter() {
    playAudio("sfx/inv_hover.mp3")
}

function onContextMenu() {
    contextMenuStore.Open({
        invItem: {
            item: props.item,
            inventoryUniqueID: props.uniqueId
        }
    })
}
</script>