import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/Helpers/blank.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Views/workout2_a.dart';
import 'package:video_app/Views/workout_a.dart';

class CategoryMyWorkouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: false,
          child: _listView(context)),
    );
  }

  Widget _listView(BuildContext context) {
    final DatabaseHandler database = Provider.of<DatabaseHandler>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<List<Routine>>(
        stream: database.routineStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  ListView.builder(
              itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return MultiProvider(
                                  providers: [
                                    Provider(create: (context) => DatabaseHandler(uid: database.uid),),
                                    //ChangeNotifierProvider(create: (context) => CTabBarIndex(context: context)),
                                  ],
                                  child: Workout2APage(routineName: snapshot.data[index].routineName));
                            },
                          ),
                        );
                      },
                      child: _listViewInput(context, snapshot.data[index].routineName)
                  );
                });
          } else {
            return SingleChildScrollView(
              child: CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _listViewInput(BuildContext context, String routineNme) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/5,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(routineNme,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'FiraSansExtraCondensed',
            fontSize: 30.0
          ),),
        ),
      ),
    );
  }
}
