
import 'package:flutter/material.dart';
import 'package:proto/components/check.dart';
import 'package:proto/components/driving.dart';
import 'package:proto/components/ivdp_list_rotas.dart';
import 'package:proto/components/ivdp_locais.dart';
import 'package:proto/components/ivdp_rotas.dart';
import 'package:proto/components/reorderor.dart';
import 'package:proto/components/swipeup.dart';
import 'components/navmine.dart';
//PROTOTYPES ROUTES
void main() => runApp(MaterialApp(
  initialRoute: '/ivdpinterest',
  routes: {
    '/rotas_list': (context) => Rotas_list(),
    '/home': (context)=>Mine(),
    '/drive': (context)=> Drive(),
    '/map': (context)=>Markers(),
    '/ivdpinterest': (context)=>LocaisMap(),
    '/order': (context)=>OriginalReorder(),
    '/rotas': (context)=>Rotas(route: (ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>)['route']),
    '/swipe':(context)=> SwipeUp()
  },
));