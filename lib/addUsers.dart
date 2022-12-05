import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUsers extends StatefulWidget {
  const AddUsers({Key? key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  final txtFullName = new TextEditingController();
  final txtEmail = new TextEditingController();
  bool _valName = false;
  bool _valEmail = false;

  Future _saveDetails(String name, String email) async {
    var url = "http://192.168.26.168/api/savedata.php";
    final response =
        await http.post(Uri.parse(url), body: {"name": name, "email": email});
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
    txtEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Users'),
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
              controller: txtEmail,
              decoration: new InputDecoration(
                hintText: 'Phone No',
                hintStyle: TextStyle(fontSize: 17.0),
                labelText: 'Phone No',
                labelStyle: TextStyle(fontSize: 17.0),
                errorText: _valEmail ? 'Phone No Can\'t Be Empty' : null,
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
                      txtEmail.text.isEmpty
                          ? _valEmail = true
                          : _valEmail = false;
                      if (_valName == false && _valEmail == false) {
                        _saveDetails(txtFullName.text, txtEmail.text);
                      }
                    });
                  },
                ),
                OutlinedButton(
                  child: Text('Clear'),
                  onPressed: () {
                    txtFullName.clear();
                    txtEmail.clear();
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
