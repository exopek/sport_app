import 'package:flutter/material.dart';
import 'package:video_app/CustomWidgets/buttonClipper.dart';

class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

          child: ClipPath(
            clipper: SichelClipper(),
            child: Container(
              color: Colors.black,
            ),
          ),
      ),
    );
  }
}
