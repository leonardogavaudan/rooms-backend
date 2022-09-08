import { Service } from 'typedi';
import { Repository } from 'typeorm';

import { AppDataSource } from '..';
import { ExplorationPost } from '../entities/exploration.post.entity';

@Service()
class ExplorationPostService {
  public async getRepository(): Promise<Repository<ExplorationPost>> {
    return (await AppDataSource).getRepository(ExplorationPost);
  }

  public async createExplorationPost(
    content: string
  ): Promise<ExplorationPost['id']> {
    const repository = await this.getRepository();
    const explorationPost = new ExplorationPost();
    explorationPost.content = content;

    const explorationPostResult = await repository.save(explorationPost);
    return explorationPostResult.id;
  }

  public async getExplorationPosts(): Promise<ExplorationPost[]> {
    const repository = await this.getRepository();
    return repository.find();
  }

  public async deleteExplorationPost(id: number): Promise<boolean> {
    const repository = await this.getRepository();
    const deleteResult = await repository.delete({ id });
    return !!deleteResult.affected;
  }
}

export { ExplorationPostService };
