import 'package:flutter/material.dart';
import 'egame.dart';

class ContainerEgame extends StatefulWidget {
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

  @override
  _ContainerEgameState createState() => _ContainerEgameState();
}

class _ContainerEgameState extends State<ContainerEgame> {

  EGameTypeWidget type;
  List<String> data = List();

  cloneData(var datas){
    data = datas;
  }

  @override
  void initState() {
    type = EGameTypeWidget.square;
    data = widget.dataForSquare.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EGame(type, data),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          if(type == EGameTypeWidget.square){
            type = EGameTypeWidget.polygon;
            data = widget.dataForPolyGon;
          }else{
            type = EGameTypeWidget.square;
            data = widget.dataForSquare;
          }
        });
      },
      child: Icon(Icons.autorenew,color: Colors.white,),),
    );
  }
}
