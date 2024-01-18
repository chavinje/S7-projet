import { Link } from 'react-router-dom';
import styles from './Breadcrumb.module.scss';

type Props = {
  paths: { name: string; path: string }[];
};

const Breadcrumb = (props: Props) => {
  return (
    <div className={styles.breadcrumb}>
      {props.paths.map((breadcrumbPath, index) => (
        <div key={breadcrumbPath.path}>
          {/* If last use span otherwise Link */}
          {props.paths.length - 1 - index > 0 ? (
            <Link className={styles.path} to={breadcrumbPath.path}>
              {breadcrumbPath.name}
            </Link>
          ) : (
            <span className={styles.path}>{breadcrumbPath.name}</span>
          )}
          {props.paths.length - 1 - index > 0 && <span>{'>'}</span>}
        </div>
      ))}
    </div>
  );
};

export default Breadcrumb;
