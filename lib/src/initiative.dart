import 'package:kpi_dash/src/directive.dart';

class Initiative
{
  String name;
  String detail;
  var directives;
  num value;
  num percentage;
  Initiative(this.name)
  {
    directives = new List<Directive>();
  }

}