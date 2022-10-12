import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Map> getCricbuzzData(String matchType) async {
   Map responseMap ={};
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'x-rapidapi-host': 'cricbuzz-cricket.p.rapidapi.com',
    'x-rapidapi-key': 'bc9b49afaamsh540ff2f9f92b0b3p1b3dfcjsnea94cac5fc61',
  };

  http.Response response = await http.get(
      Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/schedule/v1/$matchType'),
      headers: requestHeaders);

  if (response.statusCode == 200) {
    
    // number requests remaining
    print(response.headers['x-ratelimit-requests-remaining']);

    //storing response into map
    responseMap = jsonDecode(response.body);
  }
  return responseMap;
}

 
