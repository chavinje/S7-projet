import { Router } from 'express';
import { isAdmin, isAuthenticated } from '../middleware/auth.middleware';
import { propertyController } from '../controllers/property.controller';
import { uploadMiddleware } from '../utils/file';

const propertyRouter = Router();

propertyRouter.get('/', propertyController.getAll);

propertyRouter.post(
  '/',
  isAuthenticated,
  isAdmin,
  uploadMiddleware.array('images', 10),
  propertyController.create
);
propertyRouter.put('/', isAuthenticated, isAdmin, propertyController.update);
propertyRouter.delete(
  '/:id',
  isAuthenticated,
  isAdmin,
  propertyController.remove
);

export default propertyRouter;
