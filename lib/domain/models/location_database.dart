import 'package:firebase_database/firebase_database.dart';

class Location {
  String key;
  String user;
  double latitud, longitud;

  Location(this.key, this.user, this.latitud, this.longitud);

  Location.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key.toString(),
        user = snapshot.value["user"],
        latitud = snapshot.value["latitud"],
        longitud = snapshot.value["longitud"];

  toJson() {
    return {
      "key": key,
      "user": user,
      "latitud": latitud,
      "longitud": longitud,
    };
  }
}
