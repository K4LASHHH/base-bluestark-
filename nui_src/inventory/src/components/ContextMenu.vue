<template>
    <Transition enter-active-class="animate__animated animate__fadeInUp animate__faster"
        leave-active-class="animate__animated animate__fadeOutDown animate__faster">

        <div :key="contextMenuStore.coordX" class="newtooltip-parent" :style="{
                left: contextMenuStore.coordX + 'px',
                top: contextMenuStore.coordY + 'px'
            }" v-if="contextMenuStore.opened">

            <template v-if="contextMenuStore.store?.invItem">
                <div class="newtooltip-header">
                    <div style="display:flex">
                        <div class="newtooltip-header-image-content">
                            <div class="newtooltip-header-image" :style="{
                                    backgroundImage: `url(items/${contextMenuStore.store.invItem.item.name}.png)`
                                }"></div>
                        </div>
                        <div class="newtooltip-header-info-content">
                            <div class="newtooltip-header-info-item-category">
                                {{ contextMenuStore.store.invItem.item.data.category }}
                            </div>
                            <div class="newtooltip-header-info-item-name">
                                {{
                                    contextMenuStore.store.invItem.item.meta.customName ??
                                    contextMenuStore.store.invItem.item.data.label
                                }}
                            </div>
                        </div>
                    </div>
                    <div class="newtooltip-durability-content"
                        v-if="typeof contextMenuStore.store.invItem.item.meta.durability == 'number'">
                        <div class="fill" :style="{
                                    width: (contextMenuStore.store.invItem.item.meta.durability / 100) * 100 + '%',
                                    backgroundColor: settingsStore.Settings.item_durability_color
                                }"></div>
                    </div>
                    <div class="newtooltip-header-description-content"
                        v-if="contextMenuStore.store.invItem.item.data.description">
                        {{ contextMenuStore.store.invItem.item.data.description }}
                    </div>
                </div>

                <div class="newtooltip-infos-content">
                    <div class="info-entry">
                        <div class="question">
                            <i class="fa-solid fa-weight-hanging"></i>
                            Poids
                        </div>
                        <div class="answer">{{ contextMenuStore.store.invItem.item.data.weight }} kg.</div>
                    </div>
                    <div class="info-entry" v-if="typeof contextMenuStore.store.invItem.item.meta.serial == 'string'">
                        <div class="question">
                            <i class="fa-solid fa-hashtag"></i>
                            Numéro de série
                        </div>
                        <div class="answer">{{ contextMenuStore.store.invItem.item.meta.serial }}</div>
                    </div>
                    <div class="info-entry" v-if="typeof contextMenuStore.store.invItem.item.meta.note == 'string'">
                        <div class="question">
                            <i class="fa-solid fa-note-sticky"></i>
                            Note
                        </div>
                        <div class="answer">{{ contextMenuStore.store.invItem.item.meta.note }}</div>
                    </div>
                </div>

                <div class="newtooltip-attachments-content" v-if="contextMenuStore.store.invItem.item.data.weaponHash">
                    <template v-for="index in 5">
                        <template v-if="contextMenuStore.store.invItem.item.meta.attachments?.at(index - 1)">
                            <AttachmentSlot :attachment-index="index"
                                :weapon-item-hash="contextMenuStore.store.invItem.item.itemHash"
                                :unique-id="contextMenuStore.store.invItem.inventoryUniqueID"
                                :attachment-name="contextMenuStore.store.invItem.item.meta.attachments[index - 1]" />
                        </template>
                        <template v-else>
                            <EmptyAttachmentSlot :weapon-item-hash="contextMenuStore.store.invItem.item.itemHash"
                                :unique-id="contextMenuStore.store.invItem.inventoryUniqueID" />
                        </template>
                    </template>
                </div>

                <div class="newtooltip-buttons-content">
                    <button v-if="contextMenuStore.store.invItem.item.data.weaponHash"
                        :class="contextMenuStore.disableClose ? 'active' : ''"
                        @click.prevent.left="contextMenuStore.disableClose = !contextMenuStore.disableClose">Modifier</button>
                    <button @click.prevent.left="Renommer">Renommer</button>
                    <button @click.prevent.left="Note">Note</button>
                </div>
            </template>

            <!-- SHOPITEM -->
            <template v-else-if="contextMenuStore.store?.shopItem">
                <div class="newtooltip-header">
                    <div style="display:flex">
                        <div class="newtooltip-header-image-content">
                            <div class="newtooltip-header-image" :style="{
                                    backgroundImage: `url(items/${contextMenuStore.store.shopItem.item.name}.png)`
                                }"></div>
                        </div>
                        <div class="newtooltip-header-info-content">
                            <div class="newtooltip-header-info-item-category">
                                {{ contextMenuStore.store.shopItem.item.data.category }}
                            </div>
                            <div class="newtooltip-header-info-item-name">
                                {{ contextMenuStore.store.shopItem.item.data.label }}
                            </div>
                        </div>
                    </div>
                    <div class="newtooltip-durability-content"
                        v-if="typeof contextMenuStore.store.shopItem.item.meta.durability == 'number'">
                        <div class="fill" :style="{
                                width: (contextMenuStore.store.shopItem.item.meta.durability / 100) * 100 + '%',
                                backgroundColor: settingsStore.Settings.item_durability_color
                            }"></div>
                    </div>
                    <div class="newtooltip-header-description-content"
                        v-if="contextMenuStore.store.shopItem.item.data.description">
                        {{ contextMenuStore.store.shopItem.item.data.description }}
                    </div>
                </div>

                <div class="newtooltip-infos-content">
                    <div class="info-entry">
                        <div class="question">
                            <i class="fa-solid fa-weight-hanging"></i>
                            Poids
                        </div>
                        <div class="answer">{{ contextMenuStore.store.shopItem.item.data.weight }} kg.</div>
                    </div>
                    <div class="info-entry">
                        <div class="question">
                            <i class="fa-solid fa-dollar-sign"></i>
                            Prix
                        </div>
                        <div class="answer">${{ contextMenuStore.store.shopItem.item.price }} par unité</div>
                    </div>
                    <div class="info-entry" v-if="typeof contextMenuStore.store.shopItem.item.meta.serial == 'string'">
                        <div class="question">
                            <i class="fa-solid fa-hashtag"></i>
                            Numéro de série
                        </div>
                        <div class="answer">{{ contextMenuStore.store.shopItem.item.meta.serial }}</div>
                    </div>
                    <div class="info-entry" v-if="typeof contextMenuStore.store.shopItem.item.meta.note == 'string'">
                        <div class="question">
                            <i class="fa-solid fa-note-sticky"></i>
                            Note
                        </div>
                        <div class="answer">{{ contextMenuStore.store.shopItem.item.meta.note }}</div>
                    </div>
                </div>
            </template>
        </div>
    </Transition>
