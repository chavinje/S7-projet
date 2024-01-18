import React from 'react';
import styles from './DemandesEnCours.module.css';

const DemandesEnCours: React.FC = () => {
  return (
    <div className={styles.ongoingRequests}>
      <h1 className={styles.title}>Demandes en Cours</h1>
    </div>
  );
};

export default DemandesEnCours;
