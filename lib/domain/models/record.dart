import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final String user;
  final double longitud, latitud;
  final DocumentReference reference;

  LocationModel.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['user'] != null),
        assert(map['longitud'] != null),
        assert(map['latitud'] != null),
        user = map['user'],
        longitud = map['longitud'],
        latitud = map['latitud'];

  LocationModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "LocationModel<$user:$longitud:$latitud>";
}
