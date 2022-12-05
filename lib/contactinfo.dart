import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_d/addUsers.dart';
import 'package:flutter_d/updateUsers.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyAp());
}

class MyAp extends StatelessWidget {
  const MyAp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/addUsers': (BuildContext context) => new AddUsers()
      },
    );
  }
}

Future<List> getData() async {
  var url = "http://192.168.26.168/api/getdata.php";
  final response = await http.get(Uri.parse(url));
  var dataRecieved = jsonDecode(response.body);

  return dataRecieved;
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print("error in loading" + snapshot.error.toString());
            }
            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data,
                  )
                : new Center(
                    child: CircularProgressIndicator(),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addUsers');
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({Key? key, required this.list}) : super(key: key);

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
                        builder: (context) => UpdateUsers(
                              id: list[i]['ID'],
                              name: list[i]['NAME'],
                              email: list[i]['EMAIL'],
                            )));
              },
              leading: CircleAvatar(
                child: Text(
                    list[i]['NAME'].toString().substring(0, 1).toUpperCase()),
              ),
              title: new Text(
                list[i]['NAME'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle:
                  new Text(list[i]['EMAIL'], style: TextStyle(fontSize: 15)),
            ),
          );
        });
  }
}
