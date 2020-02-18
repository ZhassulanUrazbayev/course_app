import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:kak_kaspi_app/screens/pin_create_page.dart';
import 'package:kak_kaspi_app/utils/connection_status.dart';
import 'package:kak_kaspi_app/widgets/empty_fields_dialog.dart';
import 'package:kak_kaspi_app/widgets/error_fields_dialog.dart';

class RegistrationPage extends StatefulWidget {
  static const String routeName = '/registration';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _controller = new MaskedTextController(mask: '(000) 000-00-00');

  final _passwordController = TextEditingController();

  var _phoneNumber = '';

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

//  final _mobileFormatter = NumberTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    bool isOffline = false;

    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        isOffline = true;
        break;
      case ConnectivityResult.mobile:
        isOffline = false;
        break;
      case ConnectivityResult.wifi:
        isOffline = false;
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24.0,
          color: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
        title: Text(
          'Вход/Регистрация',
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
        elevation: 0.8,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Colors.black12),
                )
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
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
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.black12),
                  )
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Пароль',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  if (_controller.text.length >= 15) {
                    _phoneNumber = _controller.text.substring(1, 4) +
                        _controller.text.substring(6, 9) +
                        _controller.text.substring(10, 12) +
                        _controller.text.substring(13, 15);
                  }

                  print(_passwordController.text);

                  if (_phoneNumber == "7474563370" &&
                      _passwordController.text == "1") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CreatePinPage(),
                      ),
                    );
                  } else if (_controller.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (_) => ShowDialogEmptyFields(),
                        barrierDismissible: true);
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => ShowDialogErrorFields(),
                        barrierDismissible: true);
                  }
                },
                color: Colors.blue,
                child: Text(
                  'Войти',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 16.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
