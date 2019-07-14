import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class PolygonItem extends StatefulWidget {
  String text;
  int flex;
  bool state;
  GlobalKey globalKey;

  PolygonItem(@required this.text, @required this.flex, @required this.state,
  @required this.globalKey);

  @override
  _PolygonItemState createState() => _PolygonItemState();
}

class _PolygonItemState extends State<PolygonItem> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: widget.globalKey,
      flex: widget.flex,
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
                color: widget.state ? Colors.yellow : Colors.white,
              ),
              Center(
                child: Text(
                  widget.text.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
