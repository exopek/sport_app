import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/CustomWidgets/neoContainer.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Notifyers/listViewIndex.dart';
import 'package:video_app/Notifyers/tabbar_color.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Services/storage_handler.dart';
import 'package:video_app/Views/home_a.dart';


class CreateUserAccountPage extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<OwnUser> _createUser(BuildContext context, String email, String password) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      final user = await auth.createUserAccount(email, password);
      return user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: Column(
            children: [
              _signInButtonEmail(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButtonEmail(BuildContext context) {
    return Container(
      height: 250.0,
      child: Column(
        children: [
          SizedBox(height: 20.0,),
          Expanded(
            child: NeoContainer(
              containerHeight: MediaQuery.of(context).size.height/10.0,
              containerWidth: MediaQuery.of(context).size.width/1.1,
              containerBorderRadius: BorderRadius.all(Radius.circular(30.0)),
              shadowColor2: Color.fromRGBO(5, 5, 5, 40),
              shadowColor1: Color.fromRGBO(40, 40, 40, 40),
              blurRadius1: 3.0,
              blurRadius2: 3.0,
              spreadRadius1: 0.0,
              spreadRadius2: 0.0,
              gradientColor1: Color.fromRGBO(19, 19, 19, 40),
              gradientColor2: Color.fromRGBO(19, 19, 19, 40),
              gradientColor3: Color.fromRGBO(19, 19, 19, 40),
              gradientColor4: Color.fromRGBO(19, 19, 19, 40),
              circleShape: false,
              containerChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    controller: emailController,
                  ),
                ),
              ),),
          ),
          SizedBox(height: 20.0,),
          Expanded(
            child: NeoContainer(
              containerHeight: MediaQuery.of(context).size.height/10.0,
              containerWidth: MediaQuery.of(context).size.width/1.1,
              containerBorderRadius: BorderRadius.all(Radius.circular(30.0)),
              shadowColor2: Color.fromRGBO(5, 5, 5, 40),
              shadowColor1: Color.fromRGBO(40, 40, 40, 40),
              blurRadius1: 3.0,
              blurRadius2: 3.0,
              spreadRadius1: 0.0,
              spreadRadius2: 0.0,
              gradientColor1: Color.fromRGBO(19, 19, 19, 40),
              gradientColor2: Color.fromRGBO(19, 19, 19, 40),
              gradientColor3: Color.fromRGBO(19, 19, 19, 40),
              gradientColor4: Color.fromRGBO(19, 19, 19, 40),
              circleShape: false,
              containerChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller: passwordController,
                  ),
                ),
              ),),
          ),
          SizedBox(height: 30.0,),
          OutlineButton(
            splashColor: Colors.grey,
            onPressed: () {
              _createUser(context, emailController.text, passwordController.text).then((result) {
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
                            child: HomeAPage());
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
        ],
      ),
    );
  }

}
