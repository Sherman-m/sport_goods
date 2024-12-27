import styles from './Popup.module.css';
import Popup from 'reactjs-popup';

type Props = {
    open: boolean;
    onClose: () => void
}

export const SuccessPopup = ({open, onClose}: Props) => {
    return (
        <Popup contentStyle={{background: 'transparent', border: 'unset'}} open={open} modal onClose={onClose}>
            <div className={styles.root}>
                <span className={styles.title}>Заявка отправлена!</span>
                <span className={styles.description}>Наш менеджер свяжется с вами в ближайшее время.</span>
            </div>
        </Popup>
    )
}
