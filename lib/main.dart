import 'package:flutter/material.dart';
import 'package:kak_kaspi_app/routes/routes.dart';
import 'package:kak_kaspi_app/screens/profile_page.dart';
import 'package:kak_kaspi_app/screens/registration_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kak Kaspi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: RegistrationPage(),
      routes: {
        Routes.registration: (context) => RegistrationPage(),
        Routes.profile: (context) => ProfilePage()
      },
    );
  }
}
