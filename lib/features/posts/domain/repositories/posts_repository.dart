import 'package:dartz/dartz.dart';
import 'package:tadwin_app/core/error/failure.dart';
import 'package:tadwin_app/features/posts/domain/entities/post.dart';

abstract class PostRepository{


  Future<Either<Failure,List<Post>>> getAllPosts();
  Future<Either<Failure,Unit>> addPost({required Post post});
  Future<Either<Failure,Unit>> updatePost({required Post post});
  Future<Either<Failure,Unit>> deletePost({required int postId});

}