<template>
    <div v-if="collect.isDragging" class="inventory-slot dragged" :style="{
        left: collect?.currentOffset?.x + 'px',
        top: collect?.currentOffset?.y + 'px'
    }">
        <div class="item-image" :style="{
            backgroundImage: `url(items/${collect?.item?.image}.png)`
        }"></div>
    </div>
</template>

<script lang="ts" setup>
import { useDragLayer } from 'vue3-dnd';

const collect = useDragLayer(monitor => ({
    item: monitor.getItem(),
    itemType: monitor.getItemType(),
    currentOffset: monitor.getSourceClientOffset(),
    isDragging: monitor.isDragging(),
}))

</script>

<style lang="scss" scoped>
.dragged {
    position: absolute;
    z-index: 9999;
    pointer-events: none;
    animation: tada 2s ease infinite;
    background: radial-gradient(circle, rgba(25, 25, 25, .25) 0%, rgba(15, 15, 15, .35) 100%) !important;
    border: 0 !important;
}
</style>
