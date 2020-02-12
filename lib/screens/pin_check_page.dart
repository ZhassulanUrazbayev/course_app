import 'package:flutter/material.dart';
import 'package:kak_kaspi_app/utils/pin_check_body.dart';
import 'package:kak_kaspi_app/utils/preferences.dart';

class CheckPinPage extends StatefulWidget {
  @override
  _CheckPinPageState createState() => _CheckPinPageState();
}

class _CheckPinPageState extends State<CheckPinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24.0,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Код Доступа',
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
        elevation: 0.8,
      ),
      body: CheckPin(isAcceptedBiometricAuth: getBoolValueSP('isAcceptedBiometricAuth')),
      backgroundColor: Colors.lightBlueAccent,
    );
  }
}
