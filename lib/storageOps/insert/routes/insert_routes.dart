//FUNCTION TO INSERT ROUTE
// ignore_for_file: slash_for_doc_comments

import 'dart:convert';

import 'package:proto/Classes/route.dart';
import 'package:proto/db/dbInit.dart';
import 'package:sqflite/sqflite.dart';

//THE DB
Databaseapp db_instance = Databaseapp(
name: 'douroporto', 
commands: [], 
onUpgrade: ((db, oldVersion, newVersion) => {}), 
version: 1);




/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
//INSERT THE ROUTE
Future<bool> insert_route()async{
//GET THE DB
var db = await db_instance.getDb();
//GET THE TRANS
await db.transaction((txn)async{
//GET THE BATCH
var batch = txn.batch();
//VERIFY IF THERES AN ROUTE IN STATE 0
var state=await txn.query(
'route',
columns: ["*"],
where: "state=?",
whereArgs: [0]
);

//GET THE MAX ID
var maxId=await txn.rawQuery(
"SELECT seq as id FROM sqlite_sequence WHERE name='route'"
);


//IF THERES NO ROW WITH STATE
if(state.isEmpty){
//DEBUG
print("[INSERT] INSERTING WITH NO 0 STATE");
//CHECK IF THERES NO MAX_ID
if(maxId[0]['id'] == null){
//DEBUG
print("[INSERT] INSERTING WITH NO MAXID");
//JUST INSERT
batch.insert(
'route',
{
//NAME OF THE FIRST ROUTE
"name": "Rota 1",
//STATE OF RASCUNHO
"state": 0,
//ADD THE DAY OF THE TODAY
"start_date": DateTime.now().toString(),
//END DATE TO THE NEXT WEEK
"end_date": DateTime.now().add(Duration(days: 7)).toString(),
}
);
}else{
//DEBUG
print("[INSERT] INSERTING WITH MAXID");
//JUST INSERT
batch.insert(
'route',
{
//NAME OF THE FIRST ROUTE
"name": "Rota ${int.parse(maxId[0]['id'].toString())+1}",
//STATE OF RASCUNHO
"state": 0,
//ADD THE DAY OF THE TODAY
"start_date": DateTime.now().toString(),
//END DATE TO THE NEXT WEEK
"end_date": DateTime.now().add(Duration(days: 7)).toString(),
}
);
}
//CASE THERES ALREADY AN ROW WITH STATE
}else{
//DEBUG
print("[INSERT] INSERTING UPDATING THE AN STATE 0 TO 1");
//UPDATE THE PREVIOUS ROUTE AS FINISHED
batch.update(
'route',
{
"state": 1
},
where: "id=?",
whereArgs: [state[0]['id']]
);

//INSERT AN NEW ROW
batch.insert(
'route',{
//NAME OF THE FIRST ROUTE
"name": "Rota ${int.parse(maxId[0]['id'].toString())+1}",
//STATE OF RASCUNHO
"state": 0,
//ADD THE DAY OF THE TODAY
"start_date": DateTime.now().toString(),
//END DATE TO THE NEXT WEEK
"end_date": DateTime.now().add(Duration(days: 7)).toString(),
});
}

//COMMIT
await batch.commit(noResult: true);
//DEBUG
print("[INSERT] ROUTE INSERTED");

});
//RETURN TRUE
return true;
}
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/





