import 'dart:math';
import 'package:flutter/material.dart';
import 'polygon_view.dart';
import 'square_view.dart';

class EGame extends StatefulWidget {
  EGameTypeWidget typeWidget;
  List<String> data = List();
   List<GlobalKey> keys = List();
  List<bool> states = List();
  int numberOfItemInRowCenter;
  bool isFirstTouch = false;

  @override
  _EGameState createState() => _EGameState();

  EGame(@required this.typeWidget, @required this.data);

  generatorKeyWithData() {
    for (int i = 0; i < data.length; i++) {
      keys.add(GlobalKey());
      states.add(false);
    }
  }
}

class _EGameState extends State<EGame> {
  Map<GlobalKey, Offset> globalPosition = Map();
  Map<GlobalKey, Size> globalSizeViews = Map();
  int previousIndex = -1;
  int lastIndex = -2;

  //region --LOGIC
  getSizeWithKey(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    final size = renderBox.size;
    return size;
  }

  getPositionWithKey(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var position = renderBox.localToGlobal(Offset.zero);
    return position;
  }

  getAllPositionAndSizeViews() {
    for (var key in widget.keys) {
      globalPosition[key] = getPositionWithKey(key);
      globalSizeViews[key] = getSizeWithKey(key);
    }
  }

  bool compareDistance(int index, Offset position) {
    Offset center = globalPosition[widget.keys[index]];
    double distanceStandard = calculatorDistanceStandard(index);
    double distance = calculatorDistance(center, position);
    return distance <= distanceStandard;
  }

  calculatorDistance(Offset center, Offset position) {
    double varX = position.dx - center.dx;
    double varY = position.dy - center.dy;
    return sqrt(pow(varX, 2) + pow(varY, 2));
  }

  calculatorDistanceStandard(int index) {
    double width = globalSizeViews[widget.keys[index]].width;
    return (1 / 2) * width + width;
  }

  compareGesture(DragUpdateDetails details) {
    if (!widget.isFirstTouch) {
      getAllPositionAndSizeViews();
      widget.isFirstTouch = true;
    }
    subFuncCompareGesture(details);
  }

  void subFuncCompareGesture(DragUpdateDetails details) {
    for (int i = 0; i < widget.keys.length; i++) {
      Offset positionWidget = getPositionWithKey(widget.keys[i]);
      Size sizeWidget = getSizeWithKey(widget.keys[i]);
      Offset position = details.globalPosition;
      double width = sizeWidget.width;
      double height = sizeWidget.height;
      double x1 = positionWidget.dx;
      double x2 = x1 + width;
      double y1 = positionWidget.dy;
      double y3 = y1 + height;
      //check position
      if (position.dx <= x2 &&
          position.dx >= x1 &&
          position.dy <= y3 &&
          position.dy >= y1) {
        if (previousIndex != -1) {
          if (compareDistance(previousIndex, position)) {
            compareTrueViewAndHandleState(i);
          }
        } else {
          compareTrueViewAndHandleState(i);
        }
      }
    }
  }

  compareTrueViewAndHandleState(int index) {
    if (previousIndex == index) {
      return;
    } else {
      setState(() {
        widget.states[index] = !widget.states[index];
      });
      //todo: save and remove state
//      if(widget.states[index]){
//        //add data in select array
//      }else{
//        //remove data in select array
//      }
      previousIndex = index;
      print("data selected: ${widget.data[index]}");
    }
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    widget.generatorKeyWithData();
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: compareGesture,
          child: bodyGame(
              widget.typeWidget, widget.data, widget.keys, widget.states),
        ),
      ),
    );
  }

  Widget bodyGame(EGameTypeWidget type, List<String> data, List<GlobalKey> keys,
      List<bool> states) {
    switch (type) {
      case EGameTypeWidget.polygon:
        return PolyGon(data, keys, states, 5);
      case EGameTypeWidget.square:
        return SquareView(data, keys, states, 5);
    }
  }
}

enum EGameTypeWidget { polygon, square }
