// To parse this JSON data, do
//
//     final clshousingdetails = clshousingdetailsFromJson(jsonString);

import 'dart:convert';

Clshousingdetails clshousingdetailsFromJson(String str) =>
    Clshousingdetails.fromJson(json.decode(str));

String clshousingdetailsToJson(Clshousingdetails data) =>
    json.encode(data.toJson());

class Clshousingdetails {
  String name;
  List<dynamic> access;
  String address;
  String description;
  String distance;
  int latitude;
  int longitude;
  String mapUrl;
  String image;
  List<dynamic> photos;

  Clshousingdetails({
    required this.name,
    required this.access,
    required this.address,
    required this.description,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.mapUrl,
    required this.image,
    required this.photos,
  });

  factory Clshousingdetails.fromJson(Map<String, dynamic> json) =>
      Clshousingdetails(
        name: json["name"],
        access: List<dynamic>.from(json["access"].map((x) => x)),
        address: json["address"],
        description: json["description"],
        distance: json["distance"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        mapUrl: json["mapUrl"],
        image: json["image"],
        photos: List<dynamic>.from(json["Photos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "access": List<dynamic>.from(access.map((x) => x)),
        "address": address,
        "description": description,
        "distance": distance,
        "latitude": latitude,
        "longitude": longitude,
        "mapUrl": mapUrl,
        "image": image,
        "Photos": List<dynamic>.from(photos.map((x) => x)),
      };
}
