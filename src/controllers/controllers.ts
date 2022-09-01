import { Controller, Delete, Get, Param, Post } from 'routing-controllers';
import { Container } from 'typedi';

import { ExplorationPost } from '../entities/exploration.post.entity';
import { ExplorationPostService } from '../services/services';

@Controller()
export class Controllers {
  explorationPostService: ExplorationPostService;

  constructor() {
    this.explorationPostService = Container.get(ExplorationPostService);
  }

  @Get('/exploration-posts')
  getExplorationPosts(): Promise<ExplorationPost[]> {
    return this.explorationPostService.getExplorationPosts();
  }

  @Post('/exploration-posts')
  async createExplorationPost(): Promise<ExplorationPost['id']> {
    return this.explorationPostService.createExplorationPost('Hello', 'World');
  }

  @Delete('/exploration-posts/:id')
  async deleteExplorationPost(@Param('id') id: number): Promise<boolean> {
    return this.explorationPostService.deleteExplorationPost(id);
  }
}
