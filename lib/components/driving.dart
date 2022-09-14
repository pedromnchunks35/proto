import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:geolocator/geolocator.dart';

class Drive extends StatefulWidget {
  const Drive({Key? key}) : super(key: key);

  @override
  State<Drive> createState() => _DriveState();
}

class _DriveState extends State<Drive> {
  String _platformVersion = 'Unknown';
  String _instruction = "";
  //DECATHLON
  final _deca = WayPoint(
    name: 'Decathlon', 
    latitude: 41.569036, 
    longitude: -8.428428);

    //DECATHLON
  final _outro = WayPoint(
    name: 'Outro', 
    latitude: 41.617744, 
    longitude: -8.396747);

  Color color = Colors.blue;
  
  var _directions;
  var _options;

  bool _isMultipleStop = false;
  var _distanceRemaining, _durationRemaining;
  var _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


 // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }



Future<void> _onEmbeddedRouteEvent(e) async {
  try {
    _distanceRemaining = await _directions.distanceRemaining;
    _durationRemaining = await _directions.durationRemaining;
  } catch (e) {
    print('Error');
  }
    

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction!;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    initialize();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Column(
        children: [SafeArea(
          child: TextButton(onPressed: ()async{
          //AN ARRAY OF WAYPOINTS
          _isMultipleStop = true;
          var waypoints = <WayPoint>[];   
          var pos= await _determinePosition();
          waypoints.add(WayPoint(name: 'Home', latitude: pos.latitude, longitude: pos.longitude));
          waypoints.add(_deca);
          waypoints.add(_outro);
          await _directions.startNavigation(
                                  wayPoints: waypoints,
                                  options: MapBoxOptions(
                                      mode: MapBoxNavigationMode.driving,
                                      simulateRoute: true,
                                      language: "en",
                                      allowsUTurnAtWayPoints: true,
                                      units: VoiceUnits.metric));
        
                }, child: Text('Click me',style: TextStyle(color: Colors.white),)),
        ),
        TextButton(onPressed: ()async{
          //AN ARRAY OF WAYPOINTS
          _isMultipleStop = true;
          var waypoints = <WayPoint>[];   
          var pos= await _determinePosition();
          waypoints.add(WayPoint(name: 'Home', latitude: pos.latitude, longitude: pos.longitude));
          print(pos);
          waypoints.add(WayPoint(name: 'Amrica', latitude: 37.103826, longitude:  -122.140787));
          
        
            await _directions.startNavigation(
                                  wayPoints: waypoints,
                                  options: MapBoxOptions(
                                      mode: MapBoxNavigationMode.driving,
                                      simulateRoute: true,
                                      language: "en",
                                      allowsUTurnAtWayPoints: true,
                                      units: VoiceUnits.metric));
           if(_durationRemaining==0){
            setState(() {
              
            });
           }
          
          
        
                }, child: Text('Click me',style: TextStyle(color: Colors.white),)),
        
        ],

        


      )
      );
  }
}