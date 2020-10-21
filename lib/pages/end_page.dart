import 'package:flutter/material.dart';

class EndPage extends StatefulWidget {
  @override
  _EndPageState createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey[200],
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.black54,
                  width: 2
              )
          ),
          child: Container()
        ),
      ),
    );
  }
}
