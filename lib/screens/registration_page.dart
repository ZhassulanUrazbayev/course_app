import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:kak_kaspi_app/utils/phoneNumberFormatter.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _controller = new MaskedTextController(mask: '(000) 000-00-00');

  final _passwordController = TextEditingController();

  var _phoneNumber = '';

//  final _mobileFormatter = NumberTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 28.0,
          color: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
        title: Text(
          'Вход/Регистрация',
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w600),
        ),
        elevation: 0.8,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Мобильный номер',
                prefixText: '+7 ',
                prefixStyle: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Пароль',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _phoneNumber = _controller.text.substring(1, 4) +
                      _controller.text.substring(6, 9) +
                      _controller.text.substring(10, 12) +
                      _controller.text.substring(13, 15);

                  print(_passwordController.text);
                  if (_phoneNumber == "7474563370" ||
                      _passwordController.text == "1") {

                  } else if (_controller.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                              content: Text(
                                  "Пожалуйста,введите номер телефона или пароль"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Yes'),
                                )
                              ],
                            ),
                        barrierDismissible: true);
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                              content: Text(
                                  "Неправильный номер телефона или пароль"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Забыли пароль ?'),
                                ),
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Ввести занова'),
                                )
                              ],
                            ),
                        barrierDismissible: true);
                  }
                },
                color: Colors.blue,
                child: Text('Войти',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
