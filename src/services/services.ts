import { Service } from 'typedi';
import { Repository } from 'typeorm';

import { AppDataSource } from '..';
import { Post } from '../entities/post.entity';

@Service()
class PostService {
  public async getRepository(): Promise<Repository<Post>> {
    return (await AppDataSource).getRepository(Post);
  }

  public async createPost(title: string, content: string): Promise<Post> {
    const repository = await this.getRepository();
    const post = new Post();
    post.title = title;
    post.content = content;
    return repository.save(post);
  }

  public async getPosts(): Promise<Post[]> {
    const repository = await this.getRepository();
    return repository.find();
  }

  public async deletePost(id: number): Promise<boolean> {
    const repository = await this.getRepository();
    const deleteResult = await repository.delete({ id });
    return !!deleteResult.affected;
  }
}

export { PostService };
