<template>
    <DndProvider :backend="TouchBackend" :options="{
            enableMouseEvents: true
        }">
        <Dragged />

        <div class="center-div">
            <Shortkeys />
        </div>

        <div class="center-div" @click="contextMenuStore.Close" v-if="inventoryStore.interfaceOpened">

            <!-- <div class="inventory-background" :style="{
                backgroundImage: `url(inventory-background.png)`
            }"></div> -->

            <div class="inventory-container left">
                <Inventory v-if="inventoryStore.playerInventory" :is-local="true"
                    :inventory="inventoryStore.playerInventory" />
            </div>

            <div class="inventory-container right">
                <div class="inventory-selector" v-if="openedCount > 1">
                    <div @click.prevent.left="selectItem('inventory', index)"
                        :class="inventoryStore.selectedType == 'inventory' && inventoryStore.selectedSecondaryIdx == index ? 'selector-entry active' : 'selector-entry'"
                        v-for="(a, index) in inventoryStore.openedInventories">
                        {{ a.inventoryName }}
                    </div>
                    <div @click.prevent.left="selectItem('shop', index)"
                        :class="inventoryStore.selectedType == 'shop' && inventoryStore.selectedSecondaryIdx == index ? 'selector-entry active' : 'selector-entry'"
                        v-for="(a, index) in inventoryStore.openedShops">
                        {{ a.shopName }}
                    </div>
                </div>
                <Inventory v-if="inventoryStore.selectedInventory" :inventory="inventoryStore.selectedInventory" />
                <Inventory v-if="inventoryStore.selectedShop" :shop="inventoryStore.selectedShop" />
            </div>

            <ActionPanels />
            <InputComponent />
            <ContextMenu />
            <NearbyComponent />

            <Clothes />
            <Settings />
        </div>
    </DndProvider>
    <NotificationComponent />
    <HelpComponent />
    <Browser />
</template>

<script lang="ts" setup>
import Inventory from './views/Inventory.vue';
import ActionPanels from './views/ActionPanels.vue';
import Dragged from './components/Dragged.vue';
import ContextMenu from './components/ContextMenu.vue';
import InputComponent from "./components/InputComponent.vue";
import { useContextMenuStore } from './store/contextmenu.store';
import { useInventoryStore } from './store/inventory.store';
import Clothes from './views/Clothes.vue';
import { onMounted } from 'vue';
import Shortkeys from './views/Shortkeys.vue';
import Settings from './views/Settings.vue';
import NearbyComponent from './components/NearbyComponent.vue';
import { DndProvider } from 'vue3-dnd';
import { TouchBackend } from 'react-dnd-touch-backend';
import eventPlugin from './plugins/event.plugin';
import { computed } from '@vue/reactivity';
import NotificationComponent from './components/NotificationComponent.vue';
import HelpComponent from "./components/HelpComponent.vue";
import Browser from "./components/Browser.vue";

const contextMenuStore = useContextMenuStore();
const inventoryStore = useInventoryStore();

onMounted(() => {
    eventPlugin.post("CEF_LOADED");
});

function selectItem(type: "inventory" | "shop", idx: number) {
    inventoryStore.selectedType = type;
    inventoryStore.selectedSecondaryIdx = idx;
}

const openedCount = computed(() => {
    let count = 0;

    count += inventoryStore.openedInventories.length;
    count += inventoryStore.openedShops.length;

    return count;
});

</script>

<style lang="scss" scoped>
.inventory-background {
    width: 100%;
    height: 100%;
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
}

.inventory-selector {
    position: absolute;
    color: white;
    z-index: 99999;
    top: -7%;
    width: 100%;
    text-align: center;
    display: flex;

    .selector-entry {
        font-size: .8vw;
        flex: 1;
        background-color: rgba(0, 0, 0, .55);
        padding: .5vw 0;

        &:hover {
            background-color: rgba(25, 25, 25, .65);
        }

        &.active {
            background-color: rgba(21, 165, 248, 0.61);
        }
    }
}
</style>