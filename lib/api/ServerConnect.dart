
import 'package:moviesinfo/model/LoginInfo.dart';
import 'package:moviesinfo/model/SearchMovieItem.dart';
import 'package:moviesinfo/utils/Constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesinfo/utils/Utilities.dart';
import 'dart:async';
import 'dart:convert';
import 'package:moviesinfo/model/Ratings.dart';

class ServerConnect{

  Future<LoginInfo> fetchLogin(http.Client client,String cUrl,context) async {
    Constants constants = Constants();
    Utilities utilities = Utilities();
    //http://www.omdbapi.com?t=Guardians&y=2017&apikey=95d3a066
    final response = await http.get(cUrl);
    //print("H4 "+response.body.toString());
    //print("H5 code "+response.statusCode.toString());
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

  Future<List<SearchMovieItem>> fetchSearchMovies(http.Client client,String cUrl,context) async {

    Constants constants = Constants();
    Utilities utilities = Utilities();
    //http://www.omdbapi.com/?s=Guardians&apikey=95d3a066
    //http://www.omdbapi.com/?s=Guardians&type=movie&apikey=95d3a066
    final response = await http.get(cUrl);
    //print("S4 "+response.body.toString());
    //print("S5 code "+response.statusCode.toString());
    List<SearchMovieItem> searchMevItemList = [];
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = json.decode(response.body);
      var resErr = data["Response"] as String;
      if(resErr=="True"){
        var res = data["Search"] as List;
        var totalResults = data["totalResults"] as String;
        for(Map<String,dynamic> obj in res) {
          var title = obj["Title"] as String;
          var year = obj["Year"] as String;
          var imdbID = obj["imdbID"] as String;
          var type = obj["Type"] as String;
          var poster = obj["Poster"] as String;
          SearchMovieItem searchMovieItem = SearchMovieItem(title,year,imdbID,type,poster,totalResults);
          var raUrl = constants.BASE_URL+"/?i="+imdbID+"&apikey="+constants.API_KEY;
          final ratingsRes = await http.get(raUrl);
          var ratingsData = json.decode(ratingsRes.body);
          var ratingResErr = ratingsData["Response"] as String;
          if(ratingResErr=="True"){
            var ratingsArr = ratingsData["Ratings"] as List;
            for(Map<String,dynamic> ratingsObj in ratingsArr) {
              var source = ratingsObj["Source"] as String;
              var value = ratingsObj["Value"] as String;
              searchMovieItem.mRataingsList.add(Ratings(source,value));
            }
          }
          searchMevItemList.add(searchMovieItem);
        }
      }else{
        var errorMsg = data["Error"] as String;
        utilities.showAlert(constants.SEARCH_FAILED_MSG,errorMsg,context);
      }

      return searchMevItemList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      utilities.showAlert(constants.NETWORK_TITLE_MSG,constants.NETWORK_DESC_MSG,context);
      return null;
    }
  }

}