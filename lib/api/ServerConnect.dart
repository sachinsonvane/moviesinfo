
import 'package:moviesinfo/model/LoginInfo.dart';
import 'package:moviesinfo/utils/Constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesinfo/utils/Utilities.dart';
import 'dart:async';
import 'dart:convert';

class ServerConnect{

  Future<LoginInfo> fetchLogin(http.Client client,String cUrl,context) async {
    Constants constants = Constants();
    Utilities utilities = Utilities();
    //http://www.omdbapi.com?t=Guardians&y=2017&apikey=95d3a066
    final response = await http.get(cUrl);
    print("H4 "+response.body.toString());
    print("H5 code "+response.statusCode.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = json.decode(response.body);
      var res = data["Response"] as String;

      LoginInfo loginInfo = null;
      if(res=="True"){
        var title = data["Title"] as String;
        var year = data["Year"] as String;
        loginInfo = LoginInfo(title,year);
      }else{
        var errorMsg = data["Error"] as String;
        utilities.showAlert(constants.LOGIN_FAILED_MSG,errorMsg,context);
      }

      return loginInfo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      utilities.showAlert(constants.NETWORK_TITLE_MSG,constants.NETWORK_DESC_MSG,context);
      return null;
    }
  }
}