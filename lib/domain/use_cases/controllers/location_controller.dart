import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:red_blackboard/domain/models/location_mode.dart';

class LocationController extends GetxController {
  final databaseReference = FirebaseDatabase.instance.reference();
  var locations = <Location>[].obs;
  late StreamSubscription<Event> newEntryStream;
  late StreamSubscription<Event> updateEntryStream;

  start() {
    newEntryStream = databaseReference
        .child('flutterlocations')
        .onChildAdded
        .listen(_onEntryAdded);
    updateEntryStream = databaseReference
        .child('flutterlocations')
        .onChildChanged
        .listen(_onEntryChanged);
  }

  stop() {
    newEntryStream.cancel();
    updateEntryStream.cancel();
  }

  _onEntryChanged(Event event) {
    print("Algo ha cambiado");
    var oldEntry = locations.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    locations[locations.indexOf(oldEntry)] =
        Location.fromSnapshot(event.snapshot);
  }

  _onEntryAdded(Event event) {
    print("Algo ha sido añadido");
    locations.add(Location.fromSnapshot(event.snapshot));
  }

  Future<void> shareLocation(double latitud, double longitud) async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    try {
      databaseReference
          .child('flutterlocations')
          .push()
          .set({'user': user, 'longitud': longitud, 'latitud': latitud});
    } catch (error) {
      logError("Error compartiendo Location $error");
      return Future.error(error);
    }
  }

  Future<void> updateLocation(Location location) async {
    logInfo("Actualizando location con llave ${location.key}");
    try {
      databaseReference.child('flutterlocations').child(location.key).set({
        'latitud': location.latitud,
        'longitud': location.longitud,
        'user': location.user
      });
    } catch (error) {
      logError("Error actualizando location $error");
      return Future.error(error);
    }
  }

  Future<void> deleteLocation(Location location, int index) async {
    logInfo('Borrando location con llave ${location.key}');
    try {
      databaseReference
          .child('flutterlocations')
          .child(location.key)
          .remove()
          .then((value) => locations.removeAt(index));
    } catch (error) {
      logError("Error borrando location $error");
      return Future.error(error);
    }
  }
}
