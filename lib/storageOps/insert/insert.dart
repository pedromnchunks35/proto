//FUNCTION TO INSERT

import 'package:proto/Classes/itp.dart';
import 'package:proto/db/dbInit.dart';
import 'package:proto/fetches/images.dart';

void insert(Itp _obj,String token)async{
//INIT DB
Databaseapp app =Databaseapp(
name: 'douroporto', 
commands: [], 
onUpgrade: ((db, oldVersion, newVersion){}), 
version: 1);
//GET THE DB
var db = await app.getDb();
if(
!((await db.rawQuery("SELECT * FROM point_of_interest"))
.map((item) => item['id']).contains(_obj.id))
){
//GET THE IMAGE VALUES
var list = await getImages(token, _obj.coverImageUrl, _obj.logoImageUrl);
if(list.isNotEmpty){
//TRANSACTION
db.transaction((txn)async{
//BATCH
var batch = txn.batch();
//MAKE THE INSERT
batch.insert('point_of_interest',
{
'id':_obj.id,
'altDate':_obj.altDate,  
'coverImageUrl':list[0],  
'designation':_obj.designation,  
'latitude':_obj.latitude,  
'likes':_obj.likes,  
'locality':_obj.locality,  
'logoImageUrl':list[1],  
'longitude':_obj.longitude   
});
//COMMIT IT
await batch.commit(noResult: true);
});
}else{
print("[UPDATE]-ERROR DURING THE INSERT (IMAGES)");
}
}
}