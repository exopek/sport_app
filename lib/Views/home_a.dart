import 'dart:math';
import 'package:video_app/CustomWidgets/neoContainer.dart';
import 'package:video_app/Helpers/blank.dart';
import 'package:video_app/Models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/Notifyers/categoryTabBarIndex.dart';
import 'package:video_app/Notifyers/infoTextRoutine_notifyer.dart';
import 'package:video_app/Notifyers/tabbar_color.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Views/category_a.dart';
import 'package:video_app/Views/myWorkouts_a.dart';
import 'package:video_app/Views/workout_a.dart';

import 'category_myworkouts_a.dart';

class HomeAPage extends StatefulWidget {
  @override
  _HomeAPageState createState() => _HomeAPageState();
}

class _HomeAPageState extends State<HomeAPage> {


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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8, top: MediaQuery.of(context).size.height/6),
              child: _catergoriesHeader(context),
            ),
            Center(child: _catergories(context)),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10, right: MediaQuery.of(context).size.width/10,top: MediaQuery.of(context).size.height/1.2),
              child: _navigationBar(context),
            )
          ],
        ),
      )
    );
  }

  Widget _catergories(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Container(
      height: MediaQuery.of(context).size.height/2,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<List<Categories>>(
        stream: database.categoriesStream(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return PageView.builder(
                controller: _pageViewController,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int Index) {
                  double scale = max(viewportFraction ,(1-(pageOffset - Index).abs()) + viewportFraction);
                  return _workoutContainerContent(context, snapshot.data[Index].name, snapshot.data[Index].thumbnail, Index, scale);
                });
          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return PageView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int Index) {
                  double scale = max(viewportFraction ,(1-(pageOffset - Index).abs()) + viewportFraction);
                  return _waitContainer(context, Index, scale);
                });
          } else {
            return PageView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int Index) {
                  double scale = max(viewportFraction ,(1-(pageOffset - Index).abs()) + viewportFraction);
                  return _waitContainer(context, Index, scale);
                });
          }
        },
      ),
    );
  }

  Widget _waitContainer(BuildContext context, int index, double scale) {
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
                  borderRadius: BorderRadius.all(Radius.circular(35.0))
              ),
            ),
          ),
        ]
    );
  }

  Widget _workoutContainerContent(BuildContext context, String name, String thumbnail, int index, double scale) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    var route = {'Excercises' : CategoryAPage(category: name,),
                    'My Workouts' : CategoryMyWorkouts()};
    return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: 20.0,
                top: 50 - scale * 25,
                bottom: 10),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MultiProvider(
                        providers: [
                          Provider(create: (context) => DatabaseHandler(uid: database.uid),),
                          ChangeNotifierProvider(create: (context) => CTabBarIndex(context: context)),
                        ],
                        child: route[name]);
                  },
                ),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(35.0 ),
                elevation: 5.0,
                shadowColor: Colors.grey[200],
                child: Container(
                  width: MediaQuery.of(context).size.width/1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(35.0))
                    ),
                    child: Center(
                      child: Text(name.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'FiraSansExtraCondensed',
                        fontSize: 30.0,
                        color: Colors.white
                      ),),
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(thumbnail),
                          fit: BoxFit.fill
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(35.0))
                  ),
                ),
              ),
            ),
          ),
        ]
    );
  }

  Widget _catergoriesHeader(BuildContext context) {
    return Text('Kategorien'.toUpperCase(),
    style: TextStyle(
      fontFamily: 'FiraSansExtraCondensed',
      fontSize: 30.0,
      color: Colors.white
    )
    );
  }

  Widget _navigationBar(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return NeoContainer(
        circleShape: false,
        blurRadius2: 3.0,
        blurRadius1: 5.0,
        shadowColor1: Color.fromRGBO(19, 19, 19, 1.0),
        shadowColor2: Color.fromRGBO(19, 19, 19, 1.0),
        containerWidth: MediaQuery.of(context).size.width/1.2,
        containerHeight: MediaQuery.of(context).size.height/10,
        containerChild: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.home, color: Colors.black,),
                label: Text('home'.toUpperCase())),
            FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.analytics, color: Colors.black,),
                label: Text('')),
            FlatButton.icon(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(Icons.alarm_add_outlined, color: Colors.black,),
                label: Text(''),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MultiProvider(
                          providers: [
                            Provider(create: (context) => DatabaseHandler(uid: database.uid),),
                            ChangeNotifierProvider(create: (context) => TextRoutine()),
                          ],
                          child: MyWorkoutsAPage());
                    },
                  ),
                )
            )
          ],
        ),
    );
  }
}
