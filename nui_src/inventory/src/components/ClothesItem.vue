<template>
    <div class="clothes-item-parent">
        <!-- <div class="clothes-header">{{ header }}</div> -->

        <div @click="isActionsOpened = !isActionsOpened" class="clothes-item" :style="{
            height: height + 'vw',
            width: width + 'vw',
            background: `radial-gradient(circle, ${settingsStore.Settings.clothes_background_color_1} 0%, ${settingsStore.Settings.clothes_background_color_2} 100%)`,
        }">
            <div class="item-image" :style="{
                backgroundImage: `url(clothes_empty_items/${isWeared ? props.weared_image : props.empty_image}.png)`
            }"></div>
        </div>

        <Transition
            :enterActiveClass="'animate__animated animate__faster animate__' + (iconLeftAlign ? 'fadeInRight' : 'fadeInLeft')"
            :leaveActiveClass="'animate__animated animate__faster animate__' + (iconLeftAlign ? 'fadeOutRight' : 'fadeOutLeft')">
            <div v-if="isActionsOpened" :class="iconLeftAlign ? 'actions left' : 'actions right'">
                <i @click="Wear" class="action-entry fa-solid fa-chevron-up"></i>
                <i @click="Takeoff" class="action-entry fa-solid fa-chevron-down"></i>

                <template v-for="a in variations">
                    <i v-if="isVariationAvailable(a.id, a.prop)" @click="ChangeVariation(a.id, a.prop)"
                        class="action-entry fa-solid fa-circle-half-stroke"></i>
                </template>
            </div>
        </Transition>
    </div>
</template>

<script lang="ts" setup>
import { computed, PropType, ref } from 'vue';
import { useInventoryStore } from '../store/inventory.store';
import { useSettingsStore } from '../store/settings.store';
import eventPlugin from '../plugins/event.plugin';

const inventoryStore = useInventoryStore();
const settingsStore = useSettingsStore();

const isActionsOpened = ref(false);

const isWeared = computed(() => {
    let weared = false;

    const idx = inventoryStore.takeoffable?.findIndex(a => a.id == props.id && a.prop == props.prop && a.isWeared);
    if (idx != undefined && idx >= 0) {
        weared = true;
    }

    return weared;
});

function Wear() {
    eventPlugin.post("WEAR_DRESS", {
        id: props.id,
        prop: props.prop
    })
}

function Takeoff() {
    eventPlugin.post("TAKE_OFF_DRESS", {
        id: props.id,
        prop: props.prop
    });
}

function ChangeVariation(id: number, prop?: boolean) {
    eventPlugin.post("CHANGE_VARIATION", {
        id: id,
        prop: prop
    });
}

function isVariationAvailable(id: number, prop?: boolean) {
    return inventoryStore.variations?.findIndex(a => a.id == id && a.prop == prop && a.isAvailable) !== -1;
}

const props = defineProps({
    header: {
        type: String,
        required: true
    },
    width: {
        type: Number,
        required: false,
        default: 4
    },
    height: {
        type: Number,
        required: false,
        default: 4
    },
    empty_image: {
        type: String,
        required: true
    },
    weared_image: {
        type: String,
        required: true
    },
    prop: {
        type: Boolean,
        required: false
    },
    id: {
        type: Number,
        required: true
    },
    iconLeftAlign: {
        type: Boolean,
        required: false
    },
    variations: {
        type: Object as PropType<{ id: number; prop?: boolean; }[]>,
        required: false
    }
});

</script>


<style lang="scss" scoped>
$HEADER_COLOR: linear-gradient(180deg, rgba(75, 75, 75, 0.8), rgba(35, 35, 35, .8));
$textstroke: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;

.clothes-item-parent {
    position: absolute;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;

    .actions {
        position: absolute;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        color: rgb(200, 200, 200);

        &.left {
            left: -1.5vw;
        }

        &.right {
            right: -1.5vw;
        }

        .action-entry {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            height: .5vw;
            width: .5vw;
            background-color: rgba(25, 25, 25, .45);
            margin: .15vw;
            padding: .2vw;
            border-radius: .1vw;
            font-size: .7vw;

            &:hover {
                filter: brightness(140%);
            }
        }
    }

    .clothes-header {
        font-size: .5vw;
        color: white;
        width: 100%;
        background: $HEADER_COLOR;
        padding: .15vw 0;
        text-align: center;
    }

    .clothes-item {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
        border-radius: .25vw;

        // background: repeating-linear-gradient(-45deg,
        //         rgba(100, 100, 100, .45),
        //         rgba(0, 0, 0, .45) .35vw);

        &:hover {
            filter: brightness(120%);
        }

        .item-image {
            position: relative;
            width: 80%;
            height: 80%;
            background-position: center;
            background-size: contain;
            background-repeat: no-repeat;
            pointer-events: none;
        }

        .item-quantity {
            position: absolute;
            font-size: .55vw;
            color: rgb(220, 220, 220);
            bottom: 0;
            left: .1vw;
            pointer-events: none;
        }
    }
}
</style>