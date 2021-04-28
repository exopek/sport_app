import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/CustomWidgets/DraggableListItem.dart';
import 'package:video_app/CustomWidgets/custom_signIn_Button.dart';
import 'package:video_app/CustomWidgets/persistant_sliver_header.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Notifyers/categoryTabBarIndex.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Views/category_a.dart';
import 'dart:async';

class EditWorkoutPage extends StatefulWidget {

  final routineName;

  const EditWorkoutPage({Key key,@required this.routineName}) : super(key: key);

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {

  List<dynamic> routineInput;

  List workoutList;

  Future<List<dynamic>> getWorkoutList(BuildContext context) async {
          final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
          try {
            final Input = await database.getRoutine(widget.routineName);
            routineInput = Input;
          } catch(e) {
            print(e);
          }
          return routineInput;
  }

  bool firstVisit;

  @override
  void initState() {
    firstVisit = false;
    workoutList = new List();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);

    if (firstVisit == false) {
      getWorkoutList(context).then((value){
        setState(() {
          workoutList = value;
          firstVisit = true;
        });
      });

    }
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        top: false,
          child: CustomScrollView(
            slivers:[
              SliverPersistentHeader(
                pinned: true, // header bleibt fest bei minExtent
                //floating: true,     // Scrollt den gesamten header weg
                delegate: NetworkingPageHeader(
                    minExtent: 250.0,
                    maxExtent: MediaQuery.of(context).size.height,
                    headerName: widget.routineName
                ),
              ),
              /*
              SliverList(

                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Column(
                      children: [
                        _excerciseDragandDrop(context),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                _createRoute(context)
                            );
                          },
                          child: Center(
                            child: Icon(
                                Icons.add,
                                color: Colors.white,
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                  childCount: 1, // 1000 list items
                ),
              ),
              */
              SliverToBoxAdapter(
                child: Container(
                  child: Column(
                    children: [
                      _excerciseDragandDrop(context),
                      OutlineButton(
                        splashColor: Colors.grey,
                        borderSide: BorderSide(
                          color: Colors.white
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                              _createRoute(context)
                          );
                        },
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ]
          )),
    );
  }

  Widget _excerciseDragandDrop(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Container(
      height: MediaQuery.of(context).size.height/2,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ReorderableListView(
        //scrollController: ScrollController().,
        scrollDirection: Axis.vertical,
        children: [
          if (workoutList.isNotEmpty)
            for (int i = 0; i <= workoutList.length-1; i++)
              DraggableWidget(
                key: ValueKey(i.toString()),
                customWidgetString: workoutList[i],
              )
        ],
        onReorder: (oldIndex, newIndex) {
          setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final workout = workoutList.removeAt(oldIndex);
          print(workout);
          workoutList.insert(newIndex, workout);

            workoutList = workoutList;
            database.updateRoutineWorkoutList(workoutList, widget.routineName);
          });
        },
      ),
    );
  }

  Widget _excercises(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Container(
      height: MediaQuery.of(context).size.height/5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<Routine>(
                stream: database.routineInputStream(widget.routineName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.workoutNames.length,
                      itemBuilder: (context, adex) {
                        print(snapshot.data);
                        return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            elevation: 5.0,
                            child: Container(
                              height: MediaQuery.of(context).size.height/6,
                              width: MediaQuery.of(context).size.width/3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  child: Stack(
                                      children:[
                                        Image(
                                            image: NetworkImage(snapshot.data.thumbnails[adex]),
                                          fit: BoxFit.fitHeight,
                                        ),
                                        Text(snapshot.data.workoutNames[adex]),
                                      ]
                                  )
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(color: Colors.black,);
                  }
                }
            ),
          )
        ],
      ),
    );
  }

  Route _createRoute(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context, listen: false);
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return MultiProvider(
            providers: [
              Provider(create: (context) => DatabaseHandler(uid: database.uid),),
              ChangeNotifierProvider(create: (context) => CTabBarIndex(context: context)),
            ],
            child: CategoryAPage(category: 'Konfigurator', routineName: widget.routineName,));
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
