import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  OneToOne,
} from 'typeorm';
import { User } from './User';

@Entity()
export class Property extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id?: string;

  @Column()
  name: string;

  @Column()
  description?: string;

  @Column()
  address: string;

  @Column()
  price: number;

  @Column()
  chargesPrice: number;

  @Column()
  surface: number;

  @Column({
    enum: ['apartment', 'house'],
    type: 'enum',
  })
  type: 'apartment' | 'house';

  @Column()
  roomsCount: number;

  @Column('json', {
    default: '[]',
  })
  imagesPaths: string[];

  @OneToOne(() => User, (user) => user.rentedProperty)
  tenant?: User;
}

export type PropertyType = Omit<Property, keyof BaseEntity>;
