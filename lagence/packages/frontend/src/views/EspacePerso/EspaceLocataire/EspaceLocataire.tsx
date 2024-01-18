import React from 'react';
import styles from './EspaceLocataire.module.css';

const EspaceLocataire: React.FC = () => {
  return (
    <div className={styles.tenantSpace}>
      <h1 className={styles.title}>Espace Locataire</h1>
    </div>
  );
};

export default EspaceLocataire;
