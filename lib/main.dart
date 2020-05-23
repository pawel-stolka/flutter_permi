import 'package:flutter/material.dart';
import 'package:permi/services/connectivity_service.dart';
import 'package:provider/provider.dart';

import 'enums/connectivity_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
Widget build(BuildContext context) {
  return StreamProvider<ConnectivityStatus>(
    builder: (context) => ConnectivityService().connectionStatusController,
    create: (BuildContext context) {  },
    child: MaterialApp(
      title: 'Connectivity Aware UI',
      theme: ThemeData(
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white)),
      home: HomeView(),
    ),
  );
}
}
