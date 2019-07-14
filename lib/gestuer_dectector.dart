import 'dart:math';

import 'package:flutter/material.dart';

class GesDet extends StatefulWidget {
  List<GlobalKey> keys = [GlobalKey(), GlobalKey()];
  List<bool> states = [false,false];

  var keysState;

  @override
  _GesDetState createState(){
    return  _GesDetState();
  }
}

class _GesDetState extends State<GesDet> {
  bool isMatch = false;
  List<GlobalKey> _keys;
  var keyState = Map();

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

  compareGesture(DragUpdateDetails details) {
    for (int i = 0; i < _keys.length; i++) {
      Offset positionWidget = getPositionWithKey(_keys[i]);
      Size sizeWidget = getSizeWithKey(_keys[i]);
      Offset position = details.globalPosition;
      double width = sizeWidget.width;
      double height = sizeWidget.height;
      double x1 = positionWidget.dx;
      double y1 = positionWidget.dy;
      double y2 = y1 + width;
      double x3 = x1 + height;
      if (position.dx <= x3 &&
          position.dx >= x1 &&
          position.dy <= y2 &&
          position.dy >= y1) {
        setState(() {
          widget.states[i] = !widget.states[i];
        });
        print("match ${_keys[i]}");
      } else {
        print("don't match ${_keys[i]}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _keys = widget.keys;
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: compareGesture,
        child: Container(
          color: Colors.grey,
          width: size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.keys
                  .asMap()
                  .map(
                    (index, key) {
                      return MapEntry(
                        index,
                        Container(
                          key: key,
                          width: size.width * (1 / 4),
                          height: size.width * (1 / 4),
                          color: widget.states[index] ? Colors.green : Colors.red,
                        ),
                      );
                    },
                  )
                  .values
                  .toList()),
        ),
      ),
    );
  }
}

ramdomColor() {
  Random ran = Random();
  return Color.fromARGB(
      ran.nextInt(255), ran.nextInt(255), ran.nextInt(255), ran.nextInt(255));
}
