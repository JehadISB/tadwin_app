import 'package:dartz/dartz.dart';
import 'package:tadwin_app/core/error/failure.dart';
import 'package:tadwin_app/features/posts/domain/entities/post.dart';
import 'package:tadwin_app/features/posts/domain/repositories/posts_repository.dart';

class GetAllPostUsecase{
  final PostRepository repository;

  GetAllPostUsecase({required this.repository});

  Future<Either<Failure,List<Post>>> call() async{
    return await repository.getALlPosts();

  }
}