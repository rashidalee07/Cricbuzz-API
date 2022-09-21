import 'dart:convert';
import 'dart:developer';

import 'package:api_integeration/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

int count = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map responseMap = {};
  List<Map> rankingList = [];
  List<String> playerFaceId = [];
  int numberOfMaps = 0;

  @override
  void initState() {
    super.initState();
    getCricbuzzData();
  }

  Future<Map> getCricbuzzData() async {
    //  var url = 'https://cricbuzz-cricket.p.rapidapi.com/img/v1/i1/c170853/i.jpg';

    List<String> category = [
      'batsmen',
      'bowlers',
      'allrounders',
      'teams',
    ];
    List<Map<String, String>> parameter = [
      {'formatType': 'test'},
      {'formatType': 'odi'},
      {'formatType': 't20'}
    ];
    int paraeterNumber = 2;
    // http.Response response = await http.get(
    //     Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/stats/v1/rankings/batsmen/test'),
    //     headers: requestHeaders,
    //     );
    // var networkImage = NetworkImage()
    var httpsUri = Uri(
        scheme: 'https',
        host: 'cricbuzz-cricket.p.rapidapi.com',
        path: 'stats/v1/rankings/${category[0]}',
        queryParameters: parameter[paraeterNumber]);
    http.Response response = await http.get(httpsUri, headers: requestHeaders);

    if (response.statusCode == 200) {
      setState(() {
        responseMap = jsonDecode(response.body);
        numberOfMaps = responseMap['rank'].length;
        for (int i = 0; i < numberOfMaps; i++) {
          rankingList.add(responseMap['rank'][i]);
          //Future.delayed(const Duration(seconds: 5));
          playerFaceId.add(
              'https://cricbuzz-cricket.p.rapidapi.com/img/v1/i1/c${rankingList[i]['faceImageId']}/i.jpg');
        }
      });
    }

    return responseMap;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Rankings'),
            centerTitle: true,
          ),
          body: responseMap.isEmpty
              ? const Center(child: CircularProgressIndicator())
              // : Container(
              //     color: Colors.green,
              //     height: 500,
              //     width: 500,
              //     child: const Text(""),
              //   )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: numberOfMaps,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      tileColor: Colors.blueGrey[900],
                      leading: CircleAvatar(backgroundImage: NetworkImage(playerFaceId[index],
                      headers: requestHeaders,
                      scale: 1
                      ),),
                      title: Text(
                        rankingList[index]['name'].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        rankingList[index]['rank'].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Text(rankingList[index]['points'].toString(),
                          style: const TextStyle(color: Colors.white)),
                    );
                  }))),
    );
  }

  Widget buildImage(int index) {
    Future.delayed(const Duration(seconds: 5));
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: 'https://i.pinimg.com/originals/48/b6/b3/48b6b3c9fb83a6ff8bd1204470901789.jpg',
        httpHeaders: requestHeaders,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),

      //borderRadius:BorderRadius.circular(12),
      // child: CachedNetworkImage(
      //   imageUrl: playerFaceId[index],
      //   httpHeaders: requestHeaders,
      //   height: 50,
      //   width: 50,
      //   fit: BoxFit.cov      //   ),
    );
  }
}
