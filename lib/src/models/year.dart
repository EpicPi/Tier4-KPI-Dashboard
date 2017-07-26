import 'goal.dart';

String yearTagText = "year";
String goalsTagText = "goals";

class Year {
  String key;
  num year;
  List<Goal> goals;

  Year(this.year, this.goals, [this.key]) {}

  Map toMap(Year item) =>
      {
        yearTagText: item.year,
        goalsTagText: item.goals,
      };

  num toNum(){
    return year;
  }

}