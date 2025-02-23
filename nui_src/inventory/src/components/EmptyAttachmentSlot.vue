<template>
    <div class="newtooltip-attachment-entry" :ref="drop">
    </div>
</template>

<script lang="ts" setup>
import { useDrop } from 'vue3-dnd';
import { DragSourceTypes, I_DragSource } from '../types/dragSource';
import eventPlugin from '../plugins/event.plugin';

const props = defineProps({
    uniqueId: {
        type: String,
        required: true
    },
    weaponItemHash: {
        type: String,
        required: true
    }
});

const [dropCollect, drop] = useDrop<I_DragSource>(() => {
    return {
        accept: [DragSourceTypes.INVENTORY_ITEM],
        drop: (dragged, monitor) => {
            const { inventoryItem } = dragged;
            if (inventoryItem) {
                eventPlugin.post("ITEM_ADD_ATTACHMENT_WEAPON", {
                    fromUniqueID: inventoryItem.uniqueID,
                    toUniqueID: props.uniqueId,
                    draggedItemhash: inventoryItem.item.itemHash,
                    toItemHash: props.weaponItemHash
                });
            }
        }
    }
})
</script>
