import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateUsers extends StatefulWidget {
  final String id;
  final String name;
  final String email;

  const UpdateUsers(
      {super.key, required this.id, required this.name, required this.email});

  @override
  State<UpdateUsers> createState() => _UpdateUsersState();
}

class _UpdateUsersState extends State<UpdateUsers> {
  final txtFullName = new TextEditingController();
  final txtEmail = new TextEditingController();
  bool _valName = false;
  bool _valEmail = false;

  Future _updateDetails(String name, String email) async {
    var url = "http://192.168.26.168/api/updateUser.php";
    final response = await http.post(Uri.parse(url),
        body: {"name": name, "email": email, "id": widget.id});
    var res = response.body;
    if (res == "true") {
      Navigator.pop(context);
    } else {
      print("Error:" + res);
    }
  }

  Future _deleteUser() async {
    var url = "http://192.168.26.168/api/deleteUser.php";
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
    txtEmail.dispose();
    super.dispose();
  }

  @override
  void initState() {
    txtFullName.text = widget.name;
    txtEmail.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User'),
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
                hintText: 'Email id',
                hintStyle: TextStyle(fontSize: 17.0),
                labelText: 'Email id',
                labelStyle: TextStyle(fontSize: 17.0),
                errorText: _valEmail ? 'Email Can\'t Be Empty' : null,
              ),
            ),
            ButtonBar(
              children: <Widget>[
                OutlinedButton(
                  child: Text('Update Details'),
                  onPressed: () {
                    setState(() {
                      txtFullName.text.isEmpty
                          ? _valName = true
                          : _valName = false;
                      txtEmail.text.isEmpty
                          ? _valEmail = true
                          : _valEmail = false;
                      if (_valName == false && _valEmail == false) {
                        _updateDetails(txtFullName.text, txtEmail.text);
                      }
                    });
                  },
                ),
                OutlinedButton(
                  child: Text('Delete'),
                  onPressed: () {
                    _deleteUser();
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
