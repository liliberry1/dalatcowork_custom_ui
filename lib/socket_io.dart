import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
//import 'package:flutter_socket_io/socket_io_manager.dart';

class SocketIOPage extends StatefulWidget {

    final url = 'https://blooming-wave-16517.herokuapp.com';

    @override
  _SocketIOPageState createState() => _SocketIOPageState();
}

class _SocketIOPageState extends State<SocketIOPage> {
  String dataK;
  SocketIO socket;
  Map<String, dynamic> arguments = Map();

  onSocket() async{
    arguments["user_name"] = "Tinh phan";
    arguments["password"] = "1234";
    socket  = await SocketIOManager().createInstance(SocketOptions(widget.url));
    socket.onConnect((data){
      print("Data Of Socket $data");
      socket.emit("CREATE_USER", [json.encode(arguments)]);
    });

    socket.on("CREATED_USER", (data){
      print("CREATED_USER: $data");
      setState(() {
        dataK = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: onSocket,
              child: Text("Emit Data"),
            ),
            Text(
              dataK,
              style: TextStyle(fontSize: 22),
            )
          ],
        ),
      ),
    );
  }
}
