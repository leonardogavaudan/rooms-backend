import {
  BodyParam,
  Delete,
  Get,
  JsonController,
  Param,
  Post,
} from 'routing-controllers';
import { Service } from 'typedi';

import { ExplorationPost } from '../entities/exploration.post.entity';
import { ExplorationPostService } from '../services/services';

@Service()
@JsonController()
export class Controllers {
  constructor(public explorationPostService: ExplorationPostService) {}

  @Get('/exploration-posts')
  public getExplorationPosts(): Promise<ExplorationPost[]> {
    return this.explorationPostService.getExplorationPosts();
  }

  @Post('/exploration-posts')
  public createExplorationPost(
    @BodyParam('content') content: string
  ): Promise<ExplorationPost['id']> {
    return this.explorationPostService.createExplorationPost(content);
  }

  @Delete('/exploration-posts/:id')
  public deleteExplorationPost(@Param('id') id: number): Promise<boolean> {
    return this.explorationPostService.deleteExplorationPost(id);
  }
}
