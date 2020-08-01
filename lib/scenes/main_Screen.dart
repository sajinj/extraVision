import 'package:cafebazaar_flutter/cafebazaar_flutter.dart';
import 'package:extra_vision/scenes/bookmark_screen.dart';
import 'package:extra_vision/util.dart';
import 'package:extra_vision/widgets/carousel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> categ = ["Vocabulary", "Test"];
  List<String> subCateg = ["more than 1000 words!", "test your knowledge!"];
  TextStyle listTileStyle = TextStyle(fontSize: 18, color: Colors.black54);
  @override
  Widget build(BuildContext context) {
    Data.data.screenWidth = MediaQuery.of(context).size.width;
    Data.data.screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("ExtraVison"),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.cyan, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Carousel(
            text: categ,
            subTitle: subCateg,
          )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Text('Extra Vision',
                      style: TextStyle(color: Colors.white, fontSize: 32))),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(
                "لغات منتخب",
                textDirection: TextDirection.rtl,
                style: listTileStyle,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (con) => BookMarkScreen(),
                    ));
              },
            ),
            ListTile(
              title: Text(
                "امتیاز به برنامه",
                textDirection: TextDirection.rtl,
                style: listTileStyle,
              ),
              onTap: () {
                CafebazaarFlutter.showProgramPage("packageName");
              },
            ),
            ListTile(
              title: Text(
                "راهنما",
                textDirection: TextDirection.rtl,
                style: listTileStyle,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "درباره extra vision",
                textDirection: TextDirection.rtl,
                style: listTileStyle,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
