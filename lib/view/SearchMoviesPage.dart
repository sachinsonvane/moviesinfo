import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesinfo/model/LoginInfo.dart';
import 'dart:async';
import 'dart:convert';
import 'package:permission/permission.dart';
import 'package:moviesinfo/utils/Constants.dart';

class SearchMoviesPage extends StatefulWidget{

  @override
  _SearchMoviesPage createState() => _SearchMoviesPage();
}
//Navigator.pop(context);
class _SearchMoviesPage extends State<SearchMoviesPage>{

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
  }

