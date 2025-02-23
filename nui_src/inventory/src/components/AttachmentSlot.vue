<template>
    <div class="newtooltip-attachment-entry" :ref="drag" :style="{
        opacity: isDragging ? 0.4 : 1.0
    }">
        <div class="newtooltip-attachment-entry-image" :style="{
            backgroundImage: `url(items/${attachmentName}.png)`
        }"></div>
    </div>
</template>

<script lang="ts" setup>
import { computed, unref } from 'vue';
import { useDrag } from 'vue3-dnd';
import { DragSourceTypes, I_DragSource } from '../types/dragSource';

const props = defineProps({
    attachmentIndex: {
        type: Number,
        required: true,
    },
    attachmentName: {
        type: String,
        required: true
    },
    weaponItemHash: {
        type: String,
        required: true
    },
    uniqueId: {
        type: String,
        required: true
    }
});

const [dragCollect, drag] = useDrag<I_DragSource, unknown, { isDragging: boolean }>(() => {
    return {
        type: DragSourceTypes.WEAPON_ATTACHMENT,
        item: {
            image: props.attachmentName,
            attachmentItem: {
                attachmentName: props.attachmentName,
                fromItemHash: props.weaponItemHash,
                fromUniqueID: props.uniqueId,
                attachmentIndex: props.attachmentIndex
            }
        },
        collect: (monitor) => {
            return {
                isDragging: monitor.isDragging()
            }
        }
    }
})

const isDragging = computed(() => unref(dragCollect).isDragging)
</script>
