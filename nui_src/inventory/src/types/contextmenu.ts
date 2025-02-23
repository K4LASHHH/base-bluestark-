import { I_Item } from "./item";
import { I_ShopItem } from "./shopItem";

export interface I_ContextMenu {
    invItem?: {
        item: I_Item;
        inventoryUniqueID: string;
    }
    shopItem?: {
        item: I_ShopItem;
        shopId: string;
    }
}