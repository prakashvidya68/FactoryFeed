import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
// import '../Services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Container(
          child: new Login(),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: 'E-mail'),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text('Login'),
          onPressed: () {
            // authService.googleSignIn().then((user) {
            //   queryParameters['email'] = user.email;
            //   queryParameters['loginMethod'] = '2';
            //   queryParameters['name'] = user.displayName;
            //   user.getIdToken(refresh: true).then((usrTokenId) {
            //     queryParameters['token'] = usrTokenId.token;
            //   });
            // }).whenComplete(() {
            //   fetchPost().then((response) {
            //     print(response.body);
            //   });
            // });
          },
        )
      ],
    );
  }
}

var queryParameters = {
  'email': '',
  'loginMethod': '',
  'name': '',
  'token': ''
};

Future<http.Response> fetchPost() async {
  print(queryParameters);
  var response;

  var client = new http.Client();
  try {
    var uriResponse = await client.post(
        'https://taxheal.in/dashboard/firebase/login.php',
        body: queryParameters);

    response = client.get(uriResponse.body);
    print(await client.get(uriResponse.body));
  } finally {
    client.close();
  }

  return response;
}

void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
