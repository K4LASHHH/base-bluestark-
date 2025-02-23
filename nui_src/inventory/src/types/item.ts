export interface I_ItemData {
    label: string;
    tradable: boolean;
    deletable: boolean;
    stackable: boolean;
    description: string;
    weight: number;
    usable: boolean;
    weaponHash: number;
    category: string;
}

export interface I_Item {
    name: string;
    quantity: number;
    slot: number;
    itemHash: string;
    meta: I_ItemMetaData;
    data: Partial<I_ItemData>;
}

export interface I_ItemMetaData {
    durability?: number;
    note?: string;
    customName?: string;
    serial?: string;
    attachments?: string[];
}