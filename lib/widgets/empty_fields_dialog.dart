import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialogEmptyFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text("Пожалуйста,введите номер телефона или пароль"),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Yes'),
              )
            ],
          )
        : AlertDialog(
            content: Text("Пожалуйста,введите номер телефона или пароль"),
            actions: <Widget>[
//                                  FlatButton(
//                                      child: Text('Yes'),
//                                      onPressed: () {
//                                        Navigator.of(context).pop();
//                                      }),
            ],
          );
  }
}
