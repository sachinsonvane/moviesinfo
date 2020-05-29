import 'package:flutter/material.dart';
class Utilities{



  void showAlert(String title,String msg,context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title,style: TextStyle(fontFamily: "Rubik"),),
          content: new Text(msg,style: TextStyle(fontFamily: "Rubik"),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",style: TextStyle(fontFamily: "Rubik"),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}