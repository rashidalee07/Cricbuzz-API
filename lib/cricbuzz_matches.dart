import 'package:flutter/material.dart';

import 'fetch_matches.dart';
import 'match_card.dart';
import 'match_model.dart';

class CricbuzzMatches extends StatefulWidget {
  const CricbuzzMatches({super.key});

  @override
  State<CricbuzzMatches> createState() => _CricbuzzMatchesState();
}

class _CricbuzzMatchesState extends State<CricbuzzMatches> {
  List<MatchModel> listOfIntlMatches = [];
   List<MatchModel> listOfLeagueMatches = [];
    List<MatchModel> listOfWomenMatches = [];

  @override
  void initState() {
    
    settingUpData();
    super.initState();
  }

  void settingUpData() async {

    List <String> matchType = ['international', 'league', 'women']; 
    Future<Map> internationalResponseMap = getCricbuzzData(matchType[0]);
    Map internationalMap = await internationalResponseMap;
    MatchModel internationalMatchModel = MatchModel();
    listOfIntlMatches = internationalMatchModel.fromMap(internationalMap);

    Future<Map> leagueResponseMap = getCricbuzzData(matchType[1]);
    Map leagueMap = await leagueResponseMap;
    MatchModel leagueMatchModel = MatchModel();
    listOfLeagueMatches = leagueMatchModel.fromMap(leagueMap);

    Future<Map> womenResponseMap = getCricbuzzData(matchType[2]);
    Map womenMap = await womenResponseMap;
    MatchModel womenMatchModel = MatchModel();
    listOfWomenMatches = womenMatchModel.fromMap(womenMap);
    

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: listOfIntlMatches.isEmpty?const CircularProgressIndicator():Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(child: Text('International')),
                    Tab(child: Text('League')),
                    Tab(child: Text('Women')),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: listOfIntlMatches.length,
                          itemBuilder: (context, index) {
                            return MatchCard(
                              matchDesc:
                                  listOfIntlMatches[index].matchDesc.toString(),
                              seriesName:
                                  listOfIntlMatches[index].seriesName.toString(),
                              //teamAImage: 'IND',
                              teamAName:
                                  listOfIntlMatches[index].teamAName.toString(),
                              //teamBImage: 'AUS',
                              teamBName:
                                  listOfIntlMatches[index].teamBName.toString(),
                              date: listOfIntlMatches[index].date.toString(),
                              time: listOfIntlMatches[index].time.toString(),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: listOfLeagueMatches.length,
                          itemBuilder: (context, index) {
                            return MatchCard(
                              matchDesc:
                                  listOfLeagueMatches[index].matchDesc.toString(),
                              seriesName:
                                  listOfLeagueMatches[index].seriesName.toString(),
                              //teamAImage: 'IND',
                              teamAName:
                                  listOfLeagueMatches[index].teamAName.toString(),
                              //teamBImage: 'AUS',
                              teamBName:
                                  listOfLeagueMatches[index].teamBName.toString(),
                              date: listOfLeagueMatches[index].date.toString(),
                              time: listOfLeagueMatches[index].time.toString(),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
          
                          itemCount: listOfWomenMatches.length,
                          itemBuilder: (context, index) {
                            return MatchCard(
                              matchDesc:
                                  listOfWomenMatches[index].matchDesc.toString(),
                              seriesName:
                                  listOfWomenMatches[index].seriesName.toString(),
                              //teamAImage: 'IND',
                              teamAName:
                                  listOfWomenMatches[index].teamAName.toString(),
                              //teamBImage: 'AUS',
                              teamBName:
                                  listOfWomenMatches[index].teamBName.toString(),
                              date: listOfWomenMatches[index].date.toString(),
                              time: listOfWomenMatches[index].time.toString(),
                            );
                          }),
                    ),
                    
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
