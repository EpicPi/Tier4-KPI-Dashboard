import 'package:kpi_dash/src/initiative.dart';

class Strategy
{
  String name;
  String detail;
  var initiatives;

  Strategy(this.name, this.detail)
  {
    initiatives = new List<Initiative>();
  }

  num get percentage
  {
    var total =0;
    for(var strat in initiatives)
    {
      total += strat.percentage;
    }
    return total/initiatives.length ?? 0;
  }
}