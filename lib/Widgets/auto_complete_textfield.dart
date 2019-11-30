import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


import 'package:http/http.dart' as http;

import '../Services/dummy_data.dart';
import '../Services/user.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  AutoCompleteTextField searchTextField;
  static List<User> users = new List<User>();
  

  GlobalKey<AutoCompleteTextFieldState<User>> _key = new GlobalKey();

  @override
  void initState() {
    super.initState();
    getUsers();
  }
  var loading = true;


  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
            child: Card(
              elevation: 20,
              child: searchTextField = AutoCompleteTextField<User>(
                key: _key,
                clearOnSubmit: false,
                suggestions: users,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabled: true,
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
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  labelText: "Search Item",
                ),
                itemFilter: (item, query) {
                  return item.name
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                },
                itemSorter: (a, b) {
                  return a.name.compareTo(b.name);
                },
                itemSubmitted: (item) {
                  setState(() {
                    searchTextField.textField.controller.text = item.name;
                    userData.selectedItem = item.name;
                  });
                  print(userData.selectedItem);
                },
                itemBuilder: (context, item) {
                  // ui for the autocomplete row
                  return searchItemRow(item);
                },
              ),
            ),
          );
  }

  void getUsers() async {
    try {
      final response =
          await http.get("https://api.jsonbin.io/b/5d429ea835e3f814032deb82");
      if (response.statusCode == 200) {
        users = loadUsers(response.body);
        print('Items: ${users.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<User> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  Widget searchItemRow(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          user.name,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          user.email,
        ),
      ],
    );
  }
}
