import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tadwin_app/core/error/failure.dart';
import 'package:tadwin_app/core/strings/failure_message.dart';
import 'package:tadwin_app/features/posts/domain/entities/post.dart';
import 'package:tadwin_app/features/posts/domain/usecases/get_all_post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent,PostsState>{
  final GetAllPostUsecase getAllPost;
  PostsBloc({required this.getAllPost}):super(PostInitial()){
    on<PostsEvent>((event,emit) async{
   if(event is GetALlPostsEvent){
     emit(LoadingPostsState());
     final failureOrPosts = await getAllPost();
   emit(getFailureOrPostsToState(failureOrPosts));

   }else if (event is RefreshPostsEvents){
     emit(LoadingPostsState());
     final failureOrPosts = await getAllPost();
     emit(getFailureOrPostsToState(failureOrPosts));
   }
  });
  }

  PostsState getFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
            (failure) => ErrorPostsState(message: getFailureMessage(failure)),
            (post)=>LoadedPostsState(posts: post),
    );
  }

  String getFailureMessage(Failure failure){
    switch(failure.runtimeType){
      case OffLineFailure :
        return offLineErrorMessage;
      case ServerFailure :
        return ServerErrorMessage;
      case EmptyCacheFailure :
        return EmptyErrorMessage;
      default :
        return "UnExpected error, try again later";
    }

  }
}

