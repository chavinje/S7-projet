import classNames from 'classnames';
import styles from './Checkbox.module.scss';

type Props = {
  checked?: boolean;
  label?: string | React.ReactNode;
  onCheck?: (value: boolean) => void;
  className?: string;
};

const Checkbox = ({ checked, label, onCheck, className }: Props) => {
  return (
    <div className={classNames(styles.container, className)}>
      <label>
        <input
          className={styles.input}
          type="checkbox"
          checked={checked}
          onChange={() => onCheck && onCheck(!checked)}
        />
        <i className={classNames('fa-solid fa-check', styles.icon)} />
        <span className={styles.label}>{label}</span>
      </label>
    </div>
  );
};

export default Checkbox;
