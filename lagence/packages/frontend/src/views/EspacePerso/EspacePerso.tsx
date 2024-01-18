import React, { useState } from 'react';
import styles from './EspacePerso.module.css';
import SideBar from './components/SideBar/SideBarEspacePerso';
import InformationsPerso from './InformationsPerso/InformationsPerso';
import EspaceLocataire from './EspaceLocataire/EspaceLocataire';
import MesFavoris from './MesFavoris/MesFavoris';
import DemandesEnCours from './DemandesEnCours/DemandesEnCours';

const EspacePerso: React.FC = () => {
  const [selectedItem, setSelectedItem] = useState(0);

  const handleItemClick = (index: number) => {
    setSelectedItem(index);
  };

  const renderTabView = () => {
    switch (selectedItem) {
      case 0:
        return <InformationsPerso />;
      case 1:
        return <EspaceLocataire />;
      case 2:
        return <MesFavoris />;
      case 3:
        return <DemandesEnCours />;
      default:
        return <InformationsPerso />;
    }
  };

  return (
    <div className={styles.espacePerso}>
      <SideBar selectedItem={selectedItem} onItemSelected={handleItemClick} />
      {renderTabView()}
    </div>
  );
};

export default EspacePerso;
