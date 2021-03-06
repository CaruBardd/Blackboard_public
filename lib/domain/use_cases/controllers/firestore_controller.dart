import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:blackboard_public/domain/models/record.dart';

class FirebaseController extends GetxController {
  var _locations = <LocationModel>[].obs;
  var isUserEntry = false.obs;
  final CollectionReference locations =
      FirebaseFirestore.instance.collection('locations');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('locations').snapshots();
  late StreamSubscription<Object?> streamSubscription;
  var _addedEntries = <String>[];

  suscribeUpdates() async {
    logInfo('suscribeLocationUpdates');
    streamSubscription = _usersStream.listen((event) {
      logInfo('Got new item from fireStore');
      _locations.clear();
      event.docs.forEach((element) {
        _locations.add(LocationModel.fromSnapshot(element));
      });
      print('Got ${_locations.length}');
    });
  }

  unsuscribeUpdates() {
    streamSubscription.cancel();
  }

  List<LocationModel> get entries => _locations;

  addEntry(latitud, longitud) {
    String user = FirebaseAuth.instance.currentUser!.uid;
    if (_addedEntries.length != 0) {
      for (int i = 0; i < _addedEntries.length; i++) {
        if (_addedEntries[i] == user) {
          isUserEntry.value = true;
          break;
        }
      }
    }
    if (!isUserEntry.value) {
      _addedEntries.add(user);
      locations
          .add({'user': user, 'latitud': latitud, 'longitud': longitud})
          .then((value) => print("locations added"))
          .catchError((onError) => print("Failed to add locations $onError"));
    } else {
      updateEntry(latitud, longitud);
    }
  }

  updateEntry(latitud, longitud) {
    String user = FirebaseAuth.instance.currentUser!.uid;
    if (_locations.length != 0) {
      LocationModel location = _locations[0];
      for (int i = 0; i < _locations.length; i++) {
        if (_locations[i].user == user) {
          location = _locations[i];
          location.reference
              .update({'user': user, 'latitud': latitud, 'longitud': longitud});
          break;
        }
      }
    }
  }

  deleteEntry() {
    String user = FirebaseAuth.instance.currentUser!.uid;
    LocationModel location = _locations[0];
    bool doesExist = false;
    for (int i = 0; i < _locations.length; i++) {
      if (_locations[i].user == user) {
        location = _locations[i];
        doesExist = true;
        break;
      }
    }
    if (doesExist) {
      location.reference.delete;
      isUserEntry.value = false;
    }
  }
}
