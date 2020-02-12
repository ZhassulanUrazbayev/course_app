import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kak_kaspi_app/screens/biometric_auth_request.dart';
import 'package:kak_kaspi_app/screens/home_page.dart';
import 'package:kak_kaspi_app/utils/preferences.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class CheckPin extends StatefulWidget {
  final bool isAcceptedBiometricAuth;
  final String newEmail;
  final bool isGuestCheckOut;

  const CheckPin({
    Key key,
    @required this.isAcceptedBiometricAuth,
    this.newEmail = "",
    this.isGuestCheckOut,
  }) : super(key: key);

  @override
  _CheckPin createState() => new _CheckPin();
}

class _CheckPin extends State<CheckPin> with SingleTickerProviderStateMixin {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

// To check if any type of biometric authentication
// hardware is available.
  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAvailable;

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

// To retrieve the list of biometric types
// (if available).
  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    print(listOfBiometrics);
  }

// Process of authentication user using
// biometrics.
  Future<bool> _authenticateUser() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason:
            "Please authenticate to view your transaction overview",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAuthenticated;

    isAuthenticated
        ? print('User is authenticated!')
        : print('User is not authenticated.');

    return isAuthenticated;
  }

  Future<void> isUserAuthenticated() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      if(await _authenticateUser()){
        Route route = MaterialPageRoute(builder: (context) => HomePage());
        Navigator.pushReplacement(context, route);
//          Navigator.of(context).push(
//            MaterialPageRoute(
//              builder: (context) => HomePage(),
//            ),
//          );
      }
    }
  }

  // Constants
  final int time = 30;
  AnimationController _controller;

  // Variables
  Size _screenSize;
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;
  var _oldPin = '';

  // Return "Welcome" label
  Widget _getWelcomeLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 80.0),
      child: new Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: new TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }

//  Return label
  Widget _getLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 80.0),
      child: new Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: new TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Return "OTP" input field
  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
      ],
    );
  }

  // Returns "OTP" input part
  get _getInputPart {
    if (widget.isAcceptedBiometricAuth) {
      isUserAuthenticated();
    }
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getWelcomeLabel("Name, Здравствуйте!"),
        _getInputField,
        _getLabel("Введите код для быстрого доступа к приложению"),
        _getOtpKeyboard
      ],
    );
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: new Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.access_time),
            new SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller, 15.0, Colors.black)
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return new InkWell(
      child: new Container(
        height: 32,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(32)),
        alignment: Alignment.center,
        child: new Text(
          "Resend OTP",
          style:
              new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      onTap: () {
        // Resend you OTP via API or anything
        _startCountdown();
      },
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return new Container(
        height: _screenSize.width - 80,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 70.0,
                  ),
                  _biometricAuthButton(onPressed: () {}),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        width: _screenSize.width,
//        padding: new EdgeInsets.only(bottom: 16.0),
        child: _getInputPart,
      ),
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return new Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? "" : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: digit != null ? Colors.black : Colors.red,
      ))),
    );
  }

  // Returns "Otp custom text filled"
  Widget _otpTextFilled() {
    return new Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: SizedBox(
        height: 2,
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: Colors.black,
      ))),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      borderRadius: BorderRadius.circular(45.0),
      color: Colors.black12,
      child: new InkWell(
        highlightColor: Colors.red,
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(45.0),
        child: new Container(
          height: 70.0,
          width: 70.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                  fontSize: 28.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _biometricAuthButton({VoidCallback onPressed}) {
    return new Material(
      borderRadius: BorderRadius.circular(45.0),
      color: Colors.black12,
      child: new InkWell(
        highlightColor: Colors.red,
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(45.0),
        child: new Container(
          height: 70.0,
          width: 70.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: Icon(
              Icons.fingerprint,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return Material(
      borderRadius: BorderRadius.circular(45.0),
      color: Colors.black12,
      child: InkWell(
        onTap: onPressed,
        highlightColor: Colors.red,
        borderRadius: new BorderRadius.circular(45.0),
        child: new Container(
          height: 70.0,
          width: 70.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: label,
          ),
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        var currentPin = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();

//        normal checking needed
        if (currentPin.length == 4) {
          _oldPin = currentPin;
          currentPin = '';
          clearOtp();
        } else if (getStringValueSP('pin') == currentPin) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BiometricAuthRequest(),
            ),
          );
        }

        // Verify your otp by here. API call
      }
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }
}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Text(
            timerString,
            style: new TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}
