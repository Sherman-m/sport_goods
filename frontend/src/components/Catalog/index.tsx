import {useEffect, useState} from "react";
import axios from 'axios';
import {MainPageProductsOut} from "../../../models/backend/products.ts";
import {parseProducts} from "../../../parsers/products.ts";
import {ItemType} from "../../../models/frontend/products.ts";
import {Item} from "../Item";

type Props = {
    sectionRef: React.RefObject<HTMLDivElement>
}

export const Catalog = ({sectionRef}: Props) => {
    const [products, setProducts] = useState<ItemType[]>();

    useEffect(() => {
        axios.get<MainPageProductsOut>('/v1/products').then((response) => {
            const data = parseProducts(response.data)

            setProducts(data.items)
        });
    }, []);

    return (
        <section className="catalog" id="goods">
            <div className="container">
                <h2 className="items__logo title">Каталог</h2>
                <div className="items__inner">
                    <div className="items__content">
                        {products?.map((item) => (
                            <Item key={item.name} {...item} sectionRef={sectionRef} />
                        ))}
                    </div>
                </div>
            </div>
        </section>
    )
}
