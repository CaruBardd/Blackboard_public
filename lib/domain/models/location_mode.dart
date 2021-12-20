import 'package:firebase_database/firebase_database.dart';

class Location {
  var key;
  String user;
  double latitud, longitud;

  Location(this.key, this.user, this.latitud, this.longitud);

  Location.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key ?? "0",
        user = snapshot.value['user'],
        latitud = snapshot.value['latitud'],
        longitud = snapshot.value['longitud'];

  toJson() {
    return {
      "user": user,
      "latitud": latitud,
      "longitud": longitud,
    };
  }
}
