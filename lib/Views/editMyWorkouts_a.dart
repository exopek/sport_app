import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Notifyers/categoryTabBarIndex.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Views/category_a.dart';

class EditWorkoutPage extends StatelessWidget {

  final routineName;

  const EditWorkoutPage({Key key,@required this.routineName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
            slivers:[
              SliverAppBar(
                  pinned: true,
                  expandedHeight: 150.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('Meine Workouts',
                      style: TextStyle(
                          fontFamily: 'FiraSansExtraCondensed',
                          fontSize: 30.0,
                          color: Colors.black
                      ),),
                    background: Image.network(
                      'https://r-cf.bstatic.com/images/hotel/max1024x768/116/116281457.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  )),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Column(
                      children: [
                        _excercises(context),
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                _createRoute(context)
                            );
                          },
                          child: Center(
                            child: Icon(
                                Icons.add),
                          ),
                        )
                      ],
                    );
                  },
                  childCount: 1, // 1000 list items
                ),
              ),
            ]
          )),
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
                stream: database.routineInputStream(routineName),
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
            child: CategoryAPage(category: 'Konfigurator', routineName: routineName,));
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
