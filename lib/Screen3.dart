import 'package:flutter/material.dart';
import 'user.dart'; // Import your user model
import 'database_helper.dart'; // Import your database helper

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<User> userList = [];
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    readDataFromDatabase();
  }

  Future<void> readDataFromDatabase() async {
    // Read data from the SQLite database
    final users = await dbHelper.getUsers();
    setState(() {
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local User List Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display the list of users from the local database
          // TODO: Implement the UI to display the local user list
        ],
      ),
    );
  }
}
