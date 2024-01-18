import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  BaseEntity,
  CreateDateColumn,
  OneToOne,
  JoinColumn,
  ManyToMany,
  JoinTable,
} from 'typeorm';
import { Property } from './Property';
import { Exclude, instanceToPlain } from 'class-transformer';

@Entity()
export class User extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  firstName: string;

  @Column()
  lastName: string;

  @Column({ unique: true })
  email: string;

  @Column()
  @Exclude()
  password: string;

  @Column({ default: 'user', enum: ['admin', 'user'], type: 'enum' })
  role: 'admin' | 'user';

  @CreateDateColumn()
  createdAt: Date;

  @OneToOne(() => Property, (property) => property.tenant, {
    nullable: true,
  })
  @JoinColumn()
  rentedProperty: Property;

  @ManyToMany(() => Property)
  @JoinTable()
  favourites: Property[]

  serialize() {
    return instanceToPlain(this);
  }
}
