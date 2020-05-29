import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesinfo/api/ServerConnect.dart';
import 'package:moviesinfo/model/LoginInfo.dart';
import 'package:moviesinfo/model/SearchMovieItem.dart';
import 'package:moviesinfo/utils/Utilities.dart';
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
  final mSearchTxtController = TextEditingController(text: "Guardians");
  ServerConnect mServerConnect = ServerConnect();
  var mRefreshkey = GlobalKey<RefreshIndicatorState>();

  Utilities mUtilities = Utilities();
  String mSearchType = "NONE";
  List<SearchMovieItem> mAllSearchMovies = [];

  Future<Null> _refreshContent() async{
    print('refreshing stocks...');

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final searchTxtField = TextFormField(
      obscureText: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter movie title';
        }
        return null;
      },
      controller: mSearchTxtController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Search by title",

          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return Scaffold(
      body: RefreshIndicator(
          key: mRefreshkey,
          onRefresh: _refreshContent,
          child:  Container(
          padding: EdgeInsets.only(top: 16.0),
        child: CustomScrollView(
        slivers: <Widget>[

          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                padding: EdgeInsets.all(16.0),
                child:Form(
                  key: _formKey,
                  child:  Row(
                  children: <Widget>[

                    new DropdownButton<String>(
                      value: mSearchType,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          mSearchType = newValue;
                        });
                      },
                      items: <String>['NONE','movie', 'series', 'episode']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 45.0),
                    Expanded(
                        child: searchTxtField
                    ),
                    SizedBox(width: 45.0),
                    Material(
                      color: Colors.white,
                      child: Center(
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.lightBlue,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                doSearch(context);
                              }
                            },
                          ),
                        ),
                      ),
                    ),


                  ],
                )),
                color: Colors.grey[200],
                ),
              ],
            ),
          ),

          getGridView(),

        ]
      )))


      /*
      Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  Row(
                    children: <Widget>[

                      new DropdownButton<String>(
                          value: mSearchType,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              mSearchType = newValue;
                            });
                          },
                          items: <String>['NONE','movie', 'series', 'episode']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      SizedBox(width: 45.0),
                      Expanded(
                          child: searchTxtField
                      ),
                      SizedBox(width: 45.0),
                       Material(
                          color: Colors.white,
                          child: Center(
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.lightBlue,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.search),
                                color: Colors.white,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    doSearch(context);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),


                    ],
                  ),

                  SizedBox(
                    height: 15.0,
                  ),


                ],
              ),),
          ),
        ), */

    );
  }

  Widget getGridView(){

    if(mAllSearchMovies.length==0){
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
                alignment: Alignment.center,
                color: Colors.teal[100],
                child: Text('Record not found.',style: TextStyle(color: Colors.red[400]),),
            ),
          ],
        ),
      );
    }else {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('grid item'+mAllSearchMovies[index].title),
            );
          },
          childCount: mAllSearchMovies.length,
        ),
      );
    }
  }

  Future<void> doSearch(context) async{

    var searchTxt = mSearchTxtController.text.toString().trim();
  //  var password = mPasswordController.text.toString().trim();
    // If the form is valid, display a Snackbar.
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
    Constants constants = Constants();
    print("H2");

    if(mSearchType=="NONE"){

      mUtilities.showAlert("Search Type", "Select search type.", context);
    }else{
      var url = constants.BASE_URL + "/?s="+searchTxt+"&type="+mSearchType+"&apikey=" +constants.API_KEY;
      print("url "+url);
      mAllSearchMovies = await mServerConnect.fetchSearchMovies(http.Client(),url,context);

      print("mAllSearchMovies "+mAllSearchMovies.length.toString());
      if(mAllSearchMovies!=null){
        mRefreshkey.currentState?.show();
      }
    }
  }

  }

