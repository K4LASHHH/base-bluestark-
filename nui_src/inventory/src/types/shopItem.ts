import { I_ItemData, I_ItemMetaData } from "./item";

export interface I_ShopItem {
    name: string;
    meta: I_ItemMetaData;
    data: Partial<I_ItemData>;
    price: number;
}