import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart'; // Import your user model
import 'database_helper.dart'; // Import your database helper
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
    final response = await http.get(Uri.parse(
        'https://api.example.com/users')); // Replace with your API endpoint
    if (response.statusCode == 200) {
      // Parse the response and update the userList
      setState(() {
        userList = List<User>.from(
            json.decode(response.body).map((data) => User.fromJson(data)));
      });
    }
  }

  void _getMoreUsers() {
    // TODO: Implement logic to fetch more users from API
  }

  void _storeDataLocally() async {
    // Store selected data into SQLite database
    await dbHelper.insertUsers(userList);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Data stored locally')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display the list of users
          // TODO: Implement the UI to display the user list
          ElevatedButton(
            onPressed: _getMoreUsers,
            child: Text('Get More Users'),
          ),
          ElevatedButton(
            onPressed: _storeDataLocally,
            child: Text('Store Data Locally'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Screen3()),
              );
            },
            child: Text('Go to Screen3'),
          ),
        ],
      ),
    );
  }
}
