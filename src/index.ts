import dotenv from 'dotenv';
import { createExpressServer } from 'routing-controllers';
import { DataSource } from 'typeorm';

import { Controllers } from './controllers/controllers';
import { Post } from './entities/post.entity';

dotenv.config();
const port = process.env.PORT;

const main = async () => {
  // creates express app, registers all controller routes and returns you express app instance
  const app = createExpressServer({
    controllers: [Controllers],
    cors: true,
  });

  app.listen(port);

  const AppDataSource = new DataSource({
    type: 'postgres',
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    entities: [Post],
    synchronize: true,
  });

  // to initialize initial connection with the database, register all entities
  // and "synchronize" database schema, call "initialize()" method of a newly created database
  // once in your application bootstrap
  await AppDataSource.initialize();
};

main();
