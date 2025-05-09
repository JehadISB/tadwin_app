import 'package:dartz/dartz.dart';
import 'package:tadwin_app/core/error/failure.dart';
import 'package:tadwin_app/features/posts/domain/entities/post.dart';
import 'package:tadwin_app/features/posts/domain/repositories/posts_repository.dart';

class AddPostUsecase {
  final PostRepository repository;

  AddPostUsecase({required this.repository});
  Future<Either<Failure,Unit>> call({required Post post})async{
    return await repository.addPost(post: post);
  }
}