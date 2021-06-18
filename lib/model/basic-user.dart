import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BasicUser {
  final String id;
  final String email;
  final BasicClient client;
  BasicUser({
    this.id,
    this.email,
    this.client,
  });

  BasicUser copyWith({
    String id,
    String email,
    BasicClient client,
  }) {
    return BasicUser(
      id: id ?? this.id,
      email: email ?? this.email,
      client: client ?? this.client,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'client': client.toMap(),
    };
  }

  factory BasicUser.fromStorage(Map<String, dynamic> map) {
    return BasicUser(
      id: map['id'],
      email: map['email'],
      client: BasicClient.fromStorage(map['client']),
    );
  }
  factory BasicUser.fromMap(Map<String, dynamic> map) {
    return BasicUser(
      id: map['_id'],
      email: map['email'],
      client: BasicClient.fromMap(map['client']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BasicUser.fromJson(String source) =>
      BasicUser.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BasicUser &&
        other.id == id &&
        other.email == email &&
        other.client == client;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ client.hashCode;
}

class BasicClient {
  final String id;
  final String place;
  final String username;
  final LatLng coordinates;
  BasicClient({
    this.id,
    this.place,
    this.username,
    this.coordinates,
  });

  BasicClient copyWith({
    String id,
    String place,
    String username,
    LatLng coordinates,
  }) {
    return BasicClient(
      id: id ?? this.id,
      place: place ?? this.place,
      username: username ?? this.username,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'username': username,
      'coordinates': [coordinates.latitude, coordinates.longitude],
    };
  }

  factory BasicClient.fromMap(Map<String, dynamic> map) {
    var _lat = (map['location']['coordinates'] as List);
    return BasicClient(
      id: map['_id'],
      place: map['place'],
      username: map['username'],
      coordinates: LatLng(_lat.first, _lat.last),
    );
  }

  factory BasicClient.fromStorage(Map<String, dynamic> map) {
    var _lat = map['coordinates'] as List;

    return BasicClient(
      id: map['id'],
      place: map['place'],
      username: map['username'],
      coordinates: LatLng(_lat.first, _lat.last),
    );
  }

  String toJson() => json.encode(toMap());

  factory BasicClient.fromJson(String source) =>
      BasicClient.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BasicClient &&
        other.id == id &&
        other.place == place &&
        other.username == username;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        place.hashCode ^
        username.hashCode ^
        coordinates.hashCode;
  }
}
