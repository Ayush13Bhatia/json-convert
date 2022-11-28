import 'dart:convert';

import 'package:flutter/material.dart';

import 'json_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = jsonFile.toString();

  void _incrementCounter() {
    List<Map<String, dynamic>> filterData = [];

    for (int i = 0; i < jsonFile.length; i++) {
      var cls = jsonFile[i]['Class'];

      List<Map<String, dynamic>> students = [];
      for (var d in jsonFile) {
        if (jsonFile[i]['Class'] == d['Class']) {
          if (students.isEmpty || students.any((e) => e['RollNo'] != d['RollNo'])) {
            students.add({
              'Name': d['Name'],
              'RollNo': d["RollNo"],
            });
          } else {
            students = [];
          }
        }
      }
      var md = {'Class': cls, "Student": students};
      if (filterData.isEmpty || filterData.any((element) => element['Class'] != cls)) {
        filterData.add(md);
      }
    }
    data = filterData.map((e) => e).toString();
    print(data);
    setState(() {});
  }
  //
  // List<Map<String, dynamic>> getStudent() {
  //   return [];
  // }
  //   for (var i = 0; i < jsonFile.length; i++) {
  //     var cl = jsonFile[i]['Class'];
  //     var students = getStudentList(jsonFile[i]);
  //
  //     var m = {'Class': cl, 'student': students};
  //     if (mk.isEmpty || mk.any((e) => e['Class'] != cl)) {
  //       mk.add(m);
  //     }
  //   }
  //   data = mk.map((e) => e).toString();
  //
  //   setState(() {});
  // }
  //
  // List<Map<String, dynamic>> getStudentList(Map<String, dynamic> data) {
  //   List<Map<String, dynamic>> student = [];
  //   for (var d in jsonFile) {
  //     if (data['Class'] == d['Class']) {
  //       if (student.isEmpty || student.any((e) => e['RollNo'] != d['RollNo'])) {
  //         student.add({'Name': d['Name'], 'RollNo': d['RollNo']});
  //       }
  //     }
  //   }
  //   return student;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              data,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
