<template>
    <div class="clothes-parent">
        <div class="clothes-header-content">
            <div class="player-name">{{ inventoryStore.playerHeader }}</div>
        </div>

        <div class="clothes-items">
            <ClothesItem v-for="(a, type) in UIDATA" :clothing-type="type" :id="a.id" :prop="a.prop" :header="a.header"
                :icon-left-align="a.iconLeftAlign" :weared_image="a.weared_image" :empty_image="a.empty_image"
                :variations="a.variations" :width="a.width ?? undefined" :height="a.height ?? undefined" :style="{
                    position: 'absolute',
                    top: a.top + 'vw',
                    left: a.left + 'vw',
                    right: a.right + 'vw'
                }" />
        </div>
    </div>
</template>

<script lang="ts" setup>
import ClothesItem from '../components/ClothesItem.vue';
import { useInventoryStore } from '../store/inventory.store';

const inventoryStore = useInventoryStore();

interface WearableUInterface {
    width?: number;
    height?: number;
    top: number;
    header: string;
    left?: number;
    right?: number;
    empty_image: string;
    weared_image: string;
    prop?: boolean;
    id: number;
    iconLeftAlign?: boolean;
    variations?: { prop?: boolean; id: number; }[];
}

const UIDATA: WearableUInterface[] = [
    // LEFT
    {
        iconLeftAlign: true,
        prop: true,
        id: 0,
        top: 5,
        left: 0,
        header: "Hat",
        empty_image: 'hat',
        weared_image: 'weared_hat',
        variations: [
            { id: 0, prop: true },
            { id: 2 }
        ]
    },
    {
        iconLeftAlign: true,
        id: 0,
        top: 10,
        left: 0,
        header: "Mask",
        empty_image: 'mask',
        weared_image: 'weared_mask'
    },
    {
        iconLeftAlign: true,
        id: 11,
        top: 15,
        left: 0,
        header: "Top",
        empty_image: 'hoodie',
        weared_image: 'weared_hoodie',
        variations: [
            { id: 3, },
            { id: 11 }
        ]
    },
    {
        iconLeftAlign: true,
        id: 9,
        top: 20,
        left: 0,
        header: "Armour",
        empty_image: 'body_armour',
        weared_image: 'weared_body_armour'
    },
    {
        iconLeftAlign: true,
        id: 4,
        top: 25,
        left: 0,
        header: "Pants",
        empty_image: 'pants',
        weared_image: 'weared_pants'
    },
    {
        iconLeftAlign: true,
        id: 6,
        top: 30,
        left: 0,
        header: "Shoes",
        empty_image: 'shoes',
        weared_image: 'weared_shoes'
    },
    // // RIGHT
    {
        prop: true,
        id: 1,
        top: 5,
        right: 0,
        header: "Sunglasses",
        empty_image: 'glasses',
        weared_image: 'weared_glasses'
    },
    {
        prop: true,
        id: 2,
        top: 10,
        right: 0,
        header: "Earrings",
        empty_image: 'earrings',
        weared_image: 'weared_earrings'
    },
    {
        id: 7,
        top: 15,
        right: 0,
        header: "Accessories",
        empty_image: 'accessories',
        weared_image: 'weared_accessories'
    },
    // {
    //     id: 10,
    //     top: 15,
    //     right: 0,
    //     header: "Decals",
    //     empty_image: 'decals',
    //     weared_image: 'weared_decals'
    // },
    {
        id: 5,
        top: 20,
        right: 0,
        header: "Bag",
        empty_image: 'bag',
        weared_image: 'weared_bag',
        variations: [{ id: 5 }]
    },
    {
        prop: true,
        id: 7,
        top: 25,
        right: 0,
        header: "Bracelet",
        empty_image: 'bracelet',
        weared_image: 'weared_bracelet'
    },
    {
        prop: true,
        id: 6,
        top: 30,
        right: 0,
        header: "Watch",
        empty_image: 'watch',
        weared_image: 'weared_watch'
    },
];

</script>

<style lang="scss" scoped>
.clothes-parent {
    position: absolute;
    width: 25vw;
    top: 10%;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;

    .clothes-header-content {
        position: relative;
        top: 3vw;
        width: 100%;
        height: 2vw;
        display: flex;
        justify-content: center;
        align-items: center;

        .player-name {
            font-size: 1vw;
            color: white;
        }
    }

    .clothes-items {
        position: relative;
        width: 100%;
        height: 65%;
    }
}
</style>