</template>

<script lang="ts" setup>
import eventPlugin from '../plugins/event.plugin';
import { useContextMenuStore } from '../store/contextmenu.store';
import { useInputStore } from '../store/input.store';
import { useSettingsStore } from '../store/settings.store';
import AttachmentSlot from './AttachmentSlot.vue';
import EmptyAttachmentSlot from './EmptyAttachmentSlot.vue';

const contextMenuStore = useContextMenuStore();
const inputStore = useInputStore();
const settingsStore = useSettingsStore();

function Renommer() {
    if (contextMenuStore.store) {
        const { invItem } = contextMenuStore.store;
        if (!invItem) return;

        inputStore.open({
            hasAccept: true,
            hasCancel: true,
            acceptLabel: 'Accepter',
            cancelLabel: 'Annuler',
            description: `Veuillez saisir le nom personnalisé !`,
            descriptionHtml: true,
            headerLabel: 'Renommer',
            nameInput: invItem.item.meta.customName ?? "",
            acceptCallback: (newName) => {
                eventPlugin.post("RENAME_ITEM", {
                    itemHash: invItem.item.itemHash,
                    uniqueID: invItem.inventoryUniqueID,
                    newName: newName
                });
            }
        })
    }
}

function Note() {
    if (contextMenuStore.store) {
        const { invItem } = contextMenuStore.store;
        if (!invItem) return;

        inputStore.open({
            hasAccept: true,
            hasCancel: true,
            acceptLabel: 'Accepter',
            cancelLabel: 'Annuler',
            description: `Veuillez saisir la note que vous souhaitez ajouter !`,
            descriptionHtml: true,
            headerLabel: 'Note',
            nameInput: invItem.item.meta.note ?? "",
            acceptCallback: (newNote) => {
                eventPlugin.post("ADD_NOTE_ITEM", {
                    itemHash: invItem.item.itemHash,
                    uniqueID: invItem.inventoryUniqueID,
                    newNote: newNote
                });
            }
        })
    }
}
</script>


