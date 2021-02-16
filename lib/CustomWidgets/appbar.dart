import 'package:flutter/material.dart';

class CustomAppBarE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Center(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 70.0,
                  color: Colors.white,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Account Name',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Email Address',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );



  }
}
