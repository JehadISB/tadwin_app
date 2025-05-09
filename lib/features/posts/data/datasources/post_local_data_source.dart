import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadwin_app/core/error/exception.dart';
import 'package:tadwin_app/features/posts/data/models/post_model.dart';

abstract class PostLocalDataSource{
  Future<Unit>cachePosts(List<PostModel> postModels);
  Future<List<PostModel>>getCachedPosts();
}

class PostLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;
  final String key="CACHED_POSTS";

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelToJson=postModels.map<Map<String,dynamic>>((postModel)=>postModel.toJson(postModel)).toList();
    sharedPreferences.setString(key, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
   final jsonString= sharedPreferences.getString(key);
   if(jsonString!=null){
     List decodeJsonData=json.decode(jsonString);
     List<PostModel> jsonToPostModel=decodeJsonData.map((element)=>PostModel.fromJson(element)).toList();
     return Future.value(jsonToPostModel);
   }else{
     throw EmptyCacheException();
   }
  }
  
}