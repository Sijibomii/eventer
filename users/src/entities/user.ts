import {
  Entity,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  Column,
  BaseEntity,
  OneToMany,
} from "typeorm";


@Entity()
export class User extends BaseEntity {

  @PrimaryGeneratedColumn()
  id!: number;


  @Column({ unique: true })
  username!: string;


  @Column({ unique: true })
  email!: string;

  @Column()
  password!: string;

  
  @Field(() => String)
  @CreateDateColumn()
  createdAt: Date;

  @Field(() => String)
  @UpdateDateColumn()
  updatedAt: Date;
}