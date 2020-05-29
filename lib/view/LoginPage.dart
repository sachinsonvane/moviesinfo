import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesinfo/api/ServerConnect.dart';
import 'package:moviesinfo/model/LoginInfo.dart';
import 'package:moviesinfo/view/SearchMoviesPage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:permission/permission.dart';
import 'package:moviesinfo/utils/Constants.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  PermissionName permissionName = PermissionName.Internet;
  final _formKey = GlobalKey<FormState>();
  final mUserNameController = TextEditingController(text: "Guardians");
  final mPasswordController = TextEditingController(text: "2017");
  ServerConnect serverConnect = ServerConnect();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final emailField = TextFormField(
      obscureText: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter movie title';
        }
        return null;
      },
      controller: mUserNameController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",

          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextFormField(
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter movie relese year';
        }
        return null;
      },
      controller: mPasswordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            print("H1");
            if (_formKey.currentState.validate()) {
              doLogin(context);
             /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchMoviesPage()),
              );*/
            }
          },
          child: Text("Login",
            textAlign: TextAlign.center,
          ),
        ));

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: 45.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButon,
                  SizedBox(
                    height: 15.0,
                  ),

                ],
              ),),
          ),
        ),
      ),
    );
  }

  Future<void> doLogin(context) async{

    var username = mUserNameController.text.toString().trim();
    var password = mPasswordController.text.toString().trim();
    // If the form is valid, display a Snackbar.
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
    Constants constants = Constants();
    print("H2");

    LoginInfo loginInfo = await serverConnect.fetchLogin(http.Client(),
        constants.BASE_URL + "/?t="+username+"&y="+password+ "&apikey=" +
            constants.API_KEY,context);

    if(loginInfo!=null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchMoviesPage()),
      );
    }
  }
}
