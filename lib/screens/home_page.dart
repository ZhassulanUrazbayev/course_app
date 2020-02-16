import 'package:flutter/material.dart';
import 'package:kak_kaspi_app/routes/routes.dart';
import 'package:kak_kaspi_app/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Курсы',
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_outline,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.profile);
            },
          )
        ],
        elevation: 0.8,
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.black, //This will change the drawer background to blue.
          //other styles
        ),
        child: AppDrawer(),
      ),
    );
  }
}
