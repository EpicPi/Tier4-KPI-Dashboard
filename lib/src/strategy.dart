import 'package:kpi_dash/src/initiative.dart';

class Strategy
{
  String name;
  String detail;
  var initiatives;
  num value;
  num percentage;

  Strategy(this.name)
  {
    initiatives = new List<Initiative>();
  }

}