import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Views/videoPlayer2_a.dart';
import 'package:video_app/Views/videoPlayerChewie.dart';

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
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height,
            collapsedHeight: 250.0,
            pinned: true,
            floating: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))
            ),
            elevation: 5.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,

                title: Text(widget.routineName,
                  style: TextStyle(
                      fontFamily: 'FiraSansExtraCondensed',
                      fontSize: 30.0,
                      color: Colors.black
                  ),),
                background: Image.network(
                  'https://r-cf.bstatic.com/images/hotel/max1024x768/116/116281457.jpg',
                  fit: BoxFit.cover,
                ),
              )
          ),
          
          SliverAppBar(
            elevation: 0.0,
            expandedHeight: 50.0,
            automaticallyImplyLeading: false,
            title: Text('Übersicht',
              style: TextStyle(
                  color: Colors.white
              ),),
            /*
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Übersicht',
                style: TextStyle(
                    color: Colors.white
                ),),
            ),

             */
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
                color: Colors.blue,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Videos(videourl: videoPathList); //Hier was machen
                      },
                    ),
                  ),
                  child: Center(
                    child: Text('Start'.toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'FiraSansExtraCondensed',
                          color: Colors.black
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
