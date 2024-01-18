import axios from 'axios';
import useUserStore from '../user/useUserStore';
import toast from 'react-hot-toast';
import { CONFIG } from '../utils/config';

export const axiosClient = axios.create({
  baseURL: CONFIG.API_URL,
  withCredentials: true,
});

axiosClient.interceptors.response.use(null, (err) => {
  const { isAuthenticated, logout } = useUserStore.getState();

  if (err.response?.status === 401 && isAuthenticated) {
    logout();
  }
  if (err.response?.status === 403 && isAuthenticated) {
    toast.error("Vous n'êtes autorisé à faire cela");
  }
  return Promise.reject(err);
});

export * from './auth.service';
export * from './property.service';
