import 'package:flutter/material.dart';
import 'package:flutter_d/usca.dart';
import 'admval.dart';
import "validation.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ero Batteries',

      // to hide debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ButtonsExample(),
    );
  }
}

// list all the buttons
class ButtonsExample extends StatelessWidget {
  // const ButtonsExample ({Key ?key}) : super(key:key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  ButtonsExample({Key? key}) : super(key: key);

  // ignore: avoid_print

// assign actions to
// all the listed buttons
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Ero Batteries'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(),
              // FlatButton is Deprecated and will be removed in the future.
              // We recommend using TextButton instead.
              // FlatButton(
              //   minWidth: MediaQuery.of(context).size.width,
              //   onPressed: () {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(
              //         content: Text("Text / Flat Button"),
              //         duration: Duration(seconds: 1),
              //       ),
              //     );
              //   },
              //   child: const Text('Flat Button'),
              // ),
              SizedBox(
                height: 100,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                label: const Text('Dealer'),
              ),
              SizedBox(
                height: 50,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                label: const Text('Admin'),
              ),
              SizedBox(
                height: 50,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyAnn()),
                  );
                },
                label: const Text('User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
