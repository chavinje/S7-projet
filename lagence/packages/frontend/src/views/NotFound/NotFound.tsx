import styles from './styles.module.scss';
import { useNavigate } from 'react-router-dom';
import notFound from '../../assets/404.png';
import Button from '../../components/Button/Button';
const NotFound = () => {
  const navigate = useNavigate();
  return (
    <div className={styles.notFound}>
      <img src={notFound} />
      <h1 className={styles.title}>404</h1>
      <h2 className={styles.message}>Cette page n'existe pas</h2>
      <Button
        value="Retourner à l'accueil"
        type="primary"
        onClick={() => navigate('/')}
      />
    </div>
  );
};

export default NotFound;
