

import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
class Markers extends StatefulWidget {
  const Markers({Key? key}) : super(key: key);

  @override
  State<Markers> createState() => _MarkersState();
}



class _MarkersState extends State<Markers> {
late MapController mapController; 
/// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();


List<Marker> markers = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();
    markers.add(Marker(
            width: 50,
            height: 50,
            point: LatLng(41.604520,-8.428207), builder: (context)=> Icon(Icons.person)
            ));
  }

  @override
  Widget build(BuildContext context) {
    //IT NEEDS TO BE SCAFFOLD TO EXPLORE THE THINGS
    return Scaffold(
      //FLUTTER MAP
      body: Column(
        children: [Expanded(
          child: FlutterMap(
            mapController: mapController,
            //THE OPTIONS
          options: MapOptions(
            center: LatLng(41.607863,-8.430310),
              zoom: 18,
              onTap: (_, __) => _popupLayerController
              .hideAllPopups(), // Hide popup when the map is tapped.
          ),
          
          
          children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  
                  
                  PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
              popupController: _popupLayerController,
              markers: markers,
              markerRotateAlignment:
                  PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
              popupBuilder: (BuildContext context, Marker marker) =>
                  Container(width: 50,height: 50,child: Text('Hello World'),color: Colors.white,)
            ),
                  ),

                ],
          
        
          
              
          //
         
            ),
        ),
        
        TextButton(onPressed: ()async{
        
      

        }, child: Text('Hello world'))
        
          ]
      ),
    );
    
  }
}