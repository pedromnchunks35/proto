import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:proto/data/draggable_lists.dart';
import 'package:reorderables/reorderables.dart';

class Drag extends StatefulWidget {
  const Drag({Key? key}) : super(key: key);

  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> {
    //THE SCROLL CONTROLLERS FOR DONT TROWH ERRORS
    ScrollController controller = new ScrollController();
    ScrollController anothercontroller = new ScrollController();
    //THE ROWS
    late List<Widget> _rows;
    //FUNCTION TO GET AN CERTAIN KEY
    ValueKey getKey(list){
      var value=0;
      for (var i = 0; i < allLists.length; i++) {
        
        if(list.header == allLists[0].header){
          value=i;
          break;
        }
      }
      return ValueKey(value);
    }

    //FUNCTION TO RETURN THE CHILDS OF THE LIST
    ListView getSons(subList){
    return 
    ListView(
      //SHRINK FOR DONT OVERFLOW
      controller: controller,
      shrinkWrap: true,
      //OBLIGATE THE MAP TO GET AN WIDGET
      children: subList.map<Widget>(
      (item){
        return
        ListTile(
        title: Text(item.title),
        leading: Image.network(item.urlImage,
        width: 40,
        height: 40,),  
        );
      }  
      ).toList() ,
    );
    }
 //INIT STATE FUNC
  @override
  void initState() {
    super.initState();
    //GET THE DATA
    _rows = allLists.map((list){
    return Container(
      key: getKey(list),
      child: ListView(
        controller: anothercontroller,
        shrinkWrap: true,
        
        children: [
          //TITLE
        Text(list.header),
        //THE REST OF THE DATA
       getSons(list.items)
      ],)
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    //FUNCTION THAT WILL REORDER
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _rows.removeAt(oldIndex);
        _rows.insert(newIndex, row);
      });
    }
    //WIDGET REORDERABLECOLUMN TYPE WHICH CHILDREN WILL BE THE DATA THAT WE ASSIGNED
    Widget reorderableColumn =  ReorderableColumn(
//        crossAxisAlignment: CrossAxisAlignment.start,
      children: _rows,
      onReorder: _onReorder,
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint(
            '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
    );
    //RETURN STATEMENT
    return 
       Scaffold(
        //SAFEAREA
         body: SafeArea(
            //RETURN OF THE REORDERABLECOLUMN
             child: Container(
              child: Card(child: reorderableColumn),
              color: Colors.transparent,
              
                 ),
         ),
       );
    
  }
}