import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'enums/flavor.dart';

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
  // ConnectivityStatus _status = ConnectivityStatus.Offline;
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

            FlatButton(
              child: Text('Click me'),
              onPressed: () {
                Alert(
                  context: context, 
                  title: 'rflutter_alert',
                  desc: 'this is description',
                  content: Form(
                    child: Column(
                      children: <Widget>[

                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Username"
                          ),
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password"
                          ),
                        )

                      ],
                    ),
                  )
                  // buttons: [

                  //   DialogButton(
                  //     child: Text('My button'),
                  //     onPressed: () {
                  //       print('my button pressed');
                  //       Navigator.pop(context);
                  //     },
                  //   ),

                  //   DialogButton(
                  //     child: Text('My button#2'),
                  //     onPressed: () {
                  //       print('my button#2 pressed');
                  //       Navigator.pop(context);
                  //     },
                  //   )

                  // ]
                ).show();
              }, 
            )

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
