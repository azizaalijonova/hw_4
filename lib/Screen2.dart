// Screen2.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'database_helper.dart';
import 'Screen3.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<User> userList = [];
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse('https://api.example.com/users'));
    if (response.statusCode == 200) {
      setState(() {
        userList = List<User>.from(
            json.decode(response.body).map((data) => User.fromJson(data)));
      });
    }
  }

  void _getMoreUsers() {}

  void _storeDataLocally() async {
    await dbHelper.insertUsers(userList);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Data stored locally')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List Screen'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: userList.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(userList[index].name),
                            subtitle: Text(userList[index].email),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _getMoreUsers,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  child: Text('Get More Users'),
                ),
                ElevatedButton(
                  onPressed: _storeDataLocally,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('Store Data Locally'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Screen3()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text('Go to Screen3'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
