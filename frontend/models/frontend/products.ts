export type ItemType = {
    categoryName: string;
    description: string;
    name: string;
    price: string;
    imageUrl?: string;
}

export type ProductsData = {
    items: ItemType[];
}
