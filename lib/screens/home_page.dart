import 'package:flutter/material.dart';
import 'package:kak_kaspi_app/models/examples/album_model.dart';
import 'package:kak_kaspi_app/models/examples/newsArticle_model.dart';
import 'package:kak_kaspi_app/network/examples/fetch_album.dart';
import 'package:kak_kaspi_app/network/examples/webService_newsExample.dart';
import 'package:kak_kaspi_app/routes/routes.dart';
import 'package:kak_kaspi_app/utils/constants.dart';
import 'package:kak_kaspi_app/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  Future<Album> futureAlbum;
  List<NewsArticle> _newsArticles = List<NewsArticle>();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
//    futureAlbum = fetchAlbum();
  }

  void _populateNewsArticles() {
    Webservice().load(NewsArticle.all).then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });

  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: _newsArticles[index].urlToImage == null ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL) : Image.network(_newsArticles[index].urlToImage),
      subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
    );
  }

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
      body: ListView.builder(
        itemCount: _newsArticles.length,
        itemBuilder: _buildItemsForListView,
      ),
//      Center(
//        child: FutureBuilder<Album>(
//          future: futureAlbum,
//          builder: (context, snapshot) {
//            if(snapshot.hasData){
//              return Text(snapshot.data.title);
//            } else if(snapshot.hasError){
//              return Text('${snapshot.error}');
//            }
//
//            return CircularProgressIndicator();
//          },
//        ),
//      ),
    );
  }
}
