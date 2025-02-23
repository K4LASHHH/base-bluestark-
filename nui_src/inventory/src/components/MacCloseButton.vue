<template>
    <div ref="componentRef" @click.left.prevent="onClick" @mouseenter="mouseEnter" class="mac-button">
        <i>X</i>
    </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue';
import { playAudio } from '../plugins/audio.plugin';

const componentRef = ref<HTMLElement | null>(null);

const emit = defineEmits(["click"])

const mouseEnter = () => {
    playAudio("sfx/hover.mp3");
}

const onClick = () => {
    playAudio("sfx/gtadecline.wav")

    emit("click");
}

</script>


<style lang="scss" scoped>
.mac-button {
    position: absolute;
    right: .5vw;
    background: red;
    width: .8vw;
    height: .8vw;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;

    &:hover {
        i {
            opacity: 1;
        }
    }

    i {
        color: white;
        opacity: 0;
        font-size: .5vw;
    }
}
</style>