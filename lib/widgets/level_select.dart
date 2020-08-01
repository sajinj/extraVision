import 'package:extra_vision/scenes/question_screen.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class LevelSelect extends StatelessWidget {
  final String text;
  final String bgAddress;
  final VoidCallback onClick;
  LevelSelect(
      {Key key, @required this.text, @required this.bgAddress, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8),
          image: DecorationImage(
            image: AssetImage(bgAddress),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Material(
          borderRadius: BorderRadiusDirectional.circular(8),
          color: Colors.black26,
          child: InkWell(
            onTap: () {
              onClick();
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
