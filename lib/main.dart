import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _num1 = 10;
  int _num2 = 20 ;
  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();
//
  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/calculator.txt');
  }

  Future<File> writeCounter(  value ) async {
    final file = await _localFile;

    // Write the file.

    return file.writeAsString('$value');
  }


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;

    });

  }

  Widget _button (String number, Function() f){ // Creating a method of return type Widget with number and function f as a parameter
    return MaterialButton(
      height: 100.0,
      child: Text(number,
          style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
      textColor: Colors.black,
      color: Colors.grey[100],
      onPressed: f,
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:  Container(
        child: Column( //Since we have multiple children arranged vertically, we are using column
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equal vertical space between all the children of column
          children: <Widget>[ // the column widget uses the children property
           TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Num 1 ",


              ),
           ),
             TextField(
               controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Num 2 ",

              ),
           ),
            RaisedButton(
              onPressed: (){
                int n1 = int.parse(num1Controller.text);
                int n2 = int.parse(num2Controller.text);
                int sum = n1+n2;
                int mul = n1 * n2;
                int sub = n1 - n2;
                if(n2 == 0)
                  n2 = 1;
                double div = n1 / n2;
                var result = '\nN1 = $n1 , N2 = $n2\nN1 + N2 = $sum\nN1 - N2 = $sub\nN1 * N2 = $mul\nN1 / N2 = $div\n\n';
                writeCounter(result);
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                );

              },
              child: Text("Submit"),
            ),

          ],
        ),
      ),



      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
