import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
//METHOD TO RETURN BASE64 CODE
Future<String> getImagesCover(String coverImageUrl)async{
//INIT THE STORAGE
final LocalStorage storage = LocalStorage('Douro&Porto');
await storage.ready;
//GET THE TOKEN
var token = await storage.getItem("token");
//STRING LIST
String result = '';
//URI
var coverUri=Uri.parse(coverImageUrl);
var header={"Authorization": 'Bearer ${token}'};
//GET THE RESPONSES
var response_cover = await http.get(coverUri,headers: header);
//CASE ISNT SUCESSFULL
if(response_cover.statusCode==200){
//RETURN THE RESULT
result=jsonDecode(response_cover.body)['base64'];
}
return result;
}