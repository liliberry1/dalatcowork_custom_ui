import 'package:custom_ui/main.dart';
import 'package:flutter/material.dart';

class SquareView extends StatefulWidget {
  int numberOfItemInRowCenter = 5;
  List<String> data = List();
  List<GlobalKey> keys = List();
  List<bool> states = List();

  SquareView(
    @required this.data,
    @required this.keys,
    @required this.states,
    @required this.numberOfItemInRowCenter,
  ) {
    if (numberOfItemInRowCenter < 5) {
      numberOfItemInRowCenter = 5;
      print('With Square, numberOfItemInRowCenter must larger or equal 5');
    }
  }

  @override
  _SquareViewState createState() => _SquareViewState();
}

class _SquareViewState extends State<SquareView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: body(widget.data, widget.keys, widget.states, size)),
    );
  }

  List<Widget> body(
      List<String> data, List<GlobalKey> keys, List<bool> states, Size size) {
    List<Widget> rows = List();
    var dataTemp = List();
    var keysTemp = List();
    var statesTemp = List();
    int numSkip = 0;
    for (int i = 0; i <= widget.numberOfItemInRowCenter; i++) {
      if (i == 0) {
        dataTemp = data.take(widget.numberOfItemInRowCenter).toList();
        keysTemp = keys.take(widget.numberOfItemInRowCenter).toList();
        statesTemp = states.take(widget.numberOfItemInRowCenter).toList();
      } else {
        dataTemp =
            data.skip(numSkip).take(widget.numberOfItemInRowCenter).toList();
        keysTemp =
            keys.skip(numSkip).take(widget.numberOfItemInRowCenter).toList();
        statesTemp =
            states.skip(numSkip).take(widget.numberOfItemInRowCenter).toList();
      }
      rows.add(rowBody(dataTemp, keysTemp, statesTemp, size));
      numSkip += widget.numberOfItemInRowCenter;
    }
    return rows;
  }

  Widget rowBody(
      List<String> data, List<GlobalKey> keys, List<bool> states, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: data
          .asMap()
          .map((index, text) => MapEntry(
              index,
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Container(
                      width: size.width / (widget.numberOfItemInRowCenter + 1),
                      key: keys[index],
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: states[index] ? Colors.orange : Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Text(
                            text.toUpperCase(),
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )))
          .values
          .toList(),
    );
  }
}
