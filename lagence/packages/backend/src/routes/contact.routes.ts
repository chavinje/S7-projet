import { Router } from 'express';
import { contactController } from '../controllers/contact.controller';

const contactRouter = Router();

contactRouter.post('/post', contactController.contact);

export default contactRouter;
