import { AnyZodObject, z } from 'zod';
import { Request, Response } from 'express';

export const validateBody = <T extends AnyZodObject>(
  schema: T,
  req: Request,
  res: Response
): z.infer<T> | false => {
  try {
    return schema.parse(req.body);
  } catch (error) {
    res.status(400).json({
      message: 'Champs invalides',
      details: error.errors.map((err: any) => ({
        path: err.path.join('.'),
        message: err.message,
      })),
    });
    return false;
  }
};
