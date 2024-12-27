import {MainPageItem, MainPageProductsOut} from "../models/backend/products";
import {ItemType, ProductsData} from "../models/frontend/products";

const parseItem = (item: MainPageItem): ItemType => ({
    categoryName: item.category_name,
    description: item.description,
    name: item.name,
    price: item.price,
    imageUrl: item.image_url
})

export const parseProducts = (data: MainPageProductsOut): ProductsData => ({
    items: data.items.map(parseItem)
})
