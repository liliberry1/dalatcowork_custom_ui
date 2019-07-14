import 'dart:math';

import 'package:flutter/material.dart';
import 'polygon_item.dart';

class PolyGonCenter5 extends StatefulWidget {
  var datas = [
    'A',
    'b',
    'f',
    'h',
    's',
    't',
    'u',
    'b',
    't',
    'u',
    'b',
    'f',
    'h',
    'y',
    'k',
    'h',
    'y',
    'k',
    'l',
  ];
  List<GlobalKey> keys = List();
  List<bool> states = List();
  int limit = 5;

  generatorKeyWithData() {
    for (int i = 0; i < datas.length; i++) {
      keys.add(randomKey());
      states.add(false);
    }
  }

  @override
  _PolyGonCenter5State createState() {
    return _PolyGonCenter5State();
  }
}

class _PolyGonCenter5State extends State<PolyGonCenter5> {
  int flex = 0;
  bool isHasExpand = false;
  int limitCount = 0;

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

  compareGesture(var details) {
    for (int i = 0; i < widget.keys.length; i++) {
      Offset positionWidget = getPositionWithKey(widget.keys[i]);
      Size sizeWidget = getSizeWithKey(widget.keys[i]);
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
        print("selected ${widget.datas[i]}");
      } else {
//        print("don't match ${widget.keys[i]}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.generatorKeyWithData();
    print('data ${widget.datas}');
    return Scaffold(
      body: GestureDetector(
        onTapDown: compareGesture,
        onPanUpdate: compareGesture,
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff00A293), Color(0xff00774F)])),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //row 3 el
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                        flex: 5,
                      ),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      Expanded(
                        child: Container(),
                        flex: 5,
                      ),
                    ],
                  ),
//                  //row 4 el
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                        flex: 2,
                      ),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      Expanded(
                        child: Container(),
                        flex: 2,
                      ),
                    ],
                  ),
                  //row 5 el
                  Row(
                    children: <Widget>[
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                    ],
                  ),
                  //row 4 el
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                        flex: 2,
                      ),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      Expanded(
                        child: Container(),
                        flex: 2,
                      ),
                    ],
                  ),
                  //row 3 el
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                        flex: 5,
                      ),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      PolygonItem('A', 5, false, GlobalKey()),
                      Expanded(
                        child: Container(),
                        flex: 5,
                      ),
                    ],
                  ),
//
                ])),
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
    if ((data.length == 0) || (data.lenght == 7)) {
      return rowHasExpand(data, flex, key, state);
    } else {
      return row(data, flex, key, state);
    }
  }
}

randomKey() {
  Random random = Random();
  return GlobalKey(debugLabel: '${random.nextDouble()}');
}
