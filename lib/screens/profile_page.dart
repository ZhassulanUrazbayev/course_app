import 'package:flutter/material.dart';
import 'package:kak_kaspi_app/widgets/drawer.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        title: Text(
          'Настройки',
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
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
      body: Container(
        color: Colors.black12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          _createProfileCircleItem(),
          _createProfileItem(text: 'Изменить фото'),
          SizedBox(
            height: 30.0,
          ),
          _createProfileSwitchItem(text: 'Изменить фото'),
          SizedBox(
            height: 30.0,
          ),
          _createProfileItem(text: 'Изменить фото'),
          _createProfileItem(text: 'Изменить фото'),
          _createProfileSwitchItem(text: 'Изменить фото'),
          _createProfileItem(text: 'Изменить фото'),
          SizedBox(
            height: 30.0,
          ),
          _createProfileButtonItem(text: 'Выйти'),
          ],
        ),
      ),
    );
  }

  Widget _createProfileItem({String text, GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black12),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _createProfileSwitchItem({String text, GestureTapCallback onTap}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Изменить фото'),
          Switch(value: false, onChanged: null)
        ],
      ),
    );
  }

  Widget _createProfileButtonItem({String text, GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black12),
          ),
        ),
        child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
            )),
      ),
    );
  }

  Widget _createProfileCircleItem({GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150.0,
        color: Colors.black87,
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                width: 85.0,
                height: 85.0,
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    image: new NetworkImage(
                        'http://i.imgur.com/QSev0hg.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                  new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.grey,
                    width: 3.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 3,
                right: 3,
                child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.red,
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

}
