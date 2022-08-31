import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
class Markers extends StatefulWidget {
  const Markers({Key? key}) : super(key: key);

  @override
  State<Markers> createState() => _MarkersState();
}

class _MarkersState extends State<Markers> {
 
  @override
  Widget build(BuildContext context) {
    //IT NEEDS TO BE SCAFFOLD TO EXPLORE THE THINGS
    return Scaffold(
      //FLUTTER MAP
      body: Column(
        children: [Expanded(
          child: FlutterMap(
            //THE OPTIONS
          options: MapOptions(
            center: LatLng(41.607863,-8.430310),
              zoom: 18,
              // FOR PERFORMANCE ISSUES
              plugins: [
                MarkerClusterPlugin(),
              ]
          ),
          
          //LAYERS
          layers: [
              //THE MAP
              TileLayerOptions(
                //TEMPLATE FROM OPENSTREETMAPS
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.app',
              ),
              
              MarkerClusterLayerOptions(
              maxClusterRadius: 120,
              size: Size(40, 40),
              fitBoundsOptions: FitBoundsOptions(
                padding: EdgeInsets.all(50),
              ),
              markers: [
               Marker(
                      point: LatLng(41.608700, -8.427670),
                      width: 100,
                      height: 100,
                      builder: (context) => IconButton(onPressed: (){print('André é gay');}, icon: Icon(Icons.person)),
                      )
              ],
              polygonOptions: PolygonOptions(
                  borderColor: Colors.blueAccent,
                  color: Colors.black12,
                  borderStrokeWidth: 3),
              builder: (context, markers) {
                return FloatingActionButton(
                  child: Text(markers.length.toString()),
                  onPressed: null,
                );
              }),
              
          ],
              
          //
          nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: null,
              ),
          ],
            ),
        ),
        
        TextButton(onPressed: (){}, child: Text('Hello world'))
        
          ]
      ),
    );
    
  }
}