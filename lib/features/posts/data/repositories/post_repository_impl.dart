import 'package:dartz/dartz.dart';
import 'package:tadwin_app/core/error/exception.dart';
import 'package:tadwin_app/core/error/failure.dart';
import 'package:tadwin_app/core/network/network_info.dart';
import 'package:tadwin_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:tadwin_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:tadwin_app/features/posts/data/models/post_model.dart';
import 'package:tadwin_app/features/posts/domain/entities/post.dart';
import 'package:tadwin_app/features/posts/domain/repositories/posts_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostLocalDataSource localDataSource;
  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImpl({required this.networkInfo,required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if(await networkInfo.isConnected){
     try{
       final remotePosts= await remoteDataSource.getAllPosts();
       localDataSource.cachePosts(remotePosts);
       return Right(remotePosts);
     }on ServerException{
       return left(ServerFailure());
     }
    }else{
      try{
        final localPosts=await localDataSource.getCachedPosts();
        return Right(localPosts);
      }on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost({required Post post}) async {
    PostModel postModel=PostModel(id: post.id, title: post.title, body: post.body);
   return getMessage(functionDelOrUpdateOrAddPost: (){
     return remoteDataSource.addPost(postModel: postModel);
   });
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
      return getMessage(functionDelOrUpdateOrAddPost: (){
      return remoteDataSource.deletePost(postId: postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required Post post}) async {
    PostModel postModel=PostModel(id: post.id, title: post.title, body: post.body);
    return getMessage(functionDelOrUpdateOrAddPost:(){
      return remoteDataSource.updatePost(postModel: postModel);
    });
  }

  Future<Either<Failure, Unit>> getMessage(
      {required Future<Unit> Function() functionDelOrUpdateOrAddPost}) async {
    if( await networkInfo.isConnected){
      try{
        await functionDelOrUpdateOrAddPost;
        return Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OffLineFailure());
    }
  }

}