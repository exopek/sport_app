import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/CustomWidgets/neoContainer.dart';
import 'package:video_app/CustomWidgets/persistant_sliver_header.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Notifyers/timerEnd_notifyer.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Views/videoPlayer2_a.dart';
import 'package:video_app/Views/videoPlayerChewie.dart';
import 'package:video_app/Views/videoPlayer_withListView.dart';

class Workout2APage extends StatefulWidget {

  final routineName;

  const Workout2APage({Key key,@required this.routineName}) : super(key: key);

  @override
  _Workout2APageState createState() => _Workout2APageState();
}


class _Workout2APageState extends State<Workout2APage> {


  Routine routine;

  List workoutList;

  List videoPathList;

  Future<Routine> getWorkoutList(BuildContext context) async {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    try {
      final Routine Input = await database.getRoutineCustomMap(widget.routineName);
      routine = Input;
    } catch(e) {
      print(e);
    }
    return routine;
  }

  bool firstVisit;

  @override
  void initState() {
    firstVisit = false;
    workoutList = new List();
    videoPathList = new List();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    if (firstVisit == false) {
      getWorkoutList(context).then((value){
        setState(() {
          workoutList = value.workoutNames;
          videoPathList = value.videoPaths;
          firstVisit = true;
        });
      });

    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()
        ),
        slivers: [
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
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height/1.02,
            //collapsedHeight: 100.0,
            //pinned: true,
            floating: true,
              backgroundColor: Theme.of(context).primaryColor,
            stretchTriggerOffset: 250.0,

            onStretchTrigger: () {
              return;
            },

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))
            ),
            elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                centerTitle: true,
                title: Text(widget.routineName,
                  style: TextStyle(
                      fontFamily: 'FiraSansExtraCondensed',
                      fontSize: 30.0,
                      color: Colors.black
                  ),),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://r-cf.bstatic.com/images/hotel/max1024x768/116/116281457.jpg',
                      fit: BoxFit.cover,
                    ),
                  ]
                ),
              )
          ),
          */
          SliverToBoxAdapter(
            child: Container(
              height: 100.0,
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 40.0,
                    width: 200.0,
                    color: Colors.red,
                    child: Center(
                      child: Text('Übersicht',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'FiraSansExtraCondensed',
                            fontSize: 22.0
                        ),),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        Divider(
                          height: 0.5,
                          color: Colors.white,
                          thickness: 0.2,
                        ),
                        Container(
                          color: Theme.of(context).primaryColor,
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(workoutList[index],
                            style: TextStyle(
                              color: Colors.white
                            ),),
                          ),
                        ),
                      ],
                    );
                  },
                childCount: workoutList.length
              )),
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MultiProvider(
                            providers: [
                              ChangeNotifierProvider(create: (context) => TimerNotifyer()),
                            ], child: VideoPlayerList(urlList: videoPathList),
                        );

                      },
                    ),
                  ),
                  child: Center(
                    child: Text('Start'.toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'FiraSansExtraCondensed',
                          color: Colors.black,
                        fontSize: 25.0
                      ),),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }


}
