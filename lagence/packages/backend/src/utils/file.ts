import multer from 'multer';
import fs from 'fs';
import { promisify } from 'util';

const unlinkAsync = promisify(fs.unlink);

// Multer config
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'public/uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '_' + file.originalname.replaceAll(' ', '_'));
  },
});

export const uploadMiddleware = multer({ storage: storage });

// Utils functions
export const deleteFiles = async (files: Express.Multer.File[]) => {
  for (const file of files) {
    await unlinkAsync(file.path);
  }
};
