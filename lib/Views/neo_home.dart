import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:video_app/CustomWidgets/neoContainer.dart';
import 'package:video_app/CustomWidgets/rating.dart';
import 'package:video_app/Helpers/helpers.dart';
import 'package:video_app/Notifyers/tabbar_color.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Services/firebase_storage_service.dart';

import '../videoplayerservice.dart';

class HomePageNeo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.1, 0.3),
          focal: Alignment(-0.1, 0.6),
          focalRadius: 2,
          colors: [Colors.grey[900], Colors.grey[850], Colors.grey[800], Colors.grey[700]],
          stops: [0.2, 0.5, 0.7, 1],
        )
      ),
      child: Column(
        children: [
          _neoTabBar(context),
          _tabBarViewWorkout(context)
        ],
      ),
    );
  }

  Widget _neoTabBar(BuildContext context) {
    final TabbarColor neoBar = Provider.of<TabbarColor>(context);
    return  Container(
      height: MediaQuery.of(context).size.height/12,
      width: MediaQuery.of(context).size.width,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 8.0,),
            Expanded(
              child: GestureDetector(
                onTap: () => neoBar.updateTabColor(0, context),
                    child: Consumer<TabbarColor>(
                      builder: (context, data, child) {
                        return NeoContainer(shadowColor1: data.tabColor1[2], shadowColor2: data.tabColor1[1], containerColor: data.tabColor1[0],
                            containerText: 'Workouts');
                      }
                    ),
                ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              child: GestureDetector(
                onTap: () => neoBar.updateTabColor(1, context),
                child: Consumer<TabbarColor>(
                    builder: (context, data, child) {
                      return NeoContainer(shadowColor1: data.tabColor2[2], shadowColor2: data.tabColor2[1], containerColor: data.tabColor2[0],
                          containerText: 'Muskelgruppen');
                    }
                ),
              ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              child: GestureDetector(
                onTap: () => neoBar.updateTabColor(2, context),
                child: Consumer<TabbarColor>(
                    builder: (context, data, child) {
                      return NeoContainer(shadowColor1: data.tabColor3[2], shadowColor2: data.tabColor3[1], containerColor: data.tabColor3[0],
                          containerText: 'Favoriten');
                    }
                ),
              ),
            ),
            SizedBox(width: 8.0,)


          ]
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
