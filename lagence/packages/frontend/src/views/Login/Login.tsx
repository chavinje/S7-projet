import styles from './styles.module.scss';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { UserCredentials, authService } from '../../services';
import { Navigate, useNavigate } from 'react-router-dom';
import useUserStore from '../../user/useUserStore';
import Button from '../../components/Button/Button';
import Input from '../../components/Input/Input';
import { z } from 'zod';
import { useState } from 'react';
import toast, { Toaster } from 'react-hot-toast';

type Props = {};

const loginValidation = z.object({
  email: z
    .string()
    .min(1, { message: `L'email est requis.` })
    .email({ message: `L'email n'est pas valide.` }),
  password: z.string().min(1, { message: `Le mot de passe est requis.` }),
});

type LoginForm = z.infer<typeof loginValidation>;

const Login = (props: Props) => {
  const navigate = useNavigate();
  const { login, isAuthenticated } = useUserStore();
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<LoginForm>({
    resolver: zodResolver(loginValidation),
  });
  const [loading, setLoading] = useState(false);

  const handleLogin = async (credentials: UserCredentials) => {
    if (credentials) {
      setLoading(true);
      const user = await authService.login(credentials);
      setLoading(false);
      if (user) {
        login(user);
        navigate('/my-account');
      } else {
        toast.error('Identifiants incorrects.');
      }
    } else {
      console.log('no credentials');
    }
  };

  const onSubmit = handleSubmit((data) => {
    return handleLogin(data);
  });
  if (isAuthenticated) return <Navigate to={'/my-account'} />;

  return (
    <div className={styles.login}>
      <h1 className={styles.title}>Connexion</h1>

      <form onSubmit={onSubmit} className={styles.form}>
        <Input
          type="email"
          placeholder="Email"
          {...register('email')}
          errorMsg={errors.email?.message}
        />
        <Input
          type="password"
          placeholder="Mot de passe"
          {...register('password')}
          errorMsg={errors.password?.message}
        />
        <Button
          type="primary"
          actionType="submit"
          value="Se connecter"
          loading={loading}
        />
        <p className={styles.alreadyAccount}>
          {' '}
          Pas de compte ?{' '}
          <span className={styles.link} onClick={() => navigate('/register')}>
            Créer mon compte
          </span>
        </p>
      </form>
    </div>
  );
};

export default Login;
