import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class PolyGon extends StatefulWidget {
  List<String> data = List();
  List<GlobalKey> keys = List();
  List<bool> states = List();
  int numberOfItemInRowCenter = 0;
  final min = 3;

  PolyGon(@required this.data, @required this.keys, @required this.states,
      @required this.numberOfItemInRowCenter) {
    if (this.numberOfItemInRowCenter < 3) {
      this.numberOfItemInRowCenter = 3;
      print('With PolyGon, numberOfItemInRowCenter must larger of equal 3');
    }
  }

  @override
  _PolyGonState createState() => _PolyGonState();
}

class _PolyGonState extends State<PolyGon> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("size poly gon ${size}");
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: body(widget.data, widget.keys, widget.states, size),
      ),
    );
  }

  List<Widget> body(
      List<String> data, List<GlobalKey> keys, List<bool> states, Size size) {
    List<Widget> rows = List();
    var dataTemp = List();
    var keysTemp = List();
    var statesTemp = List();
    int numSkip = 0;

    for (int i = widget.min; i <= widget.numberOfItemInRowCenter; i++) {
        dataTemp = data.skip(numSkip).toList().take(i).toList();
        keysTemp = keys.skip(numSkip).toList().take(i).toList();
        statesTemp = states.skip(numSkip).toList().take(i).toList();
        numSkip += i;

      rows.add(rowBody(dataTemp, keysTemp, statesTemp, size));
    }

    for (int i = widget.numberOfItemInRowCenter - 1; i >= widget.min; i--) {
        dataTemp = data.skip(numSkip).toList().take(i).toList();
        keysTemp = keys.skip(numSkip).toList().take(i).toList();
        statesTemp = states.skip(numSkip).toList().take(i).toList();
        numSkip +=i;
      rows.add(rowBody(dataTemp, keysTemp, statesTemp, size));
    }

    return rows;
  }

  Widget rowBody(
      List<String> data, List<GlobalKey> keys, List<bool> states, Size size) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: data
            .asMap()
            .map((index, data) => MapEntry(
                index,
                Container(
                    width: size.width / widget.numberOfItemInRowCenter,
                    height: size.width / widget.numberOfItemInRowCenter,
                    child: ClipPolygon(
                      borderRadius: 5,
                      sides: 6,
                      boxShadows: [
                        PolygonBoxShadow(color: Colors.black, elevation: 4),
                        PolygonBoxShadow(color: Colors.orange, elevation: 6),
                      ],
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              key: keys[index],
                              color:
                                  states[index] ? Colors.orange : Colors.white,
                            ),
                            Center(
                              child: Text(
                                data.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))))
            .values
            .toList(),
      ),
    );
  }
}
