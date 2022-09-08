import {
  BodyParam,
  Delete,
  Get,
  JsonController,
  Param,
  Post,
} from 'routing-controllers';
import { Container } from 'typedi';

import { ExplorationPost } from '../entities/exploration.post.entity';
import { ExplorationPostService } from '../services/services';

@JsonController()
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
  async createExplorationPost(
    @BodyParam('content') content: string
  ): Promise<ExplorationPost['id']> {
    return this.explorationPostService.createExplorationPost(content);
  }

  @Delete('/exploration-posts/:id')
  async deleteExplorationPost(@Param('id') id: number): Promise<boolean> {
    return this.explorationPostService.deleteExplorationPost(id);
  }
}
