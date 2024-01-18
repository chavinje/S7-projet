export type ServerResponse<T> = {
  data: T;
  status: number;
  message?: string;
};
