

import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:video_app/CustomWidgets/appbar.dart';
import 'package:video_app/CustomWidgets/rating.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Views/profil.dart';

import '../Helpers/helpers.dart';
import 'package:flutter/material.dart';
import '../videoplayerservice.dart';
import '../Services/firebase_storage_service.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import '../CustomWidgets/appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      backgroundColor: Colors.black45,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
              FutureBuilder(
                future: FirebaseStorageService.instance.videoDownload(context, '/videos/'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final value = snapshot.data;
                    print(value.length);
                    return ListView.builder(
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
                            child: Container(
                              height: MediaQuery.of(context).size.height/5,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Stack(
                                  children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height/5,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image(
                                          image: FileImage(File(value['thumbnails'][Index])),
                                          fit: BoxFit.cover
                                  ),
                                      ),
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
                                        padding: const EdgeInsets.only(top: 115, left: 8.0),
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
                                      padding: const EdgeInsets.only(top: 115, left: 270.0),
                                      child: Text('Dauer: '+cardInput[1],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor
                                      ),),
                                    ),
                            ]
                                )
                              ),
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                      itemCount: 5,
                        itemBuilder: (BuildContext context, int Index) {
                        return Container(
                          height: MediaQuery.of(context).size.height/5,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                              child: _customProgress(context)
                        )
                        );
                        });
                  }

                }
              ),
      )
    );
  }

  Widget _customProgress(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );


  }


}
