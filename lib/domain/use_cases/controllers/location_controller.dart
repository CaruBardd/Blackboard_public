import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:red_blackboard/domain/models/location_database.dart';

class LocationController extends GetxController {
  final databaseReference = FirebaseDatabase.instance.ref();
  var locations = <Location>[].obs;
  late StreamSubscription<DatabaseEvent> newEntryStreamSubs;
  late StreamSubscription<DatabaseEvent> updateEntryStreamSubs;

  start() {
    locations.clear();
    newEntryStreamSubs = databaseReference
        .child('flutterlocations')
        .onChildAdded
        .listen(_onEntryAdded);
    updateEntryStreamSubs = databaseReference
        .child("flutterlocations")
        .onChildChanged
        .listen(_onEntryChanged);
  }

  stop() {
    newEntryStreamSubs.cancel();
    updateEntryStreamSubs.cancel();
  }

  _onEntryChanged(DatabaseEvent event) {
    print('Algo ha cambiado');
    var oldEntry = locations.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    locations[locations.indexOf(oldEntry)] =
        Location.fromSnapshot(event.snapshot);
  }

  _onEntryAdded(DatabaseEvent event) {
    print("Something was added");
    locations.add(Location.fromSnapshot(event.snapshot));
  }

  Future<void> shareLocation(double latitud, double longitud) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      databaseReference
          .child("flutterlocations")
          .push()
          .set({"user": uid, "latitud": latitud, "longitud": longitud});
    } catch (e) {
      logError('Error compartiendo la localizacion $e');
      return Future.error(e);
    }
  }

  Future<void> updateLocation(Location location) async {
    logInfo('Actualizando localizacion de llave ${location.key}');
    try {
      databaseReference
          .child("flutterlocations")
          .child(location.key)
          .set({"latitud": location.latitud, "longitud": location.longitud});
    } catch (e) {
      logError('Error actualizando la localizacion $e');
      return Future.error(e);
    }
  }

  Future<void> deleteLocation(Location location, int index) async {
    logInfo('Borrando localizacion de llave ${location.key}');
    try {
      databaseReference
          .child("flutterlocations")
          .child(location.key)
          .remove()
          .then((value) => locations.removeAt(index));
    } catch (e) {
      logError('Error borrando la localizacion $e');
      return Future.error(e);
    }
  }
}
