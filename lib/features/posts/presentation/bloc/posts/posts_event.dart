part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable{
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

class GetALlPostsEvent extends PostsEvent{

}

class RefreshPostsEvents extends PostsEvent{

}