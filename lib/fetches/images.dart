import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//METHOD TO RETURN BASE64 CODE
Future<List<String>> getImages(String token,String coverImageUrl,String logoImageUrl)async{
//STRING LIST
List<String> result = [];
//URI
var coverUri=Uri.parse(coverImageUrl);
var logoUri=Uri.parse(logoImageUrl);
var header={"Authorization": 'Bearer ${token}'};
//GET THE RESPONSES
var response_cover = await http.get(coverUri,headers: header);
var response_logo = await http.get(logoUri,headers: header);
//CASE ISNT SUCESSFULL
if(response_cover.statusCode==200||response_logo.statusCode==200){
//RETURN THE RESULT
result.add(jsonDecode(response_cover.body)['base64']);
result.add(jsonDecode(response_logo.body)['base64']);
}
return result;
}