import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:video_app/Models/models.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Future<void> updateData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update(data);

  }

  Future<void> deleteData({String path, String docName}) async {
    final reference = FirebaseFirestore.instance.collection(path);
    await reference.doc(docName).delete();
  }

  Future<T> getDataMap<T>({@required String path,@required builder(data)}) async {
    //Routine newRoutine;
    //var dataMap = new Map();
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = await reference.get();
    //newRoutine = Routine.fromMap(snapshots.data()); // Daten in das Model geben
    //print(newRoutine);
    //dataMap = {'workoutNames': newRoutine.workoutNames, 'videoPaths': newRoutine.videoPaths};
    return builder(snapshots.data());

  }

  Future<List<T>> getData<T>({@required String path,}) async {
    Routine newRoutine;
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = await reference.get();
     newRoutine = Routine.fromMap(snapshots.data());
     print(newRoutine);
     return newRoutine.workoutNames;

  }

  Future<void> transactionData({String path, List<dynamic> data, List<dynamic> thumb}) async {
    Routine newRoutine;
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.get();
    snapshots.then((docSnapshot) => {
      newRoutine = Routine.fromMap(docSnapshot.data()),
      data.forEach((element) {
        newRoutine.workoutNames.add(element);
      }),
      thumb.forEach((element) {
        newRoutine.thumbnails.add(element);
      }),
      reference.set(newRoutine.toMap())
    });

  }

  Future<void> transactionWorkoutData({String path, List<dynamic> data}) async {
    Routine newRoutine;
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.get();
    snapshots.then((docSnapshot) => {
      newRoutine = Routine.fromMap(docSnapshot.data()),
      newRoutine.workoutNames.replaceRange(0, newRoutine.workoutNames.length, data),
      reference.set(newRoutine.toMap())
    });

  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data),
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map(
          (snapshot) =>builder(snapshot.data()),
    ).toList());
  }

  Stream<T> documentStream<T>({
    @required String path,
    @required String docPath,
    @required T builder(Map<String, dynamic> data),
  }) {
    final reference = FirebaseFirestore.instance.collection(path).doc(docPath);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data()));
  }


}