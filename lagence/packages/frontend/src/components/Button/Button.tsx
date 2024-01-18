import styles from './styles.module.scss';
import classNames from 'classnames';
import Lotties from '../Lotties/Lotties';

type Props = {
  value: string;
  type: 'primary' | 'secondary';
  actionType?: 'button' | 'submit';
  loading?: boolean;
  icon?: React.ReactNode;
  className?: string;
  onClick?: () => void;
  disabled?: boolean;
};

function Button(props: Props) {
  return (
    <button
      type={props.actionType ?? 'button'}
      onClick={!props.loading ? props.onClick : undefined}
      disabled={props.loading || props.disabled}
      className={classNames(
        props.type === 'primary' ? styles.primary : styles.secondary,
        styles.button,
        props.className
      )}>
      {props.icon && <div className={styles.icon}>{props.icon}</div>}
      <p style={props.loading ? { opacity: 0 } : { opacity: 1 }}>
        {props.value}
      </p>
      {props.loading && (
        <div className={styles.loading}>
          <Lotties type="loading" width="45px" />
        </div>
      )}
    </button>
  );
}

export default Button;
