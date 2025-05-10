import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tadwin_app/core/error/exception.dart';
import 'package:tadwin_app/features/posts/data/datasources/remote/api_services.dart';
import 'package:tadwin_app/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource{
  Future<List<PostModel>>getAllPosts();
  Future<Unit> addPost({required PostModel postModel});
  Future<Unit> updatePost({required PostModel postModel});
  Future<Unit> deletePost({required int postId});
}
final baseUrl="https://jsonplaceholder.typicode.com";
class PostRemoteDataSourceImpl implements PostRemoteDataSource{
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response= await client.get(Uri.parse(baseUrl+ "/post/"),
        headers:{'Content-type': 'application/json'} );
    if(response.statusCode==200){
     final List decodeJson = jsonDecode(response.body) as List;
     final List<PostModel> postModel = decodeJson.map<PostModel>((element)=>PostModel.fromJson(element)).toList();
     return postModel;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost({required PostModel postModel}) async {
    //TODO: is it necessary add id here? because it is a new post.
  final body={
    'title':postModel.title,
    'body':postModel.body
  };
  final resposne = await client.post(Uri.parse(baseUrl+'/post/'),body: body);
  if(resposne.statusCode==201){
    return Future.value(unit);
  }else{
    throw ServerException();
  }
  }

  @override
  Future<Unit> deletePost({required int postId}) async {
   final response= await client.delete(Uri.parse(baseUrl+'/posts/${postId.toString()}'),
       headers:{'Content-type': 'application/json'});
   if(response.statusCode==200){
     return Future.value(unit);
   }else{
     throw ServerException();
   }
  }



  @override
  Future<Unit> updatePost({required PostModel postModel}) async {
   final String postID=postModel.id.toString();
   final body={
     'title':postModel.title,
     'body':postModel.body
   };
   final response=await client.patch(Uri.parse(baseUrl+'/posts/$postID'),body:body );
   if(response.statusCode==200){
     return Future.value(unit);
   }else{
     throw ServerException();
   }
  }

}