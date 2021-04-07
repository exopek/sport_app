import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../Models/models.dart';
import '../Models/apis.dart';
import 'firebase_cloud_service.dart';


class DatabaseHandler {
  DatabaseHandler({@required this.uid}) : assert(uid != null);
  final String uid;
  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  final _service = FirestoreService.instance;

  Future<void> createFavorite(Favorite favorite) async => _service.setData(
    path: CloudPath.setfavorite(uid, favorite.workout),
    data: favorite.toMap(),
  );

  Future<void> deleteFavorite(String workoutName) async => _service.deleteData(
    path: CloudPath.getfavorite(uid),
    docName: workoutName
  );

  Future<void> updateRoutine(List workoutNames, List thumbnails, String routineName) async => _service.transactionData(
    path: CloudPath.setroutine(uid, routineName),
    data: workoutNames,
    thumb: thumbnails
  );

  Future<void> updateRoutineWorkoutList(List workoutNames, String routineName) async => _service.transactionWorkoutData(
      path: CloudPath.setroutine(uid, routineName),
      data: workoutNames,
  );

  Future<void> createRoutine(Routine routine) async => _service.setData(
    path: CloudPath.setroutine(uid, routine.routineName),
    data: routine.toMap(),
  );

  Future<dynamic> getRoutine(String routineName) async => _service.getData(
    path: CloudPath.setroutine(uid, routineName),
    //builder: (data) => Routine.fromMap(data),
      );

  Stream<List<Favorite>> favoriteStream() => _service.collectionStream(
    path: CloudPath.getfavorite(uid),
    builder:  (data) => Favorite.fromMap(data),
  );

  Stream<List<Workout>> workoutStream() => _service.collectionStream(
    path: CloudPath.getworkouts(),
    builder:  (data) => Workout.fromMap(data),
  );

  Stream<List<Routine>> routineStream() => _service.collectionStream(
    path: CloudPath.getroutine(uid),
    builder:  (data) => Routine.fromMap(data),
  );

  Stream<Routine> routineInputStream(String id) => _service.documentStream(
    path: CloudPath.getroutineinput(uid, id),
    builder:  (data) => Routine.fromMap(data),
    docPath: id,
  );

  Stream<List<Workout>> legWorkoutStream() => _service.collectionStream(
    path: CloudPath.getlegworkouts(),
    builder:  (data) => Workout.fromMap(data),
  );

  Stream<List<Workout>> chestWorkoutStream() => _service.collectionStream(
    path: CloudPath.getchestworkouts(),
    builder:  (data) => Workout.fromMap(data),
  );

  Stream<List<Workout>> allWorkoutStream() => _service.collectionStream(
    path: CloudPath.getallworkouts(),
    builder:  (data) => Workout.fromMap(data),
  );

  Stream<List<Categories>> categoriesStream() => _service.collectionStream(
    path: CloudPath.getcatergories(),
    builder:  (data) => Categories.fromMap(data),
  );


}
