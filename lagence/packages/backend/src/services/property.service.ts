// Property Service

import { DeepPartial } from 'typeorm';
import { Property, PropertyType } from '../models/Property';
import { AppError } from '../utils/error';

const add = async (property: DeepPartial<Property>) => {
  if (property.id) {
    throw new Error('Cannot create a property with an id');
  }
  const insertedProp = await Property.insert(property);

  return await findById(insertedProp.identifiers[0].id);
};

const update = async (property: DeepPartial<Property>) => {
  const propertyExists = await Property.findOne({
    where: { id: property.id },
  });

  if (!propertyExists) {
    throw new AppError('Cannot update a property that does not exist');
  }

  return await Property.update(
    {
      id: property.id,
    },
    property
  );
};

const remove = async (propertyId: string) => {
  return await Property.delete(propertyId);
};

const findAll = async () => {
  return await Property.find({
    relations: ['tenant'],
  });
};

const findById = async (id: string) => {
  return await Property.findOne({
    where: { id },
    relations: ['tenant'],
  });
};

export const propertyService = { add, update, remove, findAll, findById };
