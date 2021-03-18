import 'dart:math';

import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart' as Scroll;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_app/CustomWidgets/add_routine_button.dart';
import 'package:video_app/CustomWidgets/buttonClipper.dart';
import 'package:video_app/CustomWidgets/custom_signIn_Button.dart';
import 'package:video_app/CustomWidgets/half_circleShape_Image.dart';
import 'package:video_app/CustomWidgets/videoClipper.dart';
import 'package:video_app/Helpers/blank.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Views/workout_final.dart';

import '../videoplayerservice.dart';

class HomeFinalPage extends StatefulWidget {

  @override
  _HomeFinalPageState createState() => _HomeFinalPageState();
}

class _HomeFinalPageState extends State<HomeFinalPage> {
  PageController _pageViewController;

  double viewportFraction = 0.8;

  double pageOffset = 0.0;

  @override
  void initState() {
    _pageViewController = PageController(initialPage: 0, viewportFraction: viewportFraction)
      ..addListener(() {
        setState(() {
          pageOffset = _pageViewController.page;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/3.0),
                      child: Center(child: _redRing(context)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.8, left: MediaQuery.of(context).size.width/18),
                      child: _buttonOwnWorkouts(context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.8, left: MediaQuery.of(context).size.width/1.6),
                      child: _buttonAddRoutine(context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 40.0),
                      child: Center(child: _nameWorkout(context)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 450.0),
                      child: _tabBar(context),
                    ),
                    _tabBarViewWorkout(context)

                  ],
                ),
          ),
        ),
      ),
    );
  }

  Widget _ringList(BuildContext context) {
    return Center(
      child: Scroll.CircleListScrollView(
        itemExtent:160.0,
        controller: Scroll.FixedExtentScrollController(initialItem: 1),
        physics: Scroll.CircleFixedExtentScrollPhysics(),
        axis: Axis.horizontal,
        children: List.generate(7, _ringListItem),
        onSelectedItemChanged: (int index) {}, //stream
        radius: MediaQuery.of(context).size.width*0.36,
      ),
    );
  }

  Widget _ringListItem(int i) {
    return Center(
      child: Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),

              child: GestureDetector(
                onTap: () {
                  //tagNames.add(value);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                  child: Center(
                      child: Icon(Icons.alarm_add_outlined)
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buttonAddRoutine(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return MultiProvider(
        providers: [
          Provider(create: (context) => DatabaseHandler(uid: database.uid),),
        ],
        child: AddRoutineButton(uid: database.uid));AddRoutineButton(uid: database.uid);
  }

  Widget _buttonOwnWorkouts(BuildContext context) {
    return FlatButton.icon(
        onPressed: () {},
        icon: Icon(Icons.folder_shared_rounded,
        color: Colors.white,),
        label: Text('my routins'.toUpperCase(),
          style: TextStyle(
            fontFamily: 'FiraSansExtraCondensed',
            fontSize: 14.0,
            color: Colors.white
          ),
        )
    );
  }

  Widget _pageViewWorkouts(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return ClipPath(
        clipper: OvalVideoClipper(),
          child: StreamBuilder<List<Routine>>(
            stream: database.routineStream(),
            builder: (context, snapshot) {
              if (snapshot.requireData.isNotEmpty) {
                return PageView.builder(
                    itemCount: int.parse(snapshot.data.first.count),
                    itemBuilder: (BuildContext context, int Index) {
                      if (snapshot.data.first.videoPaths[Index] != "") {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SamplePlayer(videourl: snapshot.data.first.videoPaths[Index]);
                                  },
                                ),
                              ),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data.first.thumbnails[Index]),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Material(
                                  child: Container(
                                    height: 120.0,
                                    child: FlatButton.icon(
                                          onPressed: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return MultiProvider(
                                                    providers: [
                                                      Provider(create: (context) => DatabaseHandler(uid: database.uid),),
                                                    ],
                                                    child: WorkoutPage());
                                              },
                                            ),
                                          ),
                                          icon: Icon(Icons.add, color: Colors.black,),
                                          label: Text('füge ein workout hinzu'.toUpperCase(),
                                          style: TextStyle(
                                            fontFamily: 'FiraSansExtraCondensed',
                                            fontSize: 16.0,
                                            color: Colors.black
                                          ),)),
                                  ),
                                ),
                        );
                    }
                    }
                    );
              } else {
                return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/Thabs.png'),
                              fit: BoxFit.cover
                          )
                      ),
                    );
              }

            }
          )


      );
  }

  Widget _nameWorkout(BuildContext context) {
    return Text('Schulterpresse',
      style: TextStyle(
          fontFamily: 'FiraSansExtraCondensed',
          fontSize: 30,
          color: Colors.white
      ),
    );
  }

  Widget _redRing(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2.1,
      width: MediaQuery.of(context).size.height/2.1,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.red,
              offset: Offset( 0, 0),
              //4.5 both
              blurRadius: 15.0,
              // 15.0
              spreadRadius: 0), // 1.0
          BoxShadow(
            color: Colors.red,
            offset: Offset(0, 0),
            // -4.5 both
            blurRadius: 3.0,
            // 15.0
            spreadRadius: 0,), // 1.0
        ],
        shape: BoxShape.circle,
            color: Colors.red
      ),
      child: Center(
        child: Container(
              height: MediaQuery.of(context).size.height/2.15,
              width: MediaQuery.of(context).size.height/2.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Logo_weiß.png')
                ),
                shape: BoxShape.circle,
                color: Colors.grey[900]
              ),
              child: _pageViewWorkouts(context),
            )
      ),
    );
  }

  Widget _logo(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height/2.15,
        width: MediaQuery.of(context).size.height/2.15,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/Logo_weiß.png')
        ),
        shape: BoxShape.circle,
        color: Colors.grey[900]
        ),
        );
  }

  Widget _tabBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/16.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return BlankPage();
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Center(
                      child: Text('Workout of the Week',
                        style: TextStyle(
                            fontFamily: 'FiraSansExtraCondensed',
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _tabBarViewWorkout(BuildContext context) {
    final FirebaseAuthService auth = Provider.of<FirebaseAuthService>(context);
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 500.0),
      child: Container(
        height: MediaQuery.of(context).size.height/4.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35.0))
        ),
        child: StreamBuilder<List<Workout>>(
            stream: database.workoutStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final value = snapshot.data;
                return PageView.builder(
                    controller: _pageViewController,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int Index) {
                      //var cardInput = HelperFunctions().splitSeparatedWords(value['pathInfo'][Index], ['/','.','_']);
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SamplePlayer(videourl: snapshot.data[Index].videoPath);
                            },
                          ),
                        ),
                        child: _imageContainerContent(context,
                          snapshot.data[Index].bodyPart, snapshot.data[Index].level, snapshot.data[Index].workout, snapshot.data[Index].thumbnail, snapshot.data[Index].videoPath, Index,),

                      );
                    });
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,

                    itemCount: 5,
                    itemBuilder: (BuildContext context, int Index) {
                      return Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 260.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height/4.0,
                            width: MediaQuery.of(context).size.width,
                            )
                      );
                    });
              }

            }
        ),
      ),
    );
  }

  Widget _imageContainerContent(BuildContext context, String workout, String level, String bodyPart, String thumbnail, String videoUrl, int index) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    double scale = max(viewportFraction ,(1-(pageOffset - index).abs()) + viewportFraction);
    return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: 20.0,
            top: 50 - scale * 25,
            bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width/1.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail),
                      fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(35.0))
              ),
            ),
          ),

