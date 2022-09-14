import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
class OriginalReorder extends StatefulWidget {
  const OriginalReorder({Key? key}) : super(key: key);

  @override
  State<OriginalReorder> createState() => _OriginalReorderState();
}



//DIFFERENT CONTAINER
class DownWidget{
Key id_lista;
Widget block;
bool isAlive;
DownWidget({required this.id_lista,required this.block,required this.isAlive});
}
//AN ITEM
class Item{
    Key id;
    String name;
    
    Item({required this.id,required this.name});
  }



class _OriginalReorderState extends State<OriginalReorder> {
//AN LIST
List<Item> lista=[];
//LIST OF THE WIDGETS
List<DownWidget>listaW=[];
//INIT OF THE LIST
void init(){
  for (var i = 0; i < 20; i++) {
    listaW.add(
    DownWidget(id_lista: ValueKey(i), block: Container(), isAlive: false)
    );
    lista.add(
      Item(id: ValueKey(i), name: 'Hello ${i}')
    );
  }
}


//FUNCTION TO GET THE CURRENT INDEX OF THE KEY APRESENTED
int indexOfKey(Key key){
  //RETURN THE INDEX WHERE THE ID IS EQUAL TO THE KEY
  return lista.indexWhere((Item i) => i.id == key);
}
//FUNCION TO REORDER THE ITEMS
bool reorder(Key item_start , Key newPosition){
//THE START
int start = indexOfKey(item_start);
//WHERE THE ITEM WILL GO
int end = indexOfKey(newPosition);

//GRAB THE ITEM FROM THE START DRAG
Item moved_item = lista[start];
//GRAB THE WIDGET FROM THE START DRAG
DownWidget moved_widget = listaW[start];

setState(() {
  //REMOVE THE ITEM FROM THE CURRENT POSITION
  lista.removeAt(start);
  //REMOVE THE WIDGET FROM THE CURRENT POSITION
  listaW.removeAt(start);
  //INSERT IT IN THE NEW POSITION
  lista.insert(end,moved_item);
  //INSERT THE WIDGET IN THE NEW POSITION
  listaW.insert(end,moved_widget);
});
//RETURN TRUE AFTER THE SUCESSFULL OPERATION
return true;
}
//FUNCTION THAT WILL RUN AFTER THE REORDER (FUNCTION TO PUT THE OLD)
void afterReorder(Key item){
//GRAB THE ITEM THAT WAS MOVED PREVIOUSLY
Item movedItem = lista[indexOfKey(item)];
//ANOUNCE THAT IT WAS MOVED SUCESSFULLY
debugPrint("Reorder ok ${movedItem.name}");
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    //init it
    init();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BODY IS A REORDERABLELIST
      body: SafeArea(
        child: ReorderableList(
          //FUNCTION TO REORDER
          onReorder: reorder,
          //FUNCTION TO RUN AFTER THE REORDER
          onReorderDone: afterReorder,
          child: CustomScrollView(
            shrinkWrap: true,
            //LIST
            slivers: [
             //AN SIMPLE PADDING
             SliverPadding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              //THE BUILDER
              sliver: 
              SliverList(
              //THE PROPPER BUILDER
              delegate: SliverChildBuilderDelegate(
                //THE LENGTH OF THE CHILD
                childCount: lista.length,
                (BuildContext context,int index){
                 //RETURN THE PROPPER LIST 
                 return ReorderableItem(
                  //THE KEY FOR REORDERS
                  key: lista[index].id,
                  //THHE BUILD ITSELF
                  childBuilder:
                  //THE PARAMETERS THAT THIS CHILD BUILDER TAKES 
                  (BuildContext context , ReorderableItemState state){
                    //THE RETURN STATEMENT
                  return IntrinsicHeight(
                    //AN ROW
                    child: Column(
                      children: [
                        //EXPAND AN GIVEN ROW SO IT DOESNT GIVE RENDER ERROR
                        Expanded(
                          child: Row(
                            //STRETCH IN THE VERTICAL
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            //THE CHILDREN
                            children: [
                            //THE REORDERABLE LISTENER
                            ReorderableListener(
                              //THE CHILD THAT WILL BE RESPONSIBLE FOR THE CHANGE 
                            child: Icon(Icons.reorder),
                            ),
                            //EXPANDED WIDGET
                            Expanded(
                              child: Container(
                                width: 300,
                                //THE COLOR OF THE CONTAINER
                                color: Colors.grey,
                                //THE CHILD
                                child: Center(child: Text(lista[index].name)),
                              ),
                            ),
                            //AN ICON TO DISPLAY FURTHER
                            IconButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              //THIS INFO ICON WILL DISPLAY OR HIDE AN CERTAIN WIDGET
                              onPressed: (){
                              //GET THE INDEX OF THE LIST OF WIDGETS OF THIS WIDGET
                              int widget_index = listaW.indexWhere((element) => lista[index].id == element.id_lista);
                              //IF THE WIDGET IS ALIVE KILL IT
                              if(listaW[widget_index].isAlive){
                              //MAKE THE WIDGET DISAPPEAR
                              listaW[widget_index].block=Container();
                              //MAKE HIM DEAD
                              listaW[widget_index].isAlive=false;
                              }else{
                              //BUILD THE ALIVE WIDGET
                              listaW[widget_index].block=
                                 Container(
                                //GET THE MAX WIDTH
                                width: MediaQuery.of(context).size.width,
                                //GET THE HEIGHT
                                height: MediaQuery.of(context).size.height*0.20,
                                decoration: const BoxDecoration(
                                  image:DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage('https://img.freepik.com/free-vector/nature-scene-with-river-hills-forest-mountain-landscape-flat-cartoon-style-illustration_1150-37326.jpg?w=2000')
                                  )
                                ),
                                child: Container(
                                  //COLOR OF THE CONTAINER
                                color: Colors.black.withOpacity(0.4),
                                child:
                                //THE CARD THAT I WILL DISPLAY WHEN CLICKING THE INFO BUTTON
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('RUMO AO 20',style: TextStyle(color: Colors.white,fontSize: 30),)
                                ],
                                ),
                                ),
                              );
                              //MAKE THE WIDGET ALIVE
                              listaW[widget_index].isAlive=true;
                              }

                              //SET STATE
                              setState(() {});
                              

                              //THE DISPLAYED ICON
                              }, icon: Icon(Icons.info)
                              )  
                              
                            ],
                          ),
                        ),
                       

                      //WIDGET CREATED IN listaW
                       listaW[index].block
                      ],
                      
                    ),
                  );
                  }
                 );
      
      
      
      
      
                }
              )),
              )
            ]
            
          )
        ),
      )
    );
  }
}