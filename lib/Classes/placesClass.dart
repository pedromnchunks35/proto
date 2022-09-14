import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class PlacesInterest {
  PlacesInterest({
    this.coverImageUrl = '',
    this.locality = '',
    this.designation = '',
    this.altDate = '',
    this.logoImageUrl = '',
    this.latitude ='', this.id = '', this.likes = '', this.longitude = '',



  });

  String coverImageUrl;
  String latitude;
  String locality;
  String id;
  String designation, altDate, logoImageUrl;
  String likes;
  String longitude;


  factory PlacesInterest.fromJson(Map<String, dynamic> json) => PlacesInterest(
    coverImageUrl: json['coverImageUrl'],
    latitude: json['latitude'].toString(),
    locality: json['locality'],
    id: json['id'].toString(),
    designation: json['designation'],
    altDate: json['altDate'],
    logoImageUrl: json['logoImageUrl'],
    likes: json['likes'].toString(),
    longitude: json['longitude'].toString(),



  );



  Map<String, dynamic> toJson() => {
    'coverImageUrl': coverImageUrl,
    'latitude': latitude,
    'locality': locality,
    'id': id,
    'designation': designation,
    'altDate': altDate,
    'logoImageUrl': logoImageUrl,
    'likes': likes,
    'longitude': longitude,

  };
}
