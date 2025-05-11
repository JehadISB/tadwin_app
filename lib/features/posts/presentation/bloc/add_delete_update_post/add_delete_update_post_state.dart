part of 'add_delete_update_post_bloc.dart';

abstract class AddDeleteUpdatePostState extends Equatable{
  const AddDeleteUpdatePostState();
  @override
  List<Object?> get props => [];
}

class PostInitial extends AddDeleteUpdatePostState{}
class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState{}
class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState{
  final String errorMessage;
  ErrorAddDeleteUpdatePostState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState{
  final String successMessage;

  MessageAddDeleteUpdatePostState({required this.successMessage});
  @override
  List<Object?> get props => [successMessage];
}