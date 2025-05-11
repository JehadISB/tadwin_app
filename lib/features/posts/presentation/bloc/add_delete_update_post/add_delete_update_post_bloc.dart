import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadwin_app/core/error/failure.dart';
import 'package:tadwin_app/core/strings/failure_message.dart';
import 'package:tadwin_app/core/strings/success_message.dart';
import 'package:tadwin_app/features/posts/domain/usecases/add_post.dart';
import 'package:tadwin_app/features/posts/domain/usecases/delete_post.dart';
import 'package:tadwin_app/features/posts/domain/usecases/get_all_post.dart';
import 'package:tadwin_app/features/posts/domain/usecases/update_post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent,AddDeleteUpdatePostState>{
  final AddPostUsecase addPost;
  final UpdatePostUsecase updatePost;
  final DeletePostUsecase deletePost;
  AddDeleteUpdatePostBloc({required this.addPost, required this.updatePost, required this.deletePost}):super(PostInitial()){
    on<AddDeleteUpdatePostEvent>((event,emit) async{
      if(event is AddPostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneAdded =await addPost(post: event.post);
        getDoneMessageOrErrorState(either: failureOrDoneAdded,successMessage:AddedSuccessMessage);
      }else if (event is UpdatePostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneAdded =await updatePost(post: event.post);
        getDoneMessageOrErrorState(either: failureOrDoneAdded,successMessage:UpdatedSuccessMessage);
      }else if (event is DeletePostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneAdded =await deletePost(postId:int.parse(event.postId));
        getDoneMessageOrErrorState(either: failureOrDoneAdded,successMessage:DeletedSuccessMessage);
      }
    });
    }
  AddDeleteUpdatePostState getDoneMessageOrErrorState({required Either<Failure, Unit> either,required String successMessage}) {
    return either.fold(
          (failure) => ErrorAddDeleteUpdatePostState(errorMessage: getFailureMessage(failure)),
          (_)=>MessageAddDeleteUpdatePostState(successMessage:successMessage ),
    );
  }
  String getFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OffLineFailure :
        return offLineErrorMessage;
      case ServerFailure :
        return ServerErrorMessage;
      default :
        return "UnExpected error, try again later";
    }
  }}
