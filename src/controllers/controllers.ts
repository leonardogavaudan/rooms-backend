import { Controller, Delete, Get, Param, Post } from 'routing-controllers';
import { Container } from 'typedi';

import { PostService } from '../services/services';

@Controller()
export class Controllers {
  postService: PostService;

  constructor() {
    this.postService = Container.get(PostService);
  }

  @Get('/posts')
  getPosts() {
    return this.postService.getPosts();
  }

  @Post('/posts')
  async createPost() {
    return this.postService.createPost('Hello', 'World');
  }

  @Delete('/posts/:id')
  async deletePost(@Param('id') id: number) {
    return this.postService.deletePost(id);
  }
}
