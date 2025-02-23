<template>
    <div :ref="drag" class="inventory-slot" @contextmenu.prevent.right="onContextMenu" :style="{
        background: `radial-gradient(circle, ${settingsStore.Settings.slot_colour_1} 0%, ${settingsStore.Settings.slot_colour_2} 100%)`,
        opacity: isDragging ? 0.7 : 1.0
    }">
        <div class="item-image" :style="{
            backgroundImage: `url(items/${shopItem.name}.png)`
        }"></div>

        <div class="item-weight" v-if="typeof shopItem.data.weight == 'number' && settingsStore.Settings.itemweight" :style="{
            color: settingsStore.Settings.item_weight_color
        }">
            {{ shopItem.data.weight }} kg
        </div>

        <div class="item-name" :style="{
            color: settingsStore.Settings.item_name_color,
            background: settingsStore.Settings.item_name_background
        }">
            ${{ shopItem.price }}
        </div>
    </div>
</template>

<script lang="ts" setup>
import { computed, PropType, unref } from 'vue';
import { useDrag } from 'vue3-dnd';
import { useContextMenuStore } from '../store/contextmenu.store';
import { useSettingsStore } from '../store/settings.store';
import { DragSourceTypes, I_DragSource } from '../types/dragSource';
import { I_ShopItem } from '../types/shopItem';

const settingsStore = useSettingsStore();
const contextMenuStore = useContextMenuStore();

const props = defineProps({
    shopId: {
        type: String,
        required: true
    },
    shopItem: {
        type: Object as PropType<I_ShopItem>,
        required: true
    },
    slotIndex: {
        type: Number,
        required: true
    }
})

const [dragCollect, drag] = useDrag<I_DragSource, unknown, { isDragging: boolean }>(() => {
    return {
        type: DragSourceTypes.SHOP_ITEM,
        item: {
            image: props.shopItem.name,
            shopItem: {
                fromSlot: props.slotIndex,
                shopId: props.shopId
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

function onContextMenu() {
    contextMenuStore.Open({
        shopItem: {
            item: props.shopItem,
            shopId: props.shopId
        }
    })
}

</script>