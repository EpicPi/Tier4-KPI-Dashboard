import 'package:kpi_dash/src/initiative.dart';

class Strategy
{
  String name;
  String detail;
  var initiatives;
  num val;

  Strategy(this.name, this.detail, [this.val])
  {
    initiatives = new List<Initiative>();
  }

  num get percentage
  {
    return val;
//    var total =0;
//    for(var strat in initiatives)
//    {
//      total += strat.percentage;
//    }
//    return total/initiatives.length ?? 0;
  }
}