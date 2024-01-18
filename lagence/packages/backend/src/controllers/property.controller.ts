import { propertyService } from '../services/property.service';
import { UserRequest } from '../types/express';
import { NextFunction, Request, Response } from 'express';
import { instanceToPlain } from 'class-transformer';
import { validateBody } from '../validation';
import {
  addPropertySchema,
  updatePropertySchema,
} from '../validation/property';
import { deleteFiles } from '../utils/file';
import { Property } from '../models/Property';

const MAX_FILE_SIZE = 1024 * 1024 * 5;
const ACCEPTED_IMAGE_MIME_TYPES = [
  'image/jpeg',
  'image/jpg',
  'image/png',
  'image/webp',
];
const ACCEPTED_IMAGE_TYPES = ['jpeg', 'jpg', 'png', 'webp'];

const create = async (req: UserRequest, res: Response) => {
  if (!req.files) {
    return res.status(400).json({
      status: 400,
      message: 'Minimum one image is required',
    });
  }

  // Validate files types and sizes
  const images = req.files as Express.Multer.File[];

  for (const image of images) {
    if (!ACCEPTED_IMAGE_MIME_TYPES.includes(image.mimetype)) {
      deleteFiles(images);
      return res.status(400).json({
        status: 400,
        message: `File ${
          image.originalname
        } is not an image. Accepted formats are: ${ACCEPTED_IMAGE_TYPES.join(
          ', '
        )}`,
      });
    }

    if (image.size > MAX_FILE_SIZE) {
      deleteFiles(images);
      return res.status(400).json({
        status: 400,
        message: `File ${image.originalname} is too big. Max size is ${
          MAX_FILE_SIZE / 1024 / 1024
        }MB`,
      });
    }
  }

  const data = validateBody(addPropertySchema, req, res);
  if (!data) return;

  const newProperty = Property.create(data);
  newProperty.imagesPaths = images.map((image) =>
    image.path.replace('public/', '')
  );

  const property = await propertyService.add(newProperty);

  res.status(201).json({ status: 201, property });
};

const update = async (req: UserRequest, res: Response, next: NextFunction) => {
  const data = validateBody(updatePropertySchema, req, res);
  if (!data) return;

  try {
    await propertyService.update(data);
  } catch (error) {
    return next(error);
  }

  res.status(200).json({ status: 201 });
};

const getAll = async (req: Request, res: Response) => {
  const properties = await propertyService.findAll();

  return res
    .status(200)
    .json({ status: 200, properties: instanceToPlain(properties) });
};

const remove = async (req: Request, res: Response) => {
  const { id } = req.params;

  await propertyService.remove(id);

  return res.status(200).json({ status: 200 });
};

export const propertyController = { getAll, create, update, remove };
