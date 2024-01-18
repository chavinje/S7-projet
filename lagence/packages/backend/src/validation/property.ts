import { z } from 'zod';

export const addPropertySchema = z.object({
  name: z.string().min(1),
  description: z.string().min(1),
  address: z.string().min(1),
  price: z.coerce.number().min(1),
  chargesPrice: z.coerce.number().min(1),
  surface: z.coerce.number().min(1),
  type: z.enum(['apartment', 'house']),
  roomsCount: z.coerce.number().min(1),
});

export const updatePropertySchema = addPropertySchema.extend({
  id: z.string().min(1),
});
