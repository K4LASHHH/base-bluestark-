GM.Shop = GM.Shop or {}

GM.Shop.List = {
    {
        name = "shop_1",
        shopName = "Shop 1",
        position = vector3(26.885562896729,-1346.6772460938,29.496976852417),
        helpNotification = "pour accéder à l'épicerie",
        ped = {
            model = GetHashKey("a_m_m_soucent_02"),
            position = vector3(24.524868011475,-1345.9040527344,29.496967315674),
            heading = 266.45
        },
        items = {
            {
                name = "hamburger",
                price = 30,
                meta = {
                    --grade = 0,
                }
            },
        }
    },
}