import { User } from '../models/User';
import { Property } from '../models/Property'

const add = async (user: User) => {
  await User.create(user);
  return await User.save(user);
};

const remove = async (userId: string) => {
  return await User.delete(userId);
};

const findById = async (userId: string) => {
  const user = await User.findOneBy({ id: userId });
  if (user) return user;
  else return null;
};

const findByEmail = async (email: string) => {
  const user = await User.findOneBy({
    email: email,
  });
  if (user) return user;
  else return null;
};

const getFavourites = async (userId: string)=> {
  const user =await User.findOne({
    where: {
      id: userId
    },
    relations:{
      favourites: true
    }
  })
  if (user) return user.favourites;
  else return []; 
}

const addFavourites = async (userId: string, propertyId: string)=> {
  const user = await User.findOne({
    where: {
        id: userId
    },
    relations:{
        favourites: true
    }
  });
  const property = await Property.findOne({
      where: {
          id: propertyId
      }
  });
  return {user, property}
}

const removeFavourites = async (userId: string, propertyId: string) => {
  const user = await User.findOne({
    where: {
      id: userId
    },
    relations: ['favourites']
  });
  const property = await Property.findOne({
    where: {
        id: propertyId
    }
  });

  return {user, property};
};

export const userService = { add, remove, findById, findByEmail, getFavourites, addFavourites, removeFavourites };
