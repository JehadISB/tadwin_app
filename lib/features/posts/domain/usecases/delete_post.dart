import 'package:dartz/dartz.dart';
import 'package:tadwin_app/core/error/failure.dart';
import 'package:tadwin_app/features/posts/domain/repositories/posts_repository.dart';

class DeletePostUsecase {
  final PostRepository repository;
  DeletePostUsecase({required this.repository});

  Future<Either<Failure,Unit>> call({required int postId}) async {
    return await repository.deletePost(id: postId);
  }
}