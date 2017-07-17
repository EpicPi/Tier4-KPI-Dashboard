import 'package:kpi_dash/src/directive.dart';

class Initiative
{
  String name;
  String detail;
  var directives;
  Initiative(this.name,this.detail)
  {
    directives = new List<Directive>();
  }

  num get percentage
  {
    var total =0;
    for(var strat in directives)
    {
      total += strat.percentage;
    }
    return total~/directives.length ?? 0;
  }
}