import { defineStore } from "pinia";
import { ref, watch } from "vue";
import eventPlugin from "../plugins/event.plugin";

interface SettingsState {
    displayradar: boolean;
    itemweight: boolean;
    itemname: boolean;
    itemquantity: boolean;
    blur: boolean;
    screenfx: boolean;
    character: boolean;
    slot_colour_1: string;
    slot_colour_2: string;
    weight_bar_background: string;
    weight_bar_color: string;
    item_name_color: string;
    item_name_background: string;
    item_quantity_color: string;
    item_weight_color: string;
    item_durability_color: string;
    clothes_background_color_1: string;
    clothes_background_color_2: string;
}

export const useSettingsStore = defineStore("SettingsStore", () => {

    const isOpened = ref(false);

    const DEFAULTS: SettingsState = {
        displayradar: false,
        itemweight: true,
        itemname: true,
        itemquantity: true,
        blur: true,
        screenfx: false,
        character: true,
        slot_colour_1: "rgba(25, 25, 25, .5)",
        slot_colour_2: "rgba(15, 15, 15, .65)",
        weight_bar_background: "rgba(220, 220, 220, .65)",
        weight_bar_color: "rgba(21, 165, 248, 0.61)",
        item_name_color: "rgb(220, 220, 220)",
        item_name_background: "rgba(25, 25, 25, .55)",
        item_quantity_color: "rgb(185, 185, 185)",
        item_weight_color: "rgb(185, 185, 185)",
        item_durability_color: "rgb(144, 238, 144)",
        clothes_background_color_1: "rgba(25, 25, 25, .5)",
        clothes_background_color_2: "rgba(15, 15, 15, .65)"
    }

    const Settings = ref<SettingsState>({
        displayradar: DEFAULTS.displayradar,
        itemweight: DEFAULTS.itemweight,
        itemname: DEFAULTS.itemname,
        itemquantity: DEFAULTS.itemquantity,
        blur: DEFAULTS.blur,
        screenfx: DEFAULTS.screenfx,
        character: DEFAULTS.character,
        slot_colour_1: DEFAULTS.slot_colour_1,
        slot_colour_2: DEFAULTS.slot_colour_2,
        weight_bar_background: DEFAULTS.weight_bar_background,
        weight_bar_color: DEFAULTS.weight_bar_color,
        item_name_color: DEFAULTS.item_name_color,
        item_name_background: DEFAULTS.item_name_background,
        item_quantity_color: DEFAULTS.item_quantity_color,
        item_weight_color: DEFAULTS.item_weight_color,
        item_durability_color: DEFAULTS.item_durability_color,
        clothes_background_color_1: DEFAULTS.clothes_background_color_1,
        clothes_background_color_2: DEFAULTS.clothes_background_color_2
    });

    const importSettingsInput = ref("");

    function applyBooleanSetting(storageName: string, storeName: string, defaultValue: boolean) {
        const local = localStorage.getItem(storageName);
        // @ts-ignore
        if (local == 'true') Settings.value[storeName] = true;
        // @ts-ignore
        else if (local == 'false') Settings.value[storeName] = false;
        // @ts-ignore
        else Settings.value[storeName] = defaultValue;
    }

    function applyNumberSetting(storageName: string, storeName: string, defaultValue: number) {
        const local = localStorage.getItem(storageName);
        // @ts-ignore
        if (local != null) Settings.value[storeName] = Number(local);
        // @ts-ignore
        else Settings.value[storeName] = defaultValue;
    }

    function applyStringSetting(storageName: string, storeName: string, defaultValue: string) {
        const local = localStorage.getItem(storageName);
        // @ts-ignore
        if (local != null) Settings.value[storeName] = local;
        // @ts-ignore
        else Settings.value[storeName] = defaultValue;
    }

    function createNumberWatcher(key: keyof SettingsState, defaultValue: any) {
        const keyLocalStr = "settings_" + key;

        watch(() => Settings.value[key], (newValue, oldValue) => {
            if (oldValue == undefined) {
                applyNumberSetting(keyLocalStr, key, defaultValue);
            }
            else {
                localStorage.setItem(keyLocalStr, newValue.toString());
            }
        }, { immediate: true });
    }

    function createBooleanWatcher(key: keyof SettingsState, defaultValue: any, cb?: (newValue: any) => void) {
        const keyLocalStr = "settings_" + key;

        watch(() => Settings.value[key], (newValue, oldValue) => {
            if (oldValue == undefined) {
                applyBooleanSetting(keyLocalStr, key, defaultValue);
            }
            else {
                localStorage.setItem(keyLocalStr, newValue.toString());
            }

            if (typeof cb === 'function') {
                cb(newValue);
            }
        }, { immediate: true });
    }

    function createStringWatcher(key: keyof SettingsState, defaultValue: string) {
        const keyLocalStr = "settings_" + key;

        watch(() => Settings.value[key], (newValue, oldValue) => {
            if (oldValue == undefined) {
                applyStringSetting(keyLocalStr, key, defaultValue);
            }
            else {
                localStorage.setItem(keyLocalStr, newValue.toString());
            }
        }, { immediate: true });
    }

    function Reset() {
        localStorage.clear();

        for (const key in Settings.value) {
            // @ts-ignore
            if (DEFAULTS[key] != undefined) {
                //@ts-ignore
                Settings.value[key] = DEFAULTS[key];
            }
        }
    }

    function ResetStorage() {
        localStorage.clear();
    }

    function ImportSettings() {
        try {
            const decode: SettingsState = JSON.parse(importSettingsInput.value);
            Object.entries(decode).forEach(([key, value]) => {
                // @ts-ignore
                if (typeof Settings.value[key] !== 'undefined') {
                    // @ts-ignore
                    Settings.value[key] = value;
                }
            });
        }
        catch (err) {

        }
    }

    // NUMBER

    // BOOLEAN
    createBooleanWatcher("displayradar", DEFAULTS.displayradar, (newValue) => {
        eventPlugin.post("SETTINGS_RADAR_ENABLED", newValue);
    });
    createBooleanWatcher("screenfx", DEFAULTS.screenfx, (newValue) => {
        eventPlugin.post("SETTINGS_SCREENFX_ENABLED", newValue)
    });
    createBooleanWatcher("blur", DEFAULTS.blur, (newValue) => {
        eventPlugin.post("SETTINGS_BLUR_ENABLED", newValue);
    });
    createBooleanWatcher("character", DEFAULTS.character, (newValue) => {
        eventPlugin.post("SETTINGS_CHARACTER_ENABLED", newValue);
    });
    createBooleanWatcher("itemname", DEFAULTS.itemname);
    createBooleanWatcher("itemweight", DEFAULTS.itemweight);
    createBooleanWatcher("itemquantity", DEFAULTS.itemquantity);

    // STRING
    createStringWatcher("slot_colour_1", DEFAULTS.slot_colour_1);
    createStringWatcher("slot_colour_2", DEFAULTS.slot_colour_2);

    createStringWatcher("weight_bar_background", DEFAULTS.weight_bar_background);
    createStringWatcher("weight_bar_color", DEFAULTS.weight_bar_color);

    createStringWatcher("item_name_color", DEFAULTS.item_name_color);
    createStringWatcher("item_name_background", DEFAULTS.item_name_background);
    createStringWatcher("item_quantity_color", DEFAULTS.item_quantity_color);
    createStringWatcher("item_weight_color", DEFAULTS.item_weight_color);
    createStringWatcher("item_durability_color", DEFAULTS.item_durability_color);

    createStringWatcher("clothes_background_color_1", DEFAULTS.clothes_background_color_1);
    createStringWatcher("clothes_background_color_2", DEFAULTS.clothes_background_color_2);

    return {
        isOpened,
        Settings,
        ResetStorage,
        Reset,
        ImportSettings,
        importSettingsInput
    }
});