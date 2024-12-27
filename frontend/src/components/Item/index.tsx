import {ItemType} from "../../../models/frontend/products.ts";

import styles from './Item.module.css';

import PlaceholderImage from '../../assets/icons/writing.svg';

type Props = ItemType & {
    sectionRef: React.RefObject<HTMLDivElement>
}

export const Item = ({name, description, price, imageUrl, sectionRef}: Props) => {
    const handleButtonClick = () => {
        sectionRef.current?.scrollIntoView({
            behavior: "smooth"
        })
    }

    return (
        <div className={styles.item}>
            <img
                className={styles.image}
                src={imageUrl ? imageUrl : PlaceholderImage}
                alt=""
                width="293" height="293"
            />
            <div className={styles.content}>
                <span className={styles.title}>{name}</span>
                <span className={styles.description}>
                    {description}
                </span>
                <div className={styles.buttonContainer}>
                    <span className={styles.price}>{price} ₽</span>
                    <button className={styles.button} onClick={handleButtonClick}>Заказать</button>
                </div>
            </div>
        </div>
    )
}
