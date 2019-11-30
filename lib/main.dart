import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import './user_pro.dart';
import './Screens/home.dart';
import 'Screens/register_entries.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Machine',
      theme: ThemeData(
        accentColor: Colors.amber,
        primaryColor: Colors.orange,
        fontFamily: 'Able',
        textTheme: TextTheme(
          button: TextStyle(fontSize: 18),
        ),
      ),
      home: new StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({
    Key key,
  }) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  int _counter ;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  //Incrementing counter after click
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CheckUser(),
              _counter==0?
              Home():Entries(),
            ],
          ),
        ),
      ),
    );
  }
}
