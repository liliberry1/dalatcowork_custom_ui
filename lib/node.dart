import 'package:flutter/material.dart';
import 'point_in_matrix.dart';

class Node extends StatelessWidget {
  bool state;
  String label;
  PointInMatrix point;

  Node({@required this.label, @required this.point, @required this.state});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: state ? Colors.orange : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Colors.grey, width: 1)),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
