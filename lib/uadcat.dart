import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final txtFullName = new TextEditingController();
  final txtPrice = new TextEditingController();
  final txtDescription = new TextEditingController();
  bool _valName = false;
  bool _valPrice = false;
  bool _valDescription = false;

  Future _saveDetail(String name, String price, String description) async {
    var url = "http://192.168.26.168/api/saveucat.php";
    final response = await http.post(Uri.parse(url),
        body: {"name": name, "price": price, "description": description});
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: new InputDecoration(
                hintText: ' Name',
                hintStyle: TextStyle(fontSize: 17.0),
                labelText: ' Name',
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
                errorText: _valPrice ? 'Price No Can\'t Be Empty' : null,
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
            ButtonBar(
              children: <Widget>[
                OutlinedButton(
                  child: Text('Save Details'),
                  onPressed: () {
                    setState(() {
                      txtFullName.text.isEmpty
                          ? _valName = true
                          : _valName = false;
                      txtPrice.text.isEmpty
                          ? _valPrice = true
                          : _valPrice = false;
                      if (_valName == false && _valPrice == false) {
                        _saveDetail(txtFullName.text, txtPrice.text,
                            txtDescription.text);
                      }
                    });
                  },
                ),
                OutlinedButton(
                  child: Text('Clear'),
                  onPressed: () {
                    txtFullName.clear();
                    txtPrice.clear();
                    txtDescription.clear();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
