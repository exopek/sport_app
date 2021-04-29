import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:video_app/CustomWidgets/neoContainer.dart';
import 'package:video_app/CustomWidgets/rating.dart';
import 'package:video_app/Helpers/blank.dart';
import 'package:video_app/Helpers/helpers.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Notifyers/tabbar_color.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Services/firebase_storage_service.dart';
import 'package:video_app/Services/storage_handler.dart';
import 'package:video_app/Views/settings.dart';

import '../videoplayerservice.dart';

class HomePageNeo extends StatelessWidget {

  getListView<widget>(int index, context) {
    if (index == 0) {
      return _tabBarViewWorkout(context);
    }
    else if (index == 2) {
      return _tabBarViewFavorits(context);
    }
    else if (index == 1) {
      return Text('ToDo');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TabbarColor neoBar = Provider.of<TabbarColor>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          //color: Color.fromRGBO(19, 19, 19, 40)
          /*
          gradient: RadialGradient(
            center: Alignment(0.1, 0.3),
            focal: Alignment(-0.1, 0.6),
            focalRadius: 2,
            colors: [Colors.grey[900], Colors.grey[850], Colors.grey[800], Colors.grey[700]],
            stops: [0.2, 0.5, 0.7, 1],
          )
           */
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromRGBO(50, 50, 50, 40),
              Color.fromRGBO(90, 90, 90, 40),

            ],
            stops: [0.0, 1.0]
          )

        ),
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            _appBarItems(context),
            //SizedBox(height: 5.0),
            _neoTabBar(context),
            SizedBox(height: 20.0,),
            getListView(neoBar.index, context),
            _neoNavigationBar(context)
          ],
        ),
      ),
    );
  }

  Widget _appBarItems(BuildContext context) {
    final StorageHandler storage = Provider.of<StorageHandler>(context);
    final FirebaseAuthService auth = Provider.of<FirebaseAuthService>(context);
    return Row(
      children: [
        SizedBox(width: 20.0,),
        StreamBuilder<DownloadUrl>(
          stream: storage.getProfilImage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NeoContainer(
                shadowColor1: Color.fromRGBO(5, 5, 5, 40),
                shadowColor2: Color.fromRGBO(50, 50, 50, 40),
                blurRadius1: 3.0,
                blurRadius2: 3.0,
                spreadRadius1: 0.0,
                spreadRadius2: 0.0,
                circleShape: true,
                containerHeight: MediaQuery.of(context).size.height / 4,
                containerWidth: MediaQuery.of(context).size.width / 4,
                gradientColor1: Color.fromRGBO(19, 19, 19, 40),
                gradientColor2: Color.fromRGBO(19, 19, 19, 40),
                gradientColor3: Color.fromRGBO(19, 19, 19, 40),
                gradientColor4: Color.fromRGBO(19, 19, 19, 40),
                containerChild: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NeoContainer(
                    shadowColor1: Color.fromRGBO(200, 200, 200, 40),
                    shadowColor2: Color.fromRGBO(0, 0, 0, 40),
                    blurRadius1: 3.0,
                    blurRadius2: 3.0,
                    spreadRadius1: 0.0,
                    spreadRadius2: 0.0,
                    circleShape: true,
                    containerChild: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              snapshot.data.downloadUrl
                            )
                          )
                        ),
                      ),
                  ),
                ),
              );
            } else {
              return StreamBuilder<OwnUser>(
                  stream: auth.onAuthStateChanged,
                  builder: (context, snapshotAuth) {
                    if (snapshotAuth.hasData) {
                      return NeoContainer(
                        shadowColor1: Color.fromRGBO(5, 5, 5, 40),
                        shadowColor2: Color.fromRGBO(50, 50, 50, 40),
                        blurRadius1: 3.0,
                        blurRadius2: 3.0,
                        spreadRadius1: 0.0,
                        spreadRadius2: 0.0,
                        circleShape: true,
                        containerHeight: MediaQuery.of(context).size.height / 5,
                        containerWidth: MediaQuery.of(context).size.width / 5,
                        gradientColor1: Color.fromRGBO(19, 19, 19, 40),
                        gradientColor2: Color.fromRGBO(19, 19, 19, 40),
                        gradientColor3: Color.fromRGBO(19, 19, 19, 40),
                        gradientColor4: Color.fromRGBO(19, 19, 19, 40),
                        containerChild: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshotAuth.data.foto
                                  )
                              )
                          ),
                        ),
                      );
                    } else {
                      return NeoContainer(
                        shadowColor1: Color.fromRGBO(5, 5, 5, 40),
                        shadowColor2: Color.fromRGBO(50, 50, 50, 40),
                        blurRadius1: 3.0,
                        blurRadius2: 3.0,
                        spreadRadius1: 0.0,
                        spreadRadius2: 0.0,
                        circleShape: true,
                        containerHeight: MediaQuery.of(context).size.height / 5,
                        containerWidth: MediaQuery.of(context).size.width / 5,
                        gradientColor1: Color.fromRGBO(19, 19, 19, 40),
                        gradientColor2: Color.fromRGBO(19, 19, 19, 40),
                        gradientColor3: Color.fromRGBO(19, 19, 19, 40),
                        gradientColor4: Color.fromRGBO(19, 19, 19, 40),
                      );
                    }
                  });
            }
          }
        ),
        SizedBox(width: 200.0,),
        Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SettingsPage(uid: storage.uid,);
                },
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: NeoContainer(
                shadowColor1: Color.fromRGBO(5, 5, 5, 40),
                shadowColor2: Color.fromRGBO(50, 50, 50, 40),
                blurRadius1: 3.0,
                blurRadius2: 3.0,
                spreadRadius1: 0.0,
                spreadRadius2: 0.0,
                circleShape: true,
                containerHeight: MediaQuery.of(context).size.height/9,
                containerWidth: MediaQuery.of(context).size.width/9,
                gradientColor1: Color.fromRGBO(10, 10, 10, 40),
                gradientColor2: Color.fromRGBO(15, 15, 15, 40),
                gradientColor3: Color.fromRGBO(40, 40, 40, 40),
                gradientColor4: Color.fromRGBO(50, 50, 50, 40),
                containerChild: Center(
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey[600],
                    size: 20.0,)
                ),
              ),
            ),
          ),
        ),
      ]
    );
  }

  Widget _neoNavigationBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60.0, top: 20.0),
          child: NeoContainer(
              shadowColor2: Color.fromRGBO(100, 40, 40, 1),
              shadowColor1: Color.fromRGBO(10, 10, 10, 80),
              circleShape: true,
              containerHeight: 40.0,
              containerWidth: 40.0,
              gradientColor1: Color.fromRGBO(30, 30, 30, 1),
              gradientColor2: Color.fromRGBO(30, 30, 30, 1),
              gradientColor3: Color.fromRGBO(30, 30, 30, 1),
              gradientColor4: Color.fromRGBO(30, 30, 30, 1),
              blurRadius1: 8.0,
              blurRadius2: 6.0,
              shadow2Offset: -5.0,
              shadow1Offset: 10.0,
              spreadRadius1: 4.0,
              spreadRadius2: 2.0,
          ),
        )
      ],
    );
  }

  Widget _neoTabBar(BuildContext context) {
    final TabbarColor neoBar = Provider.of<TabbarColor>(context);
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 8.0,),
            Expanded(
              child: GestureDetector(
                onTap: () => neoBar.updateTabColor(0, context),
                    child: Consumer<TabbarColor>(
                      builder: (context, data, child) {
                        return NeoContainer(
                            containerHeight: MediaQuery.of(context).size.height/20.0,
                            containerWidth: MediaQuery.of(context).size.width/4.0,
                            shadowColor1: neoBar.tabColor1[1],
                            shadowColor2: neoBar.tabColor1[2],
                            blurRadius1: 3.0,
                            blurRadius2: 3.0,
                            spreadRadius1: 0.0,
                            spreadRadius2: 0.0,
                            gradientColor1: neoBar.tabColor1[0],
                            gradientColor2: neoBar.tabColor1[0],
                            gradientColor3: neoBar.tabColor1[0],
                            gradientColor4: neoBar.tabColor1[0],
                            circleShape: false,
                            containerChild: Center(
                              child: Text(
                                'Workouts',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[300],
                                  fontSize: 16.0
                                ),
                              ),
                            ),);
                      }
                    ),
                ),
            ),
            SizedBox(width: 20.0,),
            Expanded(
              child: GestureDetector(
                onTap: () => neoBar.updateTabColor(1, context),
                child: Consumer<TabbarColor>(
                    builder: (context, data, child) {
                      return NeoContainer(
                          containerHeight: MediaQuery.of(context).size.height/20.0,
                          containerWidth: MediaQuery.of(context).size.width/4.0,
                          shadowColor1: neoBar.tabColor2[1],
                          shadowColor2: neoBar.tabColor2[2],
                          blurRadius1: 3.0,
                          blurRadius2: 3.0,
                          spreadRadius1: 0.0,
                          spreadRadius2: 0.0,
                          gradientColor1: neoBar.tabColor2[0],
                          gradientColor2: neoBar.tabColor2[0],
                          gradientColor3: neoBar.tabColor2[0],
                          gradientColor4: neoBar.tabColor2[0],
                          circleShape: false,
                          containerText: 'Muskelgruppen');
                    }
                ),
              ),
            ),
            SizedBox(width: 20.0,),
            Expanded(
              child: GestureDetector(
                onTap: () => neoBar.updateTabColor(2, context),
                child: Consumer<TabbarColor>(
                    builder: (context, data, child) {
                      return NeoContainer(
                          containerHeight: MediaQuery.of(context).size.height/20.0,
                          containerWidth: MediaQuery.of(context).size.width/4.0,
                          shadowColor1: neoBar.tabColor3[1],
                          shadowColor2: neoBar.tabColor3[2],
                          blurRadius1: 3.0,
                          blurRadius2: 3.0,
                          spreadRadius1: 0.0,
                          spreadRadius2: 0.0,
                          gradientColor1: neoBar.tabColor3[0],
                          gradientColor2: neoBar.tabColor3[0],
                          gradientColor3: neoBar.tabColor3[0],
                          gradientColor4: neoBar.tabColor3[0],
                          circleShape: false,
                          containerText: 'Favoriten');
                    }
                ),
              ),
            ),
            SizedBox(width: 8.0,)


          ]
        );


  }

  Widget _tabBarViewFavorits(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Container(
      height: MediaQuery.of(context).size.height/1.7,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<List<Favorite>>(
        stream: database.favoriteStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int Index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return BlankPage();
                        },
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 10.0, bottom: 15.0),
                          child: NeoContainer(
                            containerHeight: MediaQuery.of(context).size.height/2.0,
                            containerWidth: MediaQuery.of(context).size.width/1.1,
                            circleShape: false,
                              shadowColor1: Color.fromRGBO(10, 10, 10, 40),
                              shadowColor2: Color.fromRGBO(25, 25, 25, 40),
                              gradientColor1: Color.fromRGBO(30, 30, 30, 40),
                              gradientColor2: Color.fromRGBO(30, 30, 30, 40),
                              gradientColor3: Color.fromRGBO(30, 30, 30, 40),
                              gradientColor4: Color.fromRGBO(30, 30, 30, 40),
                              spreadRadius1: 0.0,
                              spreadRadius2: 0.0,
                            containerChild:  _imageContainerContent(context,
                                              [snapshot.data[Index].workout, snapshot.data[Index].duration, snapshot.data[Index].level],
                                                  snapshot.data[Index].thumbnail, snapshot.data[Index].videoPath, Index)),)
                    ),

                );
            }
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height/1.7,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int Index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 10.0, bottom: 15.0),
                        child: NeoContainer(
                        containerHeight: MediaQuery.of(context).size.height/2.0,
                    containerWidth: MediaQuery.of(context).size.width/1.6,
                    circleShape: false,
                    shadowColor1: Color.fromRGBO(10, 10, 10, 40),
                    shadowColor2: Color.fromRGBO(40, 40, 40, 40),
                    gradientColor1: Color.fromRGBO(19, 19, 19, 40),
                    gradientColor2: Color.fromRGBO(19, 19, 19, 40),
                    gradientColor3: Color.fromRGBO(19, 19, 19, 40),
                    gradientColor4: Color.fromRGBO(19, 19, 19, 40),
                    spreadRadius1: 0.0,
                    spreadRadius2: 0.0,
                        )
                    );
                  }),
            );
          }
          else {
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

        }
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
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return BlankPage();
                            },
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 10.0, bottom: 15.0),
                              child: NeoContainer(
                                  containerHeight: MediaQuery.of(context).size.height/2.0,
                                  containerWidth: MediaQuery.of(context).size.width/1.6,
                                  circleShape: false,
                                  shadowColor1: Color.fromRGBO(5, 5, 5, 40),
                                  shadowColor2: Color.fromRGBO(40, 40, 40, 40),
                                  gradientColor1: Color.fromRGBO(19, 19, 19, 40),
                                  gradientColor2: Color.fromRGBO(19, 19, 19, 40),
                                  gradientColor3: Color.fromRGBO(19, 19, 19, 40),
                                  gradientColor4: Color.fromRGBO(19, 19, 19, 40),
                                  spreadRadius1: 0.0,
                                  spreadRadius2: 0.0,
                                  containerChild: _imageContainerContent(context,
                                  cardInput, value['thumbnails'][Index], value['videoUrls'][Index], Index,),)
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
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 10.0, bottom: 15.0),
                      child: NeoContainer(
                        containerHeight: MediaQuery.of(context).size.height/2.0,
                        containerWidth: MediaQuery.of(context).size.width/1.6,
                        shadowColor1: Colors.black,
                        shadowColor2: Colors.white,
                        containerColor: Colors.grey[700],
                        circleShape: false,
                        spreadRadius1: 0.0,
                        spreadRadius2: 0.0,)
                    );
                  });
            }

          }
      ),
    );
  }

  Widget _imageContainer(BuildContext context, String imagePath, Widget content) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: FileImage(File(imagePath)),
              fit: BoxFit.fill
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      child: content,
    );
  }

  Widget _imageContainerContent(BuildContext context, List<dynamic> input, String thumbnail, String videoUrl, int index) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Stack(
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(thumbnail)),
                      fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: NeoContainer(
              circleShape: false,
              containerHeight: MediaQuery.of(context).size.height/25,
              containerWidth: MediaQuery.of(context).size.width/3.0,
              shadow1Offset: 4.5,
              shadow2Offset: -2.0,
              blurRadius2: 3.0,
              blurRadius1: 3.0,
              spreadRadius2: 0.0,
              spreadRadius1: 0.0,
              shadowColor1: Color.fromRGBO(40, 40, 40, 40),
              shadowColor2: Color.fromRGBO(5, 5, 5, 40),
              gradientColor1: Color.fromRGBO(19, 19, 19, 40),
              gradientColor2: Color.fromRGBO(19, 19, 19, 40),
              gradientColor3: Color.fromRGBO(19, 19, 19, 40),
              gradientColor4: Color.fromRGBO(19, 19, 19, 40),
              containerChild: Center(
                child: Text(input[0],
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Colors.grey[200]
                  ),),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 320, left: 10.0),
              child: NeoContainer(
                circleShape: false,
                containerHeight: MediaQuery.of(context).size.height/25,
                containerWidth: MediaQuery.of(context).size.width/2.6,
                shadow1Offset: 4.5,
                shadow2Offset: -2.0,
                blurRadius2: 3.0,
                blurRadius1: 3.0,
                spreadRadius2: 0.0,
                spreadRadius1: 0.0,
                shadowColor1: Color.fromRGBO(40, 40, 40, 40),
                shadowColor2: Color.fromRGBO(5, 5, 5, 40),
                gradientColor1: Color.fromRGBO(19, 19, 19, 40),
                gradientColor2: Color.fromRGBO(19, 19, 19, 40),
                gradientColor3: Color.fromRGBO(19, 19, 19, 40),
                gradientColor4: Color.fromRGBO(19, 19, 19, 40),
                containerChild: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text('Level: ',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColor
                        ),),
                    ),
                    StarDisplayWidget(
                      value: int.parse(input[2]),
                      filledStar: Icon(Icons.adjust, color: Theme.of(context).primaryColor, size: 18.0),
                      unfilledStar: Icon(Icons.adjust, color: Colors.grey, size: 18.0),
                    ),
                  ],
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 370, left: 10.0),
            child: NeoContainer(
              circleShape: false,
              containerHeight: MediaQuery.of(context).size.height/25,
              containerWidth: MediaQuery.of(context).size.width/2.6,
              shadow1Offset: 4.5,
              shadow2Offset: -2.0,
              blurRadius2: 3.0,
              blurRadius1: 3.0,
              spreadRadius2: 0.0,
              spreadRadius1: 0.0,
              shadowColor1: Color.fromRGBO(40, 40, 40, 40),
              shadowColor2: Color.fromRGBO(5, 5, 5, 40),
              gradientColor1: Color.fromRGBO(19, 19, 19, 40),
              gradientColor2: Color.fromRGBO(19, 19, 19, 40),
              gradientColor3: Color.fromRGBO(19, 19, 19, 40),
              gradientColor4: Color.fromRGBO(19, 19, 19, 40),
              containerChild: Center(
                child: Text('Dauer: '+input[1],
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor
                  ),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200),
            child: IconButton(
                color: Colors.black,
                icon: Icon(MdiIcons.star),
                onPressed: () => database.createFavorite(Favorite(videoPath: videoUrl, duration: input[1], workout: input[0], level: input[2], thumbnail: thumbnail))),)
        ]
    );
  }

  /*
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

   */
}
