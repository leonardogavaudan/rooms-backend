import 'reflect-metadata';

import { Controller, Post } from 'routing-controllers';

@Controller()
export class Controllers {
  @Post('/posts')
  createPost() {
    return 'This action adds a new post';
  }
}
