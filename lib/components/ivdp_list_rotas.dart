// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proto/db/dbInit.dart';
import 'package:proto/storageOps/head.dart';
import 'package:proto/storageOps/insert/routes/get.dart';
import 'package:proto/storageOps/insert/routes/insert_routes.dart';

class Rotas_list extends StatefulWidget {
  const Rotas_list({super.key});

  @override
  State<Rotas_list> createState() => _Rotas_listState();
}

class _Rotas_listState extends State<Rotas_list> {
   //THE SELECTED BUTTON
   var selected = 0;
   var _future;
    

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    head("eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjMxNDg2NTAsImp0aSI6IjQyOSIsImlzcyI6IkFOTyBzb2Z0d2FyZSIsImV4cCI6MTY2MzIzNTA1MH0.a5Wl5c29itwHJVAiLo4YaFsUQvwZ2KXkGqIGgqfjAM4");
    _future = getRoutes();
  
  }


  @override
  Widget build(BuildContext context) {
    //THE HEIGHT AND WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return Scaffold(
    appBar: AppBar(
    title: Text("AS MINHAS ROTAS"),
    ),
    //AN COLUMN
    body: Column(

    //START OF THE WIDGET ITSELF
    children: [
     //UP PART FOR THE BUTTON AND THE SELECT MENU
    Container(
    //WHITE COLOR
    color: Colors.white,
    //WIDTH AND HEIGHT
    width: width,
    height: height*0.17,
    //THE CHILD
    child: Column(
      children: [

      /*************************************************************/
      /*************************************************************/
      //AN BUTTON
      Padding(
        padding: EdgeInsets.only(top: height*0.01),
        child: TextButton(
        //SOME STYLE
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 184, 72, 64))
        ),
        //ON PRESSED
        onPressed: ()async{
        //INSERT AN ROUTE
        await insert_route();
        //UPDATE
        setState(() {});
        },

        //TEXT 
        //THE PADDING
        child: Padding(
          padding: EdgeInsets.only(left: width*0.18,right: width*0.18),
          child: Text(
          'CRIAR NOVA ROTA',
          style: TextStyle(
            color: Colors.white,
            fontSize: (width*height)*0.00006
          ),
          ),
        )
        ),
      ),
      /*************************************************************/
      /*************************************************************/ 



      /*************************************************************/
      /*************************************************************/
      //AN ROW FOR THE SELECTOR
      Padding(
        padding: EdgeInsets.only(top: height*0.03),
        child: Row(
          //MAKE THE SPACE BEETWEEN THE TWO BUTTONS
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [


          /*************************************************************/
          /*************************************************************/  
          //BUTTON ROTA (CONTAINER + GESTURE DETECTOR)
           GestureDetector(
            //ON TAP PROPERTY
             onTap: (){
              //SET STATE
              setState(() {
                selected = 0;
              });
             },
             //THE CONTAINER
             child: Container(
              width: width*0.4,
              //TEXT BUTTON
              // ignore: sort_child_properties_last
              child: Padding(
                padding: EdgeInsets.only(bottom: height*0.01),
                child: Text("ROTAS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: height*width*0.00007,
                  color: selected==0?Color.fromARGB(255, 206, 92, 84):Colors.grey
                ),),
              ),
              //SOME DECORATION
              decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                color: selected == 0? Color.fromARGB(255, 206, 92, 84) : Colors.transparent
                )
              )
              ),
                   ),
           ),
          /*************************************************************/
          /*************************************************************/



          /*************************************************************/
          /*************************************************************/
          //BUTTON AGENDA (CONTAINER + GESTURE DETECTOR)
           GestureDetector(
            //ON TAP ACTION
            onTap: (){
              //SET STATE
              setState(() {
                selected = 1;
              });
            },
            //THE CONTAINER
             child: Container(
              width: width*0.4,
              //TEXT BUTTON
              child: Padding(
                padding: EdgeInsets.only(bottom: height*0.01),
                child: Text("AGENDA",
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: height*width*0.00007,
                color: selected == 1 ? Color.fromARGB(255, 206, 92, 84) : Colors.grey
                )
                ),
              ),
              //SOME DECORATION
              decoration: BoxDecoration(
                //THE BORDER
              border: Border(
                bottom: BorderSide(
                color: selected == 1 ? Color.fromARGB(255, 206, 92, 84) : Colors.transparent
                )
              )
              ),
                   ),
           )
          /*************************************************************/
          /*************************************************************/




          ],
        ),
      )
      /*************************************************************/
      /*************************************************************/


      ],
    ),
    ),



