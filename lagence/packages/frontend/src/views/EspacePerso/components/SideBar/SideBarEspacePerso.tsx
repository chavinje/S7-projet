import { useState } from 'react';
import styles from './SideBarEspacePerso.module.css';
import useUserStore from '../../../../user/useUserStore';
import { useNavigate } from 'react-router-dom';
import avatar from '../../../../assets/avatar.png';
import classNames from 'classnames';

type Props = {
  selectedItem: number | 0;
  onItemSelected: (index: number) => void;
};

const tabs = [
  'Informations personnelles',
  'Mon espace locataire',
  'Mes favoris',
  'Mes demandes en cours',
];

const SideBarEspacePerso = (props: Props) => {
  const [isHidden, setIsHidden] = useState(true);
  const { logout, user } = useUserStore();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  const handleTabClick = (index: number) => {
    props.onItemSelected(index);
    setIsHidden(true);
  };

  return (
    <>
      <i
        className={classNames('fa-solid fa-bars', styles.burger)}
        onClick={() => setIsHidden(false)}></i>
      <div className={classNames(styles.sidebar, isHidden && styles.hidden)}>
        <i
          className={classNames('fa-solid fa-xmark', styles.closeSidebar)}
          onClick={() => setIsHidden(true)}></i>
        <div className={styles.profile}>
          <p className={styles.title}>Profile</p>
          <div className={styles.user}>
            <img src={avatar} className={styles.icon} />
            <p className={styles.name}>
              {user?.firstName} {user?.lastName}
            </p>
          </div>
          <p className={styles.logoutButton} onClick={handleLogout}>
            <i className="fa-solid fa-arrow-right-from-bracket"></i>Se
            déconnecter
          </p>
        </div>
        <ul className={styles.tabs}>
          {tabs.map((tab, i) => (
            <li
              className={classNames(
                styles.tab,
                props.selectedItem === i && styles.selected
              )}
              key={i}
              onClick={() => handleTabClick(i)}>
              {tab}
            </li>
          ))}
        </ul>
      </div>
    </>
  );
};

export default SideBarEspacePerso;
