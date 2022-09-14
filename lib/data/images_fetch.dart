//HTTP 
import 'dart:convert';

import 'package:http/http.dart' as http;
//FUNCTION TO FETCH 3 IMAGES
Future<List<String>> fetch_images(String coverImageUrl,String logoImageUrl,String token)async{
//INIT AN LIST
List<String> list = [];

//GET THE URI`S
var logoUri =Uri.parse(logoImageUrl);
var coverUri = Uri.parse(coverImageUrl);
//HEADER
var header = {"Authorization":'Bearer ${token}'};
try {
//GET THE DATA
var logo_data = jsonDecode((await http.get(logoUri,headers: header)).body);
var cover_data = jsonDecode((await http.get(coverUri,headers: header)).body);  
//ADD TO THE LIST
list.add(cover_data['base64']);
list.add(logo_data['base64']);
} catch (e) {
//RETRIEVE THE ERROR
print(e);
}


//THE RETURN OF THE DATA
return list;
}