import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var list = [Text("data"), Text("data"), Text("data")];
  void _incrementCounter() {
    setState(() {
      list.add(Text("data"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: 10),
            Container(
              width: 15,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.blueAccent,
              ),
            ),
            Expanded(
                child: Column(
              children: List.generate(list.length, (index) => list[index]),
            )),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
