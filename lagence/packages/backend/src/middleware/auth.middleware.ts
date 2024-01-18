import e, { Request, NextFunction, Response } from 'express';
import { userService } from '../services/user.service';
import { UserRequest } from '../types/express';

export async function isAuthenticated(
  req: UserRequest,
  res: Response,
  next: NextFunction
) {
  const userId = req.session.userId;
  console.log(req.session);

  if (!userId) return res.sendStatus(401);
  const user = await userService.findById(userId);
  if (!user) {
    res.sendStatus(401);
  } else {
    req.user = user;
    next();
  }
}

export async function isAdmin(
  req: UserRequest,
  res: Response,
  next: NextFunction
) {
  const user = req.user;

  if (user && user.role === 'admin') {
    next();
  } else {
    res.sendStatus(403);
  }
}
