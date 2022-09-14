// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:proto/model/markers.dart';
import '../data/marker_list.dart';
import '../model/markers.dart';

class LocaisMap extends StatefulWidget {
  const LocaisMap({Key? key}) : super(key: key);

  @override
  State<LocaisMap> createState() => _LocaisMapState();
}

class _LocaisMapState extends State<LocaisMap> {
  //THE MAP CONTROLLER
  late MapController mapController; 
 // USED TO TRIGGER/HIDE POPUPS
  final PopupController _popupLayerController = PopupController();
//LIST OF WIDGETS
List<Widget> markers_w = [];
//THE LIST OF THE MARKERS
List<Marker> markers = [];
  //AN FOCUS NODE
  FocusNode focus = FocusNode();
  //FUNCTION TO RETRIEVE AN OBJ ACCORDING TO THE KEY
  Markercoords getObjByKey(Key key){
  //NULL VALUE
  Markercoords result= Markercoords(id:ValueKey(0),coords: CoordsM(lat: 0 ,long: 0), name: '', description: '', url: '');
  for (var i = 0; i < allMarkers.length; i++) {
    //SEARCH FOR THE KEY
    if(ValueKey(allMarkers[i].id)==key){
    //ASSIGN THE VALUE
    result = allMarkers[i];
    }
  }
  //RETURN AN CERTAIN RESULT
  return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();

    //INIT OF THE MARKERS
    for (var i = 0; i < allMarkers.length; i++) {
    
    markers_w.add(
    
    SvgPicture.asset(
      'assets/interestLine.svg'
    )
    );


      //ADD AN MARKET
    markers.add(
      Marker(
      //HIS KEY
      key: ValueKey(allMarkers[i].id),
      //HIS LOCATION
      point: LatLng(allMarkers[i].coords.lat,allMarkers[i].coords.long),
      //THE ICON WE WILL PRESENT
      builder: (context) => 
        markers_w[i]
      
    ));

    }
    
  }
  @override
  Widget build(BuildContext context) {
    //NORMAL SCAFFOLD
    var trueCondition;
    return Scaffold(
      //BACKGROUND OF SCAFFOLD
      backgroundColor: Colors.white,
      //THE BODY WHICH WILL BE A COLUMN
      body: Column(
        children: [





        //AN ROW FOR THE APP BAR
        SafeArea(
          //CREATING AN CONTAINER FOR THE SHADOW
          child: Container(
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
            //NOW THE CONTAINER (APPBAR ITEMS)
            //AN ROW TO PLACE THEM 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              //SOME PADDING
              const Padding(
                padding: EdgeInsets.all(15.0),
                //THE TITLE OF THE APPBAR
                child: Text('LOCAIS DE INTERESSE',
                //THE TEXT STYLE
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 158, 78, 72)
                ),),
              ),
              //AN ROW FOR THE BUTTON ICONS
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children:
                [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Color.fromARGB(255, 158, 78, 72),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity(horizontal:-4.0,vertical: -4.0),
                  onPressed: (){}, icon: Icon(Icons.location_on)),
                //ICON BUTTONS
                IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: Color.fromARGB(255, 158, 78, 72),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity(horizontal:-4.0,vertical: -4.0),
                onPressed: (){}, icon: Icon(Icons.person))
                ],
                ),
              ),
              ],
            ),
          ),
        ),


        


        //SEARCH BAR
        //SOME TOP PADDING
        Padding(
          //PADDING INSIDE
          padding: const EdgeInsets.only(top: 10),
          //AN CONTAINER
          child: Container(
            //SIZE AND COLOR OF THE CONTAINER
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.10,
            //MORE PADDING FOR THE INPUT
            // ignore: prefer_const_constructors
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              //INPUT
              child: TextFormField(
                //FOCUS NODE
                focusNode: focus,
                //THE DECORATION
               decoration: InputDecoration(
                //FILL THE COLOR
                filled: true,
                fillColor: Color.fromARGB(59, 230, 230, 230),
                //FIRST ICON
               prefixIcon: Icon(Icons.search,color: focus.hasFocus?Color.fromARGB(58, 63, 61, 61):Color.fromARGB(58, 63, 61, 61)),
               //SECOUND ICON
               suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt),color: focus.hasFocus?Color.fromARGB(58, 63, 61, 61):Color.fromARGB(58, 63, 61, 61)),
               //THE LABEL
               labelText: "Pesquise um local de interesse",
               //LABEL STYLE
               labelStyle: TextStyle(color: Colors.grey),
               //THE BORDER
               enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(
               color: Color.fromARGB(59, 230, 230, 230),
      ),

    ),
    //ON FOCUS COLOR
    focusColor: Color.fromARGB(59, 230, 230, 230),
    //UNDERLINE ON FOCUS COLOR
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(59, 230, 230, 230)
      )
    ),
   
   ),
  
  ),
            ),
          ),
        ),






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
              //MAKING POPUPS DISAPPEAR WHEN CLICKING THE MAP
              onTap: (_, __) => _popupLayerController
              .hideAllPopups(), // Hide popup when the map is tapped.
          ),
          
          //CHILDREN PROPS WHICH WILL TAKE THE LAYERS AND SOME OPTIONS
          children: [
            //MAP LAYER WHICH WILL BE AN OPENSTEET ONE BECAUSE IS FREE
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  
                  //POPUP LAYER
            PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
              //ON POP UP EVENT
              onPopupEvent: (event, selectedMarkers){
              //WHEN THE SELECTED IS NOT EMPTY
              if(selectedMarkers.isNotEmpty){
               //GET THE INDEX
               var index = markers.indexOf(selectedMarkers[0]);
              //SET THE STATE
               setState(() {
                 //SET THE MARKERS INDEX
               markers_w[index] = SvgPicture.asset(
                            'assets/interestLine.svg'
                                                  );});
              }
              },
              //MARKERTAP BEHAVIOR
              markerTapBehavior: MarkerTapBehavior.custom(((marker, popupState, popupController){
                 //GET THE INDEX
               var index = markers.indexOf(marker);
              //SET THE STATE
               setState(() {
                 //SET THE MARKERS INDEX
               markers_w[index] = SvgPicture.asset(
                            'assets/interestFull.svg'
                                                  );
               });
                               
               //SHOW POPUP
               popupController.showPopupsOnlyFor([marker]);
               
              })),
              //THE POPUP CONTROLLER
              popupController: _popupLayerController,
              //THE LIST OF MARKERS WE WILL PUT ON THE MAP
              markers: markers,
              //MARKER ROTATION
              markerRotateAlignment:
              //THE WAY THE MARKER WILL ROTATE..IF IT IS FROM THE TOP , FROM THE BOTTOM OR , IN THIS CASE, CENTER
              PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.center),
              //POPUP BUILDER
              popupBuilder: (BuildContext context, Marker marker){
               //GET THE DATA
               Markercoords finalObj = getObjByKey(marker.key as Key);
                  //AN SIMPLE CARD TO GET SOME ELEVATION
                 return  Card(
                    elevation: 10,
                    //AN CONTAINER TO CONTROLL THE SIZE
                    child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height*0.18,
                      width: MediaQuery.of(context).size.width*0.65,
                      //ANOTHER CONTAINER WITH SOME PADDING 
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        //THE CONTAINER ITSELF
                        child: Container(
                          //ADDING SOME DECORATION TO THE IMAGE
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            //THE IMAGE
                            // ignore: prefer_const_constructors
                            image: DecorationImage(
                              // ignore: prefer_const_constructors
                              image: NetworkImage(finalObj.url),
                              //MAKE IT COVER
                              fit: BoxFit.cover, 
                              )
                          ),
                          //ANOTHER CONTAINER FOR MAKE THE CONTRAST BETWEEN THE IMAGE AND THE ICONS
                          child: Container(
                            color: Colors.black.withOpacity(0.5),


                            //AN COLUMN
                            child: Column(
                              children: [



                                   //THE ICONS IN THE UP PART OF THE IMAGE
                                   Row(
                                    //MAKE THE SPACE BETWEEN THE WIDGETS AND MAKE THEM START ON THE UP SIDE
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //FIRST ICON LEFT SIDE
                                      IconButton(onPressed: (){
                                        //FUNCTION TO HIDE THE POPUPS 
                                        _popupLayerController.hideAllPopups();
                                      },
                                      visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                                      icon:ImageIcon(AssetImage('assets/x.png'),color: Colors.white,size: 20,)),
                                      
                                      //THE TWO ICONS ON THE RIGHT
                                      Column(
                                        children: [

                                          //ROW FOR THE NUMBER OF LIKES AND THE LIKE BUTTON
                                        Row(
                                          children: [
                                            // ignore: prefer_const_constructors
                                            Padding(
                                              //NUMBER OF LIKES
                                              padding: const EdgeInsets.only(left: 3),
                                              child: Text('1',style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                              ),),
                                            ),

                                            //HEART ICON
                                            IconButton(onPressed: (){},
                                            visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                                            padding: EdgeInsets.zero,
                                            icon:ImageIcon(AssetImage('assets/love.png'),color: Colors.white,size: 20,)),

                                          ],
                                        ),

                                        //THE PLUS ICON
                                        IconButton(onPressed: (){},
                                        // ignore: prefer_const_constructors
                                        padding: EdgeInsets.only(left: 10,bottom: 14),
                                        iconSize:16,
                                        visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                                        icon: ImageIcon(AssetImage('assets/plus.png'),color: Colors.white,size: 20,))
                                        ],

                                      )



                                    ],
                                  ),
                                
                                  

                                 //COLUMN FOR THE REST OF THE WIDGETS , WHICH IS THE NAME OF THE PLACE , THE REGION AND THE KM 
                                 Column(
                                  //CENTER THEM
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    //THE NAME
                                    Text(finalObj.name,
                                    style: TextStyle(
                                      color: Colors.white
                                    ),),
                                    //REGION
                                    Text('Favaios',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13
                                    ),),
                                    
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3,right: 5),
                                      //ROW FOR THE ICON AND NUMBER OF KMS
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          //ICON
                                        Icon(Icons.location_on,size: 15,color: Colors.white,),
                                        //TEXT
                                        Text('180km',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12
                                        ),)
                                        ],
                                      ),




                                    )

                                  ],



                                 )

                                  








                              ],
                            ),
                          ),



                        ),
                      )
                    ),
                  );}
            ),
                  ),
                 
                 
                
                

                ],

                //CHILDREN THAT CANNOT BE ROTATED
                nonRotatedChildren: [
                  //THE BUTTON FOR THE LIST
                Positioned(
                  bottom: MediaQuery.of(context).size.height*0.001,
                  left: MediaQuery.of(context).size.width*0.41,
                  child: TextButton.icon(
                    focusNode: focus,
                    onPressed: (){},
                    icon: Icon(Icons.list,color: focus.hasFocus?Color.fromARGB(255, 148, 65, 59):Color.fromARGB(255, 148, 65, 59)), 
                    label: Text('Lista',style: TextStyle(
                      color: Color.fromARGB(255, 148, 65, 59)
                    ),),
                    style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                    backgroundColor: MaterialStateProperty.all(Colors.white)
                    ),),
                )

                ],
        
          
              
          //
         
            ),
        ),
       









        ],
      ),
      bottomNavigationBar: Row(
        children: [
         IconButton( iconSize: 40,onPressed: (){}, icon: Icon(Icons.abc_outlined)),
         IconButton( iconSize: 40,onPressed: (){}, icon: Icon(Icons.abc_outlined)),
         IconButton( iconSize: 40,onPressed: (){}, icon: Icon(Icons.abc_outlined)),
         IconButton( iconSize: 40,onPressed: (){}, icon: Icon(Icons.abc_outlined)),
         IconButton( iconSize: 40,onPressed: (){}, icon: Icon(Icons.abc_outlined)),
         IconButton( iconSize: 40,onPressed: (){}, icon: Icon(Icons.abc_outlined)),
         IconButton( iconSize: 40,onPressed: (){}, icon: Icon(Icons.abc_outlined)),
        ]),
      );
  }
}