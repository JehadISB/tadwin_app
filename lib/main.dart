import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadwin_app/core/app_theme.dart';
import 'package:tadwin_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:tadwin_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:tadwin_app/injection_container.dart' as di;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=> di.sl<PostsBloc>()),
      BlocProvider(create: (_)=> di.sl<AddDeleteUpdatePostBloc>()),
    ], child:

    MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: PostPage(),
    )
    );


  }
}
