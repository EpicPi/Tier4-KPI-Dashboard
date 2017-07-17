import 'package:kpi_dash/src/models/models.dart';
import 'dart:math';

class GoalsService {
  static get goals {
    var goals = new List<Goal>();
    for (int i = 0; i < 3; i++) {
      goals.add(new Goal("goal $i", "goal detail $i", null));
    }
    for (var goal in goals) {
      for (int i = 0; i < 3; i++)
        goal.strategies.add(new Strategy("strategy $i of ${goal.name}",
            "strategy detail $i of ${goal.name}",
            null));
      for (var strategy in goal.strategies) {
        for (int i = 0; i < 3; i++)
          strategy.initiatives.add(new Initiative(
              "intiative $i of ${strategy.name} of ${goal.name}",
              "intiative detail $i of ${strategy.name} of ${goal.name}",null));
        for (var init in strategy.initiatives) {
          for (int i = 0; i < 3; i++) {
            init.directives.add(new Dir(
                "directive $i of ${init.name} of ${strategy.name} of ${goal.name}",
                "directive detail $i of ${init.name} of ${strategy.name} of ${goal.name}",null,null));
          }
        }
      }
    }
    return goals;
  }
}
