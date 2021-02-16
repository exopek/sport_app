

import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:video_app/CustomWidgets/rating.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Notifyers/tabbar_color.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Services/storage_handler.dart';
import 'package:video_app/Views/profil.dart';
import 'package:video_app/Views/settings.dart';

import '../Helpers/helpers.dart';
import 'package:flutter/material.dart';
import '../videoplayerservice.dart';
import '../Services/firebase_storage_service.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class HomePageNeo extends StatefulWidget {
  @override
  _HomePageNeoState createState() => _HomePageNeoState();
}

class _HomePageNeoState extends State<HomePageNeo> {



  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth = Provider.of<FirebaseAuthService>(context);
    final TabbarColor neoToggle = Provider.of<TabbarColor>(context, listen: false);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Container(),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Center(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    StreamBuilder<OwnUser>(
                        stream: auth.onAuthStateChanged,
                        builder: (_, AsyncSnapshot<OwnUser> snapshot) {
                          if (snapshot.hasData) {
                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MultiProvider(
                                      providers: [Provider<FirebaseAuthService>(
                                        create: (context) => FirebaseAuthService(),
                                      ),
                                        Provider(
                                          create: (context) => StorageHandler(uid: snapshot.data.uid),
                                        )
                                      ],
                                      child: ProfilPage(),
                                    );
                                  },
                                ),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(20.0),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data.foto
                                          )
                                      )
                                  )
                              ),
                            );
                          } else {
                            return Text('Foto');
                          }
                        }
                    ),

                    StreamBuilder<OwnUser>(
                        stream: auth.onAuthStateChanged,
                        builder: (_, AsyncSnapshot<OwnUser> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              'Hi '+snapshot.data.name,
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            return Text(
                              'Hi',
                              style: TextStyle(color: Colors.white),
                            ); }

                        }
                    ),


                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/5
              ),
              child: TabBar(
                indicatorColor: Colors.transparent,
                onTap: (index) => neoToggle.updateTabColor(index, context),
                tabs: [
                  Consumer<TabbarColor>(
                    builder: (context, data, child) {
                      return Container(
                      height: MediaQuery.of(context).size.height/15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: data.tabColor1[0],
                          boxShadow: [
                            BoxShadow(
                                color: data.tabColor1[1],
                                offset: Offset(2.0, 2.0),
                                blurRadius: 10.0,
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: data.tabColor1[2],
                                offset: Offset(-2.0, -2.0),
                                blurRadius: 10.0,
                                spreadRadius: 1.0),
                          ]
                      ),
                      child: Center(
                      child: Text('Workouts',
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                      ),)),
                      );
                    }
                  ),
                  Neumorphic(
                    //height: MediaQuery.of(context).size.height/15,

                    child: Center(
                        child: Text('Favoriten',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                          ),)),
                  ),
                ],
              ),
            ),
          ),
          /*
          AppBar(
            title: Text('Workouts',
              style: TextStyle(
                  color: Colors.white
              ),),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
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
                    child: Icon(
                        Icons.more_vert
                    ),
                  )
              ),
            ],
            // backgroundColor: Colors.redAccent,
          ),
          */
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
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
                  ), onPressed: () {}),
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
                  ), onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SettingsPage();
                      },
                    ),
                  ),
                  )
                ],
              ),
            ),

          ),
          backgroundColor: Colors.black45,
          body: TabBarView(
            children: [
              _tabBarViewWorkout(context),
              _tabBarViewFavorits(context)
            ],
          )
      ),
    );
  }

  Widget _tabBarViewFavorits(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'No Results',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Du hast noch keinen Favoriten',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'deiner Liste hinzugefügt.',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Finde Workouts die dir gefallen',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'und füge sie über einen Klick auf',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'den Stern, deiner Favoritenliste hinzu.',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarViewWorkout(BuildContext context) {
    final FirebaseAuthService auth = Provider.of<FirebaseAuthService>(context);
    return Container(
      height: MediaQuery.of(context).size.height/1.7,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: FirebaseStorageService.instance.videoDownload(context, '/videos/'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final value = snapshot.data;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value['videoUrls'].length,
                  itemBuilder: (BuildContext context, int Index) {
                    var cardInput = HelperFunctions().splitSeparatedWords(value['pathInfo'][Index], ['/','.','_']);
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SamplePlayer(videourl: value['videoUrls'][Index]);
                          },
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0, bottom: 15.0),
                        child: Container(
                            height: MediaQuery.of(context).size.height/1.8,
                            width: MediaQuery.of(context).size.width/1.5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(value['thumbnails'][Index])),
                                    fit: BoxFit.fill
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                            ),
                            child: Stack(
                                children: [
                                  /*
                                          Image(
                                              height: MediaQuery.of(context).size.height/2,
                                                width: MediaQuery.of(context).size.width/1.5,
                                                image: FileImage(File(value['thumbnails'][Index])),
                                                fit: BoxFit.cover,

                                            ),
                                            */

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(cardInput[0] ,
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20,
                                          color: Theme.of(context).primaryColor
                                      ),),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 390, left: 8.0),
                                      child: Row(
                                        children: [
                                          Text('Level: ',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context).primaryColor
                                            ),),
                                          StarDisplayWidget(
                                            value: int.parse(cardInput[2]),
                                            filledStar: Icon(Icons.adjust, color: Theme.of(context).primaryColor, size: 18.0),
                                            unfilledStar: Icon(Icons.adjust, color: Colors.grey, size: 18.0),
                                          ),
                                        ],
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 390, left: 160.0),
                                    child: Text('Dauer: '+cardInput[1],
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).primaryColor
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 200),
                                    child: IconButton(
                                        color: Colors.black,
                                        icon: Icon(MdiIcons.star),
                                        onPressed: () {}),)
                                ]
                            )

                        ),
                      ),
                    );
                  });
            } else {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,

                  itemCount: 5,
                  itemBuilder: (BuildContext context, int Index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height/1.7,
                          width: MediaQuery.of(context).size.width/1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                          child: _customProgress(context)
                      ),
                    );
                  });
            }

          }
      ),
    );
  }

  Widget _customProgress(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Colors.red, end: Colors.red.shade900)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Colors.red, end: Colors.red.shade900))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );


  }


}
