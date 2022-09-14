// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, unnecessary_this

import 'dart:ui';

import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:proto/components/reorderor.dart';
import 'package:proto/model/markers.dart';
import 'package:proto/storageOps/insert/leafs/insert_leafs.dart';
import 'package:proto/storageOps/insert/routes/get.dart';
import 'package:proto/storageOps/updates/routes/update_route.dart';

import '../data/marker_list.dart';

class Rotas extends StatefulWidget {
  //ID ROUTE
  var route;

  Rotas({Key? key,required this.route}) : super(key: key);

  @override
  State<Rotas> createState() => _RotasState();
}

//CLASSES THAT WE NEED TO EXPORT TO AN DIFFERENT FOLDER (MAYBE)
class PopWidget{
  Key id_list;
  Widget block;
  bool isAlive;
  PopWidget({required this.id_list,required this.block,required this.isAlive});
}





class _RotasState extends State<Rotas> {
  //THE LIST OF WIDGETS FOR THE BUILDER
  List<List<Widget>>listWB=[];
  //THE LIST OF WIDGETS
  List<PopWidget>listW=[];
  //THE LIST OF THE MARKERS
  List<Marker> markers = [];
  //AN FOCUS NODE
  FocusNode focus = FocusNode();
  //LIST ALL MARKERS
  List<Map<String,dynamic>> allMarkers = [];

  //FUNCTION TO RETRIEVE AN OBJ ACCORDING TO THE KEY
  Map<String,dynamic> getObjByKey(Key key){
  //NULL VALUE
  Map<String,dynamic> result= {};
  for (var i = 0; i < allMarkers.length; i++) {
    //SEARCH FOR THE KEY
    if(ValueKey(allMarkers[i]['id'])==key){
    //ASSIGN THE VALUE
    result = allMarkers[i];
    }
  }
  //RETURN AN CERTAIN RESULT
  return result;
  }


  //GET THE DATA
  void getData() async {
  //UPDATE THE STATE
  await updateState(this.widget.route['id']);
  //THE AWAIT STATEMENT
  allMarkers = await getLeafs(this.widget.route['id']);
//INIT OF THE MARKERS
   for (var i = 0; i < allMarkers.length; i++) {
  //THE BUILDER WIDGET
  listWB.add(
    [
      Text('${(getObjByKey(ValueKey(allMarkers[i]['id'])))['id']}',
      style: TextStyle(color: Color.fromARGB(255, 7, 7, 7),
      fontSize: 15),),
        Container(
        color: Colors.black.withOpacity(0.05),
        child: ImageIcon(AssetImage('assets/locationN.png'),size: 50,color: Color.fromARGB(255, 114, 63, 63)), 
        ),
    ]
  );


  //THE REORDERABLE LIST PART (WIDGET CREATION)
  listW.add(
    PopWidget(id_list: ValueKey(allMarkers[i]['id']), block: Container(), isAlive: false)
  );


  

    //MARKERS PART
    markers.add(
      Marker(
      //HIS KEY
      key: ValueKey(allMarkers[i]['id']),
      //HIS LOCATION
      point: LatLng(allMarkers[i]['latitude'],allMarkers[i]['longitude']),
      //THE ICON WE WILL PRESENT
      builder: (context) => Stack(
        children: [
          //POS WIDGET
          Positioned(
          top: 2,
          left: 10,
          //THE TEXT
          child: listWB[i][0]
          ),
          //THE ICON
          listWB[i][1]
          ]
        )
    ));


    }

  setState(() {});


  }



  //FUNCTION TO INIT EVERYTHING
  void init(){
  //GET THE DATA
  getData();
  }




  //FUNCTION TO GET THE INDEX ACOURDING TO THE KEY APPRESENTED
  int indexOfKey(Key key){
    //RETURN THE INDEX WHERE THE ID IS EQUAL TO THE KEY
    return allMarkers.indexWhere((element) => element['id'] == key);
    }





  //FUNCTION TO REORDER THE ITEMS
  bool reorder(Key item_start , Key newPosition){
  
  //THE START
  int start = indexOfKey(item_start);
  //WHERE THE ITEM WILL GO
  int end = indexOfKey(newPosition);

  //GRAB THE ITEM FROM THE START
  Map<String,dynamic> moved_item = allMarkers[start];

  //GRAB THE WIDGET FROM THE START DRAG
  PopWidget moved_widget = listW[start];

  //GRAB THE MARKER FROM THE START
  Marker moved_marker = markers[start];

  //GRAB THE BUILDER
  List<Widget> moved_builder = listWB[start];

  //SET THE STATE
  setState(() {
  //REMOVE THE ITEM FROM THE CURRENT POSITION    
    //FROM THE LIST
    allMarkers.removeAt(start);
    //FROM THE WIDGETS
    listW.removeAt(start);
    //FROM THE MARKERS
    markers.removeAt(start);
    //FROM THE BUILDERS LIST
    listWB.removeAt(start);

  //INSERT IN THE NEW POSITION
   //INSERT THE ITEM IN THE NEW POSITON
   allMarkers.insert(end,moved_item);
   //INSERT THE WIDGET IN THE NEW POSITION
   listW.insert(end, moved_widget);
   //INSERT THE MARKER IN THE NEW POSITION
   markers.insert(end,moved_marker);
   //INSERT THE BUILDER IN THE NEW POSITION
   listWB.insert(end, moved_builder);
  });

  //RETURN TRUE AFTER EVERYTHING
  return true;
  }