/*
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height/45.0,
              left: MediaQuery.of(context).size.width/1.8,),
            child: NeoContainer(
              containerHeight: MediaQuery.of(context).size.height/20.0,
              containerWidth: MediaQuery.of(context).size.width/8.0,
              shadowColor1: Color.fromRGBO(5, 5, 5, 40),
              shadowColor2: Colors.white,
              blurRadius1: 3.0,
              blurRadius2: 3.0,
              spreadRadius1: 0.0,
              spreadRadius2: 0.0,
              shadow2Offset: -3.0,
              gradientColor1: Color.fromRGBO(33, 33, 34, 1),
              gradientColor2: Color.fromRGBO(33, 33, 34, 1),
              gradientColor3: Color.fromRGBO(33, 33, 34, 1),
              gradientColor4: Color.fromRGBO(33, 33, 34, 1),
              circleShape: false,
              containerChild: Center(
                child: IconButton(
                    color: Colors.redAccent,
                    icon: Icon(MdiIcons.star),
                    onPressed: () => database.createFavorite(Favorite(
                        videoPath: videoUrl,
                        duration: duration,
                        workout: workout,
                        level: level,
                        thumbnail: thumbnail,
                        bodyPart: bodyPart))),
              ),
            ),)

 */
        ]
    );
  }
}
