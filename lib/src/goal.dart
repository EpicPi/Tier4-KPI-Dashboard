import 'package:kpi_dash/src/strategy.dart';

class Goal
{
  String name;
  var strategies;

  Goal(this.name)
  {
    strategies = new List<Strategy>();
  }
}