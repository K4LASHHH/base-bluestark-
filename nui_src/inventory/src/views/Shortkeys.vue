<template>
    <Transition enter-active-class="animate__animated animate__fadeInUp animate__faster"
        leave-active-class="animate__animated animate__fadeOutDown animate__faster">
        <div v-if="isOpened && !inventoryStore.interfaceOpened" class="shortkeys-parent">
            <div class="shortkey-entry" v-for="idx in 5">
                <div class="shortkey-key">{{ idx }}</div>
                <div class="shortkey-img" :style="{
                    backgroundImage: `url(items/${slots[idx]?.name}.png)`
                }"></div>
                <div class="shortkey-quantity" v-if="slots[idx]?.data.stackable && slots[idx]">x{{ slots[idx]?.quantity }}
                </div>
            </div>
        </div>
    </Transition>
</template>

<script lang="ts" setup>
import { computed, ref } from 'vue';
import { useInventoryStore } from '../store/inventory.store';
import { I_Item } from '../types/item';
import eventPlugin from '../plugins/event.plugin';

const inventoryStore = useInventoryStore();

const isOpened = ref(false);

const slots = computed(() => {
    let s: Record<number, I_Item | null> = {
        1: null,
        2: null,
        3: null,
        4: null,
        5: null
    }

    const playerInventory = inventoryStore.playerInventory;
    if (playerInventory) {
        for (let i = 1; i <= 5; i++) {
            const item = playerInventory.items.find(a => a.slot == i);
            if (item) {
                s[i] = item;
            }
        }
    }

    return s;
});

eventPlugin.on("SHORTKEYS_STATE", ({ state }) => {
    isOpened.value = state;
});
</script>

<style lang="scss" scoped>
$SHORTKEY_SIZE: 3vw;

.shortkeys-parent {
    position: absolute;
    bottom: 3%;
    display: flex;
    flex-direction: row;

    .shortkey-entry {
        position: relative;
        background: radial-gradient(circle, rgba(25, 25, 25, .5) 0%, rgba(15, 15, 15, .65) 100%) !important;
        border: .1vw solid rgba(135, 135, 135, .55);
        border-radius: .25vw;
        height: $SHORTKEY_SIZE;
        width: $SHORTKEY_SIZE;
        margin: 0 .2vw;
        display: flex;
        justify-content: center;
        align-items: center;

        .shortkey-key {
            position: absolute;
            color: rgb(220, 220, 220);
            font-size: .6vw;
            top: -.65vw;
            padding: .15vw .25vw;
            background-color: rgba(0, 0, 0, .35);
            border-radius: .25vw;
        }

        .shortkey-img {
            position: relative;
            width: 70%;
            height: 70%;
            background-position: center;
            background-size: contain;
            background-repeat: no-repeat;
        }

        .shortkey-quantity {
            position: absolute;
            font-size: .55vw;
            color: rgb(220, 220, 220);
            bottom: 0;
            left: 0;
            padding: .15vw .25vw;
        }
    }
}
</style>