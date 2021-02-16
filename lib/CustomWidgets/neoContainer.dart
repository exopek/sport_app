import 'package:flutter/material.dart';

class NeoContainer extends StatelessWidget {
  final Color containerColor;
  final Color shadowColor1;
  final Color shadowColor2;
  final int animationDuration;
  final double containerHeight;
  final double containerWidth;
  final String containerText;
  final double shadow1Offset;
  final double shadow2Offset;
  final double blurRadius1;
  final double blurRadius2;
  final double spreadRadius1;
  final double spreadRadius2;

  const NeoContainer({Key key,this.containerColor, @required this.shadowColor1, @required this.shadowColor2, this.animationDuration, this.containerHeight, this.containerWidth, this.containerText,
  this.blurRadius1, this.blurRadius2, this.shadow1Offset, this.shadow2Offset, this.spreadRadius1, this.spreadRadius2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
            //height: containerHeight ?? 10.0,
            //width: containerWidth ?? 20.0,
              duration: Duration(seconds: animationDuration ?? 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: containerColor ?? Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: shadowColor1 ?? Colors.transparent,
                          offset: Offset(shadow1Offset ?? 4.5, shadow1Offset ?? 4.5), //4.5 both
                          blurRadius: blurRadius1 ?? 15.0, // 15.0
                          spreadRadius: spreadRadius1 ?? 1.0), // 1.0
                      BoxShadow(
                        color: shadowColor2 ?? Colors.transparent,
                        offset: Offset(shadow2Offset ?? -4.5, shadow2Offset ?? -4.5), // -4.5 both
                        blurRadius: blurRadius2 ?? 15.0, // 15.0
                        spreadRadius: spreadRadius2 ?? 1.0,), // 1.0
                    ]
                ),
                child: Center(
                    child: Text(containerText ?? '',
                      style: TextStyle(
                        color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                      ),)),
          );
  }
}
