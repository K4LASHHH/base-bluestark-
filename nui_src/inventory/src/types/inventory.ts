import { I_Item } from "./item";

export interface I_Inventory {
    uniqueID: string;
    inventoryName: string;
    slotsAmount: number;
    items: I_Item[];
    isFrisk?: boolean;
    isLocal?: boolean;
    maxWeight: number;
}