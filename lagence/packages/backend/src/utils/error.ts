import { NextFunction, Request, Response } from 'express';

export class AppError extends Error {
  status?: number;
  meta?: any;

  constructor(message: string, status?: number, meta?: any) {
    super(message);
    this.status = status;
    this.meta = meta;
  }
}

export const errorHandler = (
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.error('Error occured:', err.message, 'on path:', req.path);
  if (err instanceof AppError) {
    return res.status(err.status || 400).send({
      message: err.message,
      status: err.status || 400,
      meta: err.meta,
    });
  } else {
    // For unhandled errors.
    return res
      .status(500)
      .send({ message: 'An unhandled error occured', status: 500 });
  }
};