<style lang="scss">
$textstroke: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;

.newtooltip-parent {
    position: absolute;
    z-index: 99999;
    overflow: hidden;
    background: radial-gradient(circle, rgba(25, 25, 25, .5) 0%, rgba(15, 15, 15, .65) 100%) !important;
    border-radius: .25vw;
    padding: .75vw;
    display: flex;
    flex-direction: column;
    align-items: center;
    max-width: 12vw;

    .newtooltip-attachments-content {
        width: 100%;
        display: flex;
        margin-top: .75vw;

        .newtooltip-attachment-entry {
            position: relative;
            height: 2vw;
            width: 2vw;
            margin: 0 .15vw;
            background: radial-gradient(circle, rgba(25, 25, 25, .5) 0%, rgba(15, 15, 15, .65) 100%) !important;
            border-radius: .25vw;
            display: flex;
            justify-content: center;
            align-items: center;

            .newtooltip-attachment-entry-image {
                height: 80%;
                width: 80%;
                background-position: center;
                background-size: contain;
                background-repeat: no-repeat;
            }
        }
    }

    .newtooltip-buttons-content {
        width: 100%;
        display: flex;
        flex-direction: column;
        margin-top: .75vw;

        button {
            color: white;
            font-size: .65vw;
            border: .1vw solid grey;
            padding: .25vw .5vw;
            border-radius: .15vw;
            margin: .15vw .75vw;
            flex: 1;
            text-align: center;
            background: radial-gradient(circle, rgba(25, 25, 25, .35) 0%, rgba(15, 15, 15, .45) 100%) !important;

            &.active {
                border: .1vw solid lightgreen;
            }

            &:hover {
                border: .1vw solid lightblue;
            }
        }
    }

    .newtooltip-infos-content {
        width: 100%;
        margin-top: 1vw;

        .info-entry {
            margin-bottom: .5vw;

            &:last-child {
                margin-bottom: 0;
            }

            .question {
                display: flex;
                font-size: .65vw;
                color: rgb(220, 220, 220);
                margin-bottom: .25vw;

                i {
                    margin-right: .2vw;
                }
            }

            .answer {
                color: white;
                font-size: .7vw;
            }
        }
    }

    .newtooltip-header {
        width: 100%;

        .newtooltip-durability-content {
            position: relative;
            width: 100%;
            height: .3vw;
            background-color: rgb(15, 15, 15);
            border-radius: .15vw;
            margin: .55vw 0;

            .fill {
                position: relative;
                height: 100%;
                width: 50%;
                border-radius: inherit;
            }
        }

        .newtooltip-header-description-content {
            position: relative;
            color: white;
            font-size: .6vw;
            margin-top: .5vw;
        }

        .newtooltip-header-info-content {
            position: relative;
            display: flex;
            flex-direction: column;
            margin: .55vw;
            justify-content: center;

            .newtooltip-header-info-item-category {
                color: white;
                font-size: .65vw;
            }

            .newtooltip-header-info-item-name {
                color: white;
                font-size: .8vw;
                font-weight: bold;
            }
        }

        .newtooltip-header-image-content {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 4vw;
            height: 4vw;
            background: radial-gradient(circle, rgba(25, 25, 25, .55) 0%, rgba(15, 15, 15, .65) 100%) !important;
            border-radius: .25vw;
            // border: .1vw solid grey;

            .newtooltip-header-image {
                height: 80%;
                width: 80%;
                background-position: center;
                background-size: contain;
                background-repeat: no-repeat;
            }
        }

    }
}
</style>