//LIST VIEW PART
FutureBuilder(
  future: getRoutes(),
  builder: 
  //THE BUILDER
  ((context, snapshot){
 //CASE IS WAITING
 if(snapshot.connectionState==ConnectionState.waiting){
 return CircularProgressIndicator();
 }else
 if(snapshot.connectionState==ConnectionState.done){
  return Expanded(
    child: ListView(
    
      shrinkWrap: true,
    
      //THE CHILDREN
    
      children: 
      (snapshot.data as List<Map<String,dynamic>>)
      .map((data){
      //RETURN OUR DATA
      return

      
    
       //THE GESTURE DETECTOR
    
       GestureDetector(
    
        //ON TAP
    
         onTap: ()async{
        //PUSH NAMED
         await Navigator.pushNamed(context,'/rotas',arguments: {'route': data}); 
         //SET THE STATE
         setState(() {});
         },
    
         //AN CONTAINER WITH AN CERTAIN SIZE
    
         child: Container(
    
          //WIDTH
    
          width: width,
    
          //HEIGHT
    
          height: height*0.10,
    
          //THE COLOR OF THE VIEW
    
          color: data['state']=='0'?Color.fromARGB(255, 224, 130, 161):Colors.grey,
    
          //THE CONTENT WILL BE AN STACK
    
          child: Stack(
    
            children: [
    
              //THE TITLE
    
              Positioned(
    
              //RELATIVE TOP POS
    
              top: height*0.02,
    
              //RELATIVE LEFT POS
    
              left: width*0.02,
    
              //THE TEXT
    
              child: Text(data['name'],
    
              //SOME TEXT STYLE
    
              style: TextStyle(
    
              color: Colors.white,
    
              fontSize: (width*height)*0.00008
    
              ),)
    
              ),
    
       
    
              //THE SUBTITLE
    
              Positioned(
    
              //RELATIVE TOP POS
    
              top: height*0.055,
    
              //RELATIVE LEFT POS
    
              left: width*0.023,
    
              //THE TEXT
    
              child: Text(
    
              data['state']=='0'?'Rascunho':'${DateTime.parse(data['start_date']).day}-${DateTime.parse(data['start_date']).month}-${DateTime.parse(data['start_date']).year} - ${DateTime.parse(data['end_date']).day}-${DateTime.parse(data['end_date']).month}-${DateTime.parse(data['end_date']).year}',
    
              //THE TEXT STYLE
    
              style: TextStyle(
    
                color: Colors.white,
    
                fontSize: (width*height)*0.00005
    
              ),
    
              )),
    
            
    
                //THE KM TEXT
    
                Positioned(
    
                  //RELATIVE TOP POS
    
                top: height*0.055,
    
                //RELATIVE RIGHT POS
    
                right: width*0.10,
    
                //THE TEXT  
    
                child: Text("10Km",
    
                style:
    
                //THE TEXT STYLE 
    
                TextStyle(
    
                  color: Colors.white,
    
                  fontSize: (height*width)*0.00005
    
                ),)),
    
       
    
       
    
                //STACKED ICON
    
                Positioned(
    
                  //RELATIVE TOP POS
    
                  top: height*0.045,
    
                  //RELATIVE RIGHT POS
    
                  right: width*0.02,
    
                  //THE STACK
    
                  child: Stack(
    
                    children: [
    
                    //THE TEXT RELATED TO THE NUMBER OF POI`S
    
                    Positioned(
                      bottom: height*0.014,
                      child: Text("1",
                      
                      //SOME TEXT STYLE
                      
                      style: TextStyle(
                      
                        color: Colors.white
                      
                      ),),
                    ),
    
                    //THE IMAGE
    
                    SvgPicture.asset(
    
                    "assets/rota-cheio.svg",
    
                    width: width*0.03,
    
                    height: height*0.03,
    
                    ) 
    
                    ],
    
                  ),
    
                )
    
            ],
    
          ),
    
         ),
    
       );
    
    
    
      
      

      }).toList()
        
    
    ),
  );
  }else if(snapshot.hasError){
  //RETURN THIS INSTEAD CASE NO STATE YET
  return CircularProgressIndicator();
  }else{
    return CircularProgressIndicator();
  }
 
  })
  
)













    ],  
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favoritos"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favoritos"
          ),
      ],
    ),
    );
  }
}