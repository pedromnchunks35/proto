//THE MARKER
class Marker{
Coords coords;
String name;
String description;
String url;
Marker({required this.coords,required this.name,required this.description,required this.url});
}

//CLASS COORDS
class Coords{
double long;
double lat;
Coords({required this.long,required this.lat});
}