import 'package:extra_vision/util.dart';
import 'package:extra_vision/widgets/level_select.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ExtraVision"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(3, (i) {
              return LevelSelect(
                text: "Vision " + (i + 10).toString(),
                bgAddress: Data.data.salPic[i],
                onClick: () {

                  Data.data.sal = (i + 10).toString();
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, "/lesson");
                  });
                },
              );
            })),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        "choose your lesson!",
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }
}
