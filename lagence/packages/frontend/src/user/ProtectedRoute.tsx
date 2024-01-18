import { Navigate, Outlet } from 'react-router-dom';
import useUserStore from './useUserStore';
import { useEffect, useState } from 'react';
import { authService } from '../services';

type Props = {};

const ProtectedRoute = (props: Props) => {
  const [loadingUser, setLoadingUser] = useState(true);
  const login = useUserStore((state) => state.login);

  useEffect(() => {
    (async () => {
      const user = await authService.getMe();

      if (user) login(user);
      setLoadingUser(false);
    })();
  }, []);

  const isAuthenticated = useUserStore((state) => state.isAuthenticated);

  if (loadingUser) return null;

  if (!isAuthenticated) return <Navigate to="/login" replace />;

  return <Outlet />;
};

export default ProtectedRoute;
