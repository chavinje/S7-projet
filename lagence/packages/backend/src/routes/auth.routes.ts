import { Router } from 'express';
import { authController } from '../controllers/auth.controller';
import { isAuthenticated } from '../middleware/auth.middleware';

const authRouter = Router();

authRouter.post('/register', authController.register);
authRouter.post('/login', authController.login);
authRouter.post('/logout', authController.logout);
authRouter.get('/getMe', isAuthenticated, authController.getMe);

export default authRouter;
