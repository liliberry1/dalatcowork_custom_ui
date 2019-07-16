import 'package:flutter/material.dart';
import 'egame.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<String> dataForPolyGon = [
      //region --init data for PolyGon
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'h',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      'a',
      //endregion
    ];
    List<String> dataForSquare = [
      //region --init data for Square
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'h',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      'a',
      'n',
      'o',
      'p',
      'q',
      'r',
      'a',
      //endregion
    ];
    return MaterialApp(
      title: 'Flutter Demo',
      home: EGame(EGameTypeWidget.square, dataForSquare),
    );
  }
}
