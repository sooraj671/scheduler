import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double left = 150;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(seconds: 2),
              left: left,
              top: 400,
              child: Icon(
                Icons.sunny,
                color: Colors.white,
                size: 55,
              ),
            ),
            Positioned(
              top: 500,
              left: 110,
              child: InkWell(
                onTap: () {
                  setState(() {
                    left = left != 150 ? 150 : 200;
                  });
                },
                child: Container(
                  height: 50,
                  width: 140,
                  color: Colors.blue,
                  child: Center(
                    child: Text("Change"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}