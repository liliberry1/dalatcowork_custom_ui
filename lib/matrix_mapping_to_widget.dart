import 'dart:math';
import 'utils.dart';
import 'package:flutter/material.dart';
import 'node.dart';
import 'point_in_matrix.dart';

class MatrixMapping extends StatefulWidget {
  @override
  _MatrixMappingState createState() => _MatrixMappingState();
}

class _MatrixMappingState extends State<MatrixMapping> {
  List<List<String>> matrix = List();

  generatorMatrix() {
    Random random = Random();

    for (int i = 0; i < 6; i++) {
      List<String> row = List();
      for (int j = 0; j < 6; j++) {
        row.add("${random.nextDouble().round()}");
      }
      print("row: $i $row");
      matrix.add(row);
    }
  }

  @override
  void initState() {
    generatorMatrix();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: matrix
                  .asMap()
                  .map((indexColumn, row) {
                    return MapEntry(
                        indexColumn,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: row
                              .asMap()
                              .map((indexRow, data) {
                                return MapEntry(
                                  indexRow,
                                  Node(label: data, point: PointInMatrix
                                    (x:indexColumn,y: indexRow),
                                      state: false)
                                );
                              })
                              .values
                              .toList(),
                        ));
                  })
                  .values
                  .toList()),
        ),
      ),
    );
  }
}
