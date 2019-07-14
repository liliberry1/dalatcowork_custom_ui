import 'dart:math';
import 'package:flutter/material.dart';
import 'polygon_item.dart';

class PolyGonCenter4 extends StatefulWidget {
  var datas = [
    'A',
    'b',
    'f',
    'h',
    's',
    't',
    'u',
    'y',
    'k',
    'l',
  ];
  List<GlobalKey> keys = List();
  List<bool> states = List();
  int limit = 5;
  bool isFirstTouch = false;

  generatorKeyWithData() {
    for (int i = 0; i < datas.length; i++) {
      keys.add(randomKey());
      states.add(false);
    }
  }

  @override
  _PolyGonCenter4State createState() {
//    generatorKeyWithData();
    return _PolyGonCenter4State();
  }
}

class _PolyGonCenter4State extends State<PolyGonCenter4> {
  int flex = 0;
  bool isHasExpand = false;
  int limitCount = 0;
  Map<GlobalKey, Offset> globalPosition = Map();
  Map<GlobalKey, Size> globalSizeViews = Map();
  int previousIndex = -1;
  int lastIndex = -2;

  // region -FUNCTIONS LOGIC
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

  //endregion

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
      print("data selected: ${widget.datas[index]}");
    }
  }


  //region -VIEWS HANDLE

  @override
  Widget build(BuildContext context) {
    widget.generatorKeyWithData();
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: compareGesture,
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff00A293), Color(0xff00774F)])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.datas
                  .asMap()
                  .map((index, text) {
                    if (index == 0) {
                      isHasExpand = true;
                      flex = 4;
                      return MapEntry(
                        index,
                        Container(
                          child: body(
                            widget.datas.sublist(0, 3),
                            isHasExpand,
                            flex,
                            widget.keys.sublist(0, 3),
                            widget.states.sublist(0, 3),
                          ),
                        ),
                      );
                    } else if (index == 3) {
                      isHasExpand = false;
                      flex = 6;
                      return MapEntry(
                        index,
                        Container(
                          child: body(
                            widget.datas.sublist(3, 7),
                            isHasExpand,
                            flex,
                            widget.keys.sublist(3, 7),
                            widget.states.sublist(3, 7),
                          ),
                        ),
                      );
                    } else if (index == 7) {
                      isHasExpand = true;
                      flex = 4;
                      return MapEntry(
                        index,
                        Container(
                          child: body(
                            widget.datas.sublist(7, 10),
                            isHasExpand,
                            flex,
                            widget.keys.sublist(7, 10),
                            widget.states.sublist(7, 10),
                          ),
                        ),
                      );
                    }
                    return MapEntry(index, Container());
                  })
                  .values
                  .toList(),
            )),
      ),
    );
  }

  Widget row(List<String> data, int flex, var key, var state) {
    List<Widget> items = List();
    for (int i = 0; i < data.length; i++) {
      items.add(PolygonItem(data[i], flex, state[i], key[i]));
    }
    return Row(
      children: items,
    );
  }

  Widget rowHasExpand(List<String> data, int flex, var key, var state) {
    List<Widget> items = List();
    for (int i = 0; i < data.length; i++) {
      items.add(PolygonItem(data[i], flex, state[i], key[i]));
    }
    items.insert(
      0,
      Expanded(
        flex: 2,
        child: Container(),
      ),
    );
    items.insert(
      data.length + 1,
      Expanded(
        flex: 2,
        child: Container(),
      ),
    );

    return Row(
      children: items,
    );
  }

  Widget body(var data, bool isHasExpand, int flex, var key, var state) {
    if (data.length == 3) {
      return rowHasExpand(data, flex, key, state);
    } else {
      return row(data, flex, key, state);
    }
  }
  //endregion
}

randomKey() {
  Random random = Random();
  return GlobalKey(debugLabel: '${random.nextDouble()}');
}
