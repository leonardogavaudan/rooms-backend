import { Service } from 'typedi';
import { Repository } from 'typeorm';

import { dataSource } from '../app';
import { ExplorationPost } from '../entities/exploration.post.entity';

@Service()
class ExplorationPostService {
  private getRepository(): Repository<ExplorationPost> {
    return dataSource.getRepository(ExplorationPost);
  }

  public async createExplorationPost(
    content: string,
  ): Promise<ExplorationPost['id']> {
    const repository = this.getRepository();
    const explorationPost = new ExplorationPost();
    explorationPost.content = content;

    const explorationPostResult = await repository.save(explorationPost);
    return explorationPostResult.id;
  }

  public async getExplorationPosts(): Promise<ExplorationPost[]> {
    const repository = this.getRepository();
    return repository.find();
  }

  public async deleteExplorationPost(id: number): Promise<boolean> {
    const repository = this.getRepository();
    const deleteResult = await repository.delete({ id });
    return !!deleteResult.affected;
  }
}

export { ExplorationPostService };
