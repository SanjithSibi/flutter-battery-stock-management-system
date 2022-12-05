import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Update extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  final String description;

  const Update(
      {super.key,
      required this.id,
      required this.name,
      required this.price,
      required this.description});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final txtFullName = new TextEditingController();
  final txtPrice = new TextEditingController();
  final txtDescription = new TextEditingController();
  bool _valName = false;
  bool _valPrice = false;
  bool _valDescription = false;

  Future _updateDetails(String name, String price, String description) async {
    var url = "http://192.168.26.168/api/updateucat.php";
    final response = await http.post(Uri.parse(url), body: {
      "name": name,
      "price": price,
      "description": description,
      "id": widget.id
    });
    var res = response.body;
    if (res == "true") {
      Navigator.pop(context);
    } else {
      print("Error:" + res);
    }
  }

  Future _deleteUser() async {
    var url = "http://192.168.26.168/api/deleteucat.php";
    final response = await http.post(Uri.parse(url), body: {"id": widget.id});
    var res = response.body;
    if (res == "true") {
      Navigator.pop(context);
    } else {
      print("Error:" + res);
    }
  }

  @override
  void dispose() {
    txtFullName.dispose();
    txtPrice.dispose();

    txtDescription.dispose();
    super.dispose();
  }

  @override
  void initState() {
    txtFullName.text = widget.name;
    txtPrice.text = widget.price;

    txtDescription.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: new InputDecoration(
                hintText: 'Full Name',
                hintStyle: TextStyle(fontSize: 17.0),
                labelText: 'Full Name',
                labelStyle: TextStyle(fontSize: 17.0),
                errorText: _valName ? 'Name Can\'t Be Empty' : null,
              ),
              controller: txtFullName,
            ),
            TextField(
              controller: txtPrice,
              decoration: new InputDecoration(
                hintText: 'Price',
                hintStyle: TextStyle(fontSize: 17.0),
                labelText: 'Price',
                labelStyle: TextStyle(fontSize: 17.0),
                errorText: _valPrice ? 'Price Can\'t Be Empty' : null,
              ),
            ),
            TextField(
              controller: txtDescription,
              decoration: new InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(fontSize: 17.0),
                labelText: 'Description',
                labelStyle: TextStyle(fontSize: 17.0),
                errorText: _valDescription ? 'This Can\'t Be Empty' : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
