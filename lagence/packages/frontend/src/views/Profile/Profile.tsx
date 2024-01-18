import { useNavigate } from 'react-router-dom';
import useUserStore from '../../user/useUserStore';

type Props = {};

function Profile({}: Props) {
  const { logout } = useUserStore();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };
  return (
    <div>
      Profile <button onClick={handleLogout}>Logout</button>
    </div>
  );
}

export default Profile;
