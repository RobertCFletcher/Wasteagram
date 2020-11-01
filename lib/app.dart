import 'package:flutter/material.dart';
import 'package:wasteagram/screens/camera_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'screens/list_screen.dart';
import 'screens/detail_screen.dart';

class MyApp extends StatelessWidget {

  static final routes = {
    '/': (context) => ListScreen(),
    'newPost': (context) => NewPost(),
    'cameraScreen': (context) => CameraScreen(),
    'detailScreen': (context) => DetailScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}
