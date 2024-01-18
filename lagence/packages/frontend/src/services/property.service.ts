import { axiosClient } from './';
import { Property } from './property.type';

type GetAllResponse = {
  properties: Property[];
};

const getAll = async () => {
  const { data } = await axiosClient.get<GetAllResponse>('properties');

  return data.properties;
};

export const propertyService = { getAll };
