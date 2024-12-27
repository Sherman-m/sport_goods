import {Catalog} from "./components/Catalog";
import {useCallback, useRef, useState} from "react";

import SportGoods from './assets/icons/sport-goods.svg';
import ContactUs from './assets/icons/contact-us.svg';
import axios from "axios";
import 'reactjs-popup/dist/index.css';
import {SuccessPopup} from "./components/SuccessPopup";

export const App = () => {
    const [email, setEmail] = useState('');
    const [name, setName] = useState('');
    const [phone, setPhone] = useState('');
    const [showModal, setShowModal] = useState(false);
    const [showError, setShowError] = useState(false);

    const contentRef = useRef<HTMLDivElement>(null);
    const buyingSectionRef = useRef<HTMLDivElement>(null);

    const handleChangeEmail = (e: React.ChangeEvent<HTMLInputElement>) => {
        setEmail(e.target.value);
    }

    const handleChangeName = (e: React.ChangeEvent<HTMLInputElement>) => {
        setName(e.target.value);
    }

    const handleChangePhone = (e: React.ChangeEvent<HTMLInputElement>) => {
        setPhone(e.target.value);
    }

    const handleSubmit = useCallback((e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();

        if (!!email && !!name && !!phone) {
            axios.post('/v1/orders', {
                email,
                name,
                phone
            }).then(() => {
                setShowError(false);
                setShowModal(true);
                setEmail('');
                setName('');
                setPhone('');
            })
        } else {
            setShowError(true)
        }
    }, [email, name, phone])

    return (
        <div className="content" ref={contentRef}>
            <header className="header">
                <div className="container">
                    <div className="header__inner">
                        <h1 className="header__logo">Sport<span className="header__logo-highlight">ix</span></h1>
                        <nav className="header__menu">
                            <ul className="header__menu-list">
                                <li className="header__menu-item">
                                    <a className="header__menu-link" href="#" data-link="home">Начало</a>
                                </li>
                                <li className="header__menu-item">
                                    <a className="header__menu-link" href="#" data-link="goods">Каталог</a>
                                </li>
                                <li className="header__menu-item">
                                    <a className="header__menu-link" href="#" data-link="buying">Оформление заказа</a>
                                </li>
                            </ul>
                        </nav>
                        <h1 className="header__logo"></h1>
                    </div>
                </div>
            </header>

            <main className="main">
                <section className="intro" id="home">
                    <div className="container">
                        <div className="intro__inner">
                            <div className="intro__content">
                                <div className="intro__logo-container">
                                    <h2 className="intro__logo title">Интернет-магазин товаров для спорта</h2>
                                </div>
                                <p className="intro__text text text--color-gray">
                                    Компания Sportix является лидером рынка продажи
                                    спорт-товаров.
                                    Широкий ассортимент от мировых производителей
                                    Постоянное обновление ассортимента
                                    Прямые поставки от производителя
                                </p>
                                <button className="intro__button button button--color-gray"
                                        id="main-action-button">Перейти к покупкам!
                                </button>
                            </div>
                            <div className="intro__image-container">
                                <img
                                    className="intro__image"
                                    src={SportGoods}
                                    alt=""
                                    width="600" height="600"
                                />
                            </div>
                        </div>
                    </div>
                </section>

                <Catalog sectionRef={buyingSectionRef}/>

                <section className="orders" id="buying" ref={buyingSectionRef}>
                    <div className="container">
                        <h2 className="orders__logo title">Оформление заказа</h2>
                        <div className="orders__inner">
                            <div className="orders__image-container">
                                <img
                                    className="orders__image"
                                    src={ContactUs}
                                    alt=""
                                    width="477" height="429"
                                />
                            </div>
                            <div className="orders__content">

                                <form className="orders__form" onSubmit={handleSubmit}>
                                    <p className="orders__text text text--color-gray">Заполните все данные и наш
                                        менеджер свяжется с Вами для подтверждения заказа</p>
                                    <div className="orders__form-inputs">
                                        <div className="order__form-input">
                                            <input className="orders__input" id="email" type="text"
                                                   placeholder="Ваш e-mail" value={email} onChange={handleChangeEmail}/>
                                        </div>

                                        <div className="order__form-input">
                                            <input className="orders__input" id="name" type="text"
                                                   placeholder="Ваше имя" value={name} onChange={handleChangeName}/>
                                        </div>

                                        <div className="order__form-input">
                                            <input className="orders__input" id="phone" type="text"
                                                   placeholder="Ваш телефон" value={phone}
                                                   onChange={handleChangePhone}/>
                                        </div>
                                        <button className="orders__button button button--color-gray"
                                                type="submit">Оформить заказ
                                        </button>
                                        <span
                                            className="error__text">{showError ? "Нужно заполнить все поля." : null}</span>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>

            </main>

            <footer className="footer">
                <div className="container">
                    <div className="footer__wrapper">
                        <h1 className="footer__logo">Sport<span className="footer__logo-highlight">ix</span></h1>
                        <nav>
                            <ul className="footer__list">
                                <li className="footer__item">
                                    <a href="#" className="footer__link">Все права защищены</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </footer>
            <SuccessPopup open={showModal} onClose={() => setShowModal(false)}/>
        </div>
    )
}
