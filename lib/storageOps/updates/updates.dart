import 'package:proto/Classes/itp.dart';
import 'package:proto/db/dbInit.dart';
import 'package:proto/fetches/images.dart';
import 'package:proto/fetches/ip_fetch.dart';
import 'package:sqflite/sqflite.dart';
//UPDATE
void update(Databaseapp _db_instance,Database _db,String token)async{
print("[UPDATE]- UPDATING....");
//GET ALL THE DATA IN THE DEVICE
var query = await _db.rawQuery("SELECT * FROM point_of_interest");

//CHECK IF THE POINTS ARE EMPTY
if(query.isNotEmpty){ 
//VARS
String lastDate;
DateTime current_date;
print(await _db.rawQuery('SELECT * FROM date'));
//GET LAST DATE
lastDate = ((await _db.rawQuery('SELECT * FROM date'))[0]['lastDate']).toString();
//GET CURRENT DATE
current_date = DateTime.now();
//IF ONE DAY PASSES
if(DateTime.parse(lastDate).add(Duration(days: 1)).compareTo(current_date) <= 0){
print("[UPDATE] STARTING THE UPDATE ITSELF...");
//GET THE DATA
List<Itp> data = await getIntPoints(token);
//INIT TRANSACTION
_db.transaction((txn)async{
//INIT BATCH
var batch = txn.batch();
//LOOP
for (var element in query) {
//GET THE INDEX
var index = data.indexWhere((item) => item.id == element['id']);

//DELETE THE ROW IF THERES NO INDEX FOR IT , WHICH MEANS ITS DELLETED
if(index==-1){
//DELETE THAT ID
batch.delete("point_of_interest",where: "id=?",whereArgs: [element['id']]);
}else{
//IF THE DATE IS NOT UPDATED THEN WE UPDATE ALL
if(DateTime.parse(element['altDate'] as String).compareTo(DateTime.parse(data[index].altDate))<0){
print("[UPDATE] UPDATING THE ${data[index].id}..");
//GET THE IMAGES
var images =await getImages(token, data[index].coverImageUrl, data[index].logoImageUrl);
//CASE IMAGES IS NOT EMPTY
if(images.isNotEmpty){
//THEN UPDATE THE ALL THING
batch.update('point_of_interest', 
{
'altDate':data[index].altDate,
'coverImageUrl':images[0],  
'logoImageUrl':images[1],  
'designation':data[index].designation,  
'latitude':data[index].latitude,  
'likes':data[index].likes,
'locality':data[index].locality,  
'longitude':data[index].longitude,  
},
where: 'id=?',
whereArgs: [data[index].id],
);
//CASE IMAGES IS EMPTY AN ERROR AS OCCOUR
}else{
print("[UPDATES] ERROR TRYING TO UPDATE IMAGES");  
}

}
}
}

//COMMIT IT
await batch.commit(noResult: true);
print("[UPDATE] UPDATE COMPLETED");


});

//IF WE DONT PASS 1 DAY MARK
}else{

print("[UPDATE] THERES NO UPDATES TO DO");

}
//IF THE TABLE IS EMPTY
}else{

print("[UPDATE] THE POINTS ARE EMPTY , WE CANT UPDATE");
}

}