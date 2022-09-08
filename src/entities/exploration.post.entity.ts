import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class ExplorationPost {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  content: string;
}
