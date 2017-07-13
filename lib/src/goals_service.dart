import 'package:kpi_dash/src/goal.dart';
import 'package:kpi_dash/src/initiative.dart';
import 'package:kpi_dash/src/strategy.dart';
import 'package:kpi_dash/src/directive.dart';
import 'dart:math';

class GoalsService {
  static get goals {
    var rng = new Random();
    var goals = new List<Goal>();
    for (int i = 0; i < 3; i++) {
      goals.add(new Goal("goal $i", "goal detail $i"));
    }
    for (var goal in goals) {
      for (int i = 0; i < 3; i++)
        goal.strategies.add(new Strategy("strategy $i of ${goal.name}",
            "strategy detail $i of ${goal.name}",
            rng.nextInt(100)));
      for (var strategy in goal.strategies) {
        for (int i = 0; i < 3; i++)
          strategy.initiatives.add(new Initiative(
              "intiative $i of ${strategy.name} of ${goal.name}",
              "intiative detail $i of ${strategy.name} of ${goal.name}"));
        for (var init in strategy.initiatives) {
          for (int i = 0; i < 3; i++) {
            init.directives.add(new Directive(
                "directive $i of ${init.name} of ${strategy.name} of ${goal.name}",
                "directive detail $i of ${init.name} of ${strategy.name} of ${goal.name}"));
          }
        }
      }
    }
    return goals;
  }
}
