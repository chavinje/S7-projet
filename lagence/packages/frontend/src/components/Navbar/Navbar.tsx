import { Link, useNavigate } from 'react-router-dom';
import './navbar.scss';
import Button from '../Button/Button';
import logo from '../../assets/l-agence_logo.png';

const Navbar = () => {
  const navigate = useNavigate();
  return (
    <div className="navbar">
      <Link to={'/'} className="logo">
        <img src={logo} alt="" />

        <span className="name">L'agence</span>
      </Link>
      <div className="links">
        <Link to={'/properties'} className="item">
          Nos biens
        </Link>
        <Link to={'/contact'} className="item">
          Contact
        </Link>
      </div>
      <Button
        value="Mon compte"
        type="primary"
        onClick={() => navigate('/my-account')}
        icon={<i className="fa-solid fa-user" />}
      />
    </div>
  );
};

export default Navbar;
