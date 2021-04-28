import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/CustomWidgets/neoContainer.dart';
import 'package:video_app/Helpers/helpers.dart';
import 'package:video_app/Notifyers/listViewIndex.dart';
import 'package:video_app/Notifyers/tabbar_color.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Services/storage_handler.dart';
import 'package:video_app/Views/profil.dart';
import 'package:video_app/Views/test_home.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home_musik_style.dart';
import 'neo_home.dart';

class SettingsPage extends StatefulWidget {
  final String uid;

  const SettingsPage({Key key,@required this.uid}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  ScrollPhysics settingsScrollPhysics = BouncingScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text('Einstellungen',
          style: TextStyle(
              color: Colors.grey[800],
            fontWeight: FontWeight.w500,
          ),),
      ),
      /*
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height/10,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.2, 0.4, 0.9],
                  colors: [Colors.red, Colors.red[700], Colors.red[900]]
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(
                Icons.api_sharp,
                size: 30.0,
              ), onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) {
                        return HomePageT();
                      }
                  )
              ),
              ),
              IconButton(icon: Icon(
                Icons.search,
                size: 30.0,
              ), onPressed: () {}),
              IconButton(icon: Icon(
                Icons.analytics_outlined,
                size: 30.0,
              ), onPressed: () {}
              ),
              IconButton(icon: Icon(
                Icons.settings,
                size: 30.0,
              ), onPressed: () {}
              )
            ],
          ),
        ),

      ),

       */
        /*
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                builder: (context) {
                return MultiProvider(
                    providers: [
                      Provider(create: (context) => StorageHandler(uid: widget.uid),),
                      Provider(create: (context) => DatabaseHandler(uid: widget.uid),),
                      ChangeNotifierProvider(create: (context) => ListViewIndex(context: context)),
                      ChangeNotifierProvider(create: (context) => TabbarColor(context: context))
                    ],
                    child: HomePageMusikStyle());
                  },
                ),
               ),
              child: NeoContainer(
              shadowColor1: Colors.grey[500],
              shadowColor2: Colors.grey[50],
              blurRadius1: 5.0,
              blurRadius2: 3.0,
              spreadRadius1: 0.0,
              spreadRadius2: 0.0,
              circleShape: true,
              containerHeight: MediaQuery.of(context).size.height/7,
              containerWidth: MediaQuery.of(context).size.width/7,
              gradientColor1: Colors.grey[600],
              gradientColor2: Colors.grey[500],
              gradientColor3: Colors.grey[200],
              gradientColor4: Colors.grey[200],
              containerChild: Center(
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey[800],
                    size: 20.0,)
              ),
          ),
            ),
      ]
        ),
      ),
      */
      body: ListView.builder(
          physics: settingsScrollPhysics,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
                children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        child: Container(
                          height: MediaQuery.of(context).size.height/12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Center(
                            child: ListTile(
                              tileColor: Colors.transparent,
                              leading: Icon(Icons.account_circle),
                              title: Text('Mein Profil'),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Provider<FirebaseAuthService>(
                                      create: (context) => FirebaseAuthService(),
                                      child: ProfilPage(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: Container(
                        height: MediaQuery.of(context).size.height/12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                        ),
                        child: Center(
                          child: ListTile(
                            tileColor: Colors.transparent,
                            leading: Icon(MdiIcons.web),
                            title: Text('Webseite'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              await HelperFunctions().launchURL('https://exopek.de/');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 300.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/4.7,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              icon: Icon(MdiIcons.instagram,
                              size: 40.0),
                          onPressed: () async {
                                await HelperFunctions().launchURL('https://www.instagram.com/exopek/?hl=en');
                          },),
                          IconButton(
                              icon: Icon(MdiIcons.youtube,
                              size: 40.0,),
                          onPressed: () async {
                                await HelperFunctions().launchURL('https://www.youtube.com/channel/UCEcRmE0vw6DkF3ef-k2DYTw');
                          },),
                          IconButton(
                              icon: Icon(MdiIcons.facebook,
                              size: 40.0,),
                          onPressed: () async {
                                await HelperFunctions().launchURL('https://www.facebook.com/exopekofficial/');
                          },)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/5,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text('Terms of Use',
                                    style: TextStyle(
                                      color: Colors.black
                                    ),)),
                                TextButton(
                                    onPressed: () {},
                                    child: Text('Warranty',
                                      style: TextStyle(
                                          color: Colors.black
                                      ),)),
                                TextButton(
                                    onPressed: () {},
                                    child: Text('Privacy Policy',
                                      style: TextStyle(
                                          color: Colors.black
                                      ),)),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20.0),
                          child: Text('EXOPEK Version 1.0'),)
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }),
    );
  }
}
