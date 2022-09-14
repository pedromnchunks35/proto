import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proto/Classes/itp.dart';



//FUNCTION TO GET THE INTEREST POINTS
Future<List<Itp>> getIntPoints(String token) async {

//LIST
List<Itp> list = [];
//GET THE URL
var uri = Uri.parse("https://rvdp-tq.ano.pt/rvdp/services/api/pointsOfInterest/list");
//HEADER
Map<String,String> header = {'Authorization':'Bearer ${token}'};
//GET THE RESPONSE
var response = (await http.get(uri,headers: header));
//CHECK IF IT WAS SUCESSFULL
if(response.statusCode==200){
//THE GET
var data = jsonDecode(response.body);  

//LOOP OVER THE POINTS
for (var element in data['pointsOfInterest']) {
  //ADD TO THE LIST
  list.add(
  Itp(
  id: element['id'],
  coverImageUrl: element['coverImageUrl'],
   latitude: double.parse(element['latitude'].toString()), 
   locality: element['locality'], 
   designation: element['designation'], 
   altDate: element['altDate'], 
   logoImageUrl: element['logoImageUrl'], 
   likes: element['likes'], 
   longitude: double.parse(element['longitude'].toString()))
  );
}
}else{
print("[FETCH POINTS] - TOKEN NOT VALID");
}
//RETURN THE DATA
return list;
}