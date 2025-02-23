<template>
    <div v-if="inventory" class="inventory-header">
        <div class="header-name">{{ inventory.inventoryName }}</div>
        <div class="header-weight-content">
            <div class="weight-text">{{ currentWeight.toFixed(2) }} / {{ inventory.maxWeight.toFixed(2) }} kg.</div>
            <div class="weight-bar" :style="{
                background: settingsStore.Settings.weight_bar_background
            }">
                <div class="weight-bar-inside" :style="{
                        width: (currentWeight / inventory.maxWeight) * 100 + '%',
                        background: settingsStore.Settings.weight_bar_color
                    }"></div>
            </div>
        </div>
    </div>
    <div v-else-if="shop" class="inventory-header">
        <div class="header-name">{{ shop.shopName }}</div>
    </div>

    <div class="inventory-items-content" v-if="inventory">
        <template v-for="(n, index) in inventory.slotsAmount">
            <ItemSlot v-if="inventory.items.findIndex(a => a.slot == index + 1) !== -1" :unique-id="inventory.uniqueID"
                :slot-index="index + 1" :item="inventory.items.find(a => a.slot == index + 1)!" />
            <EmptySlot v-else :unique-id="inventory.uniqueID" :slot-index="index + 1" />
        </template>
    </div>
    <div class="inventory-items-content" v-else-if="shop">
        <ShopItemSlot v-for="(shopItem, index) in shop.items" :slot-index="index + 1" :shop-id="shop.shopId"
            :shop-item="shopItem" />
    </div>
</template>

<script lang="ts" setup>
import { computed, PropType } from 'vue';
import EmptySlot from '../components/EmptySlot.vue';
import ItemSlot from '../components/ItemSlot.vue';
import { useSettingsStore } from '../store/settings.store';
import { I_Inventory } from "../types/inventory"
import { I_ShopInventory } from "../types/shop"
import ShopItemSlot from '../components/ShopItemSlot.vue';

const settingsStore = useSettingsStore();

const props = defineProps({
    inventory: {
        type: Object as PropType<I_Inventory>,
        required: false
    },
    shop: {
        type: Object as PropType<I_ShopInventory>,
        required: false
    },
    isLocal: {
        type: Boolean,
        required: false
    },
    isShop: {
        type: Boolean,
        required: false
    }
});

const currentWeight = computed(() => {
    let amount = 0.0;

    if (props.inventory) {
        props.inventory.items.forEach(item => {
            if (typeof item.data.weight === 'number') {
                amount += item.data.weight * item.quantity;
            }
        });
    }

    return amount;
});

</script>

<style lang="scss">
$textstroke: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;

.inventory-container {
    position: absolute;
    height: 40.5vw;
    width: 27.5vw;

    &.left {
        left: 5%;
    }

    &.right {
        right: 5%;
    }

    .inventory-header {
        position: relative;
        height: 3vw;
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;

        .header-name {
            position: relative;
            color: white;
            font-size: 1.35vw;
            font-variant: small-caps;
            flex: 1;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        .header-weight-content {
            position: relative;
            height: 100%;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;

            .weight-text {
                position: absolute;
                font-size: 0.7vw;
                color: white;
                bottom: 50%;
                text-align: right;
                width: 100%;
            }

            .weight-bar {
                position: absolute;
                bottom: 20%;
                width: 100%;
                height: 0.6vw;
                border-radius: .25vw;
                border: .1vw solid grey;
                background-color: rgba(220, 220, 220, .65);

                .weight-bar-inside {
                    height: 100%;
                    width: 20%;
                    background: rgba(21, 165, 248, 0.61);
                    border-radius: inherit;
                }
            }
        }
    }

    .inventory-items-content {
        position: relative;
        max-height: 90%;
        width: 100%;
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        align-content: flex-start;
        overflow-y: auto;
    }
}
</style>