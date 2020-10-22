import 'package:flutter/material.dart';
import '../widgets/other_widgets.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final OtherWidgets _otherWidgets = OtherWidgets();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:[
            Container(
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
            Positioned(top: 20, left: 15, child: _otherWidgets.backButton(context))
          ]
        ),
      ),
    );
  }
}
