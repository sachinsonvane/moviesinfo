import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesinfo/api/ServerConnect.dart';
import 'package:moviesinfo/model/LoginInfo.dart';
import 'package:moviesinfo/model/Ratings.dart';
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
  var mPagePosition = 1;
  var mPageCount = 0;
  Utilities mUtilities = Utilities();
  String mSearchType = "NONE";
  String mPageDropItemVal = "1";
  List<SearchMovieItem> mAllSearchMovies = [];
  List<String> mPageArr = [];

  Future<Null> _refreshContent() async{
    //print('refreshing stocks...');

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final searchTxtField = TextFormField(
      obscureText: false,
      style: TextStyle(fontFamily: "Rubik",color: Colors.white),
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
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    return Scaffold(
      body: RefreshIndicator(
          key: mRefreshkey,
          onRefresh: _refreshContent,
          child:  Container(
          padding: EdgeInsets.only(top: 0.0),
        child: CustomScrollView(
        slivers: <Widget>[

          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 40.0,bottom: 10.0),
                child:Form(
                  key: _formKey,
                  child:  Row(
                  children: <Widget>[

                    new DropdownButton<String>(
                      value: mSearchType,
                      icon: Icon(Icons.list,color: Colors.white,),
                      iconSize: 24,
                      elevation: 16,
                      dropdownColor: Colors.purple[400],
                      style: TextStyle(color: Colors.purple[400]),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
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
                          child: Text(value,style: TextStyle(fontFamily: "Rubik",color: Colors.white),),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 45.0),
                    Expanded(
                        child: searchTxtField
                    ),
                    SizedBox(width: 45.0),
                    Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.purple[400],
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                var searchTxt = mSearchTxtController.text.toString().trim();
                                if(mSearchType=="NONE"){
                                  mUtilities.showAlert("Search Type", "Select search type.", context);
                                }else {
                                  doSearch(context);
                                  //mUtilities.showLoading(context);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),


                  ],
                )),
                color: Colors.purple[400],
                ),
              ],
            ),
          ),

          SliverList(
          delegate: SliverChildListDelegate(
          [
              Container(
              padding: EdgeInsets.only(left: 10.0,right: 10.0),
              child:Row(
                children: <Widget>[
                  Text("Search Result : $mPagePosition / $mPageCount",style: TextStyle(fontFamily: "Rubik"),),
                  SizedBox(width: 16.0),
                  Text("Current Page : ",style: TextStyle(fontFamily: "Rubik"),),
                  new DropdownButton<String>(
                    value: mPageDropItemVal,
                    icon: Icon(Icons.list),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        mPageDropItemVal = newValue;
                        if (_formKey.currentState.validate()) {
                          var searchTxt = mSearchTxtController.text.toString().trim();
                          if(mSearchType=="NONE"){
                            mUtilities.showAlert("Search Type", "Select search type.", context);
                          }else {
                            doSearch(context);
                            //mUtilities.showLoading(context);
                          }
                        }
                      });
                    },
                    items: mPageArr.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(fontFamily: "Rubik"),),
                      );
                    }).toList(),
                  ),
                ],
              )
              )
          ])
          ),

          getGridView(),

        ]
      )))

    );
  }

  Widget getGridView(){

    if(mAllSearchMovies.length==0){

      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                color: Colors.purple[400],
                child: Text('Record not found.',style: TextStyle(fontFamily: "Rubik",color: Colors.white,fontSize: 20),),
            ),
          ],
        ),
      );
    }else {


      return SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          //childAspectRatio: 4.0,

        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0),
                color: Colors.purple[400],
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Image.network(mAllSearchMovies[index].poster),
                    getImageView(mAllSearchMovies[index].poster),
                    SizedBox(height: 5.0),
                    Text(mAllSearchMovies[index].title,overflow: TextOverflow.ellipsis,style: TextStyle(fontFamily: "Rubik",color: Colors.white,fontSize: 14),textAlign: TextAlign.center,),
                    SizedBox(height: 5.0),
                    Text('Release on '+mAllSearchMovies[index].year,overflow: TextOverflow.ellipsis,style: TextStyle(fontFamily: "Rubik",color: Colors.white,fontSize: 12),textAlign: TextAlign.center,),
                    SizedBox(height: 5.0),
                    Column(
                      children:getRatingsList(mAllSearchMovies[index].mRataingsList)
                    )
                  ],
                ) //Text('grid item'+mAllSearchMovies[index].title),
            );
          },
          childCount: mAllSearchMovies.length,
        ),
      );
    }
  }

  Widget getImageView(String url){

    if(url==null||url==""||url=="N/A"){
      return Container(
        color: Colors.white,
        width: 75,
        height: 75,
        child: Center(child:Text("No Image",overflow: TextOverflow.ellipsis,style: TextStyle(fontFamily: "Rubik",color: Colors.red[400]),)),
      );
    }else{
      return Image.network(
        url,
        cacheHeight: 75,
        cacheWidth: 75,
        width: 75,
        height: 75,
      );
    }
  }

  List<Widget> getRatingsList(List<Ratings> cList){
    List<Widget> wList = [];
    if(cList.length>0){
      for(Ratings obj in cList){
        wList.add(new Text(obj.source+" : "+obj.value,overflow: TextOverflow.ellipsis,style: TextStyle(fontFamily: "Rubik",color: Colors.white,fontSize: 10),));
      }
    }
    return wList;
  }

  Future<void> doSearch(context) async{

    var searchTxt = mSearchTxtController.text.toString().trim();
  //  var password = mPasswordController.text.toString().trim();
    // If the form is valid, display a Snackbar.
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
    Constants constants = Constants();
    //print("H2");

    var url = constants.BASE_URL + "/?s="+searchTxt+"&type="+mSearchType+"&page="+mPageDropItemVal+"&apikey=" +constants.API_KEY;
    //print("url "+url);
    mPagePosition = int.parse(mPageDropItemVal);
    List<SearchMovieItem> list = await mServerConnect.fetchSearchMovies(http.Client(),url,context);
    //Navigator.pop(context);
    if(list!=null){
      if(list.length>0){
        var m = int.parse(list[0].totalResults.toString());
        var d = (m / 10);
        var n = d.toInt();
        mPageArr = [];
        mPageDropItemVal = mPagePosition.toString();
        for(int i =1 ;i<d; i++){
          mPageArr.add("$i");
        }
        setState(() {
          mPageArr = mPageArr;
          mPageCount = n;
        });
      }else{
        setState(() {
          mPagePosition = 0;
          mPageCount = 0;
        });
      }
      setState(() {
        mAllSearchMovies = list;
      });
    }else{
      setState(() {
        mPagePosition = 0;
        mPageCount = 0;
      });
    }
    //print("mAllSearchMovies "+mAllSearchMovies.length.toString());

  }


  }

