<template>
    <div class="action-panels-container">
        <input v-model="inventoryStore.quantityInput" placeholder="Quantity" type="number">
        <div :ref="drop_Throw" class="panel throw">Jeter</div>
        <div :ref="drop_Use" class="panel use">Utiliser</div>
        <div :ref="drop_Give" class="panel give">Donner</div>
    </div>
</template>

<script lang="ts" setup>
import { useDrop } from 'vue3-dnd';
import { useInventoryStore } from '../store/inventory.store';
import { useNearbyStore } from '../store/nearby.store';
import { DragSourceTypes, I_DragSource } from '../types/dragSource';
import eventPlugin from '../plugins/event.plugin';

const nearbyStore = useNearbyStore();
const inventoryStore = useInventoryStore();

const [_, drop_Throw] = useDrop<I_DragSource, void>(() => {
    return {
        accept: [
            DragSourceTypes.INVENTORY_ITEM
        ],
        drop: (item, monitor) => {
            const { inventoryItem } = item;

            if (inventoryItem) {
                eventPlugin.post("DROP_ITEM_ON_GROUND", {
                    uniqueID: inventoryItem.uniqueID,
                    itemHash: inventoryItem.item.itemHash,
                    quantity: inventoryStore.quantityInput
                });
            }
        }
    }
})

const [__, drop_Use] = useDrop<I_DragSource, void>(() => {
    return {
        accept: [
            DragSourceTypes.INVENTORY_ITEM
        ],
        drop: (item, monitor) => {
            const { inventoryItem } = item;

            if (inventoryItem) {
                eventPlugin.post("USE_ITEM", {
                    uniqueID: inventoryItem.uniqueID,
                    itemHash: inventoryItem.item.itemHash
                });
            }
        }
    }
})

const [___, drop_Give] = useDrop<I_DragSource, void>(() => {
    return {
        accept: [
            DragSourceTypes.INVENTORY_ITEM
        ],
        drop: (item, monitor) => {
            const { inventoryItem } = item;

            if (inventoryItem) {
                nearbyStore.open(
                    inventoryItem.item.itemHash
                );
            }
        }
    }
})
</script>

<style lang="scss" scoped>
.action-panels-container {
    position: absolute;
    height: 20%;
    bottom: 1%;
    display: flex;
    justify-content: center;
    align-items: center;

    input {
        width: 25%;
        position: absolute;
        border: 0;
        outline: 0;
        top: 12%;
        background: rgba(20, 20, 20, 0.35);
        font-family: majestic;
        padding: .35vw .75vw;
        font-size: 1.15vw;
        color: white;
        text-align: center;

        &::placeholder {
            color: rgb(120, 120, 120);
            font-size: 0.9vw;
        }

        &::-webkit-inner-spin-button,
        &::-webkit-outer-spin-button {
            -webkit-appearance: none;
        }
    }

    .panel {
        top: 1vw;
        position: relative;
        font-size: 1.1vw;
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        background: rgba(20, 20, 20, 0.75);
        margin: 0 0.5vw;

        &:hover {
            animation: pulse 1s ease infinite;
        }

        &.use {
            height: 4vw;
            width: 7vw;
            border-bottom: 0.2vw groove rgb(21, 165, 248);
        }

        &.throw,
        &.give {
            height: 3.25vw;
            width: 6vw;
        }
    }
}
</style>