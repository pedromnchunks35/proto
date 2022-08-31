import 'package:flutter/material.dart';
import 'package:proto/components/check.dart';
import 'package:proto/components/dragexample.dart';
import 'package:proto/components/driving.dart';
import 'package:proto/components/nav.dart';

import 'components/navmine.dart';
//PROTOTYPES ROUTES
void main() => runApp(MaterialApp(
  initialRoute: '/map',
  routes: {
    '/home': (context)=>Mine(),
    '/drive': (context)=> Drive(),
    '/drag': (context)=>Drag(),
    '/map': (context)=>Markers()
  },
));