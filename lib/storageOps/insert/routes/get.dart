//THE DB
// ignore_for_file: slash_for_doc_comments

import 'dart:convert';

import 'package:proto/db/dbInit.dart';

Databaseapp db_instance = Databaseapp(
name: 'douroporto', 
commands: [], 
onUpgrade: ((db, oldVersion, newVersion) => {}), 
version: 1);



//GET ROUTES FUNC
Future<List<dynamic>> getRoutes()async{
//THE RESULT
var result;
//GET THE DB
var db = await db_instance.getDb();
await db.transaction((txn)async{
  
//RETURN THE DATA
result = await txn.query(
"route",
columns: 
[
"*"
],
);

});
return result;
} 
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/




/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
//GET ROUTES FUNC
Future<List<Map<String,dynamic>>> getRoute(_id)async{
//GET THE DB
var db = await db_instance.getDb();
//RETURN THE DATA
return await
db.query(
"route",
columns: 
[
"*"
],
where: "id = ?",
whereArgs: [_id]
);
} 
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/









/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
//GET POI FROM AN CERTAIN ROUTE
Future<List<Map<String,dynamic>>> getLeafs(_id) async {

//GET THE DB
var db = await db_instance.getDb();

//AWAIT AND RETURN THE RESULT
return await
db.rawQuery(
"Select point_of_interest.id,point_of_interest.coverImageUrl,point_of_interest.latitude,point_of_interest.locality,point_of_interest.designation,point_of_interest.altDate,point_of_interest.logoImageUrl,point_of_interest.likes,point_of_interest.longitude FROM route JOIN route_tree ON route.id == route_tree.id_route JOIN point_of_interest ON point_of_interest.id == route_tree.id_poi WHERE route.id=$_id"
);

}
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/