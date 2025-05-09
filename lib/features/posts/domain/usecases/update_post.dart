import 'package:dartz/dartz.dart';
import 'package:tadwin_app/core/error/failure.dart';
import 'package:tadwin_app/features/posts/domain/entities/post.dart';
import 'package:tadwin_app/features/posts/domain/repositories/posts_repository.dart';

class UpdatePostUsecase{
  final PostRepository repository;
  UpdatePostUsecase({required this.repository});

  Future<Either<Failure,Unit>> call({required Post post}){
    return repository.updatePost(post: post);
  }
}