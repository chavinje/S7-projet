import React from 'react';
import styles from './MesFavoris.module.css';

const MesFavoris: React.FC = () => {
  return (
    <div className={styles.favourites}>
      <h1 className={styles.title}>Mes Favoris</h1>
    </div>
  );
};

export default MesFavoris;
