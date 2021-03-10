

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/CustomWidgets/custom_signIn_Button.dart';
import 'package:video_app/CustomWidgets/neoContainer.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Notifyers/listViewIndex.dart';
import 'package:video_app/Notifyers/tabbar_color.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Services/storage_handler.dart';
import 'package:video_app/Views/create_account.dart';
import 'package:video_app/Views/dashboard.dart';
import 'package:video_app/Views/home_horizontal.dart';
import 'package:video_app/Views/home_musik_style.dart';
import 'package:video_app/Views/test_home.dart';
import 'package:video_app/Views/xd_home.dart';

import 'home.dart';
import 'neo_home.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future<OwnUser> _signInWithGoogle(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      final user = await auth.signInWithGoogle();
      return user;
    } catch (e) {
      print(e);
    }
  }

  Future<OwnUser> _signInwithEmail(BuildContext context, email, String password) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      final user = await auth.signInWithEmail(email, password);
      return user;
    } catch (e) {
      print(e);
    }
  }

  //ToDo: dispose controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height/15),
                FlutterLogo(size: 150),
                SizedBox(height: MediaQuery.of(context).size.height/15),
                _signInButtonEmail(context),
                SizedBox(height: MediaQuery.of(context).size.height/20),
                _signInButton(context),
                SizedBox(height: MediaQuery.of(context).size.height/15),
                _createAccountButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButtonEmail(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
          children: [
            SizedBox(height: 20.0,),
            NeoContainer(
                  containerHeight: MediaQuery.of(context).size.height/17.0,
                  containerWidth: MediaQuery.of(context).size.width/1.4,
                  containerBorderRadius: BorderRadius.all(Radius.circular(30.0)),
                  shadowColor2: Color.fromRGBO(8, 8, 8, 1.0),
                  shadowColor1: Color.fromRGBO(40, 40, 44, 1.0),
                  blurRadius1: 2.0,
                  blurRadius2: 2.0,
                  spreadRadius1: 2.5,
                  spreadRadius2: 2.5,
                  shadow2Offset: -2.0,
                  shadow1Offset: 3.0,
                  gradientColor1: Theme.of(context).primaryColor,
                  gradientColor2: Theme.of(context).primaryColor,
                  gradientColor3: Theme.of(context).primaryColor,
                  gradientColor4: Theme.of(context).primaryColor,
                  circleShape: false,
                  containerChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                      style: TextStyle(
                          color: Colors.white
                      ),
                      controller: emailController,
                    ),
                  ),
                ),),

            SizedBox(height: 20.0,),
            NeoContainer(
                containerHeight: MediaQuery.of(context).size.height/17.0,
                containerWidth: MediaQuery.of(context).size.width/1.4,
                containerBorderRadius: BorderRadius.all(Radius.circular(30.0)),
                shadowColor2: Color.fromRGBO(8, 8, 8, 1.0),
                shadowColor1: Color.fromRGBO(40, 40, 44, 1.0),
                blurRadius1: 2.0,
                blurRadius2: 2.0,
                spreadRadius1: 2.5,
                spreadRadius2: 2.5,
                shadow2Offset: -2.0,
                shadow1Offset: 3.0,
                gradientColor1: Theme.of(context).primaryColor,
                gradientColor2: Theme.of(context).primaryColor,
                gradientColor3: Theme.of(context).primaryColor,
                gradientColor4: Theme.of(context).primaryColor,
                circleShape: false,
                containerChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none
                      ),
                      style: TextStyle(
                        color: Colors.white
                      ),
                      controller: passwordController,
                    ),
                  ),
                ),),
            SizedBox(height: 5.0,),
            AddTodoButton(email: emailController.text, password: passwordController.text)
            /*
            OutlineButton(
              splashColor: Colors.redAccent,
              onPressed: () {
                _signInwithEmail(context, emailController.text, passwordController.text).then((result) {
                  if (result != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return MultiProvider(
                              providers: [
                                Provider(create: (context) => StorageHandler(uid: result.uid),),
                                Provider(create: (context) => DatabaseHandler(uid: result.uid),),
                                ChangeNotifierProvider(create: (context) => TabbarColor(context: context)),
                                ChangeNotifierProvider(create: (context) => ListViewIndex(context: context)),
                              ],
                              child: HomePageMusikStyle());
                        },
                      ),
                    );
                  }
                });
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Email',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            */
          ],
        ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _signInWithGoogle(context).then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MultiProvider(
                    providers: [
                      Provider(create: (context) => StorageHandler(uid: result.uid),),
                      Provider(create: (context) => DatabaseHandler(uid: result.uid),),
                      ChangeNotifierProvider(create: (context) => TabbarColor(context: context)),
                      ChangeNotifierProvider(create: (context) => ListViewIndex(context: context)),
                    ],
                      child: XdHomeStyle());
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return Container(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Du bist nicht registriert?',
          style: TextStyle(
            color: Colors.white
          ),),
          TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CreateUserAccountPage();
                  },
                ),
              ),
              child: Text('Registrieren',
              style: TextStyle(
                color: Colors.white
              ),))
        ],
      ),
    );
  }

}
