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

  Stream<List<Favorite>> favoriteStream() => _service.collectionStream(
    path: CloudPath.getfavorite(uid),
    builder:  (data) => Favorite.fromMap(data),
  );


}
