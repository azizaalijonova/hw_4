import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstLaunch = prefs.getBool('firstLaunch') ?? true;

    if (firstLaunch) {
      // Show tutorial/welcome screen
      // TODO: Implement your tutorial/welcome screen logic here

      // Mark as not the first launch
      prefs.setBool('firstLaunch', false);
    } else {
      // Navigate to the next screen (Screen2)
      Navigator.pushReplacementNamed(context, '/screen2');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Screen'),
      ),
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
