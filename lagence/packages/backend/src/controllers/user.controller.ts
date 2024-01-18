import { userService } from '../services/user.service';
import { UserRequest } from '../types/express';
import { Response } from 'express';
import { User } from '../models/User'
import { Property } from '../models/Property'

const getFavourites = async (req: UserRequest, res: Response) => {
    const favourites = await userService.getFavourites(req.user.id)

    res.json(favourites)
}

const addFavourites = async (req: UserRequest, res: Response) => {
    const { propertyId } = req.body;

    const userId = req.user.id

    const { user, property } = await userService.addFavourites(userId, propertyId);

    if (!user || !property) {
      return res.status(404).json({ success: false, message: 'User or property not found.' });
    }

    user.favourites.push(property);

    await user.save();

    res.status(200).json({ success: true, message: 'Property added to favourites.' });
}

const removeFavourites = async (req: UserRequest, res: Response) => {
    const { propertyId } = req.params;
    const userId = req.user.id

    const {user, property } = await userService.removeFavourites(userId, propertyId);

    if (!user) {
        throw new Error('User not found');
    }    

    user.favourites = user.favourites.filter(favourite => favourite.id !== propertyId);

    await user.save();

    return res.status(200).json({ status: 200 });
}

export const userController = {getFavourites, addFavourites, removeFavourites}