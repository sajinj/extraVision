import 'package:extra_vision/scenes/lesson_screen.dart';
import 'package:extra_vision/util.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<String> text;
  final List<String> subTitle;

  Carousel({Key key, this.text, this.subTitle}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  ScrollPhysics bsp = ScrollPhysics();
  bool isTest = true;

  Widget _buildCarouselItem(BuildContext context, int itemIndex) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                itemIndex == 0
                    ? Data.data.isTest = false
                    : Data.data.isTest = true;
                Navigator.pushNamed(
                  context,
                  "/vision",
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.text[itemIndex],
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.subTitle[itemIndex],
                      style: TextStyle(
                          color:Colors.black38,
                          fontSize: 16
                             ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.8),
      itemCount: widget.text.length,
      physics: bsp,
      itemBuilder: (BuildContext context, int itemIndex) {
        return _buildCarouselItem(context, itemIndex);
      },
    );
  }
}
