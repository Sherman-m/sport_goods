export type MainPageItem = {
    category_name: string;
    description: string;
    name: string;
    price: string;
    image_url?: string;
}

export type MainPageProductsOut = {
    items: MainPageItem[];
}
