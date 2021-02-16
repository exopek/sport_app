

import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:video_app/CustomWidgets/rating.dart';
import 'package:video_app/Notifyers/tabbar_color.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Views/profil.dart';

import '../Helpers/helpers.dart';
import 'package:flutter/material.dart';
import '../videoplayerservice.dart';
import '../Services/firebase_storage_service.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class HomePageH extends StatefulWidget {
  @override
  _HomePageHState createState() => _HomePageHState();
}

class _HomePageHState extends State<HomePageH> {



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            leading: Container(),
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
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/5
              ),
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.cyan,
                /*
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 5.0),
                    insets: EdgeInsets.symmetric(horizontal:16.0)
                ),
                 */
                onTap: (index) {
                  var tabbarColorInfo = Provider.of<TabbarColor>(context, listen: false);
                  tabbarColorInfo.updateTabColor(index, context);
                },
                tabs: [

                  Consumer<TabbarColor>(
                    builder: (context, data, child) {
                    return Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: MediaQuery.of(context).size.height/14,
                      decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [data.tabColor1[0], data.tabColor1[1]],
                      )),
                        child: Center(
                            child: Text('You')));},
                  ),
                  Consumer<TabbarColor>(
                    builder: (context, data, child) {
                      return Container(
                          width: MediaQuery.of(context).size.width/3,
                          height: MediaQuery.of(context).size.height/14,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [data.tabColor2[0], data.tabColor2[1]],
                              )),
                          child: Center(
                              child: Text('You')));},
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
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(icon: Icon(Icons.api_sharp), onPressed: () {}),
                  IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  IconButton(icon: Icon(Icons.analytics_outlined), onPressed: () {}),
                  IconButton(icon: Icon(Icons.settings), onPressed: () {})
                ],
              ),
            ),

          ),
          backgroundColor: Colors.black45,
          body: Container(
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
                              padding: const EdgeInsets.all(8.0),
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
                                              padding: const EdgeInsets.only(top: 320, left: 8.0),
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
                                            padding: const EdgeInsets.only(top: 320, left: 160.0),
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
                      scrollDirection: Axis.horizontal,

                        itemCount: 5,
                        itemBuilder: (BuildContext context, int Index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: MediaQuery.of(context).size.height/1.7,
                                width: MediaQuery.of(context).size.width/1.5,
                                child: Card(
                                    child: _customProgress(context)
                                )
                            ),
                          );
                        });
                  }

                }
            ),
          )
      ),
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
