import 'reflect-metadata';

import dotenv from 'dotenv';
import path from 'path';
import { createExpressServer, useContainer } from 'routing-controllers';
import { Container } from 'typedi';
import { DataSource } from 'typeorm';

import { ExplorationPost } from './entities/exploration.post.entity';

dotenv.config();
const port = process.env.PORT;

useContainer(Container);

// creates express app, registers all controller routes and returns you express app instance
const app = createExpressServer({
  controllers: [path.join(__dirname, '/controllers/*.ts')],
  cors: {
    origin: '*', // (note: do not use this in production)
  },
});

app.listen(port);

const dataSource = new DataSource({
  type: 'postgres',
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  username: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  entities: [ExplorationPost],
  synchronize: true,
});

// to initialize initial connection with the database, register all entities
// and "synchronize" database schema, call "initialize()" method of a newly created database
// once in your application bootstrap
dataSource
  .initialize()
  .then(() => {
    console.log('Data Source has been initialized!');
  })
  .catch((err) => {
    console.error('Error during Data Source initialization:', err);
  });

console.log('Listening on port', port);

export { dataSource };
