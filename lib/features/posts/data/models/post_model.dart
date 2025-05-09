import 'package:tadwin_app/features/posts/domain/entities/post.dart';

class PostModel extends Post{
  PostModel({required super.id, required super.title, required super.body});

  factory PostModel.fromJson(Map<String,dynamic>json){
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String,dynamic>toJson(PostModel postModel){
    return {
      'id':postModel.id,
      'title':postModel.title,
      'body':postModel.body};
  }

}