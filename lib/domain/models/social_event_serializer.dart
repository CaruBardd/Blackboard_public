// Clase SocialEvent:
//  - Serialización Manual en clase modelo del Json
//  - Convertir respuesta a objeto personalizado de Dart
import 'dart:convert';

class SocialEvent {
  // Atributos
  final title;
  final url;
  final datetime_local;
  final stats;
  final performers;
  final venue;
  final short_title;
  final datetime_utc;
  final score;
  final taxonomies;
  final type;
  final id;
  final imageUrl;
  // Constructor
  SocialEvent(
      {this.title,
      this.url,
      this.datetime_local,
      this.stats,
      required this.performers,
      required this.venue,
      this.short_title,
      this.datetime_utc,
      this.score,
      this.taxonomies,
      this.type,
      this.id,
      this.imageUrl});
  // Constructor Factory // from Json
  factory SocialEvent.fromJson(Map<String, dynamic> json) {
    return SocialEvent(
      title: json['title'],
      url: json['url'],
      datetime_local: json['datetime_local'],
      stats: json['stats'],
      performers: Performers.fromJson(json['performers'][0]),
      venue: Venue.fromJson(json['venue']),
      short_title: json['short_title'],
      datetime_utc: json['datetime_utc'],
      score: json['score'],
      taxonomies: json['taxonomies'],
      type: json['type'],
      id: json['id'],
    );
  }
}

class Performers {
  final image;
  final type;
  Performers({this.image, this.type});

  factory Performers.fromJson(Map<String, dynamic> json) {
    return Performers(
      image: json['image'],
      type: json['type'],
    );
  }
}

class Venue {
  final name;
  final address;
  final display_location;
  Venue({this.name, this.address, this.display_location});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      name: json['name'],
      address: json['address'],
      display_location: json['display_location'],
    );
  }
}
