import {
  Entity,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  Column,
  BaseEntity,
} from "typeorm";


@Entity()
export class User extends BaseEntity {

  @PrimaryGeneratedColumn("uuid")
  id: string;

  @Column({ unique: true })
  username!: string;


  @Column({ unique: true })
  email!: string;

  @Column()
  password!: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}