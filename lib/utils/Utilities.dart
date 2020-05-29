import 'package:flutter/material.dart';
class Utilities{



  void showAlert(String title,String msg,context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.purple[400],
          title: new Text(title,style: TextStyle(fontFamily: "Rubik",color: Colors.white),),
          content: new Text(msg,style: TextStyle(fontFamily: "Rubik",color: Colors.white),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",style: TextStyle(fontFamily: "Rubik",color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void showLoading(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        });
    //Navigator.pop(context);
  }

}