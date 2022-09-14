//IMPORT THE MODELS
import 'dart:convert';

import 'package:proto/model/points_of_interest.dart';
//HTTP 
import 'package:http/http.dart' as http;
//FUNCTION TO RETURN POINTS OF INTEREST
Future<List<Points_of_interest>> getPoints(String token) async{
//AN INIT LIST
List<Points_of_interest> list = [];
//THE URL
var url =  Uri.https('rvdp-tq.ano.pt','rvdp/services/api/pointsOfInterest/list');
//THE HEADERS
Map<String, String> _requestHeaders = {
       'Authorization': 'Bearer ${token}'
     };
//GET THE DATA
var response = await http.get(url,headers: _requestHeaders);
//DATA
var status = response.statusCode;
//STATUS CODE
if(status == 200){
//DECODE THE RESPONSE BODY
var data = jsonDecode(response.body);


//AN SIMPLE LOOP
for (var i = 0; i < data['pointsOfInterest'].length; i++) {
//ADD TO THE LIST
 list.add(Points_of_interest(id: data['pointsOfInterest'][i]['id'], designation: data['pointsOfInterest'][i]['designation'], locality: data['pointsOfInterest'][i]['locality'], coverImageUrl: data['pointsOfInterest'][i]['coverImageUrl'], latitude: data['pointsOfInterest'][i]['latitude'].toDouble(), longitude: data['pointsOfInterest'][i]['longitude'].toDouble(), likes: data['pointsOfInterest'][i]['likes'], altDate: data['pointsOfInterest'][i]['altDate'], logoImageUrl: data['pointsOfInterest'][i]['logoImageUrl']));
}

}
//return
return list;
}