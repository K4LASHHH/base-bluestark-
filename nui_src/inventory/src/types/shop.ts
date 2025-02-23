import { I_ShopItem } from "./shopItem";

export interface I_ShopInventory {
    shopId: string;
    shopName: string;
    items: I_ShopItem[];
}