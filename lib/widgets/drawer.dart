import 'package:flutter/material.dart';
import 'package:kak_kaspi_app/routes/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
              text: 'Contacts',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.registration),
            ),
            _createDrawerItem(
              text: 'Events',
            ),
            _createDrawerItem(
              text: 'Notes',
            ),
            _createDrawerItem(text: 'Steps'),
            _createDrawerItem(text: 'Authors'),
            _createDrawerItem(text: 'Flutter Documentation'),
            _createDrawerItem(text: 'Useful Links'),
            _createDrawerItem(text: 'Report an issue'),
          ],
        ),
      ),
    );
  }

  Widget _createHeader() {
    return SafeArea(
      child: DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.only(top: 25.0),
          child: Column(children: <Widget>[
            _createHeaderItem(
                icon: Icons.person_outline, text: "Вход/Регистрация"),
            _createHeaderItem(icon: Icons.place, text: "Вход/Регистрация"),
          ])),
    );
  }

  Widget _createDrawerItem({String text, GestureTapCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white12),
        ),
      ),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _createHeaderItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white12),
        ),
      ),
      child: ListTile(
//        leading: Icon(icon, color: Colors.white, size: 24.0,),
        title: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 24.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w300,
                    fontSize: 16.0),
              ),
            )
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
