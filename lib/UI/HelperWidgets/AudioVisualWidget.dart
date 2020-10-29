import 'package:flutter/material.dart';

class AudioVisualWidget extends StatelessWidget {
  final String visualAsset;
  final bool isSelected;

  const AudioVisualWidget(
      {Key key, @required this.visualAsset, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      SizedBox(
        width: 245,
        height: 255,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            visualAsset,
            fit: BoxFit.fitWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 1,
        ),
      ),

      ///for the bit dark shadow over side visuals
      AnimatedContainer(
        margin: EdgeInsets.all(4),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            gradient: LinearGradient(
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                colors: [
                  isSelected
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.1),
                  Colors.transparent,
                  isSelected
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.1),
                ],
                stops: [
                  0.0,
                  0.5,
                  1.0
                ])),
      )
    ]);
  }
}
