import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadwin_app/core/network/network_info.dart';
import 'package:tadwin_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:tadwin_app/features/posts/data/datasources/remote/post_remote_data_source.dart';
import 'package:tadwin_app/features/posts/data/repositories/post_repository_impl.dart';
import 'package:tadwin_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:tadwin_app/features/posts/domain/usecases/add_post.dart';
import 'package:tadwin_app/features/posts/domain/usecases/delete_post.dart';
import 'package:tadwin_app/features/posts/domain/usecases/get_all_post.dart';
import 'package:tadwin_app/features/posts/domain/usecases/update_post.dart';
import 'package:tadwin_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:tadwin_app/features/posts/presentation/bloc/posts/posts_bloc.dart';

final sl=GetIt.instance;


Future<void> init() async{

  /// feature : posts

//bloc

sl.registerFactory(()=> PostsBloc(getAllPost: sl()));
sl.registerFactory(()=> AddDeleteUpdatePostBloc(addPost: sl(), updatePost: sl(), deletePost: sl()));
//usecases
sl.registerLazySingleton(()=>GetAllPostUsecase(repository: sl()));
sl.registerLazySingleton(()=>AddPostUsecase(repository: sl()));
sl.registerLazySingleton(()=>DeletePostUsecase(repository: sl()));
sl.registerLazySingleton(()=>UpdatePostUsecase(repository: sl()));

//repository
sl.registerLazySingleton<PostRepository>(()=>PostRepositoryImpl(networkInfo: sl(), localDataSource: sl(), remoteDataSource: sl()));


//dataSources
sl.registerLazySingleton<PostRemoteDataSource>(()=> PostRemoteDataSourceImpl(client: sl()));
sl.registerLazySingleton<PostLocalDataSource>(()=>PostLocalDataSourceImpl(sharedPreferences: sl()));

  ///Core
sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(internetConnectionChecker: sl()));

  ///Extrenal
  final  sharedPreferences=await SharedPreferences.getInstance();
  sl.registerLazySingleton(()=>sharedPreferences);
  sl.registerLazySingleton(()=>http.Client());
  sl.registerLazySingleton(()=> InternetConnectionChecker.createInstance());
}