import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:video_app/CustomWidgets/add_routine_button.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Notifyers/infoTextRoutine_notifyer.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Views/editMyWorkouts_a.dart';

class MyWorkoutsAPage extends StatefulWidget {
  @override
  _MyWorkoutsAPageState createState() => _MyWorkoutsAPageState();
}

class _MyWorkoutsAPageState extends State<MyWorkoutsAPage> {

  PageController _pageViewController1;

  double viewportFraction = 0.2;

  double pageOffset = 0.0;

  StreamController<dynamic> _infoIndexController;

  Stream myWorkoutInfoStream;

  int _infoState;

  @override
  void initState() {
    _infoState  = 0;
    _infoIndexController = StreamController<dynamic>();
    myWorkoutInfoStream = _infoIndexController.stream.asBroadcastStream();
    _pageViewController1 = PageController(initialPage: 0, viewportFraction: viewportFraction)
      ..addListener(() {
        setState(() {
          pageOffset = _pageViewController1.page;
        });
      });
    _infoIndexController.stream.listen((event) {
      setState(() {
        _infoState = event;
      });
    });
    super.initState();
  }


  void dispose() {
    _infoIndexController.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Workouts'),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          _workouts(context),
          Padding(
            padding: EdgeInsets.only(left: 200),
            child: _infoSideBar(context)
          ),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/1.4, top: MediaQuery.of(context).size.height/1.4),
            child: SizedBox(
                height: MediaQuery.of(context).size.height/10,
                width: MediaQuery.of(context).size.height/10,
                child: AddRoutineButton(),

              ),
          )
        ] ),
      ),
    );
  }

  Widget _workouts(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Container(
      height:  MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width/2,
      child: StreamBuilder<List<Routine>>(
        stream: database.routineStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageView.builder(
              onPageChanged: (context) {
                if (_pageViewController1.page == null) {
                  return _infoIndexController.add(0);
                } else {
                  return _infoIndexController.add(_pageViewController1.page.round());
                }
              },
                controller: _pageViewController1,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  double scale = max(viewportFraction ,(1-(pageOffset - index).abs()) + viewportFraction);
                  return _workoutsContainer(context, index, scale, snapshot.data[index].routineName);
                });
          } else {
            return Container();
          }

        }
      ),
    );
  }

  Widget _workoutsContainer(BuildContext context, index, scale, String name) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10,
      left: 10, right: 50 - scale * 25),
      child: Container(
        height: MediaQuery.of(context).size.height/3,
        width: MediaQuery.of(context).size.width/2,
        color: Colors.green,
        child: Stack(
          children: [
            Center(
              child: Text(name.toUpperCase()),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 50,
                  width: 50,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.icecream),
                      label: Text(''),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MultiProvider(
                                providers: [
                                  Provider(create: (context) => DatabaseHandler(uid: database.uid),),
                                ],
                                child: EditWorkoutPage(routineName: name,));
                          },
                        ),
                      ),
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }

  Widget _infoSideBar(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Container(
      height: MediaQuery.of(context).size.height/1.4,
      width: MediaQuery.of(context).size.width/2,
      child: Column(
        children: [
          Text('Übersicht',
          style: TextStyle(
            fontFamily: 'FiraSansExtraCondensed',
            fontSize: 30.0,
            color: Colors.black
          ),),
          Container(
            height: MediaQuery.of(context).size.height/1.6,
            width: MediaQuery.of(context).size.width/2,
            color: Colors.red,
            child: StreamBuilder<List<Routine>>(
              stream: database.routineStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data[_infoState].workoutNames.length,
                    itemBuilder: (context, adex) {
                      print(snapshot.data.length);
                      return Container(
                        color: Colors.yellow,
                          height: 30.0,
                          width: 50,
                          child: Text(snapshot.data[_infoState].workoutNames[adex]));
                    },
                  );
                } else {
                  return Container();
                }
              }
            ),
          )
        ],
      ),
    );
  }
}
