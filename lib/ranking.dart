import 'dart:convert';
import 'package:http/http.dart' as http;

Map responseMap = {};
List<Map> rankingList = [];
int numberOfMaps = 0;

void main() async {
  Future<Map> rpm = getCricbuzzData();
  Map rm = await rpm;
}

Future<Map> getCricbuzzData() async {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'x-rapidapi-host': 'cricbuzz-cricket.p.rapidapi.com',
    'x-rapidapi-key': 'bc9b49afaamsh540ff2f9f92b0b3p1b3dfcjsnea94cac5fc61',
  };

  // Map<String, String> params = {'formatType': 'test',
  // 'formatType': 'odi','formatType': 't20'};

  List<String> category = ['batsmen','bowlers','allrounders','teams',];
  List<Map<String, String>> parameter = [{'formatType': 'test'}, {'formatType': 'odi'}, {'formatType': 't20'}];
  int paraeterNumber=2;
  // http.Response response = await http.get(
  //     Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/stats/v1/rankings/batsmen/test'),
  //     headers: requestHeaders,
  //     );

  var httpsUri = Uri(
      scheme: 'https',
      host: 'cricbuzz-cricket.p.rapidapi.com',
      path: 'stats/v1/rankings/${category[2]}',
      queryParameters: parameter[paraeterNumber]);
  http.Response response = await http.get(httpsUri, headers: requestHeaders);

  if (response.statusCode == 200) {
    // number requests remaining
    print(response.headers['x-ratelimit-requests-remaining']);

    //storing response into map
    responseMap = jsonDecode(response.body);
    numberOfMaps = responseMap['rank'].length;
    for (int i = 0; i < numberOfMaps; i++) {
      rankingList.add(responseMap['rank'][i]);
    }

    print(
        "==================================================================================");
    for (int i = 0; i < numberOfMaps; i++) {
      print(rankingList[i]['rank']);
      print(rankingList[i]['name']);
      print(rankingList[i]['country']);
      print(rankingList[i]['rating']);
      print(rankingList[i]['points']);
      print(rankingList[i]['trend']);
      print(
          "==================================================================================");
    }
  }
  return responseMap;
}
