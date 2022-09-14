//FUNCTION TO INSERT LEAFS 
import 'package:proto/db/dbInit.dart';
//DB INSTANCE
Databaseapp db_instance = Databaseapp(
name: 'douroporto', 
commands: [], 
onUpgrade: ((db, oldVersion, newVersion) => {}), 
version: 1);
// INSERT LEAFS
Future<bool> insertLeaf(_id_poi,_id_route)async{
//GET THE DB
var db = await db_instance.getDb();

//GET DB TRANSACTION
db.transaction((txn)async{
//DEBUG
print("[INSERT] TRYING TO INSERT LEAF");
//CHECK IF THERES AN ROW
var isit = await txn.query(
'route_tree',
where: 'id_route=? and id_poi=?',
whereArgs: [_id_route,_id_poi]
);
if(isit.isEmpty){
//DEBUG
print("[INSERT] INSERTING...");
//MAKE THE INSERT COME TRUE
txn.insert(
'route_tree',{
"id_route": _id_route,
"id_poi": _id_poi
});

//DEBUG
print("[INSERT] INSERTED");

}else{
//DEBUG
print("[INSERT] THAT LEAF IS ALREADY ON THE TREE");
}
});
//RETURN TRUE
return true;
}