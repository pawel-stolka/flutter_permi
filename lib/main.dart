import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'enums/connectivity_status.dart';
import 'enums/flavor.dart';

void main() {
  runApp(Provider<Flavor>.value(
    value: Flavor.dev,
    child: MyApp(),
  ));
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
  StreamSubscription<ConnectivityResult> subscription;
  ConnectivityStatus _status = ConnectivityStatus.Offline;
  String status = "Offline";

  initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        var _status;
        if(result == ConnectivityResult.none)
          _status = 'Offline';
        if(result == ConnectivityResult.mobile)
          _status = 'Mobile';
          if(result == ConnectivityResult.wifi)
          _status = 'WiFi is not good...';
        setState(() {
          status = _status;
          // status = result.toString();
          
        });
        print("Connection Status has Changed $result");
    });
  }

  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flavor = Provider.of<Flavor>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$flavor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              'status: $status',
            ),

          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
