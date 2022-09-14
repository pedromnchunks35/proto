//MAKE THE COUNTER
import 'dart:async';
import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';
Timer? timer;

void counter(){
  
  //THIS IS THE TIMER
  Timer.periodic(Duration(seconds: 2),(Timer t) async{
   
   bool result = await InternetConnectionChecker().hasConnection;
  if(result == true) {
  print('YAY! Free cute dog pics!');
} else {
  print('No internet :( Reason');
}

  });
}