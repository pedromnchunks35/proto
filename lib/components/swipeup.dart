import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SwipeUp extends StatefulWidget {
  const SwipeUp({Key? key}) : super(key: key);

  @override
  State<SwipeUp> createState() => _SwipeUpState();
}

class _SwipeUpState extends State<SwipeUp> {
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {print('Hello World');},
        child: ListView(
          children: [
            Text('EI'),
            Text('Ei'),
            Text('Ei'),
            Text('Ei'),
            Text('Ei'),
            Text('Ei'),
            Text('Ei'),
            Text('Ei'),
            Text('Ei'),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
            Text('Ei',style: TextStyle(fontSize: 50),),
          ],
        ),
      ),
    );
  }
}