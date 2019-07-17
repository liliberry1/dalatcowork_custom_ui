import 'package:flutter/material.dart';
import 'egame.dart';
import 'socket_io.dart';
import 'package:flutter/services.dart';
import 'container_egame.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: ContainerEgame(),
//    home: SocketIOPage(),
    );
  }
}