  //FUNCTION THAT WILL BE INVOKED AFTER THE ITEM BEING REORDERED
  void afterReorder(Key item){
  //GRAB THE ITEM THAT WAS MOVED PREVIOUSLY
  Map<String,dynamic> movedItem = getObjByKey(item);
  //ANOUNCE THAT IT WAS MOVED SUCESSFULLY
  debugPrint("Reorder ok ${movedItem['designation']}");
  }




  //THE MAP CONTROLLER
  late MapController mapController; 
  //THE TEXT CONTROLLER
  TextEditingController testController = TextEditingController();




//INIT STATE FUNCTION TO INIT ALL THE PARAMETERS
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();
    //INIT EVERYTHING
    init();
    setState(() {});
  }











  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return Scaffold(
      //BACKGROUND
      backgroundColor: Colors.white,
     //BODY
           //SAFE AREA FOR STARTING IN AN SAFE AREA
     body: SafeArea(
       child: Column(
        children: [
     
          //THE MAP ITSELF
         Expanded(
            child: FlutterMap(
     
     
     
     
              mapController: mapController,
              //THE OPTIONS
            options: MapOptions(
              //THE CENTER OF THE MAP
              center: LatLng(41.607863,-8.430310),
              //MAX ZOOM
              maxZoom: 18.2,
              //MIN ZOOM
              minZoom: 10,
              //THE ZOOM
              zoom: 18,
            ),
            
     
     
     
     
     
     
     
     
            //CHILDREN PROPS WHICH WILL TAKE THE LAYERS AND SOME OPTIONS
            // ignore: sort_child_properties_last
            children: [
              //MAP LAYER WHICH WILL BE AN OPENSTEET ONE BECAUSE IS FREE
                    TileLayer(
                      backgroundColor: Colors.transparent,
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
     
     
     
     
     
     
     
     
     
                    
              //JUST THE MAP COORDS
                  PopupMarkerLayerOptions(
                    markers: markers,
                    markerRotate: true,
                  )
                   
                
                  ],
     
                  //CHILDREN THAT CANNOT BE ROTATED
                  nonRotatedChildren: [
                    //THE BUTTON FOR GO BACK
                  Positioned(
                    //THE POSITION
                    top: MediaQuery.of(context).size.height*0.020,
                    left: MediaQuery.of(context).size.width*0.01,
                    //THE ICON ITSELF
                    child: IconButton(
                      onPressed: (){
                      //POP
                      Navigator.pop(context);  
                      } , 
                      icon: ImageIcon(AssetImage('assets/arrow.png'),size: 24,color: Color.fromARGB(255, 148, 65, 59),),
                  )
                  )
     
                  ],
          
            
                
            //
           
              ),
          ),




          //CONTAINER WITH THE NAME OF THE ROUTE ,DATA AND KM
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.084,
           //SOME DECORATION TO MAKE THE DROP SHADOW
            decoration: const BoxDecoration(
                color: Colors.white,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  //THE SHADOW ITSELF
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 14.0,
                  ),
                ]
            ),
            //AN ROW
            child: Row(
              //MAKE SOME SPACE BETWEEN
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //THE CHILDREN
              children: [
              


              //COLUMN TO DISPLAY THE TITLE AND THE DATA
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  //THE CHILDREN
                  children: [
                   //NAME OF THE ROUTE
                   Text(this.widget.route['name'],
                   style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width*MediaQuery.of(context).size.height)*0.000085,
                    color: Color.fromARGB(255, 148, 65, 59)
                   ),),
                   //AN SIZED BOX TO GIVE SOME SPACE
                   SizedBox(height: MediaQuery.of(context).size.height*0.002,),
                   //DATE
                   Text("${DateTime.parse(this.widget.route['start_date']).day}-${DateTime.parse(this.widget.route['start_date']).month}-${DateTime.parse(this.widget.route['start_date']).year} - ${DateTime.parse(this.widget.route['end_date']).day}-${DateTime.parse(this.widget.route['end_date']).month}-${DateTime.parse(this.widget.route['end_date']).year}",
                    style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width*MediaQuery.of(context).size.height)*0.000047,
                   ),
                   )

                  ],
                ),
              ),

              //AN ROW TO DISPLAY THE KM AND THE ICON
              Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,top: MediaQuery.of(context).size.height*0.03),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.020),
                      child: Text(allMarkers.isEmpty?'0Km':'15Km',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.020),
                    //STACK WIDGET FOR MAKE AN STACK ON THE BAR
                    Stack(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        //POSITION
                        Positioned(
                          bottom: MediaQuery.of(context).size.height*0.013,
                          //THE NUMBER OF PLACES IN THE ROUTE
                          child: Text(allMarkers.length.toString(),style: TextStyle(
                          fontWeight: FontWeight.bold
                                            ),),
                        ),
                        //IMAGE ICON
                        ImageIcon(AssetImage('assets/location.png')),
                      ],
                    )
                  ],
                ),
              )
              ],
            ),

          ),
          
          //CONTAINER TO INIT THE ROUTE
          Padding(
            //SOME PADDING FOR THE CONTAINER
            padding:  EdgeInsets.all((MediaQuery.of(context).size.width*MediaQuery.of(context).size.height)*0.00005),
            //CONTAINER
            child: Container(
              //MAKE IT WHITE
              color: Colors.white,
              //PUT AN BUTTON INSIDE
              child: TextButton(
              //ON PRESSED 
              onPressed: ()async{
              //ACTION TRHOUGH ALLMARKERS LENGTH
              if(allMarkers.isEmpty)


              {


              //ADD SOME POINTS
              var value = await showDialog(
              context: context, 
              builder: (context){
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Dialog(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                 backgroundColor: Colors.white,
                 child: Container(
                  width: MediaQuery.of(context).size.width*0.20,
                  height: MediaQuery.of(context).size.height*0.20,
                   child: Column(
                    children: [
                      Text('Insert the poi id'),
                      TextFormField(
                      controller: testController,  
                      ),
                      TextButton(onPressed: (){
                      //GIVE THE VALUE BACK
                      Navigator.pop(context,testController.text);

                      }, child: Text('Submit'))
                    ],
                   ),
                 ),
                ),
              );
              }); 
              //GET THE VALUE
              await insertLeaf(int.parse(value), this.widget.route['id']);
              //REBUILD THE WIDGET
              Navigator.popAndPushNamed(context, '/rotas',arguments: {"route": this.widget.route});
              //CASE IS NOT EMPTY
              }else{
              
              print("INICIAR ROTA");
              
              }
              

              },
              //SOME PADDING FOR THE LATERALS
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.20,right: MediaQuery.of(context).size.width*0.20),
                //THE TEXT
                child: Text(allMarkers.isEmpty?
                'ADICIONAR PONTOS'
                :
                'INICIAR ROTA',
                //SOME TEXT STYLE 
                style: TextStyle(
                fontSize: (MediaQuery.of(context).size.width*MediaQuery.of(context).size.height)*0.00006,
                color: Colors.white,
                ),),
              ),
              //BUTTON STYLE
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 148, 65, 59))
              ),
              ),
            ),
          ),













          //NOW THE CONTAINER THAT WILL HAVE THE ROUTES INSIDE IN A KIND OF LIST
          Container(
            //SOME WIDTH AND HEIGHT
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,
            //THE COLOR
            color: Color.fromARGB(255, 244, 189, 189),
            child: ReorderableList(
              //FUNCTION TO REORDER
              onReorder: reorder,
              //FUNCTION TO RUN AFTER THE REORDER
              onReorderDone: afterReorder,
              //THE CHILD CUSTOMSCROLLVIEW
              child: CustomScrollView(
                //SHRINK IT
                shrinkWrap: true,
                //THE LIST
                slivers: [
                  //AN SIMPLE PADDING
                  SliverPadding(
                    //THE PADDING
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                    //THE BUILDER
                    sliver: 
                    SliverList(
                    //THE CONSTRUCTOR 
                    delegate: SliverChildBuilderDelegate(
                      //THE LENGTH OF THE CHILD
                      childCount: allMarkers.isEmpty?allMarkers.length:allMarkers.length+1,
                      
                      //THE PARAMETERS FOR CONSTRUCT
                      (BuildContext context , int index){
                        //AN REORDERABLEITEM
                      return ((index==allMarkers.length)&&(allMarkers.isNotEmpty))? 
                      //CASE THIS IS THE LAST ROW TO INSERT AND ALSO THE ALL MARKERS IS NOT EMPTY,THEN
                      
                      Container(
                      //SOME MEASURES
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.10,
                      color: Colors.white,
                      child: Text('This will be an card that will throw some nearby things'),
                      )
                      :
                      //CASE THE LENGTH IS 0 OR IS NOT THE LAST ROW TO INSERT
                      ReorderableItem(
                        
                        //GET THE KEY
                      key: ValueKey(allMarkers[index]['id']),
                      //THE BUILD ITSELF
                      childBuilder: 
                      //THE PARAMETERS
                      (BuildContext context, ReorderableItemState state){
                      //RETURN AN INTRINSICHEIGHT FOR AN VERY LARGE COLUMN WIDGET
                      return IntrinsicHeight(
                      //AN COLUMN FOR HAVING 2 WIDGETS : 1 IS THE NAME , THE SECOUND ARE FOR THE DETAILS WHEN CLICKING AN BUTTON
                      child: Column(
                        children: [
                        //EXPAND THE LISTENER
                        Expanded(
                          child: 
                          //THE WIDGET WITH THE BUTTON
                          Row(
                            //STRETCH IN THE VERTICAL
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //THE CHILDREN
                            children: [
                            //ROW FOR THE TITLE AND SUBTITLE
                            Row(
                              children: [



                                //THE REORDERABLE LISTENER
                                ReorderableListener(
                                  //THE CHILD THAT WILL BE LISTENING FOR THE CHANGES
                                  child: Icon(Icons.reorder,
                                  size: (MediaQuery.of(context).size.height*MediaQuery.of(context).size.width)*0.00020 ,),
                                ),




                             //AN COLUMN FOR THE TITLE AND SUBTITLE
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //CHILDREN
                                children: [
                              //TITLE
                              Text(allMarkers[index]['designation'],
                              style: TextStyle(
                              fontSize: (MediaQuery.of(context).size.height*MediaQuery.of(context).size.width)*0.00007
                              ),),
                              
                              //SUBTITLE
                              Text(allMarkers[index]['locality'],
                              style: TextStyle(
                              fontSize: (MediaQuery.of(context).size.height*MediaQuery.of(context).size.width)*0.00004
                              ),),
    

                              ],),
                            ),


                              ],
                            ),
                            
                            
                           
                            //WIDGET WITH ICON
                            GestureDetector(
                              onTap: (){
                              //IF IT IS ALIVE
                              if(listW[index].isAlive){
                                //MAKE HIM DEAD
                                listW[index].block=Container();
                                //MAKE HIM DEAD IN AN POLITICAL WAY
                                listW[index].isAlive=false;
                              }else{
                              
                              //MAKE AN COMPLETE NEW WIDGET
                              listW[index].block=
                              Container(
                                height: MediaQuery.of(context).size.height*0.2,
                                width: MediaQuery.of(context).size.width,
                                color: Color.fromARGB(255, 244, 189, 189),
                                //THE ATRACTIONS , HIS SIMBOLS AND THE 2 BUTTONS FOR THE DETAILS
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //CHILDREN
                                  children: [
                                   Text('ATRAÇÕES MARCADAS',
                                   style:TextStyle(
                                    fontSize: 20,
                                   ),),
                                   SizedBox(height: 20,),
                                   Row(
                                    children: [
                                     Icon(Icons.wine_bar,size: 50,),
                                     SizedBox(width: 10,),
                                     Icon(Icons.bed,size: 50,),
                                     SizedBox(width: 10,),
                                     Icon(Icons.person,size: 50,)
                                    ],
                                   ),
                                   
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    TextButton(
                                    onPressed: (){}, 
                                    child: Text('ELIMINAR',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 152, 69, 63)),
                                    )),


                                    SizedBox(width: 20),


                                    TextButton(onPressed: (){}, child: Text('EDITAR',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 152, 69, 63)),
                                    ),)
                                   ],)



                                  ],
                                ),
                              );
                              //MAKE HIM ALIVE
                              listW[index].isAlive=true;
                              }
                              //SET THE STATE
                              setState(() {});

                              },
                              child: Stack(
                                children: [
                                  Positioned(
                                  top:9,
                                  left: 20,
                                  child: listWB[index][0]
                                  ),
                                  listWB[index][1]
                                ]
                              ),
                            ),
                            
                            
                           



                            ],
                          ),
                        ),
                        //STACK IT
                         Stack(
                          children: [
                            //AN DIVIDER WITH PADDING
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.06,right: MediaQuery.of(context).size.width*0.06),
                            child: Divider(
                              color: Color.fromARGB(255, 158, 148, 148),
                              thickness: 3,
                              ),
                          ),
                          //INFO WIDGET
                          listW[index].block
                          ],
                         )

                       


                        ],
                      ),
                      );

                      },
                      );
                      
                      
                      
                      
                      }
                    ),
                    ),
                  )
                ]
              ),

            ),

          ) 
         










        ],
       ),
     ),
    );
  }
}