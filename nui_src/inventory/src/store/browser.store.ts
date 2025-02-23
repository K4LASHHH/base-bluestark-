import { defineStore } from 'pinia';

export const useBrowserStore = defineStore("BrowserStore", () => {
    function openUrl(url: string) {
        window.open(url, '_blank');
    }

    return { openUrl }
});

window.addEventListener("message", (ev: MessageEvent) => {
    const store = useBrowserStore();

    switch (ev.data.event) {
        case "BROWSER_OPEN":
            store.openUrl(ev.data.url)
            break;
    }
});