<!-- <template>
    <div v-if="!settingsStore.isOpened" class="settings-opener-parent" @click.prevent.left="settingsStore.isOpened = true">
        <i class="fa-solid fa-gears"></i> Settings
    </div>
    <div v-else ref="settingsRef" :style="{
        left: typeof settingsX === 'number' ? (settingsX + 'px') : '',
        top: typeof settingsY === 'number' ? (settingsY + 'px') : ''
    }" class="settings-parent">

        <div class="settings-navbar">
            <div @click.prevent.left="page = 'general'" :class="page == 'general' ? 'navbar-entry active' : 'navbar-entry'">
                <div class="name">General</div>
                <i class="fa-solid fa-home"></i>
            </div>
            <div @click.prevent.left="page = 'colours'" :class="page == 'colours' ? 'navbar-entry active' : 'navbar-entry'">
                <div class="name">Colours</div>
                <i class="fa-solid fa-palette"></i>
            </div>
        </div>
        <div class="settings-container">
            <div @mousedown.prevent.left="handleMouseDown" class="settings-header">
                <MacCloseButton v-on:click="settingsStore.isOpened = false" />
                Settings
                <i style="position:absolute; left: .5vw;" class="fa-solid fa-gears"></i>
            </div>

            <div class="settings-wrapper" v-if="page == 'general'">
                <div class="setting-entry">
                    <i class="fa-solid fa-map-location"></i>
                    <div class="setting-text">Radar</div>
                    <Toggle on-label="On" off-label="Off" v-model="settingsStore.Settings.displayradar" />
                </div>
                <div class="setting-entry">
                    <i class="fa-solid fa-face-grin-stars"></i>
                    <div class="setting-text">Blur</div>
                    <Toggle on-label="On" off-label="Off" v-model="settingsStore.Settings.blur" />
                </div>
                <div class="setting-entry">
                    <i class="fa-solid fa-video"></i>
                    <div class="setting-text">Screen FX</div>
                    <Toggle on-label="On" off-label="Off" v-model="settingsStore.Settings.screenfx" />
                </div>
                <div class="setting-entry">
                    <i class="fa-solid fa-user"></i>
                    <div class="setting-text">Character</div>
                    <Toggle on-label="On" off-label="Off" v-model="settingsStore.Settings.character" />
                </div>
                <div class="setting-entry">
                    <i class="fa-solid fa-weight-hanging"></i>
                    <div class="setting-text">Item weight</div>
                    <Toggle on-label="On" off-label="Off" v-model="settingsStore.Settings.itemweight" />
                </div>
                <div class="setting-entry">
                    <i class="fa-solid fa-signature"></i>
                    <div class="setting-text">Item name</div>
                    <Toggle on-label="On" off-label="Off" v-model="settingsStore.Settings.itemname" />
                </div>
                <div class="setting-entry">
                    <i class="fa-solid fa-7"></i>
                    <div class="setting-text">Item quantity</div>
                    <Toggle on-label="On" off-label="Off" v-model="settingsStore.Settings.itemquantity" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-database"></i>
                    <div class="setting-text">Clear LocalStorage</div>
                    <div class="setting-description">Clears the LocalStorage. (storing inventory positions)</div>

                    <button class="setting-button" @click.prevent.left="settingsStore.ResetStorage">Reset Storage</button>
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-rotate-left"></i>
                    <div class="setting-text">Reset</div>
                    <div class="setting-description">Fully reset everything to default.</div>

                    <button class="setting-button" @click.prevent.left="settingsStore.Reset">Full Reset</button>
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-save"></i>
                    <div class="setting-text">Export Settings</div>
                    <div class="setting-description">
                        Export your settings and share with others.
                        <br>
                        Press CTRL+A then CTRL+C
                    </div>

                    <div class="inputs-wrapper">
                        <input type="text" :value="JSON.stringify(settingsStore.Settings)">
                    </div>
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-save"></i>
                    <div class="setting-text">Import Settings</div>
                    <div class="setting-description">
                        Paste your settings here.
                        <br>
                        Press CTRL+V
                    </div>

                    <div class="inputs-wrapper">
                        <input type="text" v-model="settingsStore.importSettingsInput">
                    </div>

                    <button class="setting-button" @click.prevent.left="settingsStore.ImportSettings">Import</button>
                </div>
            </div>

            <div class="settings-wrapper" v-if="page == 'colours'">
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Slot Colour (1)</div>

                    <color-picker :disableHistory="true" v-model:pureColor="settingsStore.Settings.slot_colour_1"
                        shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Slot Colour (2)</div>

                    <color-picker :disableHistory="true" v-model:pureColor="settingsStore.Settings.slot_colour_2"
                        shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Weight bar background</div>

                    <color-picker :disableHistory="true" v-model:pureColor="settingsStore.Settings.weight_bar_background"
                        shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Weight bar fill</div>

                    <color-picker :disableHistory="true" v-model:pureColor="settingsStore.Settings.weight_bar_color"
                        shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Item name</div>

                    <color-picker :disableAlpha="true" :disableHistory="true"
                        v-model:pureColor="settingsStore.Settings.item_name_color" shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Item name background</div>

                    <color-picker :disableHistory="true" v-model:pureColor="settingsStore.Settings.item_name_background"
                        shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Item quantity</div>

                    <color-picker :disableAlpha="true" :disableHistory="true"
                        v-model:pureColor="settingsStore.Settings.item_quantity_color" shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Item weight</div>

                    <color-picker :disableAlpha="true" :disableHistory="true"
                        v-model:pureColor="settingsStore.Settings.item_weight_color" shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Item durability</div>

                    <color-picker :disableAlpha="true" :disableHistory="true"
                        v-model:pureColor="settingsStore.Settings.item_durability_color" shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Clothes Colour (1)</div>

                    <color-picker :disableHistory="true"
                        v-model:pureColor="settingsStore.Settings.clothes_background_color_1" shape="circle" />
                </div>
                <div class="setting-entry" style="flex-wrap: wrap;">
                    <i class="fa-solid fa-palette"></i>
                    <div class="setting-text">Clothes Colour (2)</div>

                    <color-picker :disableHistory="true"
                        v-model:pureColor="settingsStore.Settings.clothes_background_color_2" shape="circle" />
                </div>
            </div>
        </div>

    </div>
</template> -->

<script lang="ts" setup>
import { onMounted, ref, watch } from 'vue';
import MacCloseButton from '../components/MacCloseButton.vue';
import { useSettingsStore } from '../store/settings.store';
import "@vueform/toggle/themes/default.scss"
import Toggle from "@vueform/toggle";
import { playAudio } from '../plugins/audio.plugin';

const settingsStore = useSettingsStore();

type PageTypes = "general" | "colours"

const settingsRef = ref<HTMLElement | null>(null);
let isMoving = false;
let offsetX = 0;
let offsetY = 0;
const settingsX = ref<number | null>(null);
const settingsY = ref<number | null>(null);
const page = ref<PageTypes>("general");

onMounted(() => {
    const savedX = localStorage.getItem("settings_savedX");
    const savedY = localStorage.getItem("settings_savedY");
    if (savedX != null && savedY != null) {
        settingsX.value = Number(savedX);
        settingsY.value = Number(savedY);
    }
});

watch(() => settingsStore.isOpened, (newValue) => {
    if (newValue) {
        playAudio("sfx/select.mp3")
    }
});

function handleMouseDown(ev: MouseEvent) {
    if (isMoving) return;
    isMoving = true;
    window.addEventListener("mouseup", handleMouseUp);
    window.addEventListener("mousemove", handleMouseMove);
    const element = settingsRef.value;
    if (element) {
        offsetX = element.offsetLeft + element.offsetWidth - ev.clientX;
        offsetY = element.offsetTop + element.offsetHeight - ev.clientY;
    }
}

function handleMouseUp() {
    isMoving = false;
    window.removeEventListener("mouseup", handleMouseUp);
    window.removeEventListener("mousemove", handleMouseMove);
    if (typeof settingsX.value === 'number' && typeof settingsY.value === 'number') {
        localStorage.setItem("settings_savedX", settingsX.value.toString());
        localStorage.setItem("settings_savedY", settingsY.value.toString());
    }
}

function handleMouseMove(ev: MouseEvent) {
    if (!isMoving) return;
    const element = settingsRef.value;
    if (element) {
        settingsX.value = ev.clientX + offsetX - element.offsetWidth;
        settingsY.value = ev.clientY + offsetY - element.offsetHeight;
    }
}
</script>

<style lang="scss" scoped>
$SETTINGS_BACKGROUND: rgba(25, 25, 25, .85);

.settings-opener-parent {
    position: absolute;
    top: 1.5%;
    left: 1%;
    color: white;
    font-size: .8vw;
    background-color: rgba(0, 0, 0, .55);
    padding: .35vw .6vw;

    i {
        margin-right: .25vw;
    }

    &:hover {
        background-color: lighten(rgba(0, 0, 0, .55), 10%);
    }
}

.settings-parent {
    position: absolute;
    display: flex;
    align-items: flex-start;

    .settings-navbar {
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        background-color: $SETTINGS_BACKGROUND;
        box-shadow: 0 0 .5vw rgba(0, 0, 0, .55);
        border-radius: .5vw;
        margin-right: .35vw;
        margin-top: 2vw;

        .navbar-entry {
            color: rgb(220, 220, 220);
            display: flex;
            justify-content: center;
            align-items: center;

            .name {
                position: absolute;
                font-size: .65vw;
                text-align: right;
                opacity: 0;
                left: -3vw;
                text-align: right;
                transition: ease;
                transition-duration: .25s;
                width: 5vw;
                text-align: right;
            }

            &:hover {
                .name {
                    left: -5.5vw;
                    opacity: 1;
                }

                i {
                    color: white;
                    background-color: rgba(150, 82, 82, 0.85);
                }
            }

            &.active {
                color: white !important;

                .name {
                    opacity: 1;
                    left: -5.5vw
                }

                i {
                    background-color: rgba(180, 81, 81, 0.85);
                }
            }

            i {
                font-size: .85vw;
                margin: .25vw;
                background-color: rgba(150, 82, 82, 0.55);
                border-radius: .25vw;
                padding: .25vw;
            }
        }
    }
}

.settings-container {
    width: 15vw;
    background-color: $SETTINGS_BACKGROUND;
    border-radius: .5vw;
    border: .1vw solid grey;
    box-shadow: 0 0 .5vw rgba(0, 0, 0, .55);
    right: 3%;
    top: 5%;
    z-index: 99999;

    .settings-header {
        position: relative;
        flex: 1;
        text-align: center;
        color: white;
        padding: .5vw 0;
        border-top-left-radius: inherit;
        border-top-right-radius: inherit;
        font-size: .8vw;
        border-bottom: .1vw solid grey;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .settings-wrapper {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: .5vw 0;
        max-height: 30vw;
        overflow: auto;

        .setting-entry {
            width: 80%;
            position: relative;
            color: rgb(220, 220, 220);
            font-size: .75vw;
            margin: .25vw 0;
            display: flex;
            align-items: center;
            background-color: rgba(25, 25, 25, .5);
            border-radius: .25vw;
            padding: .35vw .5vw;
            border-top: .2vw groove transparent;
            border-bottom: .1vw solid transparent;
            justify-content: space-between;

            &:hover {
                background-color: lighten(rgba(25, 25, 25, .5), 10%);
            }

            .setting-button {
                color: white;
                font-size: .65vw;
                border: .1vw solid rgb(175, 175, 175);
                padding: .25vw .5vw;
                border-radius: .15vw;
                margin: .25vw;
                flex: 1;
                text-align: center;
                background: linear-gradient(180deg, rgba(100, 100, 100, 0.2), rgba(65, 65, 65, 0.2));

                &:hover {
                    border: .1vw solid lightgreen;
                }
            }

            .inputs-wrapper {
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
                margin-top: .25vw;
            }

            input {
                position: relative;
                width: 100%;
                border: 0;
                background: transparent;
                outline: 0;
                font-size: .75vw;
                border-radius: 0.15vw;
                color: white;
                text-align: center;
                background: rgba(20, 20, 20, 0.85);
                padding: 0.15vw 0;
                margin-top: .25vw;
                margin-left: .15vw;
                margin-right: .15vw;

                &::placeholder {
                    color: rgb(120, 120, 120);
                    font-size: 0.7vw;
                }

                &::-webkit-inner-spin-button,
                &::-webkit-outer-spin-button {
                    -webkit-appearance: none;
                }
            }

            .slider-wrapper {
                position: relative;
                width: 100%;
                display: flex;
                flex-direction: column;
                padding: 0 .5vw;
                margin-top: .25vw;
                align-items: center;
            }

            i {
                height: 1vw;
                width: 1vw;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .setting-text {
                flex: 1;
                margin-left: .65vw;
                font-size: .7vw;
                margin-right: .25vw;
            }

            .setting-description {
                font-size: .55vw;
                color: grey;
                margin-top: .4vw;
            }
        }
    }
}
</style>