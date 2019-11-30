import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/login_screen.dart';
import '../Services/auth_services.dart';


class Conclude extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shift Summary'),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          FlatButton(
            child: Text('Log out'),
            onPressed: () {
              authService.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new SizedBox(
              height: 30,
            ),
            new FormFields(
              field: 'Band',
              hint: 'enter band',
            ),
            new FormFields(
              field: 'Scrap',
              hint: 'enter scrap generated',
            ),
            new FormFields(
              field: 'Production Bundles',
              hint: 'enter productio in bundle',
            ),
            new FormFields(
              field: 'Production weight',
              hint: 'enter production in Kg/grm',
            ),
            new RaisedButton(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Text('Shift Completed'),
              onPressed: () {
                print(shiftConclusion);
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
                _decrimentCounter();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FormFields extends StatefulWidget {
  final String field;
  final String hint;
  final Function fn;

  const FormFields({
    Key key,
    this.field,
    this.hint,
    this.fn,
  }) : super(key: key);

  @override
  _FormFieldsState createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  TextEditingController cntlr;

  @override
  void initState() {
    super.initState();
    cntlr = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        enabled: true,
        controller: cntlr,
        decoration: InputDecoration(
          labelText: widget.field,
          border: OutlineInputBorder(),
          hintText: widget.hint,
        ),
        onFieldSubmitted: (val) {
          shiftConclusion[widget.field] = val;
        },
        onEditingComplete: () {
          shiftConclusion[widget.field] = cntlr.text;
        },
        onChanged: (val) {
          shiftConclusion[widget.field] = val;
        },
      ),
    );
  }
}

Map<String, dynamic> shiftConclusion = {};

_decrimentCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('counter', 0);
}