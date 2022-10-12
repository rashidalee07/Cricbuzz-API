import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  late String matchDesc;
  late String seriesName;
  //late String teamAImage;
 // late String teamBImage;
  late String teamAName;
  late String teamBName;
  late String date;
  late String time;

  MatchCard(
      {required this.matchDesc,
      required this.seriesName,
     // required this.teamAImage,
      required this.teamAName,
      //required this.teamBImage,
      required this.teamBName,

      required this.date,
      required this.time,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Card(
            color: Colors.grey[90],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(left:12.0, top:12 ),
                child: Text('$matchDesc' ' ' '$seriesName',
                style:const TextStyle(fontSize: 14),
                
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:12.0, top:12 ),
                child: Row(
                  children: [
                
                    Text(teamAName),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:12.0, top:12 ),
                child: Row(
                  children: [
                    
                    Text(teamBName),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left:12.0, top:12 ),
                child: Row(
                  children: [
                    
                    Text(date, style: const TextStyle(color: Colors.orange),),
                    Text(' $time',  style: const TextStyle(color: Colors.orange),)
                  ],
                ),
              ),

            ])),
      ),
    );
  }
}
