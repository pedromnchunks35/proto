//DB INSTANCE
import 'package:proto/db/dbInit.dart';

Databaseapp db_instance = Databaseapp(
name: 'douroporto', 
commands: [], 
onUpgrade: ((db, oldVersion, newVersion) => {}), 
version: 1);

//FUNCTION TO UPDATE THE STATE
Future<bool> updateState(_id_route)async{
//GET THE DB
var db = await db_instance.getDb();
//GET TRANS
await db.transaction((txn)async{
//GET THE OBJ THAT WAS THE STATE 0
var state_el = 
await txn.query(
'route',
columns: ["*"],
where: 'state=?',
whereArgs: [0]);
//IF THE GIVEN ID IS ALREADY WITH THE STATE 0 
if(int.parse((state_el as List<Map<String,dynamic>>)[0]['id'].toString()) == _id_route){
//DEBUG
print("[UPDATE] THAT ID IS ALREADY WITH STATE 0");
//IF THE CURRENT STATE 0 IS DIFFERENT
}else{
//DEBUG
print("[UPDATE] STARTING THE UPDATE , SINCE THE STATE 0 IS FROM ANOTHER ID_ROUTE");
//GET THE BATCH
var batch = txn.batch();
//MAKE THE UPDATE
////UPDATE THE CURRENT STATE 0 FOR STATE 1
batch.update('route',{
"state": 1
},
where: 'id=?',
whereArgs: [int.parse((state_el as List<Map<String,dynamic>>)[0]['id'].toString())]
);

//UPDATE THE GIVEN ID TO STATE 0
batch.update('route',{
"state": 0
},
where: 'id=?',
whereArgs: [_id_route]
);


//COMMIT THE CHANGES
await batch.commit();
//DEBUG
print("[UPDATE] UPDATED");
}

});


//return statement
return true;
}