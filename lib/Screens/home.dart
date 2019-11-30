import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Widgets/auto_complete_textfield.dart';
import '../Services/dummy_data.dart';
import '../Services/auth_services.dart';

import '../Screens/register_entries.dart';
import '../Widgets/shift_selection.dart';
import '../Widgets/machine_selecter.dart';

String path='';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseDatabase.instance.reference();
    final _batchController = TextEditingController();
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              children: <Widget>[
                Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Image.asset('images/image.jpg'),
                    Positioned(
                      bottom: -45,
                      child: Card(
                        color: Colors.white,
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70)),
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset('images/Jindal.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Select Shift',
                  ),
                ),
                ShiftSelect(),
                SizedBox(
                  height: 13,
                ),
                SelectMachine(),
                Text('Enter Batch Code:'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                  child: Card(
                    elevation: 22,
                    child: TextFormField(
                      controller: _batchController,
                      onChanged: (val) {
                        userData.batchCode = val;
                      },
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(),
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(90),
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        filled: true,
                        icon: Icon(Icons.code),
                        hintText: 'Enter the batch code',
                        labelText: 'Batch Code',
                      ),
                      onSaved: (String value) {
                        userData.batchCode = value;
                      },
                    ),
                  ),
                ),
                SearchField(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: RaisedButton(
                    child: Text('Record Entry'),
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      if (userData.selectedMachine.machineName == '' ||
                          userData.selectedShift == '' ||
                          userData.batchCode == '' ||
                          userData.selectedItem == '') {
                        Fluttertoast.showToast(
                            msg: "Complete the form",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Map<dynamic, dynamic> data = {
                          'selected Machine':
                              userData.selectedMachine.machineName,
                          'Selected Shift': userData.selectedShift,
                          'Selected batch': userData.batchCode,
                          'Selected SecrchItem': userData.selectedItem,
                          'Entry Time':DateTime.now().toString(),
                        };
                        path='ShiftEntry/${DateTime.now().toString()}';
                        path= path.replaceAll('-', '');
                        path=path.replaceAll(' ','');
                        path=path.replaceAll(':','');
                        path=path.replaceAll('.','');
                        print(path);
                        db
                            .child(path)
                            .set(data)
                            .whenComplete(() {
                          print(data);
                          _incrementCounter();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Entries(path:path),
                            ),
                          );
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return RaisedButton(
            onPressed: () {
              authService.googleSignIn();
            },
            color: Colors.transparent,
            child: Text(
              'Signin with GOOGLE',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }
}

_incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('counter', 1);
}

