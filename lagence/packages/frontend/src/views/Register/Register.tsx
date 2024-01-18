import styles from './styles.module.scss';
import { Navigate, useNavigate } from 'react-router-dom';
import useUserStore from '../../user/useUserStore';
import { useState } from 'react';
import { UserRegisteration, authService } from '../../services';
import Input from '../../components/Input/Input';
import Button from '../../components/Button/Button';
import { useForm } from 'react-hook-form';
import { z } from 'zod';
import { zodResolver } from '@hookform/resolvers/zod';
import toast, { Toaster } from 'react-hot-toast';

type Props = {};

const registerValidation = z
  .object({
    firstName: z.string().min(1, { message: 'Le prénom est requis.' }),
    lastName: z.string().min(1, { message: 'Le nom est requis.' }),
    email: z.string().min(1, { message: `L'email est requis.` }).email({
      message: `L'email n'est pas valide.`,
    }),
    password: z.string().min(6, {
      message: 'Le mot de passe doit contenir au moins 6 caractères.',
    }),
    confirmPassword: z
      .string()
      .min(1, { message: 'Le mot de passe de confirmation est requis.' }),
  })
  .refine((data) => data.password === data.confirmPassword, {
    path: ['confirmPassword'],
    message: 'Les mots de passes ne correspondent pas.',
  });

type RegisterForm = z.infer<typeof registerValidation>;

const Register = (props: Props) => {
  const navigate = useNavigate();
  const { login, isAuthenticated } = useUserStore();
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<RegisterForm>({ resolver: zodResolver(registerValidation) });
  const [loading, setLoading] = useState(false);

  const handleRegister = (user: UserRegisteration) => {
    setLoading(true);
    authService
      .register(user)
      .then((res) => {
        if (res.data.user) {
          toast.success('Bienvenue ' + res.data.user.firstName);
          login(res.data.user);
          navigate('/my-account');
        } else {
          toast.error('Erreur.');
        }
      })
      .catch((err) => {
        if (err.response.data.status)
          toast.error('Adresse mail déjà utilisée.');
      })
      .finally(() => setLoading(false));
  };

  const onSubmit = handleSubmit((data) => {
    return handleRegister(data);
  });

  if (isAuthenticated) return <Navigate to={'/my-account'} />;
  return (
    <div className={styles.login}>
      <h1 className={styles.title}>Créer mon compte</h1>

      <form onSubmit={onSubmit} className={styles.form}>
        <Input
          type="text"
          placeholder="Prénom"
          {...register('firstName')}
          errorMsg={errors.firstName?.message}
        />
        <Input
          type="text"
          placeholder="Nom"
          {...register('lastName')}
          errorMsg={errors.lastName?.message}
        />
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
        <Input
          type="password"
          placeholder="Confirmer le mot de passe"
          {...register('confirmPassword')}
          errorMsg={errors.confirmPassword?.message}
        />
        <Button
          type="primary"
          actionType="submit"
          value="Valider"
          loading={loading}
        />
        <p className={styles.alreadyAccount}>
          {' '}
          Déjà un compte ?{' '}
          <span className={styles.link} onClick={() => navigate('/login')}>
            Se connecter
          </span>
        </p>
      </form>
    </div>
  );
};

export default Register;
