



import 'package:intl/intl.dart';

class MatchModel {
  late String? seriesName;
  late String ?matchDesc;
  late String? teamAName;
  late String? teamBName;
  late String ? date;
  late String ? time;
  List<MatchModel> matchesObjectList=[];

  MatchModel(
    
     [this.matchDesc,
     this.seriesName,
     this.teamAName,
     this.teamBName,
     this.date,
     this.time
     ]);

  
  
List<MatchModel> fromMap(Map currentMap){
    
    int dayCounter=0;
    int totalDays = currentMap['matchScheduleMap'].length;
    int totalMatchesPerDay = currentMap['matchScheduleMap'][dayCounter]['scheduleAdWrapper']['matchScheduleList'].length;
    int perDayMatchCounter=0;

    while(dayCounter<totalDays)
    {
      if((perDayMatchCounter < totalMatchesPerDay) && (dayCounter<totalDays))
      {
      MatchModel matchModel = MatchModel(
        matchDesc= currentMap['matchScheduleMap'][dayCounter]['scheduleAdWrapper']['matchScheduleList'][perDayMatchCounter]['matchInfo'][0]['matchDesc'],
        seriesName = currentMap['matchScheduleMap'][dayCounter]['scheduleAdWrapper']['matchScheduleList'][perDayMatchCounter]['seriesName'],
        teamAName = currentMap['matchScheduleMap'][dayCounter]['scheduleAdWrapper']['matchScheduleList'][perDayMatchCounter]['matchInfo'][0]['team1']['teamName'],
        teamBName = currentMap['matchScheduleMap'][dayCounter]['scheduleAdWrapper']['matchScheduleList'][perDayMatchCounter]['matchInfo'][0]['team2']['teamName'],
        date = currentMap['matchScheduleMap'][dayCounter]['scheduleAdWrapper']['date'],
        time = getTime(currentMap['matchScheduleMap'][dayCounter]['scheduleAdWrapper']['matchScheduleList'][perDayMatchCounter]['matchInfo'][0]['startDate']).toString()
      
       );
      matchesObjectList.add(matchModel);
      perDayMatchCounter++;
    }

    else  
    {
      dayCounter++;
      perDayMatchCounter=0;
      totalMatchesPerDay=0;

      if(dayCounter==1 || dayCounter==5)
      {
        dayCounter++;
        totalMatchesPerDay=currentMap['matchScheduleMap'][dayCounter]['scheduleAdWrapper']['matchScheduleList'].length;
      }

      else if (dayCounter<totalDays)
      {
         
         totalMatchesPerDay=currentMap['matchScheduleMap'][dayCounter]['scheduleAdWrapper']['matchScheduleList'].length;

      }
    }  
  }
     return matchesObjectList; 
  }

 String getTime(String time)
 {
  int matchTime = int.parse(time);
  time='';
  //time = DateTime.fromMillisecondsSinceEpoch(matchTime).toString();
  time = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(matchTime));
  
  return time;
 }
  
}
