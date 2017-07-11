import 'package:kpi_dash/src/directive.dart';

class Initiative
{
  String name;
  var directives;
  Initiative(this.name)
  {
    directives = new List<Directive>();
  }
}