import 'package:dartz/dartz.dart';
import 'package:tadwin_app/features/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource{
  Future<List<PostModel>>getAllPosts();
  Future<Unit> addPost({required PostModel postModel});
  Future<Unit> updatePost({required PostModel postModel});
  Future<Unit> deletePost({required int postId});
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource{
  @override
  Future<Unit> addPost({required PostModel postModel}) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost({required int postId}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost({required PostModel postModel}) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

}