import 'package:flutter/material.dart';
import 'Services/auth_services.dart';

class CheckUser extends StatefulWidget {
  @override
  CheckUserState createState() => CheckUserState();
}

class CheckUserState extends State<CheckUser> {
  var _loading = false;

  @override
  initState() { 
    super.initState();

    authService.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? Center(child: CircularProgressIndicator()) : SizedBox();
  }
}
