//THE MARKER
import 'package:flutter/material.dart';

class Markercoords{
Key id;
CoordsM coords;
String name;
String description;
String url;
Markercoords({required this.id,required this.coords,required this.name,required this.description,required this.url});
}

//CLASS COORDS
class CoordsM{
double long;
double lat;
CoordsM({required this.long,required this.lat});
}