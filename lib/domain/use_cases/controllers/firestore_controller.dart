import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:red_blackboard/domain/models/record.dart';

class FirebaseController extends GetxController {
  var _locations = <LocationModel>[].obs;
  final CollectionReference locations =
      FirebaseFirestore.instance.collection('locations');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('locations').snapshots();
  late StreamSubscription<Object?> streamSubscription;

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
    locations
        .add({'user': user, 'latitud': latitud, 'longitud': longitud})
        .then((value) => print("locations added"))
        .catchError((onError) => print("Failed to add locations $onError"));
  }

  updateEntry(LocationModel location, latitud, longitud, user) {
    location.reference
        .update({'user': user, 'latitud': latitud, 'longitud': longitud});
  }

  deleteEntry(LocationModel location) {
    location.reference.delete();
  }
}
