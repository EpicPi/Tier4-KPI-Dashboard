import 'package:kpi_dash/src/strategy.dart';

class Goal
{
  String name;
  String detail;
  var strategies;
  Goal(this.name, this.detail)
  {
    strategies = new List<Strategy>();
  }
  num get percentage
  {
    var total =0;
    for(var strat in strategies)
      {
        total += strat.percentage;
      }
    return total/strategies.length ?? 0;
  }
}