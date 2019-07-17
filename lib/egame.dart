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

  String resultPolygon = "inr";
  String resultSquare = "RAN";

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
  List<String> result = List();
  GlobalKey keyBody = GlobalKey();
  bool isMatch = false;

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
    switch (widget.typeWidget) {
      case EGameTypeWidget.polygon:
        {
          return (1 / 2) * width + width;
        }
      case EGameTypeWidget.square:
        {
          return 2 * width;
        }
    }
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
      previousIndex = index;
      setState(() {
        widget.states[index] = !widget.states[index];
      });
      if (widget.states[previousIndex]) {
        result.add(widget.data[previousIndex]);
      } else {
        result.removeAt(index);
      }
    }
  }

  onPanEnd(DragEndDetails details) {
    print('data selected $result');
    var ketqua = "";
    for (var data in result) {
      ketqua += data;
    }
    if (widget.typeWidget == EGameTypeWidget.square) {
      if (ketqua.toUpperCase() == widget.resultSquare.toUpperCase()) {
        print("match");
        setState(() {
          isMatch = true;
        });
      } else {
        setState(() {
          isMatch = false;
        });
        for (int i = 0; i < widget.states.length; i++) {
          setState(() {
            widget.states[i] = false;
          });
        }
      }
    } else {
      if (ketqua.toUpperCase() == widget.resultPolygon.toUpperCase()) {
        print("match");
        setState(() {
          isMatch = true;
        });
      } else {
        setState(() {
          isMatch = false;
        });
        for (int i = 0; i < widget.states.length; i++) {
          setState(() {
            widget.states[i] = false;
          });
        }
      }
    }

    previousIndex = -1;
  }

  onPanStart(var details) {
    result.clear();
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    widget.generatorKeyWithData();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xff00A293),
              Color(0xff00774F),
            ])),
        child: Column(
          children: <Widget>[
            new QuestionWidget(),
            new EventWidget(),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: !widget.isFirstTouch
                            ? Colors.white
                            : isMatch ? Colors.orange : Colors.red,
                        width: 5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Answer: ${widget.typeWidget == EGameTypeWidget.square ? "RAN" : "INR"}",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
//                key: keyBody,
                child: GestureDetector(
                  onPanUpdate: compareGesture,
                  onPanEnd: onPanEnd,
                  onPanStart: onPanStart,
                  child: bodyGame(widget.typeWidget, widget.data, widget.keys,
                      widget.states),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Color(0xff0D442D), shape: BoxShape.circle),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Color(0xff0D442D), shape: BoxShape.circle),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Color(0xff0D442D), shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
            ),
          ],
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

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new ButtonGame("QUIT", true, Colors.white),
            new ButtonGame("321", false, Color(0xffF9E922)),
            new ButtonGame("Skip", true, Colors.white),
          ],
        ),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Text(
                "What's is animal name?".toUpperCase(),
                style: TextStyle(
                    color: Color(0xff00A293),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.menu,
                  color: Color(0xff00A293),
                  size: 36,
                ))
          ],
        ),
      ),
    );
  }
}

class ButtonGame extends StatelessWidget {
  String text;
  bool isHasOnPress;
  Color color;

  ButtonGame(
      @required this.text, @required this.isHasOnPress, @required this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          color: Color(0xff0D5F5A),
          child: FlatButton(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                  color: color, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

enum EGameTypeWidget { polygon, square }
