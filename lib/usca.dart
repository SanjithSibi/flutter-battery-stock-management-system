import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_d/uadcat.dart';
import 'package:flutter_d/uupcat.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyAnn());
}

class MyAnn extends StatelessWidget {
  const MyAnn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Hom(),
      routes: <String, WidgetBuilder>{
        '/addCat': (BuildContext context) => new Add()
      },
    );
  }
}

Future<List> getData() async {
  var url = "http://192.168.26.168/api/getucat.php";
  final response = await http.get(Uri.parse(url));
  var dataRecieved = jsonDecode(response.body);

  return dataRecieved;
}

class Hom extends StatefulWidget {
  const Hom({Key? key}) : super(key: key);

  @override
  State<Hom> createState() => _HomState();
}

class _HomState extends State<Hom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalogue'),
      ),
      body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print("error in loading" + snapshot.error.toString());
            }
            return snapshot.hasData
                ? new IemList(
                    list: snapshot.data,
                  )
                : new Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

class IemList extends StatelessWidget {
  final List list;
  const IemList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Update(
                              id: list[i]['ID'],
                              name: list[i]['NAME'],
                              price: list[i]['PRICE'],
                              description: list[i]['DESCRIPTION'],
                            )));
              },
              leading: CircleAvatar(
                child: Text(
                    list[i]['NAME'].toString().substring(0, 1).toUpperCase()),
              ),
              title: new Text(
                list[i]['NAME'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
  }
}
