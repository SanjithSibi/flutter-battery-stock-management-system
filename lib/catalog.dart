import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'daCat.dart';
import 'duCat.dart';

void main() {
  runApp(const My());
}

class My extends StatelessWidget {
  const My({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Ho(),
      routes: <String, WidgetBuilder>{
        '/addCa': (BuildContext context) => new AddCa()
      },
    );
  }
}

Future<List> getData() async {
  var url = "http://192.168.26.168/api/getCon.php";
  final response = await http.get(Uri.parse(url));
  var dataRecieved = jsonDecode(response.body);

  return dataRecieved;
}

class Ho extends StatefulWidget {
  const Ho({Key? key}) : super(key: key);

  @override
  State<Ho> createState() => _HoState();
}

class _HoState extends State<Ho> {
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
                ? new ItemLis(
                    list: snapshot.data,
                  )
                : new Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

class ItemLis extends StatelessWidget {
  final List list;
  const ItemLis({Key? key, required this.list}) : super(key: key);

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
                        builder: (context) => UpdateCa(
                              id: list[i]['ID'],
                              name: list[i]['NAME'],
                              price: list[i]['PRICE'],
                              availability: list[i]['AVAILABILITY'],
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
