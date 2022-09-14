//HEAD OF THE LOCAL DB STORAGE

import 'package:proto/db/dbInit.dart';
import 'package:proto/storageOps/updates/updates.dart';
import 'package:sqflite/sqflite.dart';

void head(String token)async{

//THE INIT OF THE VARS
Databaseapp db_instance;
Database db;
List<Map> verifyTable;

//INSTANCE OF THE DATABASE
db_instance = Databaseapp(
//NAME OF THE DATABASE
name: 'douroporto',
//THE OPCIONAL COMMANDS WE WILL RUN AT THE INIT IF WE WANT TO WITH CREATETABLE METHOD
commands: 
[
'CREATE TABLE date (lastDate TEXT)',
'CREATE TABLE point_of_interest (id INTEGER PRIMARY KEY,coverImageUrl TEXT,latitude REAL,locality TEXT,designation TEXT,altDate TEXT,logoImageUrl TEXT,likes INTEGER,longitude REAL)',
'CREATE TABLE route (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,state TEXT,start_date TEXT,end_date TEXT)',
'CREATE TABLE route_tree (id_route INTEGER,id_poi INTEGER)' 
],
//ON UPGRADE
onUpgrade: ((db, oldVersion, newVersion){}),
//THE VERSION
version: 1 
);

//GET THE DATABASE 
db=await db_instance.getDb();
//CHECKOUT THE TABLE LASTDATE
verifyTable = await db.query('sqlite_master', where: 'name = ?', whereArgs: ['date']);
//CHECK IF THE VERIFY IS EMPTY OR NOT
if(verifyTable.isEmpty){
print("[INIT] CREATING THE TABLES AND THE LASTDATE..");
//IF IT IS EMPTY LETS JUST CREATE TABLES
db_instance.createTables(db,1);
//INSERT DATE
db.transaction((
(txn)async{

//GET THE BATCH
var batch = txn.batch();
//INSERT
batch.insert('date', {"lastDate":DateTime.now().toString()});

//DONT WAIT
await batch.commit();

//DEBUG
print("[INIT] TABLES AND THE DATA WERE INSERTED");
} ));


}else if((await db.rawQuery("SELECT * FROM date")).isEmpty){


//INSERT DATE
db.transaction((
(txn)async{

//GET THE BATCH
var batch = txn.batch();
//INSERT
batch.insert('date', {"lastDate":DateTime.now().toString()});

//DONT WAIT
await batch.commit();

//DEBUG
print("[INIT] THE FAILED INSERTED DATA WAS INSERTED");
} ));

}else{

print(await db.query('route_tree',where: 'id_route=? and id_poi=?',whereArgs: [5,2]));

//IF ITS NOT EMPTY , LETS UPDATE
update(db_instance, db, token);

}}