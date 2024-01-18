import { Router } from 'express';
import { isAuthenticated } from '../middleware/auth.middleware';
import { userController } from '../controllers/user.controller';

const userRouter = Router();

userRouter.post('/favourites', isAuthenticated, userController.addFavourites);
userRouter.delete('/favourites/:propertyId', isAuthenticated, userController.removeFavourites);
userRouter.get('/favourites',isAuthenticated, userController.getFavourites)

export default userRouter;
