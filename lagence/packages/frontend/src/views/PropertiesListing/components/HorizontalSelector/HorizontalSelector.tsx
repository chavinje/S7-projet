import styles from './HorizontalSelector.module.scss';

type Option<T> = {
  id: T;
  label: string;
};

type Props<T> = {
  options: readonly Option<T>[];
  onChange: (value: T) => void;
  value: T;
};

const HorizontalSelector = <T extends string>(props: Props<T>) => {
  return (
    <div className={styles.selector}>
      {props.options.map((option) => (
        <div key={option.id} className={styles.selection}>
          <input
            checked={props.value === option.id}
            id={option.id}
            onChange={() => props.onChange(option.id)}
            type="radio"
          />
          <label htmlFor={option.id}>{option.label}</label>
        </div>
      ))}
    </div>
  );
};

export default HorizontalSelector;
