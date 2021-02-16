import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Views/home.dart';
import 'package:video_app/Views/sign_in.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuthService>(context);
    auth.initialze();
    return StreamBuilder<OwnUser>(
      stream: auth.onAuthStateChanged,
      builder: (_, AsyncSnapshot<OwnUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          OwnUser user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return Provider<FirebaseAuthService>(
              create: (context) => FirebaseAuthService(),
          child: HomePage(),);
        }
        else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      },
    );
  }
}
