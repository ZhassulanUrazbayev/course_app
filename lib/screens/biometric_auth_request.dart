import 'package:flutter/material.dart';
import 'package:kak_kaspi_app/screens/home_page.dart';
import 'package:kak_kaspi_app/screens/registration_page.dart';
import 'package:kak_kaspi_app/utils/pin_check_body.dart';
import 'package:kak_kaspi_app/utils/preferences.dart';

class BiometricAuthRequest extends StatelessWidget {
  bool isAcceptedBiometricAuth = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          icon: Icon(Icons.close),
          iconSize: 24.0,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Быстрый вход',
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.fingerprint,
              size: 100.0,
              color: Colors.red,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Использовать отпечаток пальца для быстрого входа в приложение ?',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  isAcceptedBiometricAuth = true;
                  addBoolValueSP('isAcceptedBiometricAuth', isAcceptedBiometricAuth);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CheckPin(isAcceptedBiometricAuth: isAcceptedBiometricAuth,),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Использовать Отпечаток Пальца'.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
