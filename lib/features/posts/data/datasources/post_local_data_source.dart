import 'package:dartz/dartz.dart';
import 'package:tadwin_app/features/posts/data/models/post_model.dart';

abstract class PostLocalDataSource{
  Future<Unit>cachePosts(List<PostModel> postModel);
  Future<List<PostModel>>getCachedPosts();
}

class PostLocalDataSourceImpl implements PostLocalDataSource{
  @override
  Future<Unit> cachePosts(List<PostModel> postModel) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
  